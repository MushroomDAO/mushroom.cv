# MOD-X: A Modular Open Decentralized eXchange Framework for Heterogeneous Interoperable AI Agents
**arXiv**: 2507.04376 | **Year**: 2025 | **Authors**: Ioannides et al. | **Venue**: arXiv preprint

## Core Claim
MOD-X proposes a layered architectural framework enabling diverse AI agents (rule-based, neural, symbolic, IoT, human-in-loop) to communicate and collaborate through semantic capability matching and contextual state sharing, addressing fragmentation across 20+ existing protocols.

## Key Evidence / Numbers
- Comparative analysis of 20+ existing protocols: MCP, A2A, ANP, AITP, AutoGen, FIPA-ACL, etc.
- Four architectural categories identified for existing approaches
- Three identified gaps: "semantic fragmentation," "state management conflicts," "security-interoperability tension"
- Worked example: travel-planning scenario with 6 specialized agents (flights, accommodation, transport, budget)
- Universal Message Bus: topic-based pub/sub for many-to-many interactions
- Translation Layer: semantic capability matching via vector embeddings + ontological alignment
- Blockchain/crypto hybrid: on-chain (high-value) + off-chain (routine) verification

## Paper 1 Relevance
- **Role**: §2 protocol landscape survey — the 20+ protocol comparison is useful for situating ASM in the broader ecosystem
- **§2 use**: MOD-X's gap taxonomy (semantic fragmentation, state management, security-interoperability) parallels ASM's motivation; cite as independent confirmation of the interoperability problem
- "Semantic capability discovery" through vector embeddings is interesting but lacks role-bearing semantics

## Paper 2 Relevance
**Competitor to ASM** — less direct than ACP/LACP. Key comparison:
- MOD-X emphasizes capability matching (what an agent can do), not role bearing (what social role an agent occupies)
- Hybrid blockchain model for verification is architecturally heavier than ASM's approach
- ASM differentiator: role as semantic primitive vs. MOD-X's capability-centric discovery
- Cite in §2 as "broad interoperability framework that addresses capability discovery but not role-identity binding"

## Verdict
⭐⭐⭐ | Include (§2 related work) — 20+ protocol survey is citable; gaps taxonomy is useful; less directly competitive than ACP/LACP; blockchain hybrid adds complexity that ASM avoids

## Jason's feedback
[ ]
