# [Ruan et al. 2025] Benchmarking LLMs' Swarm Intelligence: SwarmBench

**arXiv**: 2505.04364 | **Year**: 2025 | **Authors**: Kai Ruan, Mowen Huang, Ji-Rong Wen, Hao Sun | **Venue**: arXiv preprint (cs.MA)
**Cluster**: Multi-Agent Coordination / Collective Behavior / Benchmarks
**Status**: Full read

## Core Claim
SwarmBench is the first benchmark specifically evaluating LLMs as decentralized swarm agents operating under strict local-perception and local-communication constraints, revealing that current LLMs achieve only rudimentary coordination and significantly struggle with robust long-range planning under decentralized uncertainty.

## Key Evidence / Numbers
- Five foundational swarm coordination tasks: Pursuit, Synchronization, Foraging, Flocking, Transport
- All tasks run in configurable 2D grid environments with k×k local view constraint
- Leading LLMs (deepseek-v3, o4-mini) show "significant task-dependent performance variations"
- "Rudimentary coordination" observed — no LLM achieves robust swarm-level competence
- Agents "significantly struggle with robust long-range planning and adaptive strategy formation under uncertainty inherent in decentralized scenarios"
- Key constraint differentiator: local sensory input only + local communication only (no global state access)

## Paper 1 Relevance
**§4 (The Network Pillar — Emergent Coordination in Open Networks)** — SwarmBench provides direct empirical grounding for why our N (permissionless network) pillar requires more than just connecting agents: decentralized coordination is a fundamentally hard problem that current LLMs fail at. The benchmark's strict local-perception constraint is analogous to the information environment in our open collaboration network — agents cannot see global state, must reason from local context, and must coordinate through message-passing alone. The failure results (rudimentary coordination, struggles with long-range planning) are powerful motivation for why the P (protocols) pillar is necessary: without structured communication protocols, even capable individual agents cannot coordinate effectively at the network level. Cite in §4.2 (why emergent coordination requires explicit protocol support).

The swarm intelligence frame also enriches our conceptual vocabulary: "emergent coordination" from locally-constrained agents aligns with our vision of network-level behavior emerging from role-bearing agent interactions. SwarmBench shows we are not yet there and defines the gap our framework addresses.

**Contrast point**: SwarmBench treats agents as homogeneous swarm particles with identical capabilities — no role differentiation, no social capital, no identity. This is the polar opposite of our SC pillar. Cite as the "no-role, no-capital baseline" that shows why identity and reputation matter for coordination quality.

## Paper 2 Relevance
**ASM §5 (Protocol Evaluation)** — SwarmBench's task suite (Pursuit, Foraging, Flocking) could inspire evaluation scenarios for ASM protocol effectiveness. If ASM-equipped agents can coordinate on SwarmBench tasks better than prompt-only agents, that would be strong protocol validation evidence.

## Verdict
⭐⭐⭐⭐ | Establishes that decentralized LLM coordination is an open problem; motivates the P pillar and provides contrast for the SC pillar (no-role baseline); useful for §4 and potential Paper 2 evaluation design.

## Jason's feedback
> （请在此处写入你的feedback）
