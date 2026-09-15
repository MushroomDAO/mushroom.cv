# Evaluating Cooperative Resilience in Multiagent Systems: A Comparison Between Humans and LLMs
**arXiv**: 2512.11689 | **Year**: 2025 (submitted Jan 2026) | **Authors**: Chacon-Chamorro, Pinzón, Manrique, Giraldo, Quijano (Universidad de los Andes) | **Venue**: Submitted to IEEE Transactions on Artificial Intelligence

## Core Claim
Human groups with communication achieve substantially higher cooperative resilience than LLM agents across all disruption intensities in a commons tragedy scenario. LLM agents depend critically on explicit communication channels (communication narrows the gap significantly), while humans adapt flexibly through intrinsic cooperative mechanisms. Human and LLM agents occupy semantically distinct coordination strategy spaces.

## Key Evidence / Numbers
- Environment: Melting Pot 2.0 Commons Harvest (tragedy of the commons)
- Participants: Human groups vs. GPT-4 agents, each with/without communication
- Disruptions: 9-scenario curriculum varying removal frequency and resource elimination probability (0.3–0.7)
- Results: Humans maintained stable high resilience across all disruption intensities; LLMs failed under sustained disruption
- Sustainability: Humans preserved ~60% of trees; LLMs exhausted resources by step 250 in extended (1000-step) trials
- Communication effect: significantly boosted LLM performance; only marginally improved human coordination — humans already coordinate intrinsically
- Resilience metric: harmonic mean of apple availability, tree preservation, equality (Gini), satiation
- Semantic divergence: Human and LLM messages occupied distinct embedding spaces — incompatible coordination strategies

## Paper 1 Relevance
- **Role**: §4 cooperation context + N pillar — establishes the human-LLM cooperation gap as an empirical baseline; particularly important for N pillar's claim that open agent networks need governance because LLM-only collectives fail at commons management
- **§4 use**: Cite as evidence for the fragility of LLM cooperative resilience under disruption; the 60% tree preservation (humans) vs. 0% at step 250 (LLMs) quantifies the governance deficit that SC + P pillars must address
- **Methodological note**: Resilience scoring (harmonic mean of 4 indicators) is a useful measurement framework that Paper 1 could reference for SC pillar evaluation design
- **Human-AI collaboration angle**: The semantic divergence finding (distinct embedding spaces) suggests LLM agents develop coordination strategies incompatible with human partners — relevant to the hybrid teams literature (haif2026, quan2026)

## Paper 2 Relevance
The communication boost for LLM agents (but not humans) suggests that structured protocols (ASM) are especially important for LLM-only networks — LLMs cannot self-coordinate without explicit communication scaffolding in the way humans can. ASM is the scaffolding that closes the resilience gap.

## Verdict
⭐⭐⭐ | Background citation — useful for §4 empirical grounding and the N pillar commons-tragedy scenario; the human-LLM comparison is conceptually important but the paper is from a less prominent venue (IEEE TAI submission from a Colombian university); cite as supporting evidence rather than primary; the semantic divergence finding is the most novel contribution worth highlighting
