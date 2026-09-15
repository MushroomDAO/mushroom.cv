# [Chen et al. 2025] GoalAct: Enhancing LLM-Based Agents via Global Planning and Hierarchical Execution

**arXiv**: 2504.16563 | **Year**: 2025 | **Authors**: Junjie Chen, Haitao Li, Jingli Yang, Yiqun Liu, Qingyao Ai (Tsinghua University DCST) | **Venue**: arXiv preprint
**Cluster**: Agent Architecture / Hierarchical Planning
**Status**: Full read

## Core Claim
GoalAct improves LLM agent task completion by maintaining a continuously updated global plan alongside hierarchical skill-based execution, reducing planning complexity while preserving flexibility for multi-step, multi-hop tasks.

## Key Evidence / Numbers
- **12.22% average improvement** in task success rate over existing methods
- Performance gains scale with task complexity: +3.26% (1-hop) → +20% (3-hop tasks)
- Evaluated on LegalAgentBench: 300 legal tasks across six categories
- Tested across three LLMs (GPT-4o-mini, Qwen-max, GLM-4-Plus) and four baselines
- Global plan G = (P₁A₁, P₂A₂, …, PₙAₙ) dynamically updated via execution feedback
- Four high-level skill types: Searching, Coding, Writing, Finish

## Paper 1 Relevance
**§2 (Architecture Survey — Capability Invocation Paradigm)** — GoalAct exemplifies sophisticated capability-container design: agents select from a fixed skill repertoire (searching, coding, writing) based on task demands. The "hierarchical" framing refers strictly to task decomposition depth, not social hierarchy or role differentiation. There is no notion of agent identity, trust, or inter-agent social dynamics — one agent operates alone with a toolkit. Cite as evidence that even the most advanced single-agent planning systems remain capability-centric: they optimize *what* to call rather than *who* to be. The 20% gain on 3-hop tasks also shows the scalability limits of purely capability-based approaches — complexity grows with task depth, motivating social role division.

## Paper 2 Relevance
The skill taxonomy (Searching / Coding / Writing) maps loosely to capability declaration in ASM's agent profile schema — GoalAct's skill enumeration illustrates what a role-bearing agent's capability manifest might include. However, GoalAct's skills are internal; ASM is about inter-agent delegation.

## Verdict
⭐⭐⭐⭐ | Strong capability-invocation paradigm exemplar with concrete empirical numbers; useful for §2 paradigm contrast and motivating role-based decomposition.

## Jason's feedback
> （请在此处写入你的feedback）
