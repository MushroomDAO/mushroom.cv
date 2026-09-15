# Agent Capability Negotiation and Binding Protocol (ACNBP)
**arXiv**: 2506.13590 | **Year**: 2025 | **Authors**: Huang et al. | **Venue**: arXiv preprint

## Core Claim
ACNBP provides a secure, 10-step capability negotiation and binding framework for heterogeneous multi-agent systems, integrating Agent Name Service (ANS) discovery, cryptographic capability attestation, and a MAESTRO-based seven-layer security threat model.

## Key Evidence / Numbers
- 10-step protocol with built-in digital signatures and capability attestation
- Integration with Agent Name Service (ANS) for scalable discovery
- MAESTRO threat analysis across 7 security layers
- Capability consistency checks: syntactic, semantic, operational, security, temporal dimensions
- Reference implementation on GitHub
- Document translation scenario as practical demonstration
- Formal tuple definitions for agents, capabilities, skills, bindings

## Paper 1 Relevance
- **Role**: §2 protocol landscape — formal capability binding with security model; N pillar (governance/security)
- **§2 use**: ACNBP's formal capability definitions and MAESTRO security analysis provide a rigorous baseline; cite as evidence that capability negotiation is being formalized in the field

## Paper 2 Relevance
**Competitor to ASM.** Key comparison:
- ACNBP formalizes capability (what an agent can do) with attestation — strong technical rigor
- No concept of social role or principal identity — capability ≠ social role
- ANS-based discovery is similar to ASM's role registry concept but capability-centric
- `protocolExtension` mechanism for backward-compatible evolution is a design feature ASM should consider
- ASM differentiator: role-bearing identity allows trust relationships beyond capability matching — "I trust this agent not just because it can do X, but because its principal (institution/organization) vouches for its role Y"
- Cite in §2 as "rigorous capability negotiation; ASM extends to role-social binding that capability attestation cannot provide"

## Verdict
⭐⭐⭐⭐ | Include — strong technical rigor (formal tuples, MAESTRO, 10-step protocol); directly informs ASM design decisions; capability vs. role differentiation is a clean ASM contribution

## Jason's feedback
[ ]
