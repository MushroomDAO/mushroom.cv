# [Qian et al. 2024/2025] Scaling Large-Language-Model-based Multi-Agent Collaboration (MacNet)
**arXiv**: 2406.07155 | **Year**: 2024 | **Authors**: Chen Qian et al. | **Venue**: arXiv cs.AI / cs.MA
**Cluster**: Network Topology / Scaling MAS
**Status**: Full read

## Core Claim
Multi-agent collaboration quality follows a sigmoid (logistic) growth curve with agent count rather than linear scaling, saturates rapidly at 16–32 agents, and is more sensitive to network topology than to raw agent count — with small-world-like random topologies outperforming regular dense meshes at equivalent scale.

## Key Evidence / Numbers
- MacNet organizes agents as directed acyclic graphs (DAGs): nodes = executive assistants, edges = supervisory instructors
- Six topology families tested: Chain, Star-tree, Layered-tree, Star, MLP-mesh, Random
- Benchmark results (vs. single-agent CoT baseline 0.3544–0.7222):
  - MMLU: MacNet-Random 0.6877 vs. CoT 0.3544 (+94%)
  - HumanEval: AgentVerse 0.7256; MacNet-Star 0.5549
  - SRDD: MacNet-Chain 0.8056 vs. CoT 0.7222
  - CommonGen: MacNet-Star 0.7382
  - Average: MacNet-Random 0.6522 vs. CoT 0.5757
- Performance saturation: sigmoid plateau at 2⁴–2⁵ agents (16–32 nodes)
- "Reverse degradation phenomenon": 2.27–6.24% performance reduction in some deep topologies due to context visibility constraints
- Random topologies outperform regular mesh at equal agent count/density
- Collaborative emergence speed: far faster than neural scaling (millions of parameters); meaningful gains within tens of agents

## Paper 1 Relevance
**§2 (Paradigm Shift) + §4 (N Pillar — Permissionless Network)**: MacNet provides the strongest empirical grounding for Paper 1's N-pillar argument. Two key moves:
1. The sigmoid saturation curve (~16–32 agents) challenges naive "more agents = better" intuitions, supporting our claim that the bottleneck is structural (topology/roles) not scale.
2. The superiority of small-world/random topologies over engineered hierarchies directly supports our argument that permissionless, organically growing networks can outperform centrally designed capability-invocation architectures.
The DAG + role distinction (instructors vs. assistants) is a precursor to our "social role agency" framing — MacNet shows role assignment matters even at this primitive level. Cite in §4.3 (N pillar topology evidence) and §2 (capability invocation vs. role-based framing).

## Paper 2 Relevance
MacNet's memory control mechanism (propagating refined solutions forward rather than full dialogue history) is directly analogous to ASM's message compression and reputation-weighted routing — the paper demonstrates that information selectivity is a first-class design concern, not an optimization afterthought. The DAG topology also validates ASM's assumption that agent communication graphs need not be fully connected.

## Verdict
⭐⭐⭐⭐⭐ | Essential empirical reference for the N-pillar; sigmoid saturation + topology superiority findings are among the most concrete quantitative results we have for network structure effects on MAS performance.

## 论文借鉴路径（基于 Jason feedback 提炼，2026-05-24）

**Paper 1 §4（N 支柱）引用逻辑**：
MacNet 实验证明随机拓扑在 MMLU 上比单 agent CoT 提升 94%，性能饱和点在 16-32 个 agent——说明结构质量比规模更重要。Nostr 式无许可网络天然形成随机图，这是设计优势，不是缺陷。

**Paper 2 §3（双网络模型）工程借鉴**：

| MacNet 机制 | ASM/Mycelium 对应设计 |
|------------|----------------------|
| DAG 组织 agent（有向无环图）| Relay 节点形成的有向路由图 |
| 只传精炼答案，不传全对话历史 | ASM 消息压缩 + reputation-weighted routing |
| 随机邻居引入信息多样性 | 无许可节点自由加入 relay 网络 |
| 饱和点 16-32 节点 | 建议每个协作子图控制在 ≤32 个 agent 节点 |

**如何处理随机数据而不降低性能**：MacNet 用"memory control"——每一跳只传精炼结论。ASM 对应：relay 路由附带 reputation score，接收方根据发送方 SC 值加权，而非平等对待所有随机邻居输入。

**待补充到论文的具体内容**：Paper 2 §3 需增加"网络拓扑演化"小节，说明 Mycelium relay 网络如何自然形成 random graph，以及为何不需要中央设计拓扑。

---

## Jason's feedback

> **2026-05-24**
> 我们的论文有一个欠缺的地方，就是网络拓扑的设计并没有特别清晰，只是给出了技术实现方案，但没有说明我们的网络拓扑会以什么样的形式自主自动地发展。
>
> 我希望更多地借鉴这篇论文给出的建议，比如 random graph 应该如何实现，包括在什么数量级上 random graph 就饱和了。我不是特别懂 sigmoid 饱和指的是好事还是坏事，这个指标代表什么我并不清楚。
>
> 但这篇论文的核心观点我认为跟我们是一致的，我也需要更多去借鉴和引用。比如随机拓扑如何设计、如何实现——从逻辑上、架构上和具体工程实现上，包括具体的实现方案。
>
> 随机拓扑的核心是：和你交互的 agent 邻居提供了随机的信息；精心设计的网络会让信息受阻。如何让信息更丰满和不受限制？如何帮助每个 agent 处理随机数据而不降低性能？这些需要更多借鉴这篇论文，需要提取核心路径。
