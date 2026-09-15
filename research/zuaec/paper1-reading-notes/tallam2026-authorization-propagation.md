# [Tallam 2026] Authorization Propagation in Multi-Agent AI Systems: Identity Governance as Infrastructure
**arXiv**: 2605.05440 | **Year**: 2026 | **Authors**: Krti Tallam | **Venue**: arXiv preprint (cs.AI, 20 pages)
**Cluster**: Agent Identity & Authentication Protocols / Security
**Status**: Abstract + key findings (ar5iv redirect; abstract-level read)

## Core Claim
Authorization propagation in multi-agent systems is a distinct, unsolved security problem — not reducible to prompt injection or classical access-control frameworks (RBAC, ABAC, ReBAC) — and identity governance must function as foundational infrastructure, continuously evaluated at every interaction boundary and deployed before orchestration logic scales.

## Key Evidence / Numbers
- Identifies three formal sub-problems: (1) transitive delegation, (2) aggregation inference, (3) temporal validity
- Derives 7 structural requirements for authorization architectures in multi-agent AI systems
- Notes emerging convergence around 4 mechanisms: capability tokens, task-scoped authorization envelopes, dependency-graph policy enforcement, execution-count revocation
- Demonstrates failures using production enterprise AI deployments (ordinary operations already violate the model)
- 20-page treatment — substantive technical depth, not a position paper

## Paper 1 Relevance
- **§2 (Paradigm Shift)**: Tallam's point that RBAC/ABAC/ReBAC all fail for multi-agent delegation is direct evidence that the old paradigm's infrastructure is insufficient. The "authorization as infrastructure" framing mirrors our "social role agency requires new primitives" argument.
- **§4 (P Pillar)**: The three sub-problems (transitive delegation, aggregation inference, temporal validity) are exactly the failure modes that a robust Collaboration Protocol must address. Cite as motivation for P pillar's formal guarantees.
- **§4 (SC Pillar)**: Temporal validity and execution-count revocation are dynamic trust signals — bridges to SC's reputation-as-live-signal concept. Cite to show static identity tokens are insufficient.

## Paper 2 Relevance
- **§3 (ASM Architecture — Principal Identity)**: The 7 structural requirements are a checklist ASM must satisfy. Cross-reference each requirement against ASM's design: (a) principal chain covers transitive delegation, (b) task-scoped tokens cover temporal validity, (c) revocation hooks needed for execution-count mechanism.
- **§4 (Security Section)**: Cite Tallam's production failure examples as motivation for why ASM's verifiable identity is not academic — real enterprise deployments fail without it.
- **§5 (Related Work)**: Tallam's framework distinguishes ASM from prompt-injection defenses, which is a positioning clarification Paper 2 needs — ASM addresses authorization propagation, not just injection.

## Verdict
⭐⭐⭐⭐ | Strong security-theoretic grounding; the 7 structural requirements are directly actionable for ASM's design validation. Slightly lower than ⭐⭐⭐⭐⭐ because full text was inaccessible — verify the 7 requirements against Paper 2 §3 once PDF is obtained.

## Jason's feedback
> （请在此处写入你的feedback）
