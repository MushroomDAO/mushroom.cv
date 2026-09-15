/**
 * Mycelium Relayer — Cloudflare Worker
 *
 * Endpoints:
 *   POST /relay          — submit a gasless GToken purchase
 *   GET  /health         — readiness check
 *   POST /eth/v1/UserOperation  — ERC-4337 bundler stub (not yet implemented)
 *
 * Evolution path → bundler:
 *   Phase 1 (now):   fixed-purpose relayer, only sponsors GToken purchase shape
 *   Phase 2:         generalize /eth/v1/UserOperation to accept arbitrary UserOps
 *   Phase 3:         mempool + bundle aggregation (Durable Objects, multi-op batching)
 */

import type { Env, RelayRequest, RelayResponse, RelayErrorResponse } from './types.js'
import { getChainConfig } from './config.js'
import { validateRequest } from './pipeline/validate.js'
import { preflightChecks } from './pipeline/preflight.js'
import { buildTx } from './pipeline/build.js'
import { submitTx } from './pipeline/submit.js'
import { checkRateLimit } from './rateLimit.js'
import { handleV2Relay, handleV2Revoke, type V2RelayRequest, type V2RevokeRequest } from './v2/handler.js'
import { handleV3Relay, type V3RelayRequest } from './v3/handler.js'
import type { Hex } from 'viem'

// Predicted MPNTs = 1 ether — a safe over-estimate; SuperPaymaster refunds the diff.
// Will be refined once we can simulate the UserOp gas cost on-chain.
const PREDICTED_MPNTS = 1n * 10n ** 18n

export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    const url = new URL(request.url)

    // CORS for local dev + production frontend
    const corsHeaders = {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
      'Access-Control-Allow-Headers': 'Content-Type',
    }

    if (request.method === 'OPTIONS') {
      return new Response(null, { headers: corsHeaders })
    }

    if (url.pathname === '/health' && request.method === 'GET') {
      return json({ status: 'ok', chain: env.CHAIN_ID }, 200, corsHeaders)
    }

    // ── Bundler evolution stub ────────────────────────────────────────────
    if (url.pathname === '/eth/v1/UserOperation' && request.method === 'POST') {
      return json(
        { error: 'Bundler mode not yet active. Use /relay for GToken purchases.', code: 'INFRA_NOT_READY' },
        501,
        corsHeaders,
      )
    }

    if (url.pathname === '/relay' && request.method === 'POST') {
      return handleRelay(request, env, corsHeaders)
    }

    // ── v2 (EIP-7702 + EIP-712 gasless purchase) — paused, blocked by wallet RPC gap ─
    if (url.pathname === '/v2/relay' && request.method === 'POST') {
      return handleV2(request, env, corsHeaders, 'relay')
    }
    if (url.pathname === '/v2/revoke' && request.method === 'POST') {
      return handleV2(request, env, corsHeaders, 'revoke')
    }

    // ── v3 (EIP-3009 + BuyIntent gasless purchase via BuyHelper) — active ─────
    if (url.pathname === '/v3/relay' && request.method === 'POST') {
      return handleV3(request, env, corsHeaders)
    }

    return json({ error: 'Not found' }, 404, corsHeaders)
  },
}

// ── /v3/relay router (rate limit + dispatch) ─────────────────────────────────

async function handleV3(
  request: Request,
  env: Env,
  corsHeaders: Record<string, string>,
): Promise<Response> {
  let body: V3RelayRequest
  try {
    body = await request.json() as V3RelayRequest
  } catch {
    return error('Invalid JSON body', 'INVALID_SHAPE', 400, corsHeaders)
  }

  const intentBuyer = body.intent?.buyer
  if (!intentBuyer || typeof intentBuyer !== 'string' || !/^0x[0-9a-fA-F]{40}$/i.test(intentBuyer)) {
    return error('intent.buyer must be a valid Ethereum address', 'INVALID_SHAPE', 400, corsHeaders)
  }
  const rl = await checkRateLimit(intentBuyer as `0x${string}`, env)
  if (!rl.allowed) {
    return error(rl.reason ?? 'Rate limited', 'RATE_LIMITED', 429, corsHeaders)
  }

  const v3Env = { RPC_URL: env.RPC_URL, OPERATOR_PK: env.OPERATOR_PK as Hex, CHAIN_ID: env.CHAIN_ID }
  const result = await handleV3Relay(body, v3Env)

  if (!result.ok) {
    const httpStatus = pickV3HttpStatus(result.code)
    return json({ error: result.reason, code: result.code }, httpStatus, corsHeaders)
  }
  return json({ txHash: result.txHash, matchedRule: result.matchedRule, status: 'submitted' }, 200, corsHeaders)
}

function pickV3HttpStatus(code: string): number {
  switch (code) {
    case 'INVALID_SHAPE':
    case 'EXPIRED':
    case 'SIGNATURE_INVALID':
      return 400
    case 'NOT_WHITELISTED':
      return 403
    case 'SUBMIT_FAILED':
      return 502
    default:
      return 500
  }
}

