# EvolveR: Self-Evolving LLM Agents through an Experience-Driven Lifecycle
**arXiv**: 2510.16079 | **Year**: 2025 | **Authors**: Wu, Wang, Mei, Cai, Fu, Yang, Wen et al. | **Venue**: arXiv preprint

## Core Claim
LLM agents fail to systematically learn from their own experiences; EvolveR addresses this with a closed-loop lifecycle of offline self-distillation (trajectories → abstract strategic principles) + online interaction + GRPO-based policy evolution, achieving measurable self-improvement across QA benchmarks without external supervision.

## Key Evidence / Numbers
- Qwen2.5-3B with EvolveR: **0.382 average EM** across 7 QA benchmarks vs. Search-R1 baseline of 0.325
- NQ: 0.434, PopQA: 0.434, Bamboogle: 0.328
- Performance scales monotonically: 0.5B (0.150) → 1.5B (0.270) → 3B (0.382)
- Self-distillation outperforms GPT-4o teacher distillation at 3B scale (0.382 vs. 0.370) — "cognitive alignment" advantage
- Experience retrieval ablation: removing it drops 3B from 0.382 to 0.340
- Dynamic metric scoring: s(p) = (c_succ(p) + 1) / (c_use(p) + 2); underperforming principles pruned periodically
- Implemented on 8 A100 GPUs; code at GitHub (Edaizi/EvolveR)

## Paper 1 Relevance
- **Role**: Old paradigm contrast — exemplar of the experience-driven single-agent self-improvement loop; shows how the field has solved *individual* capability accumulation (offline distillation → curated experience base → RL policy update) while leaving social coordination entirely out of scope
- **§2 use**: Cite in §2.2 (self-evolution sub-cluster) to ground the observation that even the most sophisticated self-improvement pipelines operate within the capability-loop paradigm; the "experience base" is private to one agent, no shared social capital
- **Pillar**: Framework contrast (no P, no SC, no N — the experience base is a capability artifact, not a social one)

## Paper 2 Relevance
N/A — Paper 1 only. EvolveR's lifecycle has no role-bearing communication or inter-agent protocol.

## Verdict
⭐⭐⭐ | Use as background context — good concrete example of the single-agent capability-improvement paradigm; one sentence in §2 is sufficient ("e.g., EvolveR [citation] implements a closed-loop lifecycle of self-distillation and RL policy refinement").

*Note: Full text retrieved from ar5iv HTML.*

## Jason's feedback
> （请在此处写入你的feedback）
