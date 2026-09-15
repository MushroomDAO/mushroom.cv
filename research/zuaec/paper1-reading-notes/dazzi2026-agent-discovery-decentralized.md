# [Dazzi et al. 2026] Usable Agent Discovery for Decentralized AI Systems
**arXiv**: 2604.23080 | **Year**: 2025/2026 | **Authors**: Patrizio Dazzi, Emanuele Carlini, Matteo Mordacchini, Saul Urso (University of Pisa; National Research Council of Italy) | **Venue**: arXiv preprint
**Cluster**: Agent Registry & Discovery / N Pillar Infrastructure
**Status**: Full read

## Core Claim
Agent discovery in distributed systems requires simultaneously modeling node-level infrastructure instability (churn) and agent-level service readiness (warm/cold/off states); no single overlay (structured Kademlia vs. gossip Cyclon+Vicinity) dominates universally — the optimal choice depends on operating regime and latency SLO, and a novel "useful availability" metric (U_Δ) is required to capture this.

## Key Evidence / Numbers
- Simulation scale: 4,096 logical agents on 2,048 physical hosts
- Baselines: Kademlia (structured DHT) vs. Cyclon+Vicinity (gossip-based)
- Maintenance cost: Kademlia imposes substantially higher background overhead; gossip is on-demand
- Regime finding: Stable conditions → structured overlays dominate success rates; aggressive agent cooling → gossip becomes competitive or superior on latency
- Combined node + agent churn → trade-offs, no clear winner
- Semantic sparsity: Only under extreme specialization (1 skill per agent) do overlays remain distinctly separated; broader capabilities eliminate most differences
- Introduces U_Δ (useful availability within latency budget Δ) — routing success rate fails to capture cold-start delays
- 5 experimental families, confidence intervals across 5 random seeds
- Two-level churn model: node failures/recoveries + agent warm/cold/off state transitions (conceptual separation is novel)

## Paper 1 Relevance
- **§5 (N Pillar)**: The two-level churn framework (node instability + agent readiness) is the first formal model of why permissionless agent networks need dynamic discovery rather than static registries. Cite as theoretical grounding for N pillar's "permissionless" requirement — static DNS/service catalogs fail because they model only node-level state.
- **§5 (N Pillar — scalability)**: The finding that semantic sparsity has limited impact (broad-capability agents collapse overlay differences) suggests that in a large, diverse agent network, gossip-based discovery may be sufficient — relevant for ASM's lightweight discovery design.
- **§2 (Paradigm Shift)**: The U_Δ metric insight — routing success ≠ useful availability because cold-start delays dominate — is an analogy for why capability invocation metrics (can this agent be reached?) differ from social role agency metrics (is this agent ready, trusted, appropriate?).

## Paper 2 Relevance
- **§3 (ASM Architecture — N Pillar / Agent Discovery)**: The two-level churn model directly informs ASM's agent state representation. ASM's agent advertisement should include readiness state (analogous to warm/cold/off), not just capability presence.
- **§3.3 (Permissionless Registration)**: Gossip-based discovery (Cyclon+Vicinity) under churn provides a design precedent for permissionless peer-to-peer agent discovery that doesn't require a central index. Cite as infrastructure alternative to NANDA's central index.
- **§4 (Protocol Specification)**: U_Δ metric can be adapted as an ASM routing SLO metric — routing should prefer agents with high useful availability, not just raw capability match. This links discovery to the SC (reputation) layer.
- **Tension / Limitation**: Paper is about managed distributed systems (homogeneous deployment), not fully permissionless open networks with adversarial agents — note this scope limitation when citing.

## Verdict
⭐⭐⭐⭐ | Rigorous simulation with novel U_Δ metric and two-level churn model. Less directly applicable to Paper 2's protocol design than Singh et al., but provides the only empirical characterization of discovery overlay trade-offs under realistic agent state dynamics. The U_Δ concept is particularly useful for framing SC-weighted routing.

## Jason's feedback
> （请在此处写入你的feedback）
