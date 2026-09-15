# Darwin Gödel Machine: Open-Ended Evolution of Self-Improving Agents
**arXiv**: 2505.22954 | **Year**: 2025 | **Authors**: Zhang, Hu, Lu, Lange, Clune | **Venue**: arXiv preprint

## Core Claim
Rather than human-designed fixed architectures, AI agents can achieve continuous open-ended self-improvement by combining Darwinian evolutionary principles with self-modifying code — maintaining a growing archive of coding agents, sampling from it, and empirically validating mutations via coding benchmarks, thereby bypassing the need for theoretical proof of improvement (the classic Gödel Machine constraint).

## Key Evidence / Numbers
- SWE-bench: performance improved from **20.0% → 50.0%** through self-evolution
- Polyglot: improved from **14.2% → 30.7%**
- Significantly outperforms baselines lacking self-improvement or open-ended exploration
- System autonomously develops: enhanced code editing tools, context management, peer-review mechanisms
- Iteratively modifies its own code, including the code responsible for modification itself (true self-referential loop)
- Authors: Jenny Zhang, Shengran Hu, Cong Lu, Robert Lange, Jeff Clune (UBC / Vector Institute)
- Code available on GitHub; submitted May 2025, revised March 2026

## Paper 1 Relevance
- **Role**: Old paradigm contrast — the most extreme case of capability-centric self-improvement; DGM's "Darwinian archive" shows how the field's most ambitious work frames progress as evolutionary fitness of individual coding capability, not social fitness in a network
- **§2 use**: Cite in §2.2 as the frontier of the self-improvement paradigm: "Even DGM [citation], which autonomously discovers and archives agent mutations validated on benchmarks, operates entirely within a capability-optimization loop — social role, reputation, and network governance remain outside its scope"
- **Pillar**: Framework contrast (no P, no SC, no N — the evolutionary archive is a capability library, not a social institution)

## Paper 2 Relevance
N/A — Paper 1 only. DGM's self-modification is directed at task performance, not communication protocol or role identity.

## Verdict
⭐⭐⭐⭐ | Include as direct citation — the SWE-bench 20→50% result is striking and makes for a memorable rhetorical contrast: "the frontier of self-improvement can now double coding benchmark performance, yet still produces agents with no notion of social role or accountable network membership."

*Note: ar5iv conversion failed (fatal error); content retrieved from arxiv.org abstract page — abstract-only, no methodology details beyond what is in abstract.*

## Jason's feedback

> **2026-05-25**
> 这个论文说可以通过达尔文进化原则来去帮助 AI agent 形成一个动态的进化架构，它是一个纯理论的，还是说有可执行的工程实践和实证结果的？对自改代码实现可持续开放自我改进，这个主张我认为是大概率很重要的一个方向之一，但是不是正确的不好说，要验证要迭代。
>
> 对变异进行实证验证，绕过了哥德尔机器需要理论的约束，这就是说我们直接进行实证层面的验证，跳过理论约束，是这个意思吗？
>
> 他给出一个关键的数字，30% 的提升不错，SWE-bench 也是接近一倍的提升。真正的自我指涉循环指的是什么？难道指的是复杂系统中的自指吗？这就是有生命的或者有自我认知自我意识的智能的一个典型特征啊，不可能吧，真正的自我指涉循环。它只是代码层级的，这还好。
>
> 那他的这个是一个工程上的实践，应该 2025 年的，这个应该是可以认真的去借鉴和参考一下，因为它代表了很重要的一个能力，也是智能体必须具备的能力，就是自我进化。我希望找到他核心的设计范式和思路以及工程上的实践和验证的结果，否则只看结论的话，我们只能为他点赞，而不能借鉴。你把这些核心的东西给我找出来记录下来。

## 技术分析：工程细节全解 + Jason 五个问题解答

### 1. 是纯理论还是有工程实践？

**有完整工程实现**（ICLR 2026 正式发表，非理论论文）：
- GitHub 开源：`github.com/jennyzzt/dgm`（Jenny Zhang 主导）
- Docker 容器化隔离执行，严格资源限制
- 实证结果：SWE-bench 20%→50%（80 次迭代），Polyglot 14.2%→30.7%
- 改进可跨模型迁移（Claude 3.7 Sonnet、o3-mini 均验证）
- 改进可跨编程语言迁移（说明是领域通用改进，非 benchmark 过拟合）

### 2. "绕过哥德尔机器理论约束"是什么意思

Jason 猜测：直接实证验证，跳过理论约束——**完全正确**。

