# [Sapkota et al. 2025] AI Agents vs. Agentic AI: A Conceptual Taxonomy, Applications and Challenges
**arXiv**: 2505.10468 | **Year**: 2025 | **Authors**: Ranjan Sapkota, Konstantinos I. Roumeliotis, Manoj Karkee | **Venue**: arXiv preprint
**Cluster**: Taxonomy & Definitions
**Status**: Full read

## Core Claim
"AI Agents" (modular, LLM-driven, task-specific automation) and "Agentic AI" (multi-agent collaboration with dynamic task decomposition, persistent memory, and coordinated autonomy) are scientifically distinct paradigms; conflating them causes misapplication of design principles and inappropriate benchmarking.

## Key Evidence / Numbers
- Google Trends data confirms "significant rise in global search for both terms following emergence of large-scale generative models in late 2022"
- "AI Agent" as term first introduced in 1998; evolved significantly post-ChatGPT (November 2022)
- 9 comparative tables (Tables I–IX) across Generative AI, AI Agents, and Agentic AI
- 5 comparative dimensions: Architecture, Mechanisms, Scope/Complexity, Interaction, Autonomy
- 12 literature platforms queried (Google Scholar, IEEE Xplore, ACM, Scopus, arXiv, ChatGPT, Perplexity, DeepSeek, etc.)
- 8 application use cases: 4 for AI Agents (customer support, email filtering, content recommendation, scheduling), 4 for Agentic AI (multi-agent research, robotics, medical decision support, adaptive workflow)
- AI Agents: single-entity, tool-augmented, bounded environments, optional/limited memory
- Agentic AI: multi-entity orchestrated, persistent shared episodic/semantic memory, broad multi-step workflows

## Paper 1 Relevance
- **§2 (Definitional Scaffolding / §2.1 "What is an Agent Network?")**: Sapkota et al. provide the canonical two-way taxonomy that Paper 1's §2 needs to ground its argument. Cite Table I (Architecture) and Table V (Autonomy) as the definitional baseline before introducing the Three Pillars framework as the normative upgrade path.
- **§2 (Paradigm Shift argument)**: The AI Agents → Agentic AI progression maps precisely to our capability-invocation → social role agency shift. Agentic AI's defining features (multi-agent coordination, persistent memory, orchestration) are exactly what the P/SC/N framework enables. Use this to frame our contribution as "providing the infrastructure for Agentic AI."
- **§3 (Three Pillars Introduction)**: The paper's "Agentic AI" definition requires P (coordination protocols), SC (persistent trust memory), and N (permissionless peer discovery) — each pillar directly addresses one gap identified by Sapkota et al. Cite explicitly in the three-pillar motivation.
- **§6 (Challenges section)**: Their identified challenges (reliability, coordination complexity, scalability) map 1:1 to what SC, P, and N address respectively — use as a challenges-to-solutions frame.

## Paper 2 Relevance
- **§1 (Introduction / Motivation)**: Cite to establish that ASM targets "Agentic AI" systems (multi-agent, coordinated) rather than isolated AI Agents — sets the scope boundary for the protocol.
- **§2 (Background / Related Work)**: The architectural evolution model (Perception→Reasoning→Action → Specialized Agents + Advanced Planning + Persistent Memory + Orchestration) provides the layered view within which ASM's communication protocol sits — cite as the context layer.
- Moderate direct relevance for protocol design; primary value is as definitional citation for Paper 2's scoping section.

## Verdict
⭐⭐⭐⭐ | The best available taxonomy paper for Paper 1's §2 definitional scaffolding — replaces the withdrawn 2506.01438 and provides more rigorous treatment with 9 comparison tables. Must-cite for Paper 1; useful background for Paper 2's introduction.

## Jason's feedback

> **2026-05-25**
> 他提的这个明显就是单体和多 agent，以及我们的研究领域，就是 agent 的协作网络两块嘛。那左边肯定 AI Agent 指的是单体的这种垂直优化 agent 的方向。那另外一个就 Agentic AI 就是我们在提倡和研究的方向。它有几个关键词可以，比如说多 agent 的协作啊、动态任务分解、持久记忆、协调自主，这反正也都是我们要实现的核心能力。这个挺适合做一个追溯历史的引用，就是 AI agent 的起源，以及他们的 5 个维度的分析。9 张对比表怎么这么多呀？它对比啥呢？
>
> 从个人的角度讲，Agentic AI 更代表了这个 intelligence 的发展方向，比如说多实体编排、持久记忆、语义、多步骤，这是更往 intelligence 这个方向走。AI Agent 强调的是工程上的优化，而不是社会级别的 intelligence 的涌现。
>
> 总体来说，同意他这个演进的范式和考古，我们也是从这个方向立证或者佐证，我们是在正确的方向上。

