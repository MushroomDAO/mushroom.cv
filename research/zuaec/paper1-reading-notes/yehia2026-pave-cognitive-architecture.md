# PAVE: A Cognitive Architecture for Legitimate Violation in Generative Agent Societies
**arXiv**: 2605.19351 | **Year**: 2026 | **Authors**: Yehia et al. | **Venue**: arXiv preprint (cs.MA)

## Core Claim
PAVE is a four-module cognitive architecture enabling AI agents to make structured, legitimate decisions to violate rules when justified by emergencies, balancing autonomous judgment against authority deference while maintaining bounded scope violations.

## Key Evidence / Numbers
- Four modules: Perception (context extraction, authority distance, situational severity) → Assessment (necessity, proportionality, alternatives) → Verdict (legitimacy gate with agent-specific thresholds) → Emulation (execution with violation scope constraint)
- Instantiated in Voville traffic simulation; tested across 3 scenarios, 4 LLM backbones
- Agents demonstrated: legitimate violation occurrence + authority deference + bounded scope + baseline recovery post-trigger
- Human evaluators rated PAVE agents significantly more plausible than vanilla implementations
- Ablating the legitimacy gate reproduced baseline failures (confirms gate necessity)

## Paper 1 Relevance
- **Role**: §4 norm enforcement — **directly relevant** to N (Norm) pillar; PAVE models the structured decision to deviate from norms under legitimate circumstances
- **§4 use**: PAVE is the state-of-the-art on principled norm violation in agent societies; Paper 1 §4 (norm dynamics) can cite PAVE as evidence that norm compliance is not binary — agents need structured deliberation, not just rule lists
- Unique contribution: "authority distance" as a variable in norm deference — maps to principal hierarchy in ASM

## Paper 2 Relevance
§4 (norm enforcement in ASM) — PAVE's authority-distance concept is analogous to ASM's principal hierarchy; ASM provides the protocol substrate that PAVE-style agents need to communicate their legitimacy assessments to peers and orchestrators.

## Verdict
⭐⭐⭐⭐ | Include — directly relevant to N pillar; authority-distance concept maps cleanly to ASM principal hierarchy; Voville empirical results provide credibility

## Jason's feedback
[ ]
