# [Li et al. 2025] HiPlan: Hierarchical Planning for LLM-Based Agents with Adaptive Global-Local Guidance

**arXiv**: 2508.19076 | **Year**: 2025 | **Authors**: Ziyue Li, Yuan Chang, Gaihong Yu, Xiaoqiu Le | **Venue**: arXiv preprint
**Cluster**: Agent Architecture / Hierarchical Planning
**Status**: Full read

## Core Claim
HiPlan addresses LLM agent failures on long-horizon tasks by combining retrieved global milestone guides (macroscopic task decomposition) with dynamically generated step-wise hints (real-time micro-correction), achieving significantly fewer steps and higher success rates.

## Key Evidence / Numbers
- **ALFWorld**: 82% overall success (Mixtral), 94% (LLaMA) — improvements of 4–44 percentage points over baselines
- **WebShop**: 36% success (Mixtral), 40% (LLaMA) — outperforming competitors by up to 32 points
- **Step efficiency**: 28% fewer steps on ALFWorld, 37% fewer on WebShop vs. baselines
- Offline milestone library: 3,330 total entries from 577 expert demonstrations
- Dual guidance: global "milestone action guide" + per-step retrieved trajectory hints

## Paper 1 Relevance
**§2 (Architecture Survey — Capability Invocation Paradigm)** — HiPlan, like GoalAct, optimizes the capability-container model. The "milestone library" is a knowledge base of past skill executions — agents retrieve demonstrations of *what was done* in similar states and replicate it. This is capability retrieval, not social role enactment. Crucially, HiPlan's agent has no persistent identity, no reputation, and no awareness of a collaboration network — it operates as a stateless executor guided by retrieved examples. The 28–37% step reduction demonstrates that retrieval-augmented planning can improve efficiency, but the approach remains fundamentally a single-agent capability-optimization problem. Cite alongside GoalAct to show that the field's best planning innovations still operate entirely within the old paradigm.

## Paper 2 Relevance
The milestone library concept is analogous to ASM's potential "interaction history" component — prior successful task delegations could serve as templates for future protocol exchanges.

## Verdict
⭐⭐⭐⭐ | Strong empirical results; pairs well with GoalAct as dual exemplars of the hierarchical planning branch of the capability-invocation paradigm.

## Jason's feedback
> （请在此处写入你的feedback）
