# [Anbiaee et al. 2026] Security Threat Modeling for Emerging AI-Agent Protocols: A Comparative Analysis of MCP, A2A, Agora, and ANP

**Citation**: Zeynab Anbiaee, Mahdi Rabbani, Mansur Mirani, Gunjan Piya, Igor Opushnyev, Ali Ghorbani, Sajjad Dadkhah. "Security Threat Modeling for Emerging AI-Agent Protocols: A Comparative Analysis of MCP, A2A, Agora, and ANP." arXiv:2602.11327v2 [cs.CR], 17 Apr 2026.
**机构**: Canadian Institute for Cybersecurity (CIC), University of New Brunswick; Mastercard Vancouver Tech Hub
**arXiv**: https://arxiv.org/abs/2602.11327
**PDF**: papers/threatmodel2026-agent-protocols.pdf
**Cluster**: Agent Protocols / Security — Paper 2 §6 (threat/adversary model) / §2 (comparison)
**Status**: ✅ 全文已分析（2026-05-22）

> **Title note**: The provided working title ("Security Threat Modeling for AI-Agent Protocols") matches the actual title, which is fuller: "...for **Emerging** AI-Agent Protocols: A Comparative Analysis of MCP, A2A, Agora, and ANP." Covers MCP/A2A/Agora/ANP as expected; arXiv id confirmed (2602.11327, v2).

## Core claim (一句话)
The first systematic, cross-protocol security threat-modeling and lifecycle-based qualitative risk assessment of the four most mature agent communication protocols (MCP, A2A, Agora, ANP), consolidating scattered findings into a 12-vulnerability / 3-impact-domain taxonomy and validating one MCP risk — missing cryptographic identity-binding of tools to providers — as a falsifiable, measured "wrong-provider tool execution" claim (Violation Rate up to 1.0).

## 研究问题
How secure are the emerging AI-agent communication protocols at the *protocol design* level, and how do MCP, A2A, Agora, and ANP compare in risk across their lifecycle phases (creation/configuration, operation, update/maintenance)? Can a hypothesized design-level weakness be turned into an empirically demonstrable security failure rather than mere conceptual critique?

## 方法与主要内容

**Threat taxonomy (§4) — organized by three impact domains:**
- **Authentication & Access Control**: lack of authentication (early MCP), weak/limited access control, naming collision & impersonation, absence of token-lifetime limits (A2A OAuth), insufficiently granular token scope.
- **Supply Chain & Ecosystem Integrity**: installer spoofing, code injection & backdoors, tool poisoning, rug pulls.
- **Operational Integrity & Reliability**: slash command overlap, sandbox escape, runtime workflow shadowing, post-update privilege persistence, re-deployment of vulnerable versions, configuration drift.
Aligned with STRIDE and CIA triad.

**Risk assessment framework (§5)** — NIST SP 800-30 / ISO 27005 design-time qualitative method (no incident data; ratings from architecture/spec analysis). 5 tasks: identify threat sources (malicious actors / compromised agents / accidental) → identify vulnerabilities → likelihood (L) → impact (I) → risk R = L×I, mapped to Low/Med/High. **Twelve vulnerabilities** grouped by lifecycle stage (creation/config: weak identity verification, no registration-artifact integrity, insufficient namespace isolation, no baseline governance; operation: **lack of mandatory provenance & identity-binding validation**, insufficient data-exchange control, weak least-privilege, missing rate-limiting; update: failure to revoke/reissue credentials, no rollback/version-pinning, no update-package auth, uncontrolled transitive-dependency evolution).

**Per-protocol findings (Tables 5–7, the comparison engine):**
- **MCP**: highest risk overall. No mandatory identity validation, unsigned artifacts, no namespace uniqueness, no token expiry, full-context sharing with tools, no forced revocation/version-pinning/signing post-update. Sandbox limits some DoS.
- **A2A**: medium across the board. OAuth2 + JWT + mutual auth reduces exploitability and localizes impact, but tokens are coarse-grained/long-lived, agent cards are unsigned (integrity is deployment-dependent), and SSE/JSON-RPC streaming enables flooding DoS.
- **Agora**: high in operation/update. Self-declared identities, optional identity proof, Protocol-Document (PD) negotiation lacks integrity enforcement → manipulated/spoofed PDs propagate network-wide; decentralized PD propagation makes downgrade/divergence easy.
- **ANP**: lowest (low-median). W3C **DID + E2E encryption** cryptographically guarantees identity & namespace uniqueness; weaknesses are at the application/transitive-dependency layer and cross-org asynchrony, mitigated by layered/self-healing meta-protocol.

**Empirical case study (§6) — the standout contribution.** Formalizes MCP's missing tool↔provider identity binding. SUT = one orchestrator (MCP client v1.25.0, JSON-RPC over stdio) + a legitimate and a malicious MCP server both advertising an identically named tool `payments.authorize_transaction`. Strict threat model: attacker can only publish a server on the same discovery surface (no host compromise, no crypto break, no MITM). Metric = **Violation Rate (VR)** = #wrong-provider executions / N (ASR-style). Results (Table 8, N=100 each): first-match resolution → **VR=1.0** when attacker listed first (static config or registry filename order); best-match scoring → VR=1.0 when attacker injects "trust cues" into metadata; **even with cloned metadata + randomized tie-break, VR=0.52**. Conclusion: this is a *systemic identity-ambiguity property*, not a scoring bug; fix = make tool identity provider-dependent and validated by cryptographic certificates/signatures (future work). Future directions also flag **cross-protocol** confusion/downgrade/relay-abuse risk when MCP/A2A/Agora/ANP are combined, and call for a minimal canonical identity+capability+provenance mapping.

