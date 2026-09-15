# [Hu & Rong 2026] Inter-Agent Trust Models: A Comparative Study of Brief, Claim, Proof, Stake, Reputation and Constraint in Agentic Web Protocol Design—A2A, AP2, ERC-8004, and Beyond

**Citation**: Botao 'Amber' Hu, Helena Rong. "Inter-Agent Trust Models: A Comparative Study of Brief, Claim, Proof, Stake, Reputation and Constraint in Agentic Web Protocol Design—A2A, AP2, ERC-8004, and Beyond." arXiv:2511.03434v1 [cs.HC], 5 Nov 2025. Copyright © 2026 AAAI. 9 pp.
**机构**: University of Oxford (Hu); New York University Shanghai (Rong)
**arXiv**: https://arxiv.org/abs/2511.03434
**PDF**: papers/inter-agent-trust-models2025.pdf
**Cluster**: Agent Protocols / Trust — Paper 2 §2 comparison
**Status**: ✅ 全文已分析（2026-05-22）

## Core claim (一句话)
In the emerging "agentic web," trust shifts from human oversight to protocol design; no single trust mechanism suffices, so protocols should be *trustless-by-default*—anchored in Proof and Stake to gate high-impact actions, with Brief for identity/discovery and Reputation as a layered (never sole) signal—applied through risk-calibrated tiers (T0–T3).

## 研究问题
What distinct trust models underlie inter-agent protocols, how do current protocols (A2A, AP2, ERC-8004) implement them, how does each model hold up against LLM-specific fragilities, and how should they be combined?

## 方法与主要内容 (taxonomy/protocols/trust-model categories covered)
Conceptual comparative study (no empirics). Core taxonomy = **six trust models** (Table 1: basis / strengths / weaknesses / LLM-mitigation / notable uses):
1. **Brief** — third-party/self-issued *verifiable credentials* (W3C VCs, NANDA AgentFacts, TLS certs). Bootstraps identity; depends on issuers; needs robust revocation.
2. **Claim** — agent *self-proclaimed* descriptions (A2A AgentCard). Lightweight; unverified; barely mitigates LLM fragility.
3. **Proof** — cryptographic/verifiable evidence (signatures, **zero-knowledge proofs**, TEE attestations). Trust-minimized; counters hallucination/deception; costly; proves integrity, *not* alignment.
4. **Stake** — economic collateral + slashing + insurance (ERC-8004 crypto-economic validation). Aligns incentives; Sybil/wealth-skew risks; largely ex-post.
5. **Reputation** — community feedback/trust graphs (EigenTrust, ERC-8004 reputation registry). Adaptive; lagging; Sybil/collusion/whitewashing/cold-start vulnerable.
6. **Constraint** — sandboxing / least-privilege / capability bounding (A2A sandbox recs, AP2 tiered access). Bounds blast radius; may throttle capability; not foolproof.

Foundations cited: Marsh (1994) computational trust, Beta reputation, TRAVOS, EigenTrust, ReGreT; LLM fragilities = prompt injection, sycophancy/nudge-susceptibility, hallucination, deception, emergent power-seeking/misalignment.
**Protocol mapping**: A2A → Claim + Constraint (+Brief via TLS/OAuth); AP2 → Brief+Proof (signed Mandates) + Constraint (tokenization/role separation); ERC-8004 → three on-chain registries (Identity / Reputation / Validation) = Claim/Brief + Reputation + Proof+Stake, with `supportedTrust` capability advertisement.
**Design blueprint**: tiered trust **T0–T3** (read-only → moderate w/ accountability → high-assurance "verify relentlessly" → critical/life-critical multi-layer), with two invariants: least-privilege at capability boundary, evidence-first accountability at audit boundary.

## 与 ASM 的关系（差异化 + 可借用）
| Dimension | This paper (6 trust models) | ASM 的定位 |
|---|---|---|
| Trust taxonomy | Brief/Claim/Proof/Stake/Reputation/Constraint as analytical lens | ASM should *self-classify*: role-credential binding ≈ Brief+Proof; ZK reputation ≈ Proof+Reputation hybrid |
| Reputation privacy | Reputation registries (ERC-8004) are public → privacy/fairness concern flagged | ASM's ZK-proof reputation over accumulator-managed credentials directly answers this open privacy concern |
| Identity vs role | Brief binds credentials to *agent's crypto identity*; AgentCard = agent capability | ASM binds *declared principal's social role/credentials* to the agent → accountability beyond software identity |
| Accountability | AP2 Mandate captures human-present authorization; ANP `humanAuthorization` | ASM's human-authorization accountability generalizes this as a first-class protocol primitive |
| Openness | Trustless-by-default for open multi-party; Stake gates Sybil | ASM = permissionless multi-party coordination; can adopt T0–T3 tiering to calibrate role/stake requirements |
| Borrowable | The six-model vocabulary; T0–T3 tiered blueprint; ERC-8004 three-registry decomposition; "Proof guarantees integrity not alignment" | ASM §2 table should locate each ASM mechanism within this six-model space and cite T0–T3 as the trust-tiering rationale |

## Paper 2 §2 引用段落 (~150-200词，英文)
Hu and Rong (2026) supply the trust-dimension vocabulary that ASM's comparison must address. They decompose inter-agent trust into six models—Brief (verifiable credentials), Claim (self-proclaimed AgentCards), Proof (signatures, zero-knowledge proofs, TEE attestations), Stake (slashable collateral), Reputation (feedback/trust graphs), and Constraint (sandboxing)—and map A2A (Claim+Constraint), AP2 (Brief+Proof+Constraint), and ERC-8004 (Claim/Brief+Reputation+Proof+Stake) onto them. Their central finding—that no single mechanism suffices and that LLM fragilities render claim-only and purely reputational trust brittle—motivates their trustless-by-default, tiered (T0–T3) blueprint. ASM operationalizes this hybrid recommendation as a protocol: its cryptographic binding of declared principals' social roles spans Brief+Proof; its privacy-preserving reputation via ZK proofs over accumulator-managed credentials directly resolves the privacy and Sybil concerns the authors raise for public reputation registries; and its human-authorization accountability generalizes AP2's Mandate primitive. Critically, where Hu and Rong evaluate trust of the *agent-as-actor*, ASM anchors trust in the *social role and human principal* the agent represents.

## Action items
- [ ] Cite as the trust-taxonomy anchor in Paper 2 §2; map each ASM contribution to the Brief/Proof/Stake/Reputation cells
- [ ] Cite ERC-8004 three-registry (Identity/Reputation/Validation) as the closest prior art to ASM's role+reputation layer; differentiate via ZK privacy + social-role binding
- [ ] Cite T0–T3 tiered blueprint as justification for ASM's risk-calibrated role/authorization gating
- [ ] Use "Proof guarantees integrity, not alignment" to motivate ASM's role-accountability (human principal) layer beyond cryptographic correctness
- [ ] Cite the LLM-fragility list (prompt injection, sycophancy, hallucination, deception, misalignment) when arguing why role-bearing accountability is needed
- [ ] Cross-link with ehtesham2025-interop-survey.md: Ehtesham covers transport/discovery axes; Hu&Rong covers trust axes — together they define ASM §2's full comparison grid

## Jason's feedback
> （请在此处写入你的feedback）
