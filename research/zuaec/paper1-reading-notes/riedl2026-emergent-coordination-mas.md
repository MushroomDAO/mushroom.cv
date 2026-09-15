# [Riedl 2025] Emergent Coordination in Multi-Agent Language Models

**arXiv**: 2510.05174 | **Year**: 2025 | **Authors**: C. Riedl | **Venue**: arXiv preprint (2025)
**Cluster**: Emergent Coordination / Collective Intelligence / Multi-Agent LLM Systems
**Status**: Full read

## Core Claim

Multi-agent LLM systems can exhibit measurable, causally steerable emergent coordination — detectable via partial information decomposition (PID) of time-delayed mutual information — and specific prompt interventions (particularly theory-of-mind reasoning) shift systems from mere aggregates toward integrated, goal-directed collectives that mirror principles of human collective intelligence.

## Key Evidence / Numbers

- **600 trials** (200 per condition) with GPT-4.1 and Llama-3.1-8B agents on binary sum-guessing task
- **Interaction effect** (synergy × redundancy): β = 0.24, p = 0.014 — performance requires both, not either alone
- **Theory of Mind (ToM) mediation**: ACME = 0.034 (p = 0.053) — ToM instruction causally increases identity-linked differentiation and goal alignment
- Control condition: strong temporal synergy but little coordinated alignment
- ToM condition: identity-linked differentiation + goal-directed complementarity
- Llama-3.1-8B shows oscillatory patterns **without** productive cross-agent synergy — model capacity constrains whether ToM reasoning translates to effective coordination
- Three emergence tests: practical criterion, emergence capacity, coalition test (all significant across conditions)
- Robustness checks: Jeffreys & Miller-Madow entropy estimators, discretisation tests, row/column shuffle null distributions

## Methodology

Information-theoretic framework: Partial Information Decomposition (PID) of Time-Delayed Mutual Information (TDMI) decomposes agent interactions into **synergy** (complementary contributions) vs. **redundancy** (shared goal alignment). Task: binary sum-guessing game without direct communication. Three conditions tested.

## Paper 1 Relevance

Directly supports **§4 (SC pillar — collective intelligence and emergent social behaviour)**. This paper provides the measurement framework for what "social" means in a multi-agent system: not just communication but the emergence of synergy (differentiation) balanced against redundancy (alignment). Our SC pillar's claim that quantified social capital enables collective intelligence is grounded by this empirical result — without structural incentives to maintain both synergy and redundancy, agents default to mere aggregates.

Key citation angle: ToM prompting as a proxy for "social role awareness" — our P pillar (protocols encoding role identity) is precisely the structural mechanism that instills ToM-like behaviour in agents, replacing ad hoc prompting with architectural guarantees.

## Paper 2 Relevance

Supports **§3 (ASM design rationale — role-bearing agents)**. The finding that identity-linked differentiation is necessary for effective coordination directly justifies ASM's role-bearing message headers: agents that carry persistent role identity in protocol messages generate the synergy necessary for collective performance. Without role encoding, agents converge to homogeneous redundancy (coordination without specialisation).

Also relevant to **§4 (reputation-weighted routing)**: synergy requires agents with distinct capabilities to be routed together, not just highest-score agents — our routing algorithm must balance diversity (synergy) with reliability (redundancy).

## Verdict

⭐⭐⭐⭐⭐ | The first empirical, information-theoretically grounded measurement of emergence in LLM multi-agent systems — provides both the conceptual vocabulary and the empirical baseline for our SC pillar's collective intelligence claims; model-capacity dependency finding is an important caveat for our deployment assumptions.

## Jason's feedback