// ── /v2/* router (rate limit + dispatch) ─────────────────────────────────────

async function handleV2(
  request: Request,
  env: Env,
  corsHeaders: Record<string, string>,
  kind: 'relay' | 'revoke',
): Promise<Response> {
  let body: V2RelayRequest | V2RevokeRequest
  try {
    body = await request.json() as V2RelayRequest | V2RevokeRequest
  } catch {
    return error('Invalid JSON body', 'INVALID_SHAPE', 400, corsHeaders)
  }

  const buyer = (body as any).buyer
  if (!buyer || typeof buyer !== 'string' || !/^0x[0-9a-fA-F]{40}$/i.test(buyer)) {
    return error('buyer must be a valid Ethereum address', 'INVALID_SHAPE', 400, corsHeaders)
  }
  const rl = await checkRateLimit(buyer as `0x${string}`, env)
  if (!rl.allowed) {
    return error(rl.reason ?? 'Rate limited', 'RATE_LIMITED', 429, corsHeaders)
  }

  const v2Env = { RPC_URL: env.RPC_URL, OPERATOR_PK: env.OPERATOR_PK as Hex }

  const result = kind === 'relay'
    ? await handleV2Relay(body as V2RelayRequest, v2Env)
    : await handleV2Revoke(body as V2RevokeRequest, v2Env)

  if (!result.ok) {
    const httpStatus = pickHttpStatus(result.code)
    return json({ error: result.reason, code: result.code }, httpStatus, corsHeaders)
  }
  return json({ txHash: result.txHash, matchedRule: result.matchedRule, status: 'submitted' }, 200, corsHeaders)
}

function pickHttpStatus(code: string): number {
  switch (code) {
    case 'INVALID_SHAPE':
    case 'INTENT_PARSE_FAILED':
    case 'WRONG_DELEGATE':
    case 'INVALID_REVOKE_AUTH':
    case 'SIGNATURE_INVALID':
      return 400
    case 'NOT_WHITELISTED':
      return 403
    case 'SUBMIT_FAILED':
      return 502
    default:
      return 500
  }
}

// ── /relay handler ────────────────────────────────────────────────────────

async function handleRelay(
  request: Request,
  env: Env,
  corsHeaders: Record<string, string>,
): Promise<Response> {
  // 1. Parse body
  let body: RelayRequest
  try {
    body = await request.json() as RelayRequest
  } catch {
    return error('Invalid JSON body', 'INVALID_SHAPE', 400, corsHeaders)
  }

  const config = getChainConfig(env)

  // 2. Rate limit check (before any expensive work)
  const rl = await checkRateLimit(body.userOp?.sender ?? '0x0', env)
  if (!rl.allowed) {
    return error(rl.reason ?? 'Rate limited', 'RATE_LIMITED', 429, corsHeaders)
  }

  // 3. Structural validation (pure, no chain calls)
  const { result: validation, purchase } = validateRequest(body, config, Date.now())
  if (!validation.ok) {
    return error(validation.error, validation.code, 400, corsHeaders)
  }

  // 4. On-chain preflight (inventory, USDC balance)
  const preflight = await preflightChecks(purchase!, config, env.RPC_URL)
  if (!preflight.ok) {
    return error(preflight.error, preflight.code, 422, corsHeaders)
  }

  // 5. Check infra readiness (registry/mpnts/airAccountDelegate must all be deployed)
  const infraReady = !!(config.registry && config.mpnts && config.airAccountDelegate)
  if (!infraReady) {
    return error(
      'Relayer infra not yet deployed (SuperPaymaster + Registry). Check back after mainnet launch.',
      'INFRA_NOT_READY',
      503,
      corsHeaders,
    )
  }

  // 6. Build Type-4 tx
  const hasSbt = body.skipSbt ?? false
  const builtTx = buildTx(
    body.authorization,
    body.userOp,
    config,
    PREDICTED_MPNTS,
    hasSbt,
  )

  // 7. Submit
  let txHash: Hex
  try {
    const result = await submitTx(builtTx, env.OPERATOR_PK as Hex, env.RPC_URL)
    txHash = result.txHash
  } catch (e) {
    const msg = e instanceof Error ? e.message : String(e)
    // Surface chain revert reason to frontend for display
    return error(`Relay failed: ${msg}`, 'RELAY_FAILED', 502, corsHeaders)
  }

  const response: RelayResponse = { txHash, status: 'submitted' }
  return json(response, 200, corsHeaders)
}

// ── Helpers ────────────────────────────────────────────────────────────────

function json(body: unknown, status: number, headers: Record<string, string>): Response {
  return new Response(JSON.stringify(body), {
    status,
    headers: { 'Content-Type': 'application/json', ...headers },
  })
}

function error(
  message: string,
  code: RelayErrorResponse['code'],
  status: number,
  headers: Record<string, string>,
): Response {
  const body: RelayErrorResponse = { error: message, code }
  return json(body, status, headers)
}
