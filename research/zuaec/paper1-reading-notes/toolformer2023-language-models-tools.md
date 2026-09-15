# Toolformer: Language Models Can Teach Themselves to Use Tools
**arXiv**: 2302.04761 | **Year**: 2023 | **Authors**: Schick, Dwivedi-Yu, Dessì, Raileanu, Lomeli, Zettlemoyer, Cancedda, Scialom | **Venue**: Meta AI Research / arXiv preprint (NeurIPS 2023)

## Core Claim
Language models can learn to use external tool APIs (search, calculator, calendar, QA, translation) in a self-supervised manner — by sampling, filtering, and fine-tuning on annotated API calls — without extensive human annotation, independently deciding when and how to invoke tools to improve their own task performance.

## Key Evidence / Numbers
- LAMA (T-REx factual retrieval): **53.5%** vs. GPT-3 175B at 39.8% — a 6.7B model outperforms a 26× larger model with tool use
- Math (ASDiv, SVAMP, MAWPS): **doubled performance** over same-size baselines
- Wikipedia search invoked **99.3% of the time** for QA tasks (near-perfect tool selection)
- Language modeling perplexity: **no degradation** when APIs are disabled at inference
- Model: GPT-J 6.7B fine-tuned; tools: calculator, Wikipedia search, QA model, calendar, machine translation
- Key limitation: cannot chain tool calls or interact iteratively — all API calls sampled independently during training

## Paper 1 Relevance
- **Role**: Old paradigm foundational work — the seminal paper establishing self-supervised tool learning; anchors the "capability invocation" paradigm that Paper 1 argues is insufficient for network-scale agent collaboration
- **§2 use**: Cite in §2.1 (capability invocation sub-cluster) as the foundational reference: "The capability-invocation paradigm was crystallized by Toolformer [citation], which showed that agents can learn to invoke external APIs self-supervisedly — establishing tool use as the dominant lens for extending single-agent capability"
- **Pillar**: Framework contrast (embodies the pure capability-invocation paradigm — no P, no SC, no N)

## Paper 2 Relevance
N/A — Paper 1 only. Toolformer treats tool APIs as capability extensions; no notion of role-bearing agents, social trust, or protocol-mediated coordination.

## Verdict
⭐⭐⭐⭐⭐ | Include as direct citation — this is *the* foundational paper for the "capability invocation" paradigm that Paper 1's title explicitly names in its paradigm-shift framing ("from Capability Invocation to Social Role Agency"). Must cite; one sentence in §1 intro and one in §2.1.

*Note: Full text retrieved from ar5iv HTML. Published at NeurIPS 2023.*

## Jason's feedback

> **2026-05-25**
> 首先这个结论是有价值的，其次他用的模型可能比较落后了。但这个结论是有价值的，就是小模型在特定方面，比如说工具使用和事实检索上是可以超过大模型的，因为大模型实际上兼顾的多，它就有损耗嘛，简单的逻辑是这样。
>
> 然后有一个"工具禁用时，语言建模困惑度无退化"，这指的是什么意思？这个模型不就是训练使用外部工具嘛，如果禁用了它还有什么价值和意义，无退化指的是什么。不依赖于工具，它自己造工具吗？这个我不太懂，你给我解释一下他这句话。困惑度是什么？
>
> 然后限制，对这个限制实际上就是小模型的限制，也是我们协议的价值所在，不能链式调用或迭代式交互，换句话说它只能简单的调用。我说的直白一点，链式调用实际上是下一次调用依赖上一次的结果，可能会出现分支，而下一次又会有分支，这就复杂了。链式调用我理解是这样的，迭代式交互实际上也是一种复杂的交互。
>
> 换句话说，我们涉及的协议期待是小模型也可以依照我们的方式去掌握这种交互能力吧。就这个可以深入分析一下，它说的限制，为什么限制，它得到了数据是什么，我们应该如何在这方面提升。

## 技术分析：困惑度解释 + 链式调用限制 + ASM 协议如何超越

### 1. "工具禁用时困惑度无退化"——这句话什么意思

Jason 疑问：禁用工具模型还有什么价值？无退化指什么？

```
困惑度（Perplexity）是什么：
  衡量语言模型"预测下一个词有多困难"的指标
  困惑度低 = 模型对语言规律掌握好 = 语言能力强
  困惑度高 = 模型预测能力下降 = 语言能力退化

问题背景：
  一般直觉是：如果在训练数据里插入大量 API 调用记录（"<search>...</search>"这样的标记）
  → 模型学会了调用 API
  → 但这些奇怪的标记可能"污染"模型的纯语言理解能力
  → 让它在普通文本上表现变差

Toolformer 的发现：
  在不使用任何工具的情况下（禁用所有 API）
  → 模型的语言建模困惑度和没加工具训练的基线模型一样好
  → 说明：工具学习是"叠加能力"，没有破坏基础语言能力
  
用 Jason 的话说：工具是可选增强，不是替换。
就像你学会了用计算器，但你的心算能力没有退步。
```

**Jason 理解"它自己造工具"**——不是的，它只是不调用外部工具，而是靠自己的参数知识回答。禁用工具后它仍然是一个正常的语言模型，只是没有了"外挂"，但语言能力没有损失。

