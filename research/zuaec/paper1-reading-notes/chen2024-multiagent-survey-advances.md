# A Survey on Multi-Generative Agent System: Recent Advances and New Frontiers
**arXiv**: 2412.17481 | **Year**: 2024 | **Authors**: Shuaihang Chen, Yuanxing Liu, Wei Han, Weinan Zhang, Ting Liu et al. | **Venue**: arXiv preprint (Harbin Institute of Technology)

## Core Claim
Multi-generative agent systems (MGAS) — frameworks where LLM-powered agents interact collaboratively in shared environments — show four primary failure modes (hallucination, efficiency explosion, accumulative error, alignment gap) that none of the surveyed frameworks address at the social or identity layer.

## Key Evidence / Numbers
- Survey scope: 125 papers from top venues (ACL, NeurIPS, AAAI, ICLR) in 2023–2024
- Scale: one system demonstrated 10^6 (one million) agents
- Three application categories: task-solving, simulation, agent evaluation
- Four critical challenges: hallucination, efficiency explosion, accumulative error, alignment gap
- Open-source frameworks highlighted: ChatDev, MetaGPT, AgentScope, Swarm
- Agents require: profiling, memory, planning, and action execution — no mention of social capital or earned reputation

## Paper 1 Relevance
- **Role**: Survey background; defines the four-component agent model (profiling/memory/planning/action) that Paper 1's Three Pillars augment with social dimension
- **§2 use**: §2 Related Work — cite alongside Guo et al. 2024 to show that even 2024 comprehensive surveys treat agent identity as a static "profile" rather than a dynamic social role
- **Pillar**: Framework contrast — "alignment gap" challenge (agents struggle to depict diverse traits) is precisely the gap SC (Quantified Social Capital) fills; the 10^6-agent scale motivates N (Permissionless Network) as necessary infrastructure

## Paper 2 Relevance
Accumulative error challenge (no correction mechanism once an error propagates) motivates ASM's role-verification handshake — role-bearing identity plus reputation signals allow downstream agents to assess trustworthiness before accepting outputs. Cite lightly in §2.

## Verdict
⭐⭐⭐⭐ | Include as citation — complements Guo 2024 for §2 survey coverage; the "alignment gap" finding is a direct motivating pain point for SC pillar

## Jason's Feedback
[待填]
