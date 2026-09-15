# TrustFlow: Topic-Aware Vector Reputation Propagation for Multi-Agent Ecosystems
**arXiv**: 2603.19452 | **Year**: 2026 | **Authors**: Volodymyr Seliuchenko (robutler.ai) | **Venue**: arXiv preprint

## Core Claim
TrustFlow replaces scalar agent reputation with multidimensional reputation vectors that propagate through interaction graphs via topic-gated transfer operators — achieving 98% multi-label precision on dense graphs while resisting Sybil attacks, reputation laundering, and vote rings with ≤4 percentage-point impact.

## Key Evidence / Numbers
- Dense labeled graph precision: **98% multi-label P@5** with scalar-gated operator
- Combined graph (682 edges): **72–78% P@5** depending on operator
- Adversarial impact: **≤4 percentage-point** across Sybil, laundering, vote-ring attacks
- Graph density: "single most important determinant" of precision
- Economic signal weighting: **3× base weight** for payment-delegation interactions
- Convergence proof via contraction mapping theorem
- Four operator variants: projection, squared gating, scalar-gated, hybrid (all Lipschitz-1)
- Continuous formulation: R_new[j] = α∑ᵢw(i→j)f(R[i],eᵢⱼ) + (1-α)T[j] + C[j]
- Support for negative trust edges (moderation flags)

## ASM Comparison (Paper 2 focus)
- **What it does**: The most sophisticated reputation system in this review — topic-aware vector reputation that flows through interaction graphs, mathematically closest to ASM's topic-aware reputation scoring. Direct overlap with ASM §5 reputation mechanism
- **Gap vs ASM**: (1) No identity anchoring — TrustFlow operates on interaction graphs without requiring agents to have DID-linked identities (the graph is the trust substrate); (2) No role encoding — reputation vectors capture topic expertise but not protocol role (Coordinator, Executor, etc.); (3) Stand-alone reputation system, not integrated into a communication protocol — ASM embeds reputation into message routing decisions in real-time
- **Paper 2 §5 use**: Primary citation for topic-aware reputation — acknowledge TrustFlow as the most advanced reputation algorithm and differentiate ASM's approach: (a) reputation is DID-linked and persistent across networks (not just local graph); (b) reputation is embedded in routing, not post-hoc scored; (c) ASM's role layer adds a prior on what reputation dimensions matter per role type

## Paper 1 Relevance
- **§4.3 (S pillar)**: TrustFlow is the strongest single paper validating the S pillar's topic-aware reputation concept — cite as the mathematical foundation. The vector formulation (domain-specific reputation) directly supports Paper 1's claim that agents need multi-dimensional reputation, not just a single score

## Verdict
⭐⭐⭐⭐⭐ | Most important S pillar reference — cite in both papers. P1 §4.3: primary reputation math reference. P2 §5: primary competitor/validation for topic-aware reputation. Key differentiator: ASM integrates reputation into protocol routing + adds DID anchoring + adds role priors. Single-author preprint is the main weakness.

---
## Jason's Feedback

> **2026-05-24**
> 多维度 reputation 是很好的创新。声誉从单一数值升级为多维度话题感知向量，实际上就是从一个具体数值成为了一个 tensor（张量），每一个维度上都有数值，这个数值不是简单的好和坏，而是多维度向量的表示。
>
> 好奇的是：这个向量是如何计算的？交互图是什么东西，它为什么能传播多维度向量？
>
> 核心数据看了，很好。对于 SC 支柱来说确实要借鉴——社会资本有基础定义，但需要后边我整理出来再输入。我们需要借鉴 agent 声誉的多维度感知向量，以及传播机制。这篇论文很不错，可以借鉴和参考。

## 技术深入解析（Jason 追问，2026-05-24）

### 1. 向量如何计算？

TrustFlow 的声誉向量 R[agent] ∈ ℝ^d，每个维度对应一个**话题/领域**（如"代码评审"、"合同谈判"、"物流协调"）。

计算方式是**递归更新**，核心公式：
```
R_new[j] = α × Σᵢ w(i→j) × f(R[i], eᵢⱼ) + (1-α) × T[j] + C[j]
```
逐项解释：
- `R[i]`：邻居 i 的当前声誉向量
- `w(i→j)`：边权重（经济交互权重 3×，普通对话权重 1×）
- `eᵢⱼ`：这条边的话题标签（"在哪个领域发生了这次交互"）
- `f(...)`：话题门控函数——**只允许匹配话题的声誉分量通过**（其他维度屏蔽）
- `α`：邻居影响权重 vs 自身历史权重的平衡
- `T[j]`：agent j 自身的直接交互记录（一手数据）
- `C[j]`：常数项（防止归零的偏置）

**结果**：每次交互后，只有"本次交互相关的话题维度"被更新，其他维度不受影响。这就避免了"在 A 领域声誉高的 agent 洗白 B 领域"的问题。

---

### 2. 交互图是什么？如何传播声誉？

**交互图**（Interaction Graph）：
- 节点 = 每个 agent
- 有向边 i→j = "agent i 曾经评价过 agent j"（完成了一次协作）
- 边上标注：话题标签（"代码"、"合同"）+ 交互类型（付款/委托/纯对话）+ 评分

**传播机制**（类比 PageRank，但加了话题门控）：
```
迭代 1：j 的声誉 = 直接交互记录
迭代 2：j 的声誉 += 邻居 i 的声誉 × 话题过滤 × 边权重
迭代 3：再传播一层……
直到收敛（数学上有 Contraction Mapping 保证必然收敛）
```

**直觉理解**：如果 A 在"代码评审"领域声誉很高，A 给 B 做过代码评审并给了好评，那 B 在"代码评审"维度的声誉就会被 A 的声誉加权提升。但 A 在"物流协调"的声誉不会影响 B 的"物流协调"声誉——因为这次交互的话题标签是"代码"，不是"物流"。

**图越稠密，传播越准确**——这就是为什么 P@5 在稠密图上是 98%，稀疏图上会下降。

---

### 3. 我们 SC 支柱的借鉴与超越

| 特性 | TrustFlow | 我们的 SC 支柱 |
|------|-----------|--------------|
| 向量维度 | 话题/领域 | 社会资本维度（专业域 + 网络多样性 + 协作频率…）|
| 数据来源 | 交互图上的评价 | VC_rep（协议层颁发）+ LAAS 本地提取 |
| 身份锚定 | ❌ 无 DID | ✅ DID 绑定，跨平台可携带 |
| 协议嵌入 | ❌ 独立系统 | ✅ 嵌入 ASM 路由，实时影响消息权重 |
| 隐私保护 | ❌ 图可见 | ✅ LAAS + DP 噪声，向量不暴露原始数据 |
| 话题门控 | ✅ 精确话题过滤 | ✅ 继承（协议维度 = 话题标签）|

**Jason 提到的"社会资本的基础定义"**：待 Jason 整理后补入 Paper 1 §6（SC 支柱的理论基础），然后与 TrustFlow 的话题向量做正式对应。