## 技术分析：9 张对比表内容 + AI Agent vs Agentic AI 的本质区分

### 1. 9 张对比表对比的是什么

Jason 问：怎么这么多表，对比啥？

```
9 张表的覆盖范围（Tables I-IX）：

Table I：架构对比（Architecture）
  → 单体 LLM + 工具 vs 多 agent 协作图
Table II：记忆机制对比（Memory Mechanisms）
  → 无记忆/短期 vs 持久情节/语义记忆
Table III：任务处理方式（Task Decomposition）
  → 固定工作流 vs 动态分解
Table IV：交互模式（Interaction Patterns）
  → 人→agent 单向 vs agent↔agent 双向
Table V：自主性等级（Autonomy Levels）
  → 受限自主 vs 协调自主
Table VI：学习与适应（Learning & Adaptation）
  → 静态 vs 持续自我进化
Table VII：应用场景（Applications）
  → 4 个 AI Agent 场景 vs 4 个 Agentic AI 场景
Table VIII：挑战对比（Challenges）
  → 可靠性/延迟 vs 协调复杂性/信任/可扩展性
Table IX：Generative AI vs AI Agent vs Agentic AI 三方横比
  → 完整的三层递进关系
```

表多的原因：论文想做一篇"定义规范"文章——通过大量对比表建立词汇共识（类似 CoALA 的词汇统一功能）。这 9 张表是这篇论文的核心贡献，为 Paper 1 §2 提供了现成的引用支撑。

### 2. Jason 的核心洞见——工程优化 vs 社会涌现

Jason 的判断精准：

| 维度 | AI Agent | Agentic AI | 我们（P/SC/N）|
|------|---------|-----------|------------|
| 优化目标 | 单任务工程效率 | 多 agent 协调自主 | **社会级别 intelligence 涌现** |
| 记忆 | 可选/有限 | 持久情节/语义 | SC 链上跨会话记忆 |
| 交互 | 人→工具 | agent↔agent | 开放网络中任意 agent 互找 |
| 学习 | 静态 | 内部进化 | 协议层 + 声誉层 + 个体层三层进化 |
| 智能层次 | 工程 | 系统 | **社会（social intelligence）** |

**Jason 提出的关键区分**："AI Agent 是工程优化，Agentic AI 是系统协调，P/SC/N 是社会涌现" —— 这是一个清晰的三层递进。可以作为 Paper 1 §1 的开篇定位论点。

### 3. "考古引用"的使用方式

Jason 说这篇适合做"追溯历史的引用"——正确，具体用法：

**Paper 1 §2 建议引用语**：
> "Sapkota et al. [2025] provide a canonical two-way taxonomy: AI Agents optimize single-entity task performance through engineering; Agentic AI coordinates multi-entity systems with persistent memory and dynamic decomposition. We extend this progression one step further: the P/SC/N framework provides the social infrastructure that transforms Agentic AI from a closed multi-agent system into an open collaboration network — enabling social-level intelligence emergence that neither paradigm currently achieves."

**引用价值**：用他们的表 I-V 作为"旧范式的清晰定义"，然后说我们在 Agentic AI 的基础上再往上走一层（社会涌现层）。

### 4. 三层递进的正式表达（Paper 1 §1 候选框架）

```
Layer 1：AI Agent（工程优化）
  → 单体、工具增强、任务专精
  → 代表论文：Toolformer, ReAct, Voyager

Layer 2：Agentic AI（系统协调）
  → 多体、持久记忆、动态编排
  → 代表论文：MetaGPT, AutoGen, CrewAI
  → Sapkota et al. [2025] 的"Agentic AI"定义覆盖此层

Layer 3：Social Role Agency（社会涌现）← 我们的贡献
  → 开放网络、角色身份、社会资本累积、涌现协作规范
  → 代表框架：P/SC/N + ASM + ACN
  → Agentic AI 是前提，但缺少社会层的制度基础设施
```

这个三层递进回答了审稿人可能的质疑："你们和 Agentic AI 有什么不同？"——Agentic AI 是封闭协作系统，我们提供开放网络的社会制度基础设施。
