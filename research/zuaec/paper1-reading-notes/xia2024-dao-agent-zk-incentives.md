# DAO-Agent: Zero Knowledge-Verified Incentives for Decentralized Multi-Agent Coordination
**arXiv**: 2512.20973 | **Year**: 2024 | **Authors**: Yihan Xia, Taotao Wang, Wenxin Xu, Shengli Zhang (Shenzhen University) | **Venue**: arXiv preprint

## Core Claim
DAO-Agent achieves 99.9% gas reduction for on-chain incentive verification in multi-agent LLM systems by computing Shapley value fairness off-chain and using recursive ZKP (STARK wrapped in Groth16) for constant-cost O(1) on-chain verification — making axiomatically fair agent reward distribution feasible on blockchain.

## Key Evidence / Numbers
- Gas reduction: **99.9%** (27K vs 28.6M gas for 10 agents)
- Verification time: **~0.36 seconds constant** regardless of agent count
- Proof size: **1,417–1,802 bytes** across all configurations (stable)
- Dual-commitment: IPFS CIDs + on-chain storage for output hashing
- ZKP pipeline: off-chain STARK → Groth16 compression → on-chain verification
- Shapley values: average marginal contribution across coalition permutations
- Demonstrated on cryptocurrency trading task with 4–10 agents

## ASM Comparison (Paper 2 focus)
- **What it does**: On-chain ZK-verified fair incentive distribution using cooperative game theory (Shapley) — addresses the economic fairness problem in multi-agent collaboration
- **Gap vs ASM**: (1) Incentive/reward layer, not communication protocol — DAO-Agent distributes rewards after task completion, ASM handles message routing during task execution; (2) Requires on-chain settlement — adds latency for real-time routing; (3) No role encoding in the incentive model — Shapley treats all agents symmetrically; (4) No identity/DID — agents are identified by coalition membership only
- **Paper 2 §5 use**: Cite as precedent for economically verifiable agent coordination — if ASM includes economic incentives for routing (e.g., reputation-staking), Shapley+ZKP is the fairness primitive to reference

## Paper 1 Relevance
- **§4.3 (S pillar)**: Shapley-based fair contribution measurement is a strong reference for the S pillar's reputation/contribution tracking — cooperative game theory provides axiomatic fairness guarantees
- **§5 (economic coordination)**: DAO governance + ZK verification as a model for trustless coordination in open agent networks

## Verdict
⭐⭐⭐ | Useful for Paper 1 §4.3 (Shapley as fair contribution mechanism) and Paper 2 §5 (if economic layer discussed). Limited direct relevance to communication protocol; more relevant if ASM includes economic incentives for participation.

---
*Jason's feedback*: [待填]
