# A Novel Zero-Trust Identity Framework for Agentic AI: Decentralized Authentication and Fine-Grained Access Control
**arXiv**: 2505.19301 | **Year**: 2025 | **Authors**: Ken Huang, Vineeth Sai Narajala, John Yeoh, et al. | **Venue**: Cloud Security Alliance (CSA) technical whitepaper / arXiv

## Core Claim
Traditional IAM (OAuth 2.0, OIDC, SAML) fundamentally fails for multi-agent systems — it assumes single entities, coarse-grained permissions, and static contexts. This paper proposes a four-layer DID+VC+ZKP framework with ANS discovery, JIT scoped VCs, and Adapter Enforcement Middleware for cross-protocol session management.

## Key Evidence / Numbers
- Identifies five concrete IAM failure scenarios: coarse-grained permissions, single-entity focus, limited context awareness, scalability failures, delegation inadequacy
- Four-layer architecture: Identity & Credential Management → Agent Discovery/Trust Establishment → Dynamic Access Control → Unified Global Session Management
- ANS naming scheme: `protocol://AgentFunction.CapabilityDomain.Provider.Version`
- JIT scoped VCs for least-privilege access
- ZKP for attribute disclosure without revealing identity
- ABAC (Attribute-Based Access Control) with Policy Decision Points using OPA/Rego
- Session State Synchronizer (SSS) on distributed ledger for global logout
- Security analysis via MAESTRO framework

## ASM Comparison (Paper 2 focus)
- **What it does**: Most comprehensive IAM replacement for multi-agent systems — covers identity creation through revocation, cross-protocol enforcement, and privacy-preserving compliance
- **Gap vs ASM**: This is a security/access-control framework, not a communication protocol. Missing: (1) role-bearing message headers for routing, (2) reputation scoring based on task performance (not security behavior), (3) permissionless participation model — the ANS naming and credential issuance still imply some authority structure
- **Paper 2 §3 use**: Cite as the fullest IAM framework ASM's identity layer builds upon; note that ASM's role layer is an addition not covered here — roles shape network routing, not just access decisions

## Paper 1 Relevance
- **§4.2 (P pillar)**: JIT scoped VCs and ABAC with dynamic context are exactly the "verifiable principal" mechanisms Paper 1's P pillar should cite
- **§5 (security)**: MAESTRO framework + zero-trust principles as background for security analysis

## Verdict
⭐⭐⭐⭐ | Include as P2 §3 citation — best single reference for "why traditional IAM fails for agents and what DID+VC+ZKP provides." Also cite in Paper 1 §4.2.

---
*Jason's feedback*: [待填]
