# [Kim, Gu, Park et al. 2025] Towards a Science of Scaling Agent Systems
**arXiv**: 2512.08296 | **Year**: 2025 | **Authors**: Yubin Kim, Ken Gu, Chanwoo Park, Chunjong Park, Samuel Schmidgall, A. Ali Heydari, Yao Yan, Zhihan Zhang, Yuchen Zhuang, Yun Liu, Mark Malhotra, Paul Pu Liang, Hae Won Park, Yuzhe Yang, Xuhai Xu, Yilun Du, Shwetak Patel, Tim Althoff, Daniel McDuff, Xin Liu | **Venue**: arXiv cs.AI (submitted Dec 9, 2025)
**Cluster**: Scaling Laws / Quantitative MAS Science
**Status**: Full read

## Core Claim
Multi-agent coordination is not universally beneficial: depending on task structure and architecture choice, adding agents can improve performance by up to +80.8% or degrade it by up to -70.1%; a quantitative mixed-effects model (R²=0.524, 87% architecture-selection accuracy) identifies capability saturation (single-agent baseline >45% accuracy) and tool complexity as the primary determinants of when coordination helps vs. hurts.

## Key Evidence / Numbers
- Study scale: 180 (later described as 260) controlled configurations, 4–6 benchmarks, 5 architectures, 3 LLM families (OpenAI, Google, Anthropic)
- Performance range: +80.8% (Finance Agent, centralized coordination) to -70.1% (PlanCraft, independent agents)
- Error amplification: independent agents amplify errors 17.2× vs. 4.4× for centralized coordination
- Capability saturation threshold: single-agent accuracy >~45% → coordination yields diminishing returns (β=-0.404, p<0.001)
- Token efficiency: MAS achieves 21.5–67.7 successes per 1,000 tokens vs. 67.7 for single-agent
- Communication overhead: 0% (single-agent) to 515% (hybrid architecture)
- Turn-count scaling: super-linear with agent count (exponent 1.724)
- Tool-coordination trade-off: tool-heavy tasks incur compounding coordination costs (β=-0.267, p<0.001)
- Overhead-complexity scaling: β=-0.162 (coordination overhead compounds with task complexity)
- Validation: 5-fold cross-validation + out-of-sample GPT-5.2 test; R²=0.524, 87% architecture accuracy
- Architectures tested: Single-Agent, Independent (parallel ensemble), Centralized (hierarchical), Decentralized (peer debate), Hybrid

## Paper 1 Relevance
**§4 (Three Pillars) + §5 (Empirical Claims)**: This is the most important quantitative paper for Paper 1's empirical scaffolding. Three direct contributions:
1. **Validates the paradigm shift argument**: The -70.1% degradation finding proves that naive capability-invocation (independent parallel agents) is actively harmful in structured tasks, not merely suboptimal — a strong empirical base for our §2 critique.
2. **Quantifies the SC pillar's necessity**: The 17.2× error amplification in independent vs. 4.4× in centralized coordination is the strongest empirical case for why social capital (reputation-weighted routing) must precede raw collaboration.
3. **Defines the coordination design space**: The capability saturation threshold (45%) and tool-complexity penalty give Paper 1 concrete conditions under which our ACN framework should be applied.
The 87% architecture-selection accuracy suggests a quantitative decision model for when to deploy ACN vs. single-agent systems — a framing opportunity for §5.
Cite extensively in §4 (three pillars motivation) and §5 (empirical validation + comparison baseline).

## Paper 2 Relevance
The super-linear turn-count growth (exponent 1.724) and 515% communication overhead in hybrid architectures directly motivate ASM's design constraint: message overhead must be bounded by protocol, not left to emergent agent negotiation. ASM's reputation-weighted routing is a response to the tool-coordination trade-off identified here — by routing to high-reputation agents for tool-heavy tasks, ASM reduces the coordination overhead penalty.

## Verdict
⭐⭐⭐⭐⭐ | The most empirically rigorous quantitative treatment of MAS scaling in the literature; the +80.8%/−70.1% range and 17.2× error amplification are must-cite numbers for Paper 1's empirical motivation. Treat as a cornerstone reference.

## Jason's feedback

> **2026-05-24**
> 这个论文很不错，对 agent 规模做了很多探索和尝试。180 多种配置，5 种架构。
>
> **去中心化辩论**想了解它的结构特征。
>
> 多 agent 的协调不一定有益——这个很正常，因为它只是本能地让 agent 去协调协作，并没有建立 agent 的协作基础协议。这也是我们要建立的。如果没有这些协议，什么都可能发生，就如同得到的结果一样——可以提升近一倍，也可以降低近一倍。反而证明了需要一个 agent 协作协议来保证协作结果是正向的。
>
> 独立 agent 错误放大率 17.2 倍，中心化协调 4.4 倍——这证明协作在某种程度上有相互制约和相互验证，让错误放大倍率有所降低。中心化协调有控制，在边界上给出了一些风险控制；独立 agent 没有这个控制。
>
> **能力饱和门槛这个结论有问题**。我认为在 2 到 3 年内，单体 agent 的准确率一定会突破 60% 甚至 70% 以上。给出的"大于 45% 协调边际效应递减"——为什么能力越强、准确率越高，它的边际效应会递减？这有点反逻辑。就如同一个有能力的个体，他跟全社会协作，会放大它的能力而不是递减。一个有能力的人跟全社会协作，会放大他的能力，而不是递减。这个逻辑结论有点反逻辑。
>
> 通信开销大——这也说明我们的通信协议要设计好。
>
> 量化选择模型（87%）可以深入介绍一下，对我们有什么借鉴意义。
>
> **重要纠正**：-70.1% 的降级数据不能说是"naive 并行多 agent 有害"的实证。只能说协作协议没有设计好，造成上下限很大。不代表 naive 并行 agent 是有害的——有害和无序是两回事。

