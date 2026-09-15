# Generative Exaggeration in LLM Social Agents: Consistency, Bias, and Toxicity
**arXiv**: 2507.00657 | **Year**: 2025 | **Authors**: Nudo et al. | **Venue**: arXiv preprint

## Core Claim
LLM agents simulating political users systematically amplify salient ideological traits ("generative exaggeration"), producing stereotypical caricatures rather than realistic simulations — a structural phenomenon rooted in LLMs prioritizing linguistic salience over contextual accuracy.

## Key Evidence / Numbers
- Dataset: 21 million X/Twitter interactions, 1,186 real users, 2024 U.S. presidential election
- 6 model variants tested: Gemini, Mistral, DeepSeek families
- Rainbow emoji: 20× more frequent in model outputs than human baseline
- Hashtags (#MAGA2024): 10–15× more frequent in model outputs
- Human emoji rate: 12.5% vs. model outputs: 49%+
- Human hashtag rate: 3.7% vs. model outputs: 50%+
- Human toxicity baseline: ~5%; Gemini Few-Shot: substantially exceeded baseline
- Few-Shot Republican agents: ~95% ideological alignment but heightened partisan tone
- Zero-Shot: uniform distribution regardless of prompted leaning

## Paper 1 Relevance
- **Role**: §4 social dynamics critique — methodological caution for social simulation claims; supports "Stop Drawing" (Ye2026) argument
- **§4 use**: Concrete quantitative evidence that LLM persona prompting exaggerates rather than replicates social identity; motivates principled role design (S pillar) over naive persona injection
- Strongest in trio with Ye2026 and DEBATE for methodological critique of simulation validity

## Paper 2 Relevance
N/A — simulation fidelity paper, not protocol design.

## Verdict
⭐⭐⭐ | Background/Include — good empirical companion to Ye2026's robustness critique; specific numbers (20×, 10–15×) are citable evidence of simulation distortion

## Jason's feedback
[ ]
