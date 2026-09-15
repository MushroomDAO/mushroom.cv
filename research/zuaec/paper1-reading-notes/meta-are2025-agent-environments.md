# [Meta AI 2025] ARE: Scaling up Agent Environments and Evaluations
**arXiv**: 2509.17158 | **Year**: 2025 | **Authors**: Meta AI (multiple authors) | **Venue**: arXiv cs.AI
**Cluster**: Evaluation Infrastructure / Benchmarking
**Status**: Full read

## Core Claim
Existing agent benchmarks rely on static, sequential environments that fail to capture real-world dynamic conditions; ARE provides an event-driven asynchronous evaluation platform with Gaia2 (1,120 scenarios, 101 tools, 10 universes) revealing that frontier models can handle search/execution but fail systematically at time-awareness, ambiguity resolution, and agent-to-agent collaboration.

## Key Evidence / Numbers
- Gaia2: 1,120 verifiable scenarios, 10 distinct synthetic universes, 101 tools, Mobile environment (smartphone simulation)
- Eight capability splits: Search/Execution, Adaptability, Time, Ambiguity, Agent2Agent, Noise, Augmentations
- Benchmark results (Pass@1, overall):
  - GPT-5 (high reasoning): 42.1%
  - Claude 4 Sonnet: 34.8%
  - Gemini 2.5 Pro: 25.8%
  - Kimi-K2: 20.1% (strongest open-source)
  - Llama 3.3 70B: 4.4%
- Capability-specific breakdown:
  - Search: GPT-5 high 79.6% (strong across models)
  - Time scenarios: <10% for most; only Claude 4 Sonnet 8.1%, Gemini 2.5 Pro 7.3%
  - Adaptability: Claude 4 Sonnet 38.1%; most others <5%
  - Agent2Agent: weaker models benefit more than frontier models
- Verifier agreement with human labels: 0.98 vs. 0.72 for baseline approach
- Event DAGs used for ground truth (not final state comparison)
- ARE supports asynchronous evaluation: environment time passes independent of agent action timing
- Key finding: "All curves plateau, suggesting standard scaffolds and/or models miss key ingredients for sustained progress"

## Paper 1 Relevance
**§5 (Evaluation / Empirical Validation)**: ARE is the most rigorous evaluation infrastructure yet for multi-agent systems and directly informs Paper 1's empirical claims about what current MAS can and cannot do. Three specific connections:
1. The persistent failure on Time (<10%) and Ambiguity capabilities confirms that role-based social agency — which provides persistent context and role-defined response norms — addresses a real performance gap.
2. The Agent2Agent split (where sub-agents replace APIs) is essentially a test of the N-pillar's collaborative model; weaker models benefiting more than frontier models suggests that network coordination protocols can amplify weaker participants, consistent with our social capital hypothesis.
3. The plateau finding across all architectures validates Paper 1's central argument: the bottleneck is not model capability but coordination paradigm.
Cite in §5 as a benchmark against which ACN performance should eventually be measured.

## Paper 2 Relevance
ARE's asynchronous event-driven architecture provides a design template for ASM's runtime model: agents in an open network cannot assume synchronous turn-taking. ASM's message semantics must handle time-driven environmental state changes, which ARE's framework explicitly models. The Noise split (tool signature changes, random events) directly motivates ASM's robustness requirements for protocol versioning and graceful degradation.

## Verdict
⭐⭐⭐⭐ | Essential empirical baseline showing where frontier MAS performance currently stands; the Time and Ambiguity failure modes directly motivate the social role agency paradigm, and Gaia2 is a strong candidate for future ACN evaluation.

## Jason's feedback
> （请在此处写入你的feedback）
