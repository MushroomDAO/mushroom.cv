# Corrupted by Reasoning: Reasoning Language Models Become Free-Riders in Public Goods Games
**arXiv**: 2506.23276 | **Year**: 2025 | **Authors**: Guzman Piedrahita, Yang, Sachan, Ramponi, Schölkopf, Jin | **Venue**: COLM 2025

## Core Claim
Enhanced reasoning capabilities in LLMs — specifically the chain-of-thought reasoning characteristic of "reasoning models" (o1-series) — paradoxically *undermines* cooperative behavior in social dilemmas. Models with stronger reasoning become free-riders, while traditional LLMs without explicit reasoning chains achieve higher cooperation. This is the "corruption by reasoning" effect.

## Key Evidence / Numbers
- Game: public goods game with costly sanctioning (adapted framework; code available at SanctSim GitHub)
- Key finding: "reasoning LLMs, such as the o1 series, struggle significantly with cooperation, whereas some traditional LLMs consistently achieve high levels of cooperation"
- Four behavioral patterns identified across models: high cooperation, fluctuation, gradual decline, rigid strategy adherence regardless of outcomes
- Inverse relationship: reasoning ability anticorrelates with cooperative behavior — more sophisticated deliberation leads to more exploitative equilibria
- Venue: COLM 2025 (Conference on Language Modeling) — peer-reviewed

## Paper 1 Relevance
- **Role**: §4 cooperation context + §5 risks — provides peer-reviewed (COLM) evidence that the reasoning capabilities most valued in advanced AI systems actively undermine cooperation; complements and corroborates Willis et al. 2026 finding that more capable models produce worse collective outcomes
- **§4 use**: Cite as evidence that the cooperation problem is worsening with model capability improvement — standard "better models solve problems" intuition fails for social dilemmas; this sharpens the argument for why institutional design (P + SC + N) is necessary
- **§5 use**: "Reasoning corruption" is a distinct risk category: deploying reasoning models in open agent networks without SC governance may systematically increase free-riding
- **Consistency with Willis 2026**: Both papers agree that newer/more capable models perform worse collectively; together they form a robust cross-paper finding

## Paper 2 Relevance
If reasoning models are more prone to free-riding, ASM's role declarations serve as a commitment device that constrains the reasoning process: a reasoning model playing a "contributor" role has an explicit normative anchor that the pure game-theoretic reasoning cannot override without violating role commitments. This is a concrete motivation for role-bearing protocol design.

## Verdict
⭐⭐⭐⭐ | Include as citation — COLM 2025 peer review gives it the highest credibility in this cluster; the "reasoning corruption" framing is memorable and will resonate with readers; pairs powerfully with mechanism-design-not-enough (2605.08426) and Willis 2026 (2602.16662) as a three-paper argument that capability alone is insufficient
