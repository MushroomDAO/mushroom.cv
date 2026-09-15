# A Scalable, Privacy-Preserving Decentralized Identity and Verifiable Data Sharing Framework based on Zero-Knowledge Proofs
**arXiv**: 2510.09715 | **Year**: 2025 | **Authors**: Hui Yuan | **Venue**: arXiv preprint (cs.CR)

## Core Claim
Combining DID + VC with zk-STARK (instead of zk-SNARK) enables scalable, post-quantum-secure, privacy-preserving credential verification — users prove credential conditions ("age > 18") without revealing underlying data — with scalable credential revocation via cryptographic accumulators and social key recovery.

## Key Evidence / Numbers
- zk-STARK advantages over zk-SNARK: no trusted setup required, post-quantum security, transparent randomness
- Cost: larger proof sizes than zk-SNARKs (trade-off)
- Credential revocation: cryptographic accumulators for large-scale scenarios
- Social key recovery: enhances usability alongside security
- Demonstrated via DeFi credit scoring use case
- Single-author paper — limited peer review signal

## ASM Comparison (Paper 2 focus)
- **What it does**: ZK-STARK-based credential verification for DID+VC systems — privacy-preserving proof of credential conditions without identity disclosure
- **Gap vs ASM**: (1) Single-author preprint with no empirical evaluation beyond the DeFi use case; (2) Focus is on credential privacy technology, not agent communication protocol; (3) No role encoding; (4) No reputation mechanism
- **Paper 2 §3 use**: Cite as ZKP technology choice justification — if ASM uses ZK proofs for selective reputation disclosure, zk-STARK's post-quantum security and no-trusted-setup properties are relevant. Primarily a cryptographic primitive paper

## Paper 1 Relevance
- **§4.2 (P pillar)**: Minimal — credential privacy is relevant but the ZKP technology choice is implementation detail. Could be a footnote.

## Verdict
⭐⭐ | Optional background citation — useful only if ASM specifically discusses ZKP implementation choices. Low priority vs. the richer papers in this batch. Single-author preprint limits authority.

---
*Jason's feedback*: [待填]
