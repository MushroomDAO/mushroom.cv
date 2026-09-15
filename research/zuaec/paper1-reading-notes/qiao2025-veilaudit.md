# VeilAudit: Breaking the Deadlock Between Privacy and Accountability Across Blockchains
**arXiv**: 2510.12153 | **Year**: 2025 | **Authors**: Minhao Qiao, Hai Dong, Iqbal Gondal | **Venue**: Submitted to USENIX Security 2026 (Cycle 1)

## Core Claim
VeilAudit solves the privacy-accountability deadlock in cross-chain blockchain systems through Auditor Only Linkability (AOL) — auditors can link transactions from the same entity without learning identity, enabling pseudonymous reputation and conditional identity revelation with due process safeguards.

## Key Evidence / Numbers
- Novel primitive: **Auditor Only Linkability (AOL)** — auditors link transactions without identity disclosure
- Linkable Audit Tags: ZK proofs embedded in transactions validating legitimacy while concealing wallet addresses
- Auditor-Only Ciphertext: specialized encryption for selective auditability
- Threshold Gated Identity Revelation: conditional identity disclosure requiring safeguards
- Pseudonymous Reputation System: cross-chain credit scoring from verifiable behavioral history
- Prototype deployed across multiple EVM chains
- Submitted to USENIX Security 2026 (high-quality venue signal)

## ASM Comparison (Paper 2 focus)
- **What it does**: Enables pseudonymous reputation (behavioral history) with selective auditability and conditional identity revelation — directly addresses the tension between permissionless participation and accountability
- **Gap vs ASM**: (1) Blockchain-native — the mechanism requires on-chain interaction; ASM may operate off-chain with on-chain anchoring only for identity; (2) Cross-chain accountability focus vs. cross-agent network focus; (3) No role encoding; (4) Reputation is transaction-history-based, not task-performance-based
- **Paper 2 §5 use**: Cite as the strongest precedent for pseudonymous accountability in open agent networks — the AOL pattern is directly applicable to ASM's privacy-accountability tradeoff for reputation scores

## Paper 1 Relevance
- **§5 (security/risks)**: Pseudonymous accountability with conditional identity revelation is a design pattern Paper 1's security section should acknowledge as a solution direction for open networks
- **§4.3 (S pillar)**: Cross-chain credit scoring validates the cross-network reputation portability that ASM's S pillar aims for

## Verdict
⭐⭐⭐⭐ | Strong P2 §5 citation — best reference for the privacy-accountability tradeoff in permissionless reputation systems. USENIX Security 2026 venue adds significant credibility.

---
*Jason's feedback*: [待填]
