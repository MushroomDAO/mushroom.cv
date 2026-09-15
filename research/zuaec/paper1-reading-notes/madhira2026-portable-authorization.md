# Digital Identity for Agentic Systems: Toward a Portable Authorization Standard for Autonomous Agents
**arXiv**: 2605.11487 | **Year**: 2026 | **Authors**: Partha Madhira | **Venue**: arXiv preprint

## Core Claim
Identity alone is insufficient for cross-organizational agentic workflows — agents need portable, typed, auditable authorization payloads that are "explicit, constrained, auditable, revocable, and consistently interpretable by independent receivers." The paper proposes a portable authorization standard decoupling credential containers from authorization semantics.

## Key Evidence / Numbers
- Problem grounded in enterprise use cases: insurance claims processing, supply chain integrity
- Framework components: issuer-authored authorization payloads, typed constraint algebra, delegation attenuation, governed semantic resolution, fail-closed processing, pre-flight discovery
- Architecture deliberately separates: credential containers (JWT/JWS, VCs, OAuth RAR) from authorization payload semantics from enforcement engines
- Decision-consistent evaluation semantics to ensure uniform interpretation across trust boundaries

## ASM Comparison (Paper 2 focus)
- **What it does**: Proposes a portable, profile-agnostic authorization layer that sits above identity (DID/VC) and below task execution — addresses cross-org authorization semantics
- **Gap vs ASM**: Focuses on authorization envelope semantics but has no role layer — an agent's "role" (e.g., Coordinator, Executor) is not encoded; also no reputation mechanism or network-level routing. Portable auth is a necessary primitive but does not address how roles shape trust-weighted routing
- **Paper 2 §3 use**: Cite as related work on agent authorization — ASM extends this by embedding role-type into the VC credential schema itself, so routing decisions can be role-aware without a separate lookup

## Paper 1 Relevance
- **§4.2 (P pillar — principal identity)**: Supports the argument that agent identity must carry delegation/authorization semantics, not just cryptographic anchors; validates the "verifiable principal" design requirement
- **§5 (security)**: The constraint algebra and fail-closed semantics align with ASM's revocation and policy enforcement design

## Verdict
⭐⭐⭐ | Include as P2 citation — validates authorization-layer design; differentiate ASM on role encoding and reputation routing

---
*Jason's feedback*: [待填]
