# Agentic Large Language Models, a Survey
**arXiv**: 2503.23037 | **Year**: 2025 | **Authors**: Aske Plaat, Max van Duijn, Niki van Stein, Mike Preuss, Peter van der Putten, Kees Joost Batenburg | **Venue**: arXiv preprint (Leiden University)

## Core Claim
Agentic LLMs are defined by three core capabilities — reason, act, and interact — and represent a paradigm where inference-time behavior generates new training data, potentially resolving data scarcity; however, the survey's "interact" layer treats multi-agent coordination as role-based collaboration without addressing identity verification or social capital accumulation.

## Key Evidence / Numbers
- Three-property framework for "agentic": (1) reason, (2) act, (3) interact
- Self-consistency improves CoT performance by 10–20 percentage points typically
- MathPrompter: 92.5% on MultiArith (up from 78.7% baseline)
- AgentHarm benchmark: 110 malicious agent tasks; GPT-4 remains vulnerable to adaptive jailbreaks
- Medical: LLMs scored higher than trained doctors on diagnostics (Goh et al., 2024)
- Survey organized around reasoning, acting, interacting — with multi-agent systems under the "interacting" category

## Paper 1 Relevance
- **Role**: Survey background; the three-property definition of agentic LLMs is the capability-centric paradigm Paper 1 contrasts with its social-role paradigm
- **§2 use**: §2 Related Work — cite as a 2025 comprehensive survey that still frames agents through capability lenses (reason/act/interact) rather than social lenses (role/reputation/network)
- **§1 use**: §1 Introduction — the "interact" capability as the third dimension directly sets up Paper 1's argument that interaction without social structure is insufficient; capability-invocation vs. social-role-agency contrast
- **Pillar**: Framework contrast — Plaat et al.'s "interact" = capability-level; Paper 1's P/SC/N = social-level; this is the paradigm shift framing

## Paper 2 Relevance
Lightly relevant — the survey's treatment of multi-agent interaction under "interacting" shows what ASM is designed to go beyond (role-based collaboration with no protocol for role attestation). Light mention in ASM §2.

## Verdict
⭐⭐⭐ | Background context — useful for §2 survey landscape, lower priority than Guo 2024 and Tran 2025 which have more specific taxonomies

## Jason's Feedback
[待填]
