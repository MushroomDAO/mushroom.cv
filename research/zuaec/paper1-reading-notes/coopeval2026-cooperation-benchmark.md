# CoopEval: Benchmarking Cooperation-Sustaining Mechanisms and LLM Agents in Social Dilemmas
**arXiv**: 2604.15267 | **Year**: 2026 | **Authors**: Tewolde, Zhang, Guzman Piedrahita, Conitzer, Jin (CMU FOCAL; Jinesis Lab; ETH Zürich; Max Planck) | **Venue**: ICML 2026 submission

## Core Claim
Modern LLMs defect nearly 100% in single-shot social dilemmas without institutional mechanisms; however, game-theoretic cooperation mechanisms (especially Contracting and Mediation) can recover 80–100% of socially optimal welfare. The paper provides the first comparative benchmark of four cooperation-sustaining mechanisms across 6 models and 4 games, establishing that mechanism choice — not just model capability — determines cooperative outcomes.

## Key Evidence / Numbers
- Scale: 85,864+ individual decisions per model; 6 models × 4 games × 4 mechanisms; 3 repetitions each
- Models: Claude Sonnet 4.5, GPT-5.2, Gemini 3 Flash (w/wo reasoning), GPT-4o, Qwen3-30B
- Games: Prisoner's Dilemma, Traveler's Dilemma, Public Goods Game, Trust Game
- Baseline (no mechanism): all modern LLMs defect ~100%; GPT-4o exception at ~50% cooperation (except PGG at 80% defection)
- Mechanism welfare recovery: Reputation+ = 23% of socially optimal; Contracting = 80%; Mediation comparable to Contracting (Mean payoff 0.695 vs 0.801 aggregated)
- Evolutionary dynamics: under replicator dynamics, cooperation under Repetition reaches 0.992 fitness; Contract 0.999
- Mechanism hierarchy: Contract ≈ Mediation >> Repetition >> Reputation+
- Repetition vs. Reputation: Repetition substantially outperforms (Mean 0.587 vs 0.321–0.227); lower δ/k parameters counterintuitively improve Reputation effectiveness
- Decision justifications: majority cite "Individual Utility Maximization" and "Strategic Equilibrium Focus" — models recognize cooperation as rational under mechanisms
- Proposed mediators/contracts achieve Nash equilibrium 70–89% of the time; cooperative outcomes in 81–94% for Contract
- Theorem 1: all four mechanisms enable Pareto-improved equilibria achievable in subgame perfect equilibrium

## Paper 1 Relevance
- **Role**: SC pillar core evidence + methodological grounding — CoopEval is the most rigorous available benchmark for what institutional mechanisms actually achieve; directly informs SC pillar's design choice of contracting/mediation over pure reputation
- **§4 use**: Primary citation for "cooperation-sustaining mechanisms" section; Theorem 1 provides theoretical grounding; the 23% (Reputation) vs. 80% (Contract) gap is the quantitative argument for why SC needs multiple pillars including formal contracting
- **SC pillar**: Reputation+ recovering only 23% of welfare is a devastating critique of reputation-only approaches; Paper 1's SC must explain how combining reputation + contracting closes the gap
- **N pillar**: ICML venue and 85K+ decisions establish methodological credibility for Paper 1's empirical claims about agent cooperation at scale

## Paper 2 Relevance
Mediation mechanism (delegation to trusted third-party decision-maker) is architecturally closest to ASM's role-based protocol — the mediator corresponds to a role-bearing orchestrator agent. The finding that mediation achieves ~80% welfare recovery supports ASM's design as a mediation-layer protocol.

## Verdict
⭐⭐⭐⭐⭐ | Include as citation — the definitive 2026 benchmark paper for this cluster; ICML venue gives it maximum credibility; the mechanism hierarchy (Contract > Mediation > Repetition > Reputation) directly shapes SC pillar design; must-cite alongside Willis et al. for the "institutional design" argument
