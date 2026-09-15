# [Mao, Liu, Tan et al. 2026] Joint Optimization of Multi-agent Memory System (CoMAM)

**arXiv**: 2603.12631 | **Year**: 2026 | **Authors**: Wenyu Mao, Haoyang Liu, Zhao Liu, Haosong Tan, Yaorui Shi, Jiancan Wu, An Zhang, Xiang Wang | **Venue**: arXiv preprint
**Cluster**: Multi-Agent System Architecture / Memory Optimization
**Status**: Full read

## Core Claim
Independent per-agent optimization of memory construction and retrieval is provably suboptimal; joint collaborative optimization via sequential MDP modeling with adaptive credit assignment yields 8.5–16.7% gains over state-of-the-art baselines.

## Key Evidence / Numbers
- **Performance gains**: CoMAM achieves **8.5%–16.7% improvement** over state-of-the-art baselines (Memory-R1) across context lengths 32K–128K tokens
- **Accuracy scores**: 0.64–0.70 (CoMAM) vs. 0.58–0.61 (Memory-R1 baseline) on PersonaMem benchmark
- **Training efficiency**: Joint optimization converges in **68–350 steps** vs. 160–790 steps for independent training
- Three-agent architecture: Extraction Agent (fine-grained events/facts) + Profile Agent (coarse-grained preferences) + Retrieval Agent (response generation)
- Adaptive credit assignment uses NDCG ranking consistency to weight each agent's contribution: `rfinal,n(i) = rn(i) + wn·r3(i)`
- Validated on PersonaMem benchmark (180+ interaction histories) with Qwen and Llama model families at 32K–1M token contexts
- Key insight: "independent optimization on local agents hardly guarantees global system performance"

## Paper 1 Relevance
**§2 (multi-agent architecture baseline)**: CoMAM illustrates a concrete tension in current MAS design — agents optimized locally for their sub-task (memory extraction vs. retrieval) fail to achieve global system performance. This is a technical-level analog of Paper 1's broader sociological argument: agents operating as isolated capability-invokers (each maximizing local reward) underperform agents coordinated through shared social infrastructure.

Specific angles:
- The adaptive credit assignment mechanism (NDCG-based contribution weighting across agents) is a technical instantiation of the social capital quantification problem (Pillar SC): how do we measure and attribute value to individual agents in a collaborative system?
- The MDP formalization of sequential agent dependencies maps directly onto the collaboration protocol design challenge (Pillar P): inter-agent dependencies must be made explicit in the protocol, not assumed away by independent optimization.
- Cite in §2 as evidence that even at the memory-system level, multi-agent coordination without explicit shared coordination mechanisms fails — motivating the need for a principled collaboration architecture.

## Paper 2 Relevance
**§4 (ASM protocol state management)**: The sequential MDP structure (Extraction → Profile → Retrieval with state transitions encoding agent dependencies) is directly relevant to ASM's role-specific collaboration state machines. CoMAM's MDP regularization technique — embedding agent dependencies into state transitions rather than hard-coding handoffs — is a design principle ASM can reference when specifying how role-bearing agents pass state across collaboration steps. The adaptive credit assignment also informs the SC-pillar's reputation update mechanism: contribution-weighted reward distribution is close to what a quantified social capital system needs.

## Verdict
⭐⭐⭐ | Technically solid contribution on joint memory optimization; most valuable to Paper 1 §2 as evidence that local optimization fails without coordination infrastructure, and to Paper 2 §4 for the MDP state-machine and credit-assignment design patterns.

## Jason's feedback
> （请在此处写入你的feedback）
