# [Ren et al. 2025] Towards Scientific Intelligence: A Survey of LLM-Based Scientific Agents

**arXiv**: 2503.24047 | **Year**: 2025 | **Authors**: Jian Ren, Leng Ren, Xie, Zhang et al. (State Key Laboratory of Multimodal AI Systems, Chinese Academy of Sciences) | **Venue**: arXiv preprint
**Cluster**: Domain Specialization / Scientific Agents
**Status**: Full read

## Core Claim
LLM-based scientific agents fundamentally differ from general-purpose agents: they require deep domain expertise, specialized toolsets, and rigorous validation mechanisms — the survey argues for domain specialization over breadth as the correct design principle for research-grade agents.

## Key Evidence / Numbers
- Four planner types identified: prompt-based (ResearchAgent, ChemCrow, Coscientist), SFT-based (BioGPT, GatorTronGPT, DrugAssist), RL-based (ReFT, SciMARL, MolRL-MGPT), process supervision-based (ChemReasoner, SGA)
- Three memory mechanisms: historical context, external knowledge bases, intrinsic model knowledge
- Two tool categories: API/code library-based tools + simulator/emulation platform-based tools
- Domains covered: chemistry, materials science, biology, medicine, physics, astronomy, ML, literature review
- Benchmarks range from K-12 through expert-level and research-oriented reasoning

## Paper 1 Relevance
**§5 (Domain Specialization and the Limits of Generalist Agents)** — This survey is the best evidence that the field has bifurcated: general-purpose agents (CoALA paradigm) vs. hyper-specialized domain agents. Crucially, both branches still treat agents as capability containers — a chemistry agent is a container of chemistry tools; a biology agent is a container of biology workflows. Neither branch asks: can these specialized agents *collaborate* as social peers in an open network? The survey implicitly reveals the missing layer: domain-specialized agents need a social coordination protocol to cooperate across disciplines (e.g., a chemistry agent + a biology agent working on drug discovery). This gap motivates our P/SC/N framework — specifically the N (permissionless network) pillar that allows domain experts to participate without a priori trust relationships.

## Paper 2 Relevance
**ASM §3 (Role Declaration)** — Scientific agents naturally map to role-bearing agents: a "chemistry agent" carries a social role identity that encodes both domain expertise and epistemic authority. ASM's role field could encode domain specialization as part of the agent's social identity, enabling other agents to locate appropriate expert collaborators without central orchestration.

## Verdict
⭐⭐⭐⭐ | Comprehensive survey of domain specialization; useful for Paper 1 §5 to show the field's best domain agents still lack inter-agent social coordination.

## Jason's feedback
> （请在此处写入你的feedback）
