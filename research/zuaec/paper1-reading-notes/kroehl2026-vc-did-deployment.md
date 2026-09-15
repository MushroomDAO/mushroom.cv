# From Specification to Deployment: Empirical Evidence from a W3C VC + DID Trust Infrastructure for Autonomous Agents
**arXiv**: 2605.06738 | **Year**: 2026 | **Authors**: Lars Kersten Kroehl | **Venue**: arXiv preprint

## Core Claim
The paper closes the gap between W3C specification and production deployment: it provides the first production evidence (MolTrust system, operational since March 2026) that W3C VC 2.0 + DID v1.0 with on-chain anchoring can serve as a real trust infrastructure for autonomous agents transacting at scale.

## Key Evidence / Numbers
- MolTrust operational since March 2026 across **eight credential verticals**
- Uses Base Layer 2 on-chain anchoring for DID anchoring
- Agent Authorization Envelope (AAE) enforced at **three layers**: cryptographic signatures + API-level credential lifecycle + kernel-level syscall monitoring via Falco eBPF
- Cross-protocol interoperability demonstrated via **five test vectors**
- Layered Sybil resistance: dual-signature interaction proofs + cross-vertical endorsement diversity gating + DID-linked violation persistence

## ASM Comparison (Paper 2 focus)
- **What it does**: Production-deployed DID+VC system with syscall-level enforcement and multi-vertical Sybil resistance — the most complete identity deployment found in this review
- **Gap vs ASM**: Strong on identity and authorization, but no role-bearing layer and no reputation-weighted routing. The AAE enforces per-transaction policy but does not score agents dynamically based on interaction history (no reputation accumulation). Also no permissionless network participation model — MolTrust appears to assume credentialed verticals
- **Paper 2 §3 use**: Primary empirical precedent — ASM's DID+VC identity pillar can cite MolTrust as existence proof that W3C primitives work at production scale; ASM adds role encoding in the VC schema and reputation-weighted routing on top

## Paper 1 Relevance
- **§4.2 (P pillar)**: Best empirical evidence in this batch for "verifiable principal identity" being deployable — cite as the production-deployment reference for the P pillar
- **§6 (future work)**: Multi-vertical credential diversity is a good model for open agent networks

## Verdict
⭐⭐⭐⭐⭐ | Primary P2 citation — production deployment of W3C VC+DID; cite in §3 (identity layer) and §6 (empirical validation context)

---
*Jason's feedback*: [待填]