```
经典哥德尔机器的问题：
  要求在修改自身代码之前，形式化证明"这个修改对我有益"
  → 对复杂 AI 系统来说，形式化证明几乎不可能（计算不可判定）
  → 实践中无法实现

DGM 的解法（工程替代）：
  不需要证明，只需要实测
  → 修改后 → 跑 benchmark → 性能提升 → 保留进档案库
  → 性能下降 → 仍然保留（可能是未来突破的"跳板"）
  → 用达尔文选择压力代替数学证明
```

这是从"理论正确性"到"实证有效性"的范式转换——和 Jason 说的完全一致。

### 3. "真正的自我指涉循环"是代码层面的，不是意识层面的

Jason 问：是复杂系统的自指吗（意识/自我认知）？

**不是**，是更具体的代码工程层面：

```
自我指涉循环的具体机制：

Step 1：选择一个父 agent（从档案库按分数+后代数加权抽样）
Step 2：父 agent 读取自己的 benchmark 运行日志（分析自己的失败）
Step 3：父 agent 提出改进方案（作为一个编程任务）
Step 4：父 agent 修改自己的代码库（包括 self_improve_step.py）
         ↑ 这个文件就是"负责自我改进的代码"本身
Step 5：应用 Git patch，编译验证，跑 benchmark
Step 6：新 agent 成为下一次迭代的父候选

关键：Step 4 中，agent 修改了包含"修改代码的逻辑"的代码本身
→ 这就是"自我指涉"：修改工具本身的代码
→ 但这是纯代码层面的递归，不是意识层面的自我认知
```

用 Jason 的类比：就像一个工厂的机器人，不仅能生产零件，还能修改自己的生产流程代码（包括"如何修改生产流程"这段代码本身）。是工程自指，不是哲学自指。

### 4. 核心工程架构（Jason 要求的核心设计）

```
DGM 工程组件：

dgm_outer.py         ← 主进化循环，编排所有迭代
self_improve_step.py ← 自我修改逻辑（自指的核心）
coding_agent.py      ← 基础 agent（接收问题、benchmark、测试框架）
llm.py               ← 模型接口（支持 OpenAI + Anthropic）

档案库（Archive）：
  - 初始：单个基础 agent
  - 每次迭代：所有生成变体都加入（不丢弃）
  - 选择策略：分数加权 × 后代数量加权（平衡性能与探索性）
  - 关键设计：即使性能暂时下降的变体也保留（是未来突破的"跳板"）

三阶段评估门控：
  Stage 1（浅评）：10 任务验证编辑功能是否正常 → 通过才进入 Stage 2
  Stage 2（中评）：50 任务评分 → 达到 40% 阈值进入 Stage 3
  Stage 3（全评）：200 任务完整 benchmark → 决定是否进入档案库高权重

系统自主发现的改进（没有人类设计）：
  - 从全文件查看 → 精准行级查看（减少 context 消耗）
  - 字符串替换编辑工具（比全文件覆写更精准）
  - 多次尝试策略 + LLM 选择最优方案
  - 考虑历史尝试记录
```

### 5. 对 Paper 3 自进化模块的借鉴

| DGM 机制 | Paper 3 借鉴点 |
|---------|--------------|
| 达尔文档案库（不丢弃任何变体）| LAAS 情节记忆层：保存所有历史协作记录，包括失败的 |
| 实证验证替代理论证明 | ACN 协议自进化：用协作质量评分替代理论最优证明 |
| 三阶段评估门控 | Paper 3 Tier A/B/C：分阶段验证 agent 升级资格 |
| 后代数量加权（探索多样性）| N 支柱：保留低声誉 agent 的 30% 探索配额（ε-greedy）|
| Git patch 版本化 | ACN 协议版本化：每次协议进化都有版本锚定（链上） |
| 自主发现工具改进 | M4 行动层：agent 自主扩展工具集（EvoAgentX 方向）|

**关键差异**：DGM 的进化目标是单体 agent 的编码能力；我们需要的是**协议层的进化**（多 agent 协作规范的迭代改进）。DGM 提供的是个体进化机制，我们需要的是社会协作模式进化机制——两者可以叠加，不竞争。

### 在论文中的引用位置

| 位置 | 引用方式 |
|------|---------|
| **Paper 1 §2**（旧范式对比）| "DGM [Zhang et al. 2025, ICLR 2026] represents the frontier of capability-centric self-improvement: agents autonomously evolve their own code, doubling SWE-bench performance (20%→50%). Yet DGM's evolutionary archive is a capability library — social role, reputation, and network governance remain entirely outside its scope. Self-improving capability and social collaboration infrastructure are orthogonal problems." |
| **Paper 3 §3**（自进化设计）| DGM 的三阶段评估门控 + 达尔文档案库 → Paper 3 Tier A/B/C + LAAS 情节记忆层设计依据 |
