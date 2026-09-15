# [Xu et al. 2025] Towards Multi-Agent Reasoning Systems for Collaborative Expertise Delegation

**arXiv**: 2505.07313 | **Year**: 2025 | **Authors**: Baixuan Xu, Chunyang Li, Weiqi Wang, et al. (HKUST, WeBank, Hong Kong PolyU) | **Venue**: arXiv preprint
**Cluster**: Multi-Agent Collaboration / Expertise Delegation / Role Design
**Status**: Full read

## Core Claim
Three design dimensions — expertise-domain alignment, collaboration paradigm (diversity-driven vs. structured workflow), and system scale — jointly determine collective reasoning quality in multi-agent LLM systems, with domain-aligned diverse collaboration yielding the best performance-to-cost ratio.

## Key Evidence / Numbers
- **Domain alignment**: 75% of aligned configurations achieved highest accuracy; +6.75% avg improvement in Health/Law domains (contextual reasoning)
- **Diversity-driven collaboration beats structured workflows**: +1.75% avg in Business/Health; +1.25% overall
- **Scale**: Adding agents consistently improves performance non-linearly, especially for contextual tasks; math shows marginal gains
- **Token efficiency**: Contextual reasoning tasks yield higher performance-per-token than mathematical reasoning
- Dataset: MMLU-pro (Math, Business, Health, Law) with DeepSeek-R1-Distill-Qwen-7B
- Sequential communication: agent i receives full output from i-1 but only summary answers from prior agents

## Key Mechanism — Expertise Delegation
- Agents assigned specialized roles via system prompts encoding expertise group, formal role, and responsibilities
- Two collaboration modes: (a) diversity-driven — fine-grained sub-domain specialization; (b) structured workflow — functional roles (solver/critic/coordinator)
- Knowledge Recall: role framing activates domain-specific knowledge dormant in the base model
- Perspective Synthesis: sequential cascade allows each agent to refine prior reasoning rather than start fresh
- Sequential protocol avoids context explosion while enabling iterative refinement