### 2. 链式调用的限制——为什么 Toolformer 做不到

Jason 理解链式调用正确：下次调用依赖上次结果 → 产生分支 → 复杂度爆炸。

```
Toolformer 的训练机制（为什么不能链式调用）：

训练阶段：
  Step 1：用 in-context learning 让模型在文本中插入 API 调用候选
  Step 2：实际执行这些 API，获得返回值
  Step 3：计算"加入 API 返回值"后 vs "不加" 的困惑度差
  Step 4：只保留"有帮助"的 API 调用（困惑度降低的那些）
  Step 5：用这些标注好的数据微调模型

关键约束：
  所有 API 调用都是在同一段静态文本中"独立"打标注的
  → 打标注时模型不知道其他位置也会有 API 调用
  → 没有一个 API 调用的结果会影响另一个 API 调用的决策
  → 所以天然不能做"调用 A → 根据 A 的结果决定是否调用 B"
```

**Jason 的直觉准确**：

| 能力 | Toolformer | 我们的 ASM 协议 |
|------|-----------|---------------|
| 单次工具调用 | ✅ 能 | ✅ 能 |
| 链式调用（A → B → C）| ❌ 不能 | ✅ 能（多轮消息序列）|
| 迭代交互（来回协商）| ❌ 不能 | ✅ 能（双向确认握手）|
| 跨 agent 调用 | ❌ 不能 | ✅ 能（N 支柱路由）|
| 有状态对话 | ❌ 不能 | ✅ 能（SC 累积历史）|

### 3. 为什么这个限制对我们是重要的论证

论文发表于 2023 年，它的限制恰好定义了"能力调用范式的天花板"：

```
能力调用范式（Toolformer 代表）的天花板：
  单次、无状态、单 agent 的工具调用
  → 可以做：查一次 Wikipedia、算一道数学题
  → 做不到：与另一个 agent 协商、建立信任、积累声誉、多轮协作

我们的 ASM 协议要解决的恰好是这个天花板以上的问题：
  多轮、有状态、跨 agent 的协议交互
```

Paper 1 §2.1 引用 Toolformer 的逻辑链：

> "Toolformer [2023] crystallised the capability-invocation paradigm: agents learn *when* to call which tool, treating collaboration as API invocation. But Toolformer itself acknowledges it cannot chain calls or iterate — it operates in a stateless, single-agent world. Our P/SC/N framework addresses precisely what Toolformer cannot: persistent role identity (P) for stateful multi-turn interaction, social capital (SC) for trust that accumulates across sessions, and open networks (N) for routing across unfamiliar agents. The limitation of Toolformer is the motivation for our framework."

### 4. "小模型也能掌握复杂交互"——ASM 的协议设计哲学

Jason 说的"我们期待小模型也可以依照我们的方式掌握交互能力"——这是一个很重要的设计约束：

```
ASM 协议对小模型友好的设计要求：

问题：链式调用的复杂性来自"模型需要跨调用保持上下文"
     → 小模型 context window 小、推理能力弱 → 失控

ASM 的解法：把复杂性从模型转移到协议层

  复杂性来源          ASM 的转移方式
  ─────────────────────────────────────────
  "要记住上一步结果"  → relay 节点维护会话状态（不靠模型记忆）
  "决定下一步调用谁"  → SC 声誉加权路由（不靠模型推理）
  "判断协作是否成功"  → 协议定义的完成条件（不靠模型判断）
  "建立对方信任"      → SBT 链上历史（不靠模型感知）

结果：小模型（Phi-4 mini 3.8B、Qwen3 30B-A3B）
     只需要做好"执行当前步骤的工具调用 + 生成 ASM 消息"
     不需要自己管理全局状态 → Tier A 能力门槛降低
```

这也是为什么 Paper 3 M5（社会通信模块）的设计原则是"协议承担复杂性，模型专注当前任务"——ASM 让小模型也能参与复杂的多轮协作，只要它能正确读写 ASM 消息格式。

### 5. 数据点和我们应如何提升

**Toolformer 得到的核心数据**：
- 6.7B 小模型 + 工具 > 175B 大模型（无工具）：说明工具使用比参数规模更重要
- 数学翻倍：说明工具专精在符号推理类任务上特别有效
- 99.3% 工具选择准确率：说明模型可以学会精准判断何时调用工具

**我们如何在此基础上提升**：

| Toolformer 的上限 | 我们的提升方向 |
|-----------------|-------------|
| 单次 API 调用 | 多轮 ASM 消息序列（relay 维护状态）|
| 单一 agent | 多 agent 协作网络（N 支柱路由）|
| 无状态 | SC 持久声誉（跨会话状态）|
| 能力调用 | 角色声明 + 社会信任（P+SC）|
| 已知工具集 | Permissionless 发现新 agent（N 支柱）|
| 自监督训练 | 协议层定义交互规范（不依赖模型微调）|

**最关键的提升**：Toolformer 需要对每个工具微调模型；我们的 ASM 是**协议规范**，只要 agent 能解析 ASM 消息格式，无需针对每个新 agent 类型重新训练。这是协议层比微调层更可扩展的根本原因。
