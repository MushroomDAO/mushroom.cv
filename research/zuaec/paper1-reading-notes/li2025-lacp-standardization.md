# LLM Agent Communication Protocol (LACP) Requires Urgent Standardization: A Telecom-Inspired Protocol is Necessary
**arXiv**: 2510.13821 | **Year**: 2025 | **Authors**: Li et al. (NTU Singapore) | **Venue**: arXiv preprint

## Core Claim
The fragmentation of LLM agent communication mirrors pre-standardization telecommunications; LACP proposes a "narrow waist" three-layer protocol (Semantic/Transactional/Transport) with mandatory security-by-design to enable interoperability in safety-critical applications.

## Key Evidence / Numbers
- LACP adds only 2.9–3.5% latency overhead across payload sizes
- Payload size overhead decreases to 30% for realistic 1,964-byte messages
- Demonstrated defense against tampering attacks (signature verification failure) and replay attacks (transaction ID tracking)
- LangChain agent ↔ framework-agnostic LACP tool server interoperability demonstrated
- Semantic Layer: universal message types PLAN, ACT, OBSERVE wrapped in JSON Web Signature envelopes
- Transactional Layer: signing, sequencing, unique transaction IDs, two-phase commit support
- Transport Layer: agnostic (HTTP/2, QUIC, WebSockets)

## Paper 1 Relevance
- **Role**: §2 protocol landscape — establishes the telecom analogy for agent protocol standardization; N pillar (governance/security-by-design)
- **§2 use**: LACP's PLAN/ACT/OBSERVE message types provide a useful baseline for comparison with ASM's role-aware message structure; cite as evidence that the field recognizes standardization urgency

## Paper 2 Relevance
**Direct competitor to ASM.** Key comparison:
- LACP focuses on message security and interoperability (JWS signatures, two-phase commit) — strong on transport security
- LACP message types (PLAN/ACT/OBSERVE) are task-oriented, not role-bearing — no concept of social role or principal identity
- ASM differentiator: role-bearing identity as first-class primitive enables not just secure message passing but semantically meaningful role-to-role interaction
- Cite in §2 as "closest protocol in security design; ASM extends LACP-style security with role semantics"
- 2.9% latency overhead benchmark is a useful baseline for ASM overhead comparison

## Verdict
⭐⭐⭐⭐⭐ | Include — **strong direct competitor**; telecom analogy is powerful for §2 motivation; latency numbers provide benchmark; NTU affiliation adds credibility

## Jason's feedback
[ ]
