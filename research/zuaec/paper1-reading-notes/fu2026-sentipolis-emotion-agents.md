# Sentipolis: Emotion-Aware Agents for Social Simulations
**arXiv**: 2601.18027 | **Year**: 2026 | **Authors**: Fu et al. | **Venue**: arXiv preprint

## Core Claim
Proposes Sentipolis, a framework that maintains continuous PAD (Pleasure-Arousal-Dominance) emotional states across multi-agent simulation interactions, addressing "emotional amnesia" in LLM social simulations and enabling long-horizon behavioral consistency.

## Key Evidence / Numbers
- 110–316% improvement in emotional continuity metrics vs. non-emotional baseline
- ~30% average improvement in communication quality metrics
- Emergent reciprocal relationships: weighted reciprocity >0.87, modularity ≈0.22
- Believability gains 35–85% for high-capacity models (GPT-5.2) but 7–26% degradation for smaller models (GPT-4o-mini)
- 25 agents, 36 time steps (12 simulated hours); 6 LLM backbones tested; inter-judge agreement ρ=0.895

## Paper 1 Relevance
- **Role**: §4 social dynamics context — emotion as persistent agent state supporting "social role" argument
- **§4 use**: Demonstrates that agent behavioral consistency requires stateful emotional grounding, not just reactive LLM calls; supports claim that identity/role needs persistence infrastructure (P pillar)
- Minor note: capacity-dependent degradation is a caution for real-world deployment claims

## Paper 2 Relevance
N/A — no protocol design, but the persistent-state requirement implicitly supports ASM's need for role-bearing identity continuity across interactions.

## Verdict
⭐⭐⭐ | Background — §4 social dynamics context; useful footnote on persistent agent state requirements

## Jason's feedback
[ ]