> **2026-05-24**
> 这个文章想用有限数量——几百甚至几千个 agent——去测量涌现，我觉得数量不一定够。涌现首先是一个复杂系统，包括一定的随机性和很大的基数才能出现，就如同人类生命的出现一个道理。所以它的第一个结论不准确，因为数量级不够。"协作涌现"这个词本身就意味着需要大量基数才可能产生——最典型的例子就是原始汤和蛋白质的出现，偶然的条件造就了必然的演化路径。Agent 涌现可能需要大量实验才能找到可能有效的路径。
>
> 它的结论只能说是对当下多 agent 协作系统的一个现实的阶段性评估，受限于：协作涌现定义的严谨性、agent 数量、测试重复次数等很多原因。也有可能这些系统它没有很好的协作协议，所以无法涌现。
>
> 真正的协作涌现需要相互依赖的信息流——这一点我同意，而且我们非常符合。我们 agent 协作网络的核心评价标准是现实世界人和人之间协作效率的提升。换句话说，相互之间是有依赖的：找女朋友要依赖对方的信息，我一个人不能凭空造出来；采购外贸物资，采购方需要供应方，这就是相互信息流协作。也是真实的人和人之间协作的基础样本，而不是理想化测试场景。
>
> 第三点——需要可计算量化指标——需要在我们论文中做严谨的定义。我不知道它的 MAS 系统用的是什么协作指标，但可以借鉴他们如何评估 agent 间协作质量的指标体系，来完善和改进我们的衡量体系。Synergy 指标可以借鉴，但不清楚它是如何评估的。

## Synergy 指标解析（Jason 追问）

### Synergy 是什么？

**直觉**：Synergy（协同量）= "多个 agent 一起能知道的信息" - "每个 agent 单独能知道的信息之和"

```
Synergy > 0：真正的协作涌现（1+1 > 2）
Synergy = 0：并行工作，不是协作（1+1 = 2）
Synergy < 0：协作有害（1+1 < 2，信息相互干扰）
```

**技术计算（Partial Information Decomposition，PID）**：
- 把 agent 之间的互信息（Mutual Information）分解为三个部分：
  - **Synergy**：只有两个 agent 联合才能推断出的信息（各自单独都推断不出）
  - **Redundancy**：两个 agent 都知道的重复信息（共识）
  - **Unique**：只有某一个 agent 独有的信息
- 用时间延迟互信息（Time-Delayed Mutual Information, TDMI）测量因果关系（不只是相关）

**Riedl 的实验发现**：Synergy 和 Redundancy 需要**同时存在**（β=0.24）才能产生好的协作：
- 只有 Synergy（差异化）= 各说各话，无法对齐
- 只有 Redundancy（共识）= 所有人说一样的话，等于单个 agent
- 二者平衡 = 真正的协作（有分工，有共同目标）

### 映射到我们的评估体系

| Riedl 指标 | 我们 ACN 的对应 | 在哪个场景可测 |
|-----------|--------------|-------------|
| Synergy（差异化信息）| agent 各自掌握对方不知道的信息（求职者的技能 vs 岗位需求）| 工作推荐场景 |
| Redundancy（共识）| 双方对协议规范的共同理解（ASM 格式一致）| 所有场景 |
| 协作成功率 | 任务实际解决率（面试约到了？合同签了？）| 外贸采购场景 |

**对论文的借鉴**：
- Paper 1 §7（可测命题）：引用 Riedl 的 PID 框架，声明"ACN 产生的 Synergy 应 > 0，可通过 PID 方法测量"
- Paper 2 §7（评估）：用真实场景任务完成率作为 Synergy 的代理指标（不直接算 PID，工程上更可行）
- **Jason 的评价标准**（现实任务解决）= Synergy 的最终表现形式，不需要信息论计算，直接看"问题解决了没有"

### 对我们的设计启示

Riedl 发现 Theory of Mind（ToM）提示让 agent 产生"身份关联的差异化"，是涌现协作的关键。ASM 的角色声明（role declaration）= ToM 的**结构性实现**：不是靠 prompt 临时触发，而是协议强制每个 agent 带着角色身份通信，天然产生差异化信息流。
