# Gödel Agent: A Self-Referential Framework for Recursive Self-Improvement
**arXiv**: 2410.04444 | **Year**: 2024 | **Authors**: Yin, Wang, Pan, Wan, W.Y. Wang | **Venue**: arXiv preprint

## Core Claim
LLM-based agents can improve themselves without predefined routines or fixed optimization algorithms by dynamically modifying their own code at runtime (via monkey patching), guided only by high-level objectives — realizing the theoretical idea of a self-referential Gödel Machine in practice and outperforming both manually crafted and meta-learning-optimized agents.

## Key Evidence / Numbers
- DROP: **80.9 F1** vs. 79.4 (Meta Agent SOTA); unconstrained: 90.5
- MGSM: **64.2%** vs. 53.4% (Meta Agent); unconstrained: 90.6%
- MMLU: **70.9%** vs. 69.6%; unconstrained: 87.9%
- GPQA: **34.9%** vs. 34.6%; unconstrained: 55.7%
- Computational cost: **~$15** for a full evolutionary process vs. **$300** for Meta Agent Search
- Four core actions: `self_inspect`, `interact`, `self_update`, `continue_improve`
- Mutual recursion: decision-making function and action function call each other, enabling true self-referential improvement

## Paper 1 Relevance
- **Role**: Old paradigm contrast — the "self-referential agent" archetype; shows how the capability-centric paradigm reaches its logical extreme (an agent that rewrites the code that rewrites itself), yet the goal remains individual task performance, not social participation
- **§2 use**: Cite in §2.2 (self-improvement sub-cluster): "Gödel Agent [citation] takes self-referentiality to its limit — the agent modifies the very subroutine responsible for self-modification — yet its objective function remains personal task performance, leaving no machinery for social role, reputation, or permissionless network entry."
- **Pillar**: Framework contrast (no P, no SC, no N)

## Paper 2 Relevance
N/A — Paper 1 only. The self-referential loop is entirely inward-facing; no inter-agent communication protocol is designed or studied.

## Verdict
⭐⭐⭐⭐ | Include as direct citation — the cost efficiency ($15 vs. $300) and the SOTA benchmark performance make this a rhetorically powerful example of what the old paradigm has achieved; citing it sharpens the contrast that Paper 1 is making.

*Note: Full text retrieved from ar5iv HTML.*

## Jason's feedback
> （请在此处写入你的feedback）
