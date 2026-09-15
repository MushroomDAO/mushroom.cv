# [Sun et al. 2025] Multi-Agent Coordination across Diverse Applications: A Survey
**arXiv**: 2502.14743 | **Year**: 2025 | **Authors**: Lijun Sun, Yijun Yang, Qiqi Duan, Yuhui Shi, Chao Lyu, Yu-Cheng Chang, Chin-Teng Lin, Yang Shen | **Venue**: arXiv cs.MA / cs.AI (23 pages, submitted Feb 2025)
**Cluster**: Coordination Mechanisms / Broad Surveys
**Status**: Full read

## Core Claim
A unified four-question framework ("what, why, who, how to coordinate") can account for coordination mechanisms across all MAS applications from traditional warehousing to emergent LLM-based systems, revealing that scalability, heterogeneity, and learning generalization are the field's defining unsolved challenges.

## Key Evidence / Numbers
- MAS research spans 148 of 252 Web of Science research areas, with publication volume accelerating sharply in the last decade
- Six major application categories surveyed: search/rescue, warehouse automation, logistics, transportation, humanoid robots, satellite constellations, and LLM-based systems
- Taxonomy of coordination methods: rule-based/lexicographic, game-theoretic, MARL (learning-based), and evolution-based optimization
- Three communication sub-dimensions identified: topology, timing, encoding, and form
- LLMs flagged for "poor generalization ability (e.g., hallucination)" when training data coverage is inadequate
- Open challenge: centralized solvers face "curse of dimensionality"; distributed rule-based solutions are "imperfect"

## Paper 1 Relevance
**§4 (Three Pillars — P, SC, N)**: The survey's four-question decomposition ("who to coordinate with" + "how to coordinate") maps directly onto our P-pillar (protocol) and SC-pillar (social capital determines who). The identification of scalability and heterogeneity as core unsolved challenges validates our N-pillar (permissionless network) as a genuine open problem rather than an engineering detail. The survey's gap analysis — lack of unified framework bridging general coordination theory and domain-specific LLM systems — is precisely the gap Paper 1 claims to fill. Cite in §4.1 (related work on coordination) and §4.2 (why role-based social agency addresses the "who" question better than capability invocation).

## Paper 2 Relevance
The communication sub-taxonomy (topology, timing, encoding, form) provides a framing vocabulary for ASM's design choices. The survey's acknowledgment that LLM-based MAS coordination remains under-theorized supports ASM's motivation as a missing formalization layer. The heterogeneity challenge directly motivates ASM's role-bearing message structure as a coordination primitive that works across heterogeneous agents.

## Verdict
⭐⭐⭐⭐ | Solid broad survey that legitimizes our problem space; useful as a §4 citation establishing the field's open challenges around scalability, heterogeneity, and LLM-specific coordination.

## Jason's feedback
> （请在此处写入你的feedback）
