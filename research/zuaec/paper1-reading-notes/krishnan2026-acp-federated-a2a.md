# Beyond Context Sharing: A Unified Agent Communication Protocol (ACP) for Secure, Federated, and Autonomous Agent-to-Agent Orchestration
**arXiv**: 2602.15055 | **Year**: 2026 | **Authors**: Krishnan | **Venue**: arXiv preprint

## Core Claim
Proposes ACP as a standardized four-layer protocol enabling heterogeneous AI agents to discover, negotiate, and collaborate across disparate platforms — positioned as "the TCP/IP of the Agentic Web" with federated identity via DIDs and Verifiable Credentials.

## Key Evidence / Numbers
- 40% reduction in inter-agent communication latency vs. baseline
- ACP: 58ms average latency with 96% success rate under high load
- Comparison: local MCP 22ms, JSON-RPC HTTPS 145ms
- O(log N) search time for decentralized discovery with 500+ agents
- Trust score example: 0.98 based on 1.2k interactions
- ACP header overhead: 8% with 96% high-load success rate
- Cross-enterprise supply chain case study (4 companies, heterogeneous agents)

## Paper 1 Relevance
- **Role**: Protocol landscape §2 / N pillar — federated trust infrastructure using DIDs/VCs; directly relevant to governance and identity
- **§2 use**: Cite as existing protocol work that addresses identity via DIDs but lacks explicit role-bearing semantics — "ACP provides federated identity but does not formalize agent social roles or principal delegation chains, which ASM addresses"

## Paper 2 Relevance
**Direct competitor to ASM.** Key comparison:
- ACP uses DID/VC for identity (similar to ASM) + four-layer architecture (Transport/Semantic/Negotiation/Governance)
- ACP does NOT explicitly address role-bearing agent identity or principal hierarchy — agents have identity but not formalized social roles
- ASM differentiator: role as first-class protocol primitive, not just identity attestation
- Cite in §2 related work as closest protocol competitor; highlight role-bearing gap

## Verdict
⭐⭐⭐⭐⭐ | Include — **strongest direct competitor to ASM**; DID/VC overlap with ASM design; 40% latency improvement numbers credible; single-author paper may have limited peer review — verify claims

## Jason's feedback
[ ]
