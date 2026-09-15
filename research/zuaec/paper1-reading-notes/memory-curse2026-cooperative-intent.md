# The Memory Curse: How Expanded Recall Erodes Cooperative Intent in LLM Agents
**arXiv**: 2605.08060 | **Year**: 2026 | **Authors**: Liu, Li, Du, Luo, Zeng, Tewolde, Lee, Wang, Kingsford, Conitzer | **Venue**: arXiv preprint (submitted May 2026)

## Core Claim
Counterintuitively, increasing LLM context window/memory in multi-agent cooperative settings *reduces* cooperation: expanded recall erodes forward-looking cooperative intent rather than building trust. The mechanism is not increased distrust of partners but loss of future-orientation as memory fills with past-defection evidence.

## Key Evidence / Numbers
- Prevalence: cooperation degraded in 18 of 28 model-game configurations across 7 LLMs tested over 500 rounds
- Root cause (lexical analysis of 378,000 reasoning traces): degradation stems from "eroding forward-looking intent" not increased distrust — agents become more backward-looking as memory grows
- Validation: LoRA adapter trained on forward-looking reasoning traces mitigated cooperation decay and generalized to new games
- Counterfactual test: replacing actual history with synthetic cooperative records (same prompt length) substantially restored cooperation — confirms memory *composition*, not length alone, drives the effect
- Deliberation paradox: removing explicit Chain-of-Thought reasoning often *reduced* cooperation collapse — detailed reasoning amplifies the negative memory effect
- Scale: 500-round experiments; 7 LLMs; multiple game types

## Paper 1 Relevance
- **Role**: §4 cooperation context + §5 risks — documents a non-obvious failure mode of memory-enabled agents; directly relevant to SC pillar design choices about what history information agents should track
- **§4 use**: Cite as evidence that naive memory augmentation can harm rather than help cooperation — SC's reputation scoring must be carefully designed to preserve forward-looking orientation (e.g., decay functions, forgiveness mechanisms)
- **§5 use**: The "memory curse" is a concrete institutional design risk: in an open agent network, agents with long memory may systematically become less cooperative as they accumulate defection histories
- **SC pillar design**: Practical implication — SC should score based on recent behavior + trend rather than full history; the composition of reputation data matters more than its completeness

## Paper 2 Relevance
ASM message design implication: if ASM carries history-rich context headers, agents processing those headers may exhibit memory curse effects. Protocol design should consider what historical information is exposed in role-bearing messages vs. kept in agent-private state.

## Verdict
⭐⭐⭐⭐ | Include as citation — counter-intuitive finding that challenges naive "more memory = better cooperation" assumption; directly actionable for SC pillar design; the LoRA mitigation result also suggests that role-based training (forward-looking reasoning) can counteract the curse; CMU FOCAL group (Conitzer, Tewolde) gives it strong credibility alongside CoopEval
