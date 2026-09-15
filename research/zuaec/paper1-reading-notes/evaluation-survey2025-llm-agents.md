# [Yehudai, Eden, Li et al. 2025] A Survey on Evaluation of LLM-based Agents

**arXiv**: 2503.16416 | **Year**: 2025 (v1 Mar 20, 2025; v2 Apr 23, 2026) | **Authors**: Asaf Yehudai, Lilach Eden, Alan Li, Guy Uziel, Yilun Zhao, Roy Bar-Haim, Arman Cohan, Michal Shmueli-Scheuer | **Venue**: ACL Findings
**Cluster**: Evaluation & Benchmarking
**Status**: Full read

## Core Claim
LLM-based agents require fundamentally different evaluation methodologies than traditional LLMs — spanning planning, tool use, self-reflection, and memory — and the field has a critical gap in standardized fine-grained metrics for cost-efficiency, safety, and robustness; the survey covers 100+ distinct benchmarks and frameworks across four primary categories.

## Key Evidence / Numbers
- 100+ distinct benchmarks and evaluation frameworks surveyed
- Four primary evaluation categories:
  1. **Fundamental capabilities**: Planning, tool use, self-reflection, memory
  2. **Application-specific domains**: Web agents, software engineering, scientific research, conversational systems
  3. **Generalist agent assessment**: Cross-domain capability evaluation
  4. **Development frameworks**: Integration tools for continuous evaluation
- Critical gaps identified:
  - Limited focus on cost-efficiency, safety, and robustness
  - Lack of fine-grained evaluation beyond end-to-end success metrics
  - Insufficient emphasis on policy compliance and organizational safety protocols
  - Inadequate testing for adversarial robustness and bias mitigation
- Trend identified: movement toward realistic, dynamic benchmarks with continuously refreshed test sets
- Contributions: first comprehensive mapping of LLM agent evaluation methodologies; identification of research gaps; documentation of emerging trends
- Published at ACL Findings (peer-reviewed, competitive venue)

## Paper 1 Relevance
**§4 (Evaluation Landscape — SC pillar, empirical grounding)**: This survey establishes the evaluation landscape that Paper 1 must position against. The four-category taxonomy is directly useful for §4's literature organization. The critical gap on "policy compliance and organizational safety protocols" is precisely the evaluation dimension our SC pillar addresses — social capital scores are a continuous, multi-dimensional evaluation signal that goes beyond binary task success. The "adversarial robustness" gap maps onto our SC pillar's design requirement: reputation scores must be robust to strategic manipulation. Paper 1 §4 can cite this survey to establish that existing evaluation frameworks do not measure social/reputational dimensions, positioning SC as filling a genuine gap. The "cost-efficiency" gap is also relevant — SC could incorporate economic efficiency of collaboration as a scored dimension.

## Paper 2 Relevance
**§5–6 (Protocol Evaluation / Governance)**: The survey's finding that most benchmarks evaluate end-to-end success (not fine-grained intermediate steps) is a design implication for ASM: the protocol should emit evaluatable signals at each message exchange, not just at task completion. This enables the kind of fine-grained, step-level evaluation the survey identifies as missing. The "policy compliance" gap directly motivates ASM's role-contract enforcement mechanism — ASM messages should be evaluatable for compliance with declared role constraints.

## Verdict
⭐⭐⭐⭐ | A peer-reviewed (ACL Findings) comprehensive survey establishing the evaluation landscape; the identified gaps in policy compliance, adversarial robustness, and fine-grained metrics directly motivate our SC pillar and ASM's evaluatable message design — strong background citation for Paper 1 §4.

## Jason's feedback
> （请在此处写入你的feedback）