## 架构深度解析（Jason 追问）

### 去中心化辩论（Decentralized Debate）的结构

```
Round 1: 每个 agent 独立生成答案 A1, A2, A3...
Round 2: 所有 agent 看到彼此答案 → 互相批评 / 质疑
Round 3: 每个 agent 基于批评修改自己的答案
... 迭代 N 轮后投票 or 取均值 → 最终结果
```

没有 leader，每个 agent 是平等的辩手（类似"多个法官互相质疑后投票"）。

**核心问题**：若多数 agent 犯同样的错误，辩论会强化错误（群体极化）。独立 agent 错误放大率 17.2× 的主要来源之一。

**对比中心化**：中心化有 leader 做最终裁决，错误放大率 4.4× 低得多——因为 leader 承担了最终判断责任，隔离了部分错误传播。

### 180 种配置的构成

```
5 种架构 × 6 个 benchmark（医疗/法律/金融/规划等）
× 3 个 LLM 家族（OpenAI/Google/Anthropic）× 不同 agent 数量
≈ 180 个 (架构 × 任务 × 模型) 组合格子
```

### 量化选择模型（R²=0.524，87% 准确率）

**模型类型**：混合效应回归（Mixed-Effects Regression）

```
输入变量:
  - 单体准确率（能力饱和度）
  - 工具数量（工具复杂度）
  - 任务类型
输出: 哪种架构获得最高分

R² = 0.524: 模型解释了 52.4% 的结果方差（47.6% 未被捕捉）
87%: 在留出集上（out-of-sample，包括 GPT-5.2 测试）预测正确的概率
```

**对我们的借鉴**：这个决策框架本身有价值——"什么情况下用单体 agent，什么情况下用 ACN 协作"。可在 Paper 1 §5 中引用：基于 Kim et al. 的选择模型，**异质化互补型任务**（求职推荐、外贸采购）是 ACN 的适用场景；同质化冗余型任务可能单体已够用。

## Jason 洞见的技术分析

### 核心纠正：有害 ≠ 无序

Jason 的纠正非常精准：

| 论文的表述 | 正确解读（Jason 版）|
|-----------|----------------|
| -70.1% 降级 = naive parallel agents 有害 | -70.1% + 80.8% 大方差 = **没有协议的协作结果无序** |
| 有害是内在属性 | 无序是协议缺失的结果，不是 agent 并行的内在属性 |

**推论**：加入 ASM 协议后，并行 agent 的结果方差应该大幅收窄，下界应该显著提升。这才是 ACN 的价值主张。

### 能力饱和门槛的范畴局限（Jason 洞见）

论文的"饱和"是**同质化冗余协作**：多个 agent 做同一道题

```
同一任务 × N 个 agent → 单体已能做好 → 加人边际收益递减 ✓（论文正确）
```

Jason 描述的是**异质化互补协作**：不同 agent 贡献互补信息

```
找对象: 我有我的信息 + 对方有对方的信息 → 互补，不是冗余
外贸采购: 采购方的需求 + 供应方的货源 → 互补，不是重复做同一件事
→ 能力越强，互补价值越大 → 协作放大效应越强 ✓（Jason 正确）
```

**对 Paper 1 §4 的论证**：Kim et al. 的饱和阈值适用于**同质冗余**场景，不适用于我们的**异质互补**场景。ACN 的三个验证场景（求职推荐/社交匹配/跨境采购）全部是异质互补型——这正是 ACN 的适用域，应与 Kim et al. 的局限明确区分。

### 更新后的引用策略

| 论文位置 | 引用方式（更新版）|
|---------|----------------|
| Paper 1 §4（N 支柱规模问题）| "Kim et al. (2025) 记录到无协议 MAS 的结果方差跨越 150% 区间（-70.1% 至 +80.8%），这不是 agent 并行协作内在有害，而是协议缺失的后果 — 正是 P 支柱的设计动机" |
| Paper 1 §5（ACN 适用域界定）| "基于 Kim et al. 的架构选择模型，ACN 的适用域是异质互补型任务；同质冗余型任务单体 agent 可能已够用" |
| Paper 2 §1（问题动机）| "超线性的通信开销增长（指数 1.724）验证了 ASM 协议必须显式约束消息开销的设计决策" |
