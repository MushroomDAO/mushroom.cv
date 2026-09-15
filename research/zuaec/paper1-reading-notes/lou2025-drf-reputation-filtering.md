# DRF: LLM-Agent Dynamic Reputation Filtering Framework
**arXiv**: 2509.05764 | **Year**: 2025 | **Authors**: Yuwei Lou, Hao Hu, Shaocong Ma, Zongfei Zhang, Liang Wang, Jidong Ge, Xianping Tao | **Venue**: arXiv preprint

## Core Claim
DRF builds an interactive rating network where agents mutually evaluate each other during task execution, then uses reputation scoring with UCB-based Multi-Armed Bandit selection to filter low-quality and potentially malicious agents — outperforming DyLAN and Reflexion on HumanEval (92.9%) and BigBench (70.5%) while reducing cost.

## Key Evidence / Numbers
- HumanEval Pass@1 (18 agents): **92.9%** vs DyLAN 88.3%, Reflexion 86.5%
- BigBench accuracy (18 agents): **70.5%** vs DyLAN 66.2%, LLM-Debate 63.4%
- Cost factor: **0.71** vs competitors 0.81–0.90 (lower = cheaper)
- Rating mechanism: forward pass (generation) + backward pass (peer evaluation) in each round
- Reputation: weighted formula combining performance scores + historical reputation with decay function
- UCB selection: balances reputation, cost, and exploration uncertainty (Multi-Armed Bandit)

## ASM Comparison (Paper 2 focus)
- **What it does**: Intra-session, task-local reputation scoring via peer mutual evaluation — agents rate each other on outputs during a single collaborative task
- **Gap vs ASM**: (1) Reputation is task-local, not persistent across sessions or networks — cannot bootstrap trust for new agents in an open network; (2) No identity anchoring — reputation scores are session-scoped, not DID-linked; (3) No role differentiation — all agents evaluated on same criteria regardless of their role type; (4) No permissionless participation model
- **Paper 2 §5 use**: Cite as the best existing intra-session reputation mechanism; contrast with ASM's persistent, DID-linked, role-aware reputation that accumulates across interactions and participants in an open network

## Paper 1 Relevance
- **§4.3 (S pillar — social/reputation)**: DRF is the strongest empirical validation of reputation-based agent selection — cite as evidence the S pillar's reputation mechanism is effective; ASM extends it to cross-session, cross-network scope

## Verdict
⭐⭐⭐⭐ | Include as P1 §4.3 and P2 §5 citation — best empirical reputation paper; clearly differentiable from ASM on persistence, identity-anchoring, and role-awareness.

---
*Jason's feedback*: [待填]
