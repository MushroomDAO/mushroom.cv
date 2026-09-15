# Spiral of Silence in Large Language Model Agents
**arXiv**: 2510.02360 | **Year**: 2025 | **Authors**: Zhong et al. | **Venue**: arXiv preprint

## Core Claim
LLM agents exhibit Spiral of Silence dynamics (minority opinions fade, majority dominates) through statistical language generation alone — not emotional motivation — when exposed to historical collective opinion signals combined with persona information.

## Key Evidence / Numbers
- 2×2 experiment: History × Persona conditions on 100 agents rating films (1–10 scale)
- History + Persona condition: strong majority dominance, Mann-Kendall statistics show positive monotonic trends, Spearman correlation near 1.0
- History-only: powerful anchoring, minimal evolution (Mann-Kendall ≈ 0)
- Persona-only: diverse but uncorrelated opinions, no convergence
- Baseline: inherent positivity bias toward higher ratings
- Tested on 7 models: GPT-4o-mini, Qwen, DeepSeek, Mistral variants

## Paper 1 Relevance
- **Role**: §4 social dynamics + §5 risks — emergence of conformity pressure in agent networks without explicit coordination
- **§4 use**: Demonstrates that social influence operates at the statistical/token level, not just explicit protocol level; motivates N (Norm) pillar for explicit norm enforcement to counter implicit conformity collapse
- Key insight: "SoS dynamics emerge most clearly when both signals are present" — both context (history) and identity (persona) together create conformity pressure

## Paper 2 Relevance
§5 risk analysis — implicit social pressure as threat model for ASM open networks; warrants consideration of role-isolation mechanisms.

## Verdict
⭐⭐⭐ | Include (§4 + §5) — clean mechanistic finding with controlled experiment; good citation for opinion manipulation risk

## Jason's feedback
[ ]
