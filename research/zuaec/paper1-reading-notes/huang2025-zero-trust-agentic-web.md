# Fortifying the Agentic Web: A Unified Zero-Trust Architecture Against Logic-layer Threats
**arXiv**: 2508.12259 | **Year**: 2025 | **Authors**: Ken Huang, Yasir Mehmood, Hammad Atta, Jerry Huang, Muhammad Zeeshan Baig, Sree Bhargavi Balija | **Venue**: arXiv preprint

## Core Claim
Proposes the first formal model of Logic-layer Prompt Control Injection (LPCI) — attacks embedding dormant malicious commands in agent persistent memory — and a unified five-layer zero-trust security architecture with mathematical bounds on attack success probability.

## Key Evidence / Numbers
- CPTQuant behavioral fingerprint compression: **2.8× compression** with **98.3% anomaly detection accuracy**
- Identity verification overhead: **10–50ms per operation**
- Access control latency: **5–20ms per authorization**
- Formal proof: LPCI success bounded as ε·∏(1−P_detection_i) across k independent layers
- Architecture layers: identity/discovery, composition/access control, deployment/enforcement, evaluation, incentivization
- DID + VC + ANS + Trust-Adaptive Runtime Environments (TARE) + Causal Chain Auditing

## ASM Comparison (Paper 2 focus)
- **What it does**: Comprehensive security framework with DID/VC identity, ANS discovery, behavioral biometrics, causal auditing — addresses the full threat surface of agentic systems
- **Gap vs ASM**: Broad security framework, not a communication protocol. Addresses security properties but does not define message format, role encoding, or reputation-weighted routing. The "trust score" in the five-layer system is security-oriented (behavioral anomaly) not reputation-oriented (task performance history)
- **Paper 2 §5 use**: Cite LPCI as the threat motivation for ASM's message authentication and audit trail requirements; cite CPTQuant as precedent for behavioral scoring in agent systems

## Paper 1 Relevance
- **§5 (risks and security)**: LPCI is the primary new attack vector to cite for persistent-memory attacks on agent systems — important addition to Paper 1's threat landscape §5
- **§4.2 (P pillar)**: DID+VC+ANS stack validated here confirms the security properties ASM's P pillar claims to provide

## Verdict
⭐⭐⭐⭐ | Include as P1 §5 citation (threat model) and P2 §5 citation (security motivation); ASM is positioned as the communication protocol layer this framework assumes but does not specify.

---
*Jason's feedback*: [待填]