## Paper 1 Relevance
**§3 (Role Agency) + §4 (Social Capital)** — This paper is the closest existing work to our social role agency paradigm. Agents are given *social roles with epistemic identity* (domain expert personas) rather than capability labels, and the paper shows this outperforms functional capability roles (solver/critic). The "Knowledge Recall" finding is particularly important: role framing does not just organize work — it activates deeper knowledge, suggesting that social identity has epistemic effects beyond mere task assignment. This is empirical support for our claim that social role agency is not just an organizational metaphor but a functional upgrade. However, the paper stops short of our framework: it does not address persistent identity across sessions, reputation accumulation (SC), or open/permissionless participation (N). Cite in §3.2 (role agency evidence) and §4.1 (social capital motivation — what's missing from this paper).

**Tension**: The "structured workflow" (solver/critic/coordinator) underperformance vs. diversity-driven may seem to challenge role specialization. Clarify in Paper 1: fixed functional roles ≠ social role agency; SC-mediated role emergence is different from pre-assigned workflow positions.

## Paper 2 Relevance
**ASM §3 (Role Declaration) + §4 (Delegation Protocol)** — The sequential communication algorithm (agent i → i+1 with selective history) is a concrete prior for ASM's message-passing design. ASM could adopt a similar selective-history approach to prevent context explosion while preserving reasoning chains. The expertise group + formal role + responsibilities triple maps naturally to ASM's role-bearing agent profile structure.

## Verdict
⭐⭐⭐⭐⭐ | The strongest empirical bridge between capability-container and social role paradigms — shows role identity activates deeper capabilities; essential for §3/§4 of Paper 1 and §3 of Paper 2.

## Jason's feedback

> **2026-05-25**
> 这个论文22不错呀，他有一个 collaborative expertise delegation 是一个协作专家代理是吧？他给出的几个发现不一定是全局适应，但确实是有价值的。比如说三个设计维度，专业领域、协作范式、系统规模。专业领域属于能力的范围，但我希望看一下它是如何评估专业能力、专业领域是好还是坏，是如何评估的。
>
> 协作范式是重点，我们需要借鉴和学习的。在这个论文的视角内，究竟什么是协作，什么是高质量的协作，它有什么具体的设计和产出。对，系统规模的话，嗯，这个不好说可以看一下。
>
> 专业的多样性驱动的协作优于结构化的工作流程。这个论点倒是有价值，也和我们的论文 Paper 1 Paper 2 是契合的。因为我们就是要基于这种特定的协作场景，建立协作协议和专业的入口数据。这样的话就实际上是用专业的多样性来驱动这个协作的，而不是统一的结构化的工作流程。对，然后可能一个协作一个协议，甚至一个协作多个协议都有可能。
>
> 这个知识召回，应该是 agent 的自我进化和学习的一个特征吧。对，它在这个协作和工作过程中，对有价值知识进行召回，然后存储。我猜的你可以纠正。
>
> "75% 对齐配置达到最高标准"这个数据我不太明白是什么意思，你给我解释一下。
>
> 他给的是一个领域专家的情况，比我们普通人协作更特殊，更稀少更专业一些。那他这个结论倒是可以为我们所用，就是一些特定的角色比 general 的角色效果也会好一点。
>
> 当然他欠缺的你也说出来了，就是身份啊，社会声誉啊，开放网络啊。因为开放网络实际上是一个资源和能力的互补的网络，当然也是一个多样性专业性驱动的不同协议的协作的网络。

## 技术分析：论文核心机制解读与 Jason 疑问回应

### 1. 专业领域质量如何评估

论文的评估方法是**能力触发率**（Knowledge Recall Rate）：

```
评估逻辑：
  将 MMLU-pro 题目（Health/Law/Business/Math）
  → 分别分配给"对齐角色"（Health 问题→医疗专家 agent）
                     vs "错位角色"（Health 问题→法律专家 agent）
  → 测量最终答案准确率差异

核心指标：
  - 领域准确率：domain-aligned vs misaligned 的答题正确率
  - 性能增益：对齐配置 +6.75%（Health/Law 语境推理类）
  - 无增益领域：Math（符号推理，不依赖领域知识语境）
```

**结论**：他们的"专业领域好坏"不是直接评估 agent 能不能做这件事，而是测量"给对了角色身份后，模型内部的领域知识会不会更好地被调用"。

### 2. 论文视角内的"协作"定义和高质量协作

```
协作结构（论文实现）：
  Agent 0（专家 A）→ 输出完整推理 → Agent 1（专家 B）接收
  Agent 1 只接收：上一个 agent 的完整输出 + 更早 agent 的摘要答案（非完整推理）
  → 防止 context 爆炸，同时保留推理链
  → 称为：Sequential Cascade Protocol（顺序级联协议）
```

**什么是高质量协作**（论文定义）：
| 维度 | 低质量 | 高质量 |
|------|--------|--------|
| 专业对齐 | 通用 assistant 角色 | 领域专家角色（Health/Law/Business）|
| 协作范式 | 结构化工作流（solver→critic→coordinator 固定流）| 多样性驱动（不同子域专家平行精炼）|
| context 传递 | 完整历史（context 爆炸）| 选择性摘要（保留关键，压缩次要）|
| 产出 | 单一答案 | 经多轮精炼的推理链 + 最终答案 |

**对我们 ASM 的借鉴**：Sequential Cascade 的选择性历史传递 → ASM 消息头中可以设计"推理摘要"字段，避免 relay 节点 context 爆炸。

### 3. 知识召回（Knowledge Recall）——Jason 猜测的纠正

Jason 猜测"知识召回 = agent 自我进化和学习的特征"——这个猜测**方向对但机制不同**：

```
实际机制（论文所说）：
  役前训练阶段   → base model 已经学习了大量领域知识（医疗/法律/数学）
  推理时，给角色  → "你是一位专科心脏病医生" 这个 system prompt
  → 激活模型参数中与该角色对应的知识权重
  → 模型"召回"出平时被遮蔽的领域知识

本质：不是实时学习新知识，而是"身份标签解锁预训练知识"
```

**与 Jason 说的自我进化的区别**：

| 机制 | 知识召回（本论文）| 自我进化（EvoAgentX/IML）|
|------|----------------|----------------------|
| 时机 | 推理时，靠 role prompt | 协作过程中，靠经验积累 |
| 数据变化 | 模型参数不变，只是激活不同权重 | 模型/记忆/策略实际更新 |
| 跨会话 | 不持久（每次推理重新激活）| 持久（写入记忆/权重/规则库）|

**对 Paper 3 的启示**：LAAS 的情节记忆层（Episodic Memory）应该支持"角色上下文快速加载"——让下次协作时不需要重新激活，而是直接读取上次的角色知识状态。这才是连接"知识召回"和"自我进化"的工程桥梁。

### 4. "75% 对齐配置达到最高标准"的含义

Jason 问：这个数据什么意思？

```
实验设计：
  论文测试了多种专家角色配置（不同领域、不同数量的专家组合）
  → 总配置数：N 种组合

"对齐配置" = 专家角色与问题领域匹配的配置
  例：Health 题目 → 分配了 [内科/外科/药学] 专家 = 对齐
     Health 题目 → 分配了 [法律/会计/工程] 专家 = 错位

发现：在所有专家配置中，
  75% 的"对齐配置"达到了各个任务类型的最高准确率
  → 意思是：领域对齐不是每次都有用，但大多数情况下有用
  → 25% 的情况下即使对齐也不是最优（可能因 agent 间讨论引入噪声）
```

**Jason 的直觉正确**：这个数字说明领域对齐有统计显著性但不是万能药——Math 领域几乎没有增益（符号推理不依赖角色身份）；Law/Health 增益最显著（语境和案例推理高度依赖领域知识）。

### 5. "一个协作一个协议/一个协作多个协议"——与 Paper 2 的对接

Jason 提出的这个设计原则很重要：

```
论文（单一顺序协议）：
  所有 agent → 同一 Sequential Cascade Protocol → 固定流
  
我们（多协议）：
  协作场景 A（采购初步筛选）→ 协议 α（轻量 ZK 验证 + 声誉路由）
  协作场景 B（医疗多专科会诊）→ 协议 β（领域对齐 + 推理链传递）
  协作场景 C（代码审查）→ 协议 γ（功能角色 + 结构化工作流）
  
  → 同一 ASM 框架下，协议参数可配置
  → N 支柱中的 relay 根据协议类型路由到不同专家 agent 集合
```

这正是 ASM 比论文更灵活的地方：ASM 的角色声明头 + N 支柱路由 = 动态协议选择，而论文是静态配置。

### 在三篇论文中的引用位置

| 论文位置 | 引用方式 |
|---------|---------|
| **Paper 1 §3**（角色代理实证）| "Xu et al. [2025] demonstrate empirically that domain-aligned role framing outperforms generic capability labels (+6.75% in contextual domains), providing direct evidence that social role identity is a functional upgrade, not merely an organizational metaphor. Our P pillar operationalizes what their work implies: persistent role identity across sessions, not just per-task framing." |
| **Paper 2 §3**（ASM 角色声明设计）| Sequential Cascade 的选择性历史传递 → ASM 消息摘要字段设计依据 |
| **Paper 3 §3**（M5 社会通信）| 专家对齐激活效应 → LAAS 角色上下文快速加载设计动机 |
