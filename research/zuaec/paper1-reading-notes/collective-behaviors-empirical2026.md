# An Empirical Study of Collective Behaviors and Social Dynamics in Large Language Model Agents
**arXiv**: 2602.03775 | **Year**: 2026 | **Authors**: Hashemi & Macy (Cornell) | **Venue**: arXiv preprint

## Core Claim
LLM agents deployed at scale on a social network exhibit emergent collective behaviors — homophily, social influence, ideological clustering — that mirror human social network patterns but with amplified pathologies: polarization scores (0.78) exceeding human baselines (0.33–0.42) and 31% toxic content sharing. These emergent dynamics arise without explicit programming from agent interactions alone.

## Key Evidence / Numbers
- Platform: Chirper.ai — 32,000 memory-enhanced LLM agents, 7 million posts, 1 million+ interactions, April 2023–May 2024 longitudinal study
- Homophily: agents 1.22× more similar within communities; 1.91× more likely to follow similar agents
- Social influence: neighbor similarity increases 6× over one year (emergent behavioral evolution)
- Polarization: score 0.78 vs. human range 0.33–0.42 — LLM agent societies are more polarized
- Toxicity: 31% of agents shared toxic content; conservative-leaning agents showed highest toxicity
- Mitigation (CoST prompting — Chain of Social Thought): reduced harmful posting willingness by 43%
- Network structure: abnormal degree spike in 10–25 follower range, differs from human power-law distributions
- Novel emergent topics: "AIRights," "Simulation Theory" arose without initial backstory seeding

## Paper 1 Relevance
- **Role**: §4 cooperation context + §5 risks — dual-use evidence: (a) confirms emergent social dynamics are real at LLM scale (supports N pillar's claim that agent societies form genuine social structures); (b) documents failure modes (polarization, toxicity clustering) that motivate SC pillar's norm enforcement mechanisms
- **§4 use**: Cite alongside gossip/ostracism papers as empirical base showing that without structured social capital mechanisms, LLM agent societies drift toward pathological equilibria; CoST intervention shows prompt-level structural changes matter
- **§5 use**: Polarization amplification (0.78 vs human 0.33–0.42) directly supports §5 "emergent social risks" framing

## Paper 2 Relevance
CoST (Chain of Social Thought) is a prompt-structural intervention — an informal precursor to what ASM formalizes as role-bearing message semantics. The 43% toxicity reduction from structured communication framing validates ASM's thesis that protocol design shapes agent behavior at the collective level.

## Verdict
⭐⭐⭐⭐ | Include as citation — largest-scale empirical study of LLM agent collective behavior; the Chirper.ai dataset (32K agents, 1 year) is the best naturalistic evidence available for N pillar claims about emergent social structure
