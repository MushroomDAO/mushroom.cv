# [Yao, Chen, Zhang 2026] Competition and Cooperation of LLM Agents in Games

**arXiv**: 2604.00487 | **Year**: 2026 | **Authors**: Jiayi Yao, Cong Chen, Baosen Zhang | **Venue**: CDC 2026 (IEEE Conference on Decision and Control; submitted Apr 1, 2026)
**Cluster**: Game Theory & MAS Dynamics
**Status**: Full read

## Core Claim
LLM agents in multi-round non-zero-sum games consistently pursue Pareto-optimal cooperative outcomes rather than Nash equilibria, driven by embedded fairness reasoning — a behavior explained by a dynamic model where collaboration weight (θ) and retaliation intensity (γ) evolve across rounds based on information visibility, horizon length, and opponent behavior.

## Key Evidence / Numbers
- In resource allocation and Cournot competition games, agents approach Pareto-optimal (social welfare maximizing) solutions, not Nash equilibria
- Chain-of-thought reveals explicit fairness arithmetic: one agent computed "my profit of 0.566 is higher than the 0.50 I was getting during the Round 1 stalemate" while sustaining cooperation
- Collaboration parameter θ evolves from 0.0 → 1.0 across five rounds through mutual concession
- Tit-for-tat retaliation: γ = 1.0 when trust breaks; γ = 0 upon correction (rapid forgiveness)
- Cooperation requires: individual action observability (not just aggregate market data), multi-round horizon, non-zero-sum framing
- Competition emerges when: only aggregate data visible, single-round prompts, or endgame horizon reached
- Synthetic payoff model: combines original utility + θ (collaboration weighting) + γ (stability penalty)

## Paper 1 Relevance
**§4 (Empirical Foundations — P and SC pillars)**: This is the empirical complement to Hao2026's theoretical survey. The finding that LLMs cooperate when individual actions are *observable* is a direct argument for our SC pillar — quantified social capital makes individual contribution/reputation visible, which this paper shows is the critical precondition for sustained cooperation. The θ/γ evolution model is essentially a behavioral description of what social capital tracking formalizes. The "endgame defection" finding (cooperation collapses at horizon boundary) is a concrete threat that justifies long-horizon, persistent reputation scoring — the exact mechanism our SC pillar proposes. The fairness heuristic embedding (not rational maximization) supports the paradigm shift argument: capability-invocation systems assume rational actors; social role agency systems must account for fairness norms.

## Paper 2 Relevance
**§6 (Threat Model)**: The "information visibility" finding is a direct threat model insight — if ASM message routing hides individual agent identities or contribution attribution (e.g., anonymized aggregation), the cooperation equilibrium collapses. ASM protocol design should ensure attribution is preserved (not anonymized away) at the message layer. The γ-retaliation dynamic also implies ASM governance needs a "cool-down" mechanism: a one-strike ban would be too harsh (agents quickly forgive); graduated reputation decay is more stable.

## Verdict
⭐⭐⭐ | An elegant empirical paper with clear game-theoretic findings; the observability-cooperation link and θ/γ dynamics provide concrete design requirements for both SC pillar specification and ASM §6 threat modeling.

## Jason's feedback
> （请在此处写入你的feedback）
