# [Sumers et al. 2023] CoALA: Cognitive Architectures for Language Agents

**arXiv**: 2309.02427 | **Year**: 2023 | **Authors**: Theodore R. Sumers, Shunyu Yao, Karthik Narasimhan, Thomas L. Griffiths (Princeton University) | **Venue**: arXiv preprint (TMLR 2024)
**Cluster**: Agent Architecture / Cognitive Frameworks
**Status**: Full read

## Core Claim
Drawing from cognitive science and symbolic AI, CoALA proposes a unified conceptual framework organizing language agents across three dimensions — memory, action space, and decision-making — to enable systematic comparison and design of agent architectures.

## Key Evidence / Numbers
- Framework covers all major memory types: working memory (across LLM calls), long-term episodic, semantic, and procedural memory
- Action space taxonomy: external grounding actions + internal reasoning/retrieval/learning actions
- Decision-making cycle: proposal → evaluation → selection → execution
- Case studies demonstrate that diverse existing agents (ReAct, Voyager, Generative Agents, etc.) can all be expressed in CoALA's vocabulary
- Framework reveals that sophisticated internal processes (planning, reflection, memory management) are already present but inconsistently implemented across systems

## Paper 1 Relevance
**§2 (Paradigm Contrast — Old vs. New)** — CoALA is the canonical "capability container" paradigm paper. It treats agents as modular cognitive machines: memory slots, action repertoires, and decision loops. The entire framework is built around what an agent *can do* (capability inventory) rather than *who an agent is* (social role, identity, trust). This is precisely the old paradigm our Paper 1 argues against. CoALA's taxonomy is valuable as the clearest articulation of the capability-centric view — cite it as the benchmark of prior art that the P/SC/N framework transcends. Specifically: CoALA has no concept of social capital, reputation, or permissionless participation — agents exist in isolated task contexts with no persistent identity across collaboration networks.

## Paper 2 Relevance
Minimal direct relevance to ASM protocol design, but CoALA's action-space taxonomy (external grounding vs. internal reasoning) is useful background for understanding what capabilities ASM messages need to invoke.

## Verdict
⭐⭐⭐⭐⭐ | The definitive systematic treatment of the capability-container paradigm — essential as our primary contrast reference for Paper 1 §2.

## Jason's feedback

> **2026-05-25**
> 正如你说的，这个论文清晰地表达了语言 agent 能做什么——它的结构决定了它的能力，而这些结构本身需要对应的能力支持。可以说它是基础 agent 的一个比较典型的设计规范。其他的 agent 其实都是语言 agent 的扩展——包括能力的扩展和结构上的扩展。
>
> **疑问：它的核心发现"跨系统实现不一致"是什么意思？** 是指很多 agent 都有复杂的内部过程管理，但每个系统实现都不一致吗？我觉得这算核心发现吗？所有系统都没有同一个标准，实现一定是不一致的——这不是废话吗？你从论文中找出真实含义告诉我。
>
> 主流 agent 都可以用它的设计语言来表达——说明它是从传统的 language agent architecture 角度给出了一个认知架构。这是一个挺好的 agent 框架，它的概念框架对我们无论是 Paper 1、Paper 2 还是 Paper 3 都有一定的借鉴意义。

## "跨系统实现不一致"的真实含义（解答 Jason 疑问）

**Jason 的质疑成立——字面理解是废话，但原文含义更深**：

CoALA 的真正发现不是"不同系统实现不同"，而是：

> **许多现有 agent 系统已经在做规划、反思、记忆管理这些高级认知行为——但它们是以各自的特设（ad hoc）方式实现的，彼此之间没有共同词汇体系。**

具体的例子：
```
同一个能力（自我反思/修正），不同系统叫法：
  ReAct:          "inner monologue"
  Reflexion:      "self-reflection"
  Chain-of-Thought: "reasoning trace"
  Generative Agents: "reflection synthesis"
  → 四个词说的是同一件事，但研究者互相不知道
```

**CoALA 的真正贡献**：通过统一词汇表，揭示了 agent 领域存在大量**隐性能力冗余**——研究者 A 以为自己在做创新，其实研究者 B 三年前已经做了同样的事，只是叫法不同。标准化词汇让后续研究可以系统比较和复用，不必反复重新发明同样的轮子。

这是**分类学贡献**（Taxonomy Contribution），价值在于降低领域碎片化——跟 Lin Nan 的社会资本理论、Kasirzadeh 的四维治理框架是同一类学术贡献：不提出新技术，而是提供新的**理解框架和统一语言**。

## 技术分析与三篇论文的借鉴

### CoALA 的三维框架 vs 我们的扩展

| CoALA 维度 | 覆盖内容 | 我们的扩展 |
|-----------|---------|---------|
| **记忆**（Memory）| 工作/情节/语义/程序四层 | Paper 3 M3 模块直接采用此分类（加 LAAS 隐私层）|
| **行动空间**（Action Space）| 外部基础行动 + 内部推理/检索/学习行动 | Paper 3 M4 行动层 + **M5 社会通信**（CoALA 无此类别）|
| **决策周期**（Decision Cycle）| 提案→评估→选择→执行 | ASM 协议中的双方确认机制对应"评估+执行" |

**CoALA 的最大空白**（Paper 1 §2 的论证核心）：
- 无社会身份：agent 没有跨任务、跨系统的持久角色
- 无声誉机制：agent 的历史行为不影响未来的协作准入
- 无网络概念：agent 在孤立任务上下文中存在，不参与开放网络

### 在三篇论文中的引用位置

| 论文位置 | 引用方式 |
|---------|---------|
| **Paper 1 §2**（范式对比）| "CoALA [Sumers et al. 2023] represents the definitive articulation of the capability-container paradigm: agents are defined by memory slots, action repertoires, and decision loops — what they *can do*, not *who they are*. The P/SC/N framework transcends this by adding the social dimension: persistent role identity (P), verifiable interaction history (SC), and open network participation (N) — none of which appear in CoALA's taxonomy." |
| **Paper 3 §2**（背景综述）| CoALA 四层记忆框架作为 M3 模块设计的理论基础；决策周期作为 agent 内部架构参考 |
| **Paper 3 §3**（五模块框架）| M1-M4 扩展自 CoALA 的行动空间+记忆分类；**M5 社会通信 = CoALA 的空白，我们的新增** |