## 与 ASM 的关系（差异化 + 可借用之处）

| Dimension | This paper | ASM — what ASM adds |
|---|---|---|
| Goal | *Diagnose* security risk of existing protocols (MCP/A2A/Agora/ANP); proposes no new protocol | ASM is a *constructive* protocol that designs the missing controls in by default |
| Identity | Finds identity binding is the dominant failure: MCP/Agora self-declared, A2A token-based, only ANP cryptographic (DID) | ASM **cryptographically binds social roles & credentials from declared principals to agents** — generalizes ANP's DID identity to *role/credential* binding, the strongest position on this axis |
| Provenance / tool binding | Empirically shows MCP wrong-provider execution VR up to 1.0 from missing provider↔tool binding | ASM's principal→agent credential binding + accumulator membership directly closes this misbinding gap |
| Reputation / Sybil | Naming collision & capability spoofing (esp. open-discovery ANP/Agora) noted as unsolved | ASM adds **privacy-preserving reputation via ZK proofs over accumulator-managed credentials** — a defense this survey identifies as absent |
| Adversary model | Abstract threat sources (malicious/compromised/accidental); 12 vulns × 3 lifecycle stages | ASM's explicit **8-attacker-type** model can be cross-mapped to these 12 vulns to show coverage |
| Coordination trust | Agora PD negotiation & ANP cross-layer = high update-stage risk; assumes varying trust | ASM's **permissionless multi-party coordination** + role-specific FSMs target exactly the dynamic-discovery / rug-pull / shadowing risks |

**可借用之处 (ASM should cite/adopt heavily):**
1. This is the **single best §6 input** — its 12-vulnerability lifecycle taxonomy and the L×I qualitative matrix give ASM a ready-made framework to *evaluate ASM itself* and to score the 8-attacker model against MCP/A2A/Agora/ANP.
2. The **VR (Violation Rate) wrong-provider experiment** is a concrete, citable demonstration of the *exact* problem ASM's role-credential binding solves — quote VR=1.0 / VR=0.52 as motivation in Paper 2's intro and §6.
3. The per-protocol risk verdicts (MCP highest, ANP lowest via DID) supply the comparison-table cells for §2; ASM can be added as the "binds *roles* not just identities + ZK reputation + permissionless" column that dominates all four.
4. The **cross-protocol relay/downgrade/confusion** future-work gap is a forward-looking threat ASM's dual-network model can claim to address.

## Paper 2 区分/引用段落（~190 词，英文）
Anbiaee et al. (2026, CIC/UNB + Mastercard) provide the first systematic cross-protocol security threat model of the four most mature agent communication protocols — MCP, A2A, Agora, and ANP — consolidating scattered findings into a twelve-vulnerability taxonomy across three impact domains (authentication/access control, supply-chain integrity, operational reliability) and scoring each protocol with a NIST SP 800-30 lifecycle risk matrix (creation, operation, update). Crucially, they convert MCP's missing tool-to-provider identity binding into a falsifiable, measured claim, showing wrong-provider tool execution at Violation Rates up to 1.0 (and 0.52 even under randomized tie-breaks). For Paper 2 this is the anchor reference of §6: it is the strongest available empirical evidence that *the absence of cryptographic identity/credential binding* — the precise gap ASM closes — produces concrete, reproducible compromise. We map ASM's eight-attacker adversary model onto their twelve-vulnerability lifecycle taxonomy to demonstrate coverage, cite their VR experiment as motivation, and use their per-protocol verdicts (MCP highest risk, ANP lowest via W3C DID + E2E) as the §2 comparison baseline. ASM is positioned as generalizing ANP's DID identity to *social-role/credential* binding, adding privacy-preserving ZK reputation over accumulators (their unaddressed Sybil/capability-spoofing gap) and permissionless multi-party coordination, and as a candidate answer to their open cross-protocol relay/downgrade/confusion problem.

## Action items
- [ ] §6: adopt the 12-vulnerability × 3-lifecycle-stage taxonomy as the scaffold; cross-map ASM's 8-attacker model to show coverage vs. MCP/A2A/Agora/ANP.
- [ ] §1/intro + §6: cite the wrong-provider VR=1.0 / VR=0.52 result as concrete motivation for cryptographic role/credential binding.
- [ ] §2 comparison table: use their per-protocol risk verdicts (MCP high, A2A medium, Agora high op/update, ANP low via DID) as baseline cells; add ASM column.
- [ ] §6/future: cite their cross-protocol relay/downgrade/confusion gap as a threat ASM's dual-network model addresses.
- [ ] Optionally adopt R = L×I qualitative scoring to self-assess ASM's residual risks.

## Jason's feedback
> （请在此处写入你的feedback）
