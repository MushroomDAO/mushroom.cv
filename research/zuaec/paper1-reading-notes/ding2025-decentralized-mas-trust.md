# Decentralized Multi-Agent System with Trust-Aware Communication
**arXiv**: 2512.02410 | **Year**: 2025 | **Authors**: Yepeng Ding, Ahmed Twabi, Junwei Yu, Lingfeng Zhang, Tohru Kondo, Hiroyuki Sato | **Venue**: IEEE ISPA 2025 (Best Paper Award)

## Core Claim
A decentralized agent runtime using blockchain + self-sovereign identity (DID) enables trust-aware, censorship-resistant multi-agent interactions with performance comparable to centralized systems — demonstrated with DFS/BFS service discovery, verifiable on-chain registry, and off-chain P2P communication.

## Key Evidence / Numbers
- **IEEE ISPA 2025 Best Paper Award** — high credibility signal
- Architecture: Proxy Agents (user interface) + Service Agents (computation) across on-chain + off-chain
- Verifiable Agent Registry: smart contract with DID + capability schemas
- Trust-Aware Protocol: blockchain attestations (on-chain) + P2P communication (off-chain)
- Service Discovery: DFS and BFS traversal + delegation patterns
- Performance: on-chain costs decrease as percentage of total latency as concurrent requests scale
- Off-chain performance matches centralized systems
- Security properties: verifiable interaction cycles, communication integrity, authenticity, non-repudiation, conditional confidentiality
- Semi-formal security property analysis provided

## ASM Comparison (Paper 2 focus)
- **What it does**: Full decentralized multi-agent runtime with on-chain DID registry and off-chain P2P communication — the most complete decentralized deployment model found in this batch. Directly validates ASM's hybrid on-chain/off-chain architecture
- **Gap vs ASM**: (1) No role-bearing — DID+capability schema does not encode role type for routing; (2) No reputation mechanism — trust is based on attestation (authenticated) not reputation (earned); (3) Service discovery is DFS/BFS graph traversal, not intent-based or role-based routing; (4) The architecture is a runtime system, not a message protocol specification — ASM defines the message format and semantics within such a runtime
- **Paper 2 §4 use**: Best citation for the hybrid on-chain/off-chain architecture pattern that ASM adopts. Cite as empirical validation that this architecture achieves centralized-comparable performance. "Ding et al. [2025] demonstrate that DID-anchored decentralized runtimes achieve off-chain performance matching centralized systems; ASM's protocol operates within such runtimes and adds role-bearing message semantics"

## Paper 1 Relevance
- **§4.1 (N pillar)**: Best paper award + IEEE ISPA credibility makes this a strong citation for decentralized agent network feasibility — the N pillar's "permissionless" claim is empirically backed here
- **§4.2 (P pillar)**: DID + verifiable on-chain registry is the reference implementation for the P pillar's identity anchoring

## Verdict
⭐⭐⭐⭐⭐ | High priority — IEEE ISPA Best Paper is the strongest credibility signal in this batch. Validates ASM's hybrid architecture. Cite in P1 §4.1/4.2 and P2 §4. The role/reputation gap makes it a clean differentiation story for ASM.

---
*Jason's feedback*: [待填]
