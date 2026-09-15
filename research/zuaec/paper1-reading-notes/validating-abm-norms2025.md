# Validating Generative Agent-Based Models of Social Norm Enforcement: From Replication to Novel Predictions
**arXiv**: 2507.22049 | **Year**: 2025 | **Authors**: Cross et al. | **Venue**: arXiv preprint

## Core Claim
Generative agent-based models (GABMs) using LLM-powered agents can replicate established human psychology findings on norm enforcement only when specific cognitive architectures are present — namely, persona-based individual differences combined with theory of mind. The paper provides a systematic validation framework moving from replication to novel prediction.

## Key Evidence / Numbers
- Study 1 (Third-Party Punishment): Social architecture (persona + ToM) replicated Jordan et al. (2016) trust game; choosers sent 22% more to punishers (t=6.08, p<<0.001); punishment dropped from 64.8% (public) to 48.9% (private), quantifying reputational vs. intrinsic motivation (16 pp gap)
- Study 2 (Gossip & Ostracism): Social + Strategic Reflection architecture achieved comprehensive replication (F=509.32, η²=.74 across 6 effects); pre-round discussion periods increased mean contributions from 35.76 to 38.17 points (t=-3.52, p<0.001)
- Four agent architecture components tested: Persona, Theory of Mind, Strategic Reflection, Emotion — minimal combinations assessed via principle of parsimony
- Implementation: Concordia framework + GPT-4o; four-agent public goods game across 6 rounds

## Paper 1 Relevance
- **Role**: §4 cooperation context — establishes that norm enforcement in LLM agent populations requires architectural features analogous to social cognition (persona, ToM), validating the "Three Pillars" premise that agents need social role structure, not just capability wiring
- **§4 use**: Cite when arguing that gossip/ostracism mechanisms (precursors to SC pillar's reputation scoring) are reproducible in LLM agent systems; also supports need for structured social architecture as opposed to raw LLM behavior
- **SC pillar**: The third-party punishment and gossip+ostracism replication directly maps to quantified social capital mechanisms — reputation flows, punishment costs, exclusion voting are all SC primitives

## Paper 2 Relevance
Pre-round discussion periods (structural communication intervention) boosting contributions maps to ASM's role as a communication protocol enabling cooperative norm signaling. The Concordia framework architecture (modular prompt-chaining) is analogous to ASM message-passing design.

## Verdict
⭐⭐⭐⭐ | Include as citation — strongest methodological grounding for GABM-based norm enforcement validation; directly supports SC pillar feasibility with replication rigor
