# Large Language Model based Multi-Agents: A Survey of Progress and Challenges
**arXiv**: 2402.01680 | **Year**: 2024 | **Authors**: Taicheng Guo, Xiuying Chen et al. | **Venue**: arXiv preprint (IJCAI 2024 workshop)

## Core Claim
LLM-based multi-agent systems advance beyond single-agent architectures by specializing agents into distinct roles and enabling inter-agent communication for collective intelligence, yet still treat agents as capability-bearing workers rather than social role-bearers with identity constraints.

## Key Evidence / Numbers
- Societal simulations spanning 1,000–17,945 agents documented in the survey
- Four communication structure types: layered, decentralized, centralized, shared message pool
- Three agent profiling methods: pre-defined, model-generated, data-derived
- Identifies hallucination cascading as a critical systemic risk: "one agent's hallucination can have a cascading effect" across interconnected systems
- Three major open-source frameworks covered: MetaGPT, CAMEL, AutoGen
- Applications span problem-solving (software dev, science) and world simulation (societal dynamics, economics)

## Paper 1 Relevance
- **Role**: Primary survey background; establishes the field landscape that Paper 1 builds upon and departs from
- **§2 use**: §2 Related Work — cite as broad MAS survey to show the field's focus on communication structures and capability acquisition, with no treatment of social role or trust capital
- **Pillar**: Framework contrast — the "four communication structures" taxonomy is exactly what Paper 1 reframes from topology to social role; the gap between "profiling" (capability tags) and true social identity (SC pillar) is directly illustrated here

## Paper 2 Relevance
The "shared message pool" (MetaGPT) and "layered communication" structures are the capability-centric predecessors that ASM supersedes; cite in §2 to show what existing protocols assume (homogeneous, trusted agents) versus what ASM handles (role-bearing, reputation-tracked agents in open networks).

## Verdict
⭐⭐⭐⭐ | Include as citation — key survey background for Paper 1 §2; also cite in Paper 2 §2 as legacy communication framework contrast

## Jason's Feedback
[待填]
