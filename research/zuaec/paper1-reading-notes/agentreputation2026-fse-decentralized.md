# AgentReputation: A Decentralized Agentic AI Reputation Framework
**arXiv**: 2605.00073 | **Year**: 2026 | **Authors**: Mohd Sameen Chishti, Damilare Peter Oyinloye, Jingyue Li | **Venue**: FSE 2026 (Ideas, Visions and Reflections track)

## Core Claim
Decentralized AI agent marketplaces (e.g., for software engineering tasks) require a purpose-built reputation system that is context-conditioned, gaming-resistant, and verification-regime-aware — current ad hoc approaches conflate domain-specific competence and cannot verify agent claims rigorously.

## Key Evidence / Numbers
- **Three-layer architecture**: task execution layer / reputation services layer / tamper-proof persistence layer (independent evolution of each)
- **Context-conditioned reputation cards**: prevent cross-domain reputation transfer (an agent's SE-testing reputation does not spill into code-generation scores)
- **Verification escalation**: risk- and uncertainty-based regimes linked to agent metadata; escalation is adaptive, not uniform
- **Policy engine**: governs resource allocation, access control, and verification scheduling
- Published at **FSE 2026 Ideas, Visions and Reflections** — peer-reviewed venue; submitted April 2026
- Identifies three failure modes in current systems: gaming evaluations, competence non-transferability across contexts, variable verification rigor

## Paper 1 Relevance
- **Role**: SC pillar (Quantified Social Capital) — **direct peer-reviewed validation** that the field has recognized context-conditioned reputation as essential; cite as the strongest concurrent work on SC-like mechanisms
- **§3 use**: Foreground as a competitor in the SC design space. Key difference: AgentReputation is a framework for *closed* software engineering marketplaces with a known task ontology; our SC pillar is grounded in Bourdieu/Putnam social capital theory and designed for open permissionless networks with heterogeneous role types
- **Competitive positioning**: Their "context-conditioned reputation cards" ≈ our domain-scoped social capital fields; their "verification regimes" ≈ our role-verification protocol in Paper 2. We go further by (a) grounding SC in social-science theory, (b) integrating with a permissionless network (N pillar), and (c) providing a formal communication protocol (Paper 2 ASM)

## Paper 2 Relevance
**High** — This is the closest peer-reviewed competitor to Paper 2's reputation/identity layer in ASM. AgentReputation proposes verification regimes but not a message-level communication protocol. ASM operationalizes what AgentReputation leaves abstract: the on-wire format for role claims, reputation assertions, and verification challenge-response. Cite in Paper 2 §5 (Related Work) as the concurrent FSE 2026 work we build on and extend.

## Verdict
⭐⭐⭐⭐⭐ | Include as core citation — peer-reviewed FSE 2026 paper that simultaneously validates our SC + N direction and creates a clear differentiation target. Must cite in both papers.

## Jason's feedback

> **2026-05-25**
> 这个论文很棒，我们可以充分学习和借鉴。
>
> 实际上我有一篇论文已经给出了一个去中心化的 reputation + credit 机制，在 SuperPaymaster 这个仓库里，叫 **Communify**——从社区的角度，给社区活动的人群记录他们参与社区活动的贡献，从而记录他们的 reputation。而且这个 reputation 是跨社区的、global 的、不会丢失的。同时针对这些 reputation，给这些社区提供了授信的小实验——比如说我可以授信在我这儿参加过三次活动的人群 100 credit。这 credit 就能让你不需要 gas token 就可以直接做一些链上交易，基础逻辑就是他用 credit 来做记账。换句话说这些是要还的，如果不还的话 reputation 就会丢，或者被抵扣，或者形成坏账。简单说我们实现了这个 reputation + credit 机制，它是去中心化的（decentralized）。
>
> 对于这篇论文的几个具体疑问：
>
> **疑问 1：情境化声誉卡为什么要防止跨域声誉迁移？** 跨域声誉迁移是好事呀——乔丹是篮球界明星，他去拍电影也能获得粉丝。跨域声誉迁移本身就是社会网络的典型应用。他为什么要防止这个？
>
> **疑问 2：验证升级机制是中心化还是去中心化？** 如果是中心化的话，这个 reputation 实际上没什么意义和价值，因为你说了算的 reputation 不一定适用于其他的组织和业务场景。
>
> **疑问 3：策略引擎为什么要控制资源分配？** 这个需要深入看一下，不太明白它为什么要控制资源分配。
>
> **疑问 4：有一个矛盾**——它的失败模式里有"能力跨域不可迁移"，但同时又说"防止跨域声誉迁移"。一个是能力，一个是 reputation，这两个是不同的东西。能力怎么可能不能迁移呢？agent 的能力能就是能，看使用范围就可以了。感觉这篇论文和我们的范围没有那么一致，你可以再深入调研一下。

## 技术分析：论文核心机制解读与质疑回应

### 1. 情境化声誉卡（Context-Conditioned Reputation Cards）——防止跨域迁移的真实原因

**Jason 的质疑是对的，但这里有一个背景差异**：

这篇论文的场景是**软件工程 agent 市场**，是一个封闭的、有明确任务分类的商业市场。在这个语境里：

```
SE 市场的问题：
  agent A 在"SQL 数据库优化"任务上得分很高（真实能力）
  → 用这个声誉去接"前端 React 开发"的任务（不同领域）
  → 实际能力差很多，但声誉显示"高分"
  → 客户被误导，声誉系统失去可信度
```

他们防止的是**能力声誉的跨域误导**（不是社会声誉的跨域传播）——这是一个**商业市场**中的**能力认证问题**，而非社会网络中的**信任传播问题**。

**Jason 的乔丹例子是正确的**——但乔丹的情况是"个人品牌/社会信誉"的跨域传播（不同于"技术能力认证"的跨域迁移）。论文混淆了两种不同的"声誉"概念：

| 声誉类型 | 跨域行为 | 是否应该防止 |
|---------|---------|-----------|
| **技术能力声誉**（我能做 SQL 优化）| 迁移到 React 开发 = 误导 | ✅ 论文的防止有道理 |
| **社会信任声誉**（我是可靠的协作者）| 迁移到任何协作场景 = 正常 | ❌ 不应该防止（Jason 正确）|
| **个人品牌/影响力**（乔丹效应）| 跨域传播 = 社会资本变现 | ❌ 不应该防止（Lin Nan 正确）|

**对我们的启示**：我们的 SC 支柱的声誉应该是**社会信任声誉**（第二类），可以跨域传播，但需要**话题向量加权**（TrustFlow）——在某个领域贡献的声誉，对该领域有更强权重，对其他领域有较弱权重，而不是完全隔离。

### 2. 验证升级机制——中心化 vs 去中心化

论文的验证升级机制（Verification Escalation）：
```
低风险任务 → Tier 1: 声誉分足够
中风险任务 → Tier 2: 挑战-响应测试
高风险任务 → Tier 3: 密码学证据包
```

**Jason 的质疑正确**：论文没有明确说明谁来判定"风险等级"。如果是中心化的策略引擎决定，则确实有中心化风险。

**我们的改进**：
- 风险等级由**协议层定义**（每个 ASM 协议在元数据中声明所需验证层级），而非策略引擎动态判定
- 这样，验证要求是**协议内生的**，不依赖中央策略引擎

### 3. 策略引擎控制资源分配——这是闭合市场的特定需求

```
软件工程市场场景：
  - 平台有有限的计算资源（GPU 集群）
  - 策略引擎决定：哪些 agent 能接哪类任务
  - 目的：防止能力不足的 agent 占用高价值任务的资源
```

这是**闭合平台**的内部资源调度逻辑，不适用于我们的**开放无许可网络**。在 ACN 中，资源分配由**市场机制**（声誉加权路由 + 任务广播）决定，没有中央策略引擎。

### 4. 论文范围 vs 我们的范围对比

| 维度 | AgentReputation（FSE 2026）| 我们的 SC 支柱 |
|------|--------------------------|------------|
| 适用场景 | 闭合软件工程 agent 市场 | 开放无许可协作网络 |
| 声誉类型 | 技术能力声誉（域特定）| 社会信任声誉（可跨域传播，TrustFlow 加权）|
| 声誉控制 | 中央策略引擎管理 | 协议层定义 + 去中心化 relay 执行 |
| 跨域迁移 | 防止（因为是能力认证）| 允许且鼓励（因为是社会资本）|
| 理论基础 | 软件工程市场模型 | Lin Nan 社会资本理论 + TrustFlow |
| 持久化 | 防篡改数据库（中心化）| SBT 链上（去中心化）|

### 5. Communify 与 AgentReputation 的比较

| 维度 | AgentReputation | Communify（我们）|
|------|----------------|----------------|
| 声誉载体 | Reputation Cards（中心化数据库）| SBT（链上，不可转让，去中心化）|
| 信用机制 | 无 | Credit：用声誉换 gas-free 交易额度，必须偿还 |
| 跨社区 | 不支持 | ✅ 全局声誉，跨社区不丢失 |
| 坏账机制 | 无 | ✅ 不还 credit → reputation 扣除 → 坏账记录 |
| 去中心化程度 | 低（策略引擎中心化）| 高（链上合约执行，无人工干预）|

### 在论文中的引用策略

| 论文位置 | 引用方式 |
|---------|---------|
| Paper 1 §3（SC 支柱相关工作）| "AgentReputation [Chishti et al. FSE 2026] introduces context-conditioned reputation in closed SE marketplaces. Our SC pillar extends this to open permissionless networks where social trust reputation — unlike technical capability certification — *should* propagate across domains (analogous to Bourdieu's social capital transfer), modulated by topic-aware weighting (TrustFlow) rather than blocked by domain isolation." |
| Paper 2 §5（相关工作）| "AgentReputation's three-layer architecture (execution/reputation/persistence) validates the layered design principle; ASM's role-bearing protocol operationalizes what their reputation service layer leaves abstract." |
