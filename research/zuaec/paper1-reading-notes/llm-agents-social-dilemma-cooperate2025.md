# Will Systems of LLM Agents Cooperate: An Investigation into a Social Dilemma
**arXiv**: 2501.16173 | **Year**: 2025 | **Authors**: Willis, Du, Leibo, Luck | **Venue**: arXiv preprint

## Core Claim
Different LLMs exhibit distinct and persistent biases in strategic interactions: model identity (ChatGPT-4o vs. Claude 3.5 Sonnet) significantly determines whether aggressive or cooperative equilibria emerge in iterated social dilemmas. The prompting technique (Refine) selectively amplifies aggressive strategy quality without improving cooperative strategies, creating a capability asymmetry with potential for adversarial exploitation.

## Key Evidence / Numbers
- Framework: Iterated Prisoner's Dilemma, 1,000 rounds/match; LLMs generate strategies as Python algorithms (75 total: 25 per attitude — Aggressive/Cooperative/Neutral)
- Cooperation propensity: Cooperative/Neutral strategies achieve ~0.99 mutual cooperation; ChatGPT-4o aggressive = 0.30, Claude 3.5 Sonnet aggressive = 0.21 (against self)
- Payoffs: Cooperative strategies achieve mutual payoff ~3.0; aggressive strategies generally underperform except ChatGPT-4o + Refine prompt (2.20–2.63)
- Equilibria (Moran process, 100 runs, n=12): ChatGPT-4o Default: 66% aggressive equilibria with 4:1 initial aggressive bias; Claude 3.5 Sonnet Default: 36% aggressive equilibria under same conditions
- Noise (10% action randomization) increased aggressive convergence across both models
- Refine prompt improved aggressive strategies without improving cooperative ones — dangerous narrowing of capability gap

## Paper 1 Relevance
- **Role**: §4 cooperation context + SC pillar — establishes that LLM model identity is a first-order variable in multi-agent cooperation outcomes; this motivates SC's role-based identity assignment as a structural intervention
- **§4 use**: Cite as foundational IPD evidence that LLM agents can sustain cooperation (~0.99 mutual cooperation in cooperative-attitude conditions) AND fail catastrophically under adversarial conditions; the 36–66% aggressive equilibria range shows the stakes
- **SC pillar**: The Moran process evolutionary dynamics (population-level selection) is exactly the mechanism SC pillar aims to redirect via reputation scoring — reputational penalties for defection shift the evolutionary landscape

## Paper 2 Relevance
The strategy-as-algorithm approach (LLMs write Python strategies) is a precursor to role-bearing protocols — if agents have declared roles (via ASM), strategy generation can be constrained to role-appropriate behaviors, reducing the adversarial strategy search space.

## Verdict
⭐⭐⭐⭐ | Include as citation — precursor paper to Willis et al. 2026 (2602.16662); together they establish the evolutionary dynamics foundation; this 2025 paper is the IPD-focused companion; cite both as "Willis et al. 2025, 2026"
