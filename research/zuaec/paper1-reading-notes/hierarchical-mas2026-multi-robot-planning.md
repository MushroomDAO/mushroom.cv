# [Kawabe, Takano 2026] Hierarchical LLM-Based Multi-Agent Framework with Prompt Optimization for Multi-Robot Task Planning

**arXiv**: 2602.21670 | **Year**: 2026 | **Authors**: Tomoya Kawabe, Rin Takano | **Venue**: ICRA 2026 (IEEE International Conference on Robotics and Automation; submitted Feb 25, 2026)
**Cluster**: Hierarchical MAS & Role Decomposition
**Status**: Full read

## Core Claim
Combining a three-layer hierarchical role decomposition (global → type → robot) with textual-gradient prompt optimization and meta-prompt sharing achieves substantially higher success rates in multi-robot household task planning than monolithic LLM approaches, with hierarchical structure alone contributing the majority of gains.

## Key Evidence / Numbers
- Benchmark: MAT-THOR (multi-robot household tasks)
- Compound tasks: 95% success rate (+2pp vs. prior SOTA LaMMA-P)
- Complex tasks: 84% success rate (+7pp improvement)
- Vague tasks: 60% success rate (+15pp improvement)
- Ablation contributions: hierarchical structure alone = +59pp; prompt optimization = +37pp; meta-prompt sharing = +4pp
- Three-layer hierarchy:
  1. Global layer: natural language → high-level subtask decomposition
  2. Type layer: subtask → robot category allocation by capability
  3. Robot layer: PDDL specification generation for individual agents
- Each agent maintains individual prompts + shares layer-wide meta-prompts with peers (meta-learning concept)
- Textual-gradient feedback (TextGrad-inspired) drives iterative prompt refinement when planning fails

## Paper 1 Relevance
**§3 (Role Decomposition — P pillar)**: This paper provides an empirical existence proof that hierarchical role decomposition dramatically outperforms flat agent architectures (+59pp from structure alone). For Paper 1, this validates the P pillar's emphasis on role-differentiated collaboration protocols — roles are not cosmetic but structurally load-bearing. The global/type/robot hierarchy maps onto our framework's distinction between orchestrator agents, domain-specialist agents, and executor agents. The meta-prompt sharing mechanism (homogeneous agents in the same layer share learned meta-strategies) is a practical implementation of protocol-level coordination that Paper 1 can cite as evidence that role-structured collaboration protocols are feasible and high-performing. Note: this paper stays within a closed, pre-defined robot environment — it does not address open, permissionless networks, which is our key extension.

## Paper 2 Relevance
**§4–5 (Protocol Design)**: The three-layer message routing structure (global → type → robot) offers a concrete precedent for ASM's hierarchical message schema — task decomposition requests, capability-type advertisements, and individual execution confirmations are three structurally distinct message types that ASM should natively support. The PDDL integration point (LLM → formal specification → verifiable execution) is a model for how ASM messages could carry verifiable task commitments rather than natural-language instructions only, strengthening the trust/accountability dimension.

## Verdict
⭐⭐⭐ | A strong engineering paper with clean ablations demonstrating hierarchical role decomposition is the dominant performance driver; most useful for Paper 1 §3 as an existence-proof citation, with limited relevance to open/permissionless settings that are our core contribution.

## Jason's feedback
> （请在此处写入你的feedback）
