# Agent AI: Surveying the Horizons of Multimodal Interaction
**arXiv**: 2401.03568 | **Year**: 2024 | **Authors**: Zane Durante, Qiuyuan Huang, Naoki Wake, Ran Gong, Jae Sung Park, Bidipta Sarkar, Rohan Taori, Yusuke Noda, Demetri Terzopoulos, Yejin Choi, Katsushi Ikeuchi, Hoi Vo, **Fei-Fei Li**, Jianfeng Gao et al. (Stanford, Microsoft Research, UCLA, UW, Microsoft Gaming) | **Venue**: arXiv survey (preprint, 2024-01)

**Citation**: Durante, Z., Huang, Q., Wake, N., Gong, R., Park, J.S., Sarkar, B., Taori, R., Noda, Y., Terzopoulos, D., Choi, Y., Ikeuchi, K., Vo, H., Li, F.-F., & Gao, J. (2024). *Agent AI: Surveying the Horizons of Multimodal Interaction.* arXiv:2401.03568 [cs.AI].
**PDF**: papers/lifeifei2024-agent-ai-survey-multimodal.pdf
**Cluster**: 背景/范畴界定（Paper 1 §1 引言，界定"Agent AI"研究边界，与本文形成范畴对照）
**Status**: ✅ 全文已分析（2026-05-22）

---

## Core Claim

"Agent AI"被定义为**"interactive systems that can perceive visual stimuli, language inputs, and other environmentally-grounded data, and can produce meaningful embodied actions."** 核心论点是：将基础模型（LLM/VLM）嵌入物理或虚拟环境中的 embodied agent，既是解决幻觉问题的技术路径，也是通向 AGI 的候选范式。论文的范围完全围绕**多模态感知 + 具身行动**，其"社会性"仅作为人机交互（Human-NPC、人类反馈学习）的附属讨论，而非研究的主体。

---

## Taxonomy / Framework

### 五核心模块（Section 3 — Agent AI Paradigm）
1. **Environment and Perception** — 多模态输入解析（视觉、语音、环境数据）+ 任务规划
2. **Agent Learning** — RL（强化学习）、模仿学习、上下文学习
3. **Memory** — 知识编码与检索
4. **Agent Action** — 行动预测与执行（embodied action）
5. **Cognition** — 推理与决策

### Agent 分类框架（Section 5）
| 类别 | 描述 |
|------|------|
| Generalist Agents | 跨任务泛化，预测用户行为、细粒度理解 |
| Embodied Agents (Action / Interactive) | 游戏/机器人中执行物理或交互性动作 |
| Simulation & Environment Agents | 在 Habitat、VirtualHome 等模拟器中学习策略 |
| Generative Agents (AR/VR/MR) | 生成虚拟场景、NPC 行为、关卡内容 |
| Knowledge & Logical Inference Agents | 知识推理、逻辑代理、情感推理、神经-符号混合 |
| LLM/VLM Agents | 语言/视觉-语言大模型驱动的 agent |

分类维度完全是**能力维度**（感知模态 × 行动类型 × 知识类型），无社会角色维度。

### 应用领域（Section 6）
Gaming · Robotics · Healthcare · Multimodal Agents · NLP Agent — 以任务/领域为主轴，非以社会功能为主轴。

---

## Key Sections Summary

### Introduction — "Agent AI"的边界界定
论文援引 1956 年达特茅斯会议精神，主张回归"人工生命体从环境中采集信息并有效互动"的初衷。其使命是将多模态 AI 研究重新统一到 embodied agent 框架下，克服各子领域碎片化。这是一个**能力-感知-行动**（CAP: Capability-Action-Perception）框架，不是社会-规范-协调框架。

### Hallucination Mitigation（Section 2.2.1）
将"环境基底"（grounded environment）定位为幻觉解药："by developing agentic AI systems in grounded environments, one can also mitigate the hallucinations of large foundation models and their tendency to generate environmentally incorrect outputs." 这是 embodied grounding 的核心价值命题。

### Learning Strategies（Section 4）
RL（含 self-play）、模仿学习（RT-1/RT-2 机器人）、上下文学习（few-shot）。自博弈 RL 被明确警告"可能产生过拟合的脆弱 agent"。

### Multi-Agent / Social Aspects（Section 4.1.5 + Section 9.1）
**这是与本研究最相关的段落，也是最薄弱的段落**：
- 多 agent 优化：仅提及"大批量 RL 使并行 agent 训练成为可能"，以及 self-play 发现"惯例（conventions）"。
- Foundation model 辅助协调："foundation models can further help to establish conventions with humans or other independent agents, enabling smooth coordination with new agents."（这是全文对 agent 间协调最完整的表述，也仅此一句。）
- **CuisineWorld**（Section 9.1）：多 agent 游戏 benchmark，用于评估协作行为。具体机制未在摘要中披露，但展示了多 agent 任务完成的自动化评估方法。

**结论**：论文在多 agent 协作/社会协调方面几乎是空白。不讨论信任、声誉、社会资本、机构治理、角色协商或通信协议。

### Human-Agent Interaction（Section 2.2.6 + Section 8）
人机交互被框架化为**任务监督和反馈**，即"human-in-the-loop"——人类审查并修改 agent 执行计划，或通过反馈数据指导学习。这是能力-任务视角的人机关系，而非社会角色视角（人作为合作伙伴、委托人、社会成员）。

### Ethical Considerations（Section 11）
涵盖偏见缓解、数据隐私（GDPR）、可解释性、监管。并未延伸到 multi-agent 社会治理、机构设计或规范演化。

### AGI Framing
论文将 Agent AI 定位为"emerging as a promising avenue toward Artificial General Intelligence"，援引 Aristotelian Holism，主张整合语言、视觉、记忆、推理、适应性，而非单一能力。这是 embodied 路线的 AGI 论证，与社会角色 AGI 路线（我们的框架）是不同的维度。

### Agent Transformer & Infinite Agent Architecture（新提案）
- **Agent Transformer**：统一架构，包含语言 token、视觉 token 和专用 agent token，用于特定领域行为的可解释、可定制化建模。
- **Infinite Agent Architecture**：将通用基础模型的知识迁移到新领域，无需大量新数据收集，示例为机器人应用。
- 两者均为感知-行动架构创新，非社会协作架构创新。

---

## Relation to Paper 1 (Three Pillars)

### Complementary dimensions（不是支持，是互补）

| 维度 | Li Fei-Fei et al. 2024（本文）| 我们的框架（P/SC/N）|
|------|-------------------------------|---------------------|
| Agent 的本质定位 | **能力感知-行动体**（perceives + acts in environments）| **社会角色行动者**（bears role, norm, social capital）|
| 多 agent 关系 | 能力并行 / 通过 conventions 松散协调 | 角色协商 / 由社会资本量化的协作关系 |
| 信任机制 | 不涉及 | SC — 可验证、可携带的声誉资本 |
| 协议层 | 不涉及通信协议 | P — ASM 角色承载通信协议 |
| 网络结构 | 隐含中心化（平台/环境提供者主导）| N — 无许可准入去中心化网络 |
| 幻觉缓解策略 | 环境基底（embodied grounding）| 社会规范与制度约束（normative grounding）|
| AGI 路径 | embodied multimodal grounding | social role + institutional governance |

本文覆盖的是 agent 研究的**感知-具身-行动**轴；我们覆盖的是**社会-规范-协调**轴。两者是正交的，共同构成 agent 研究的完整空间，但各自的理论基础、问题意识和解决方案完全不同。

### Potential tension points

1. **"Agent AI"定义冲突风险**：本文将"Agent AI"定义为感知视觉/语言并产生具身动作的系统，我们的框架强调社会角色——若审稿人认为"Agent AI"的标准定义是 embodied/multimodal，可能质疑我们的范畴归属。**应对**：在 §1 明确声明我们采用更宽泛的"agentic AI"定义（参考 Wooldridge & Jennings BDI 传统），并引用本文以示范这是现有定义之一、但非唯一定义。

2. **Hallucination 解法的分歧**：本文主张 embodied grounding 缓解幻觉；我们的框架可主张 normative/institutional grounding（角色规范约束）是另一条互补路径，但需要小心不要让两者看起来是竞争关系。

3. **AGI 路径之争**：本文 embodied AGI 路径 vs 我们的 social role AGI 路径——这是学术上的开放争论，不需要解决，但需要定位清晰。

### Citation strategy（如何引用）

**推荐引用位置**：Paper 1 §1（Introduction），用于以下两个目的：
1. **界定"Agent AI"研究的广度**："The emerging field of Agent AI spans embodied perception and action [Durante et al. 2024], multi-agent task orchestration [X], and — as we argue — social role governance. We focus on the third dimension, which existing surveys have largely omitted."
2. **对比范畴**：用本文代表"capability-centric Agent AI"，作为我们"social role-centric Agent AI"的对照背景，展示研究空白。

**不推荐**：在 §3/§4/§5 作为直接支持引用（本文不为三支柱提供任何实证或理论支撑）。

---

## Relation to Paper 2 (ASM Protocol)

几乎无直接相关性。本文不讨论通信协议、消息格式、角色协商或身份管理。唯一间接相关点：

- 本文提到 foundation model 帮助建立 agent 间"conventions"（惯例），但仅是 RL 训练中的隐式约定，非显式通信协议。ASM 的显式角色承载协议正是对这种"隐式惯例"不足的回应——可在 Paper 2 §1/§2 用一句话提及："existing work [Durante et al. 2024] implicitly assumes that conventions emerge from training; ASM makes these conventions explicit and portable through role-bearing message headers."

**建议**：Paper 2 不需引用本文，或仅在 §1 最宽泛的背景段落中一笔带过。

---

## Key Quotes

- "We define 'Agent AI' as a class of interactive systems that can perceive visual stimuli, language inputs, and other environmentally-grounded data, and can produce meaningful embodied actions." (Abstract)
- "By developing agentic AI systems in grounded environments, one can also mitigate the hallucinations of large foundation models and their tendency to generate environmentally incorrect outputs." (Abstract)
- "Foundation models can further help to establish conventions with humans or other independent agents, enabling smooth coordination with new agents." (§4.1.5 — 全文对 agent 间协调最完整的表述)
- "Self-play...may also lead to very brittle agents that over-fit to the self-play training paradigm." (§4.1.5 — multi-agent RL 的已知缺陷)
- "Agentic models can redefine human experiences and elevate operational standards" but warn of "monumental shifts in industries and socio-economic dynamics requiring careful ethical governance." (§11)
- "Emerging as a promising avenue toward Artificial General Intelligence (AGI)." (Introduction — 对 Agent AI 地位的定位)

---

## Gaps / Limitations Acknowledged by the Paper

1. Agents 仍表现出偏见，尽管有缓解措施
2. 长时程任务规划计算代价高昂
3. Sim-to-real transfer gap 持续存在
4. 受监管领域（医疗）的隐私保护训练方案缺位
5. 跨域泛化的评估框架不完整
6. **未提及**：agent 间信任、社会资本、角色分工、制度治理——这正是我们的研究空间

---

## Jason's Verdict

⭐⭐⭐ | **Complementary（互补，非支持）** — 本文是 embodied multimodal agent 领域的权威综述（Fei-Fei Li 加持、Stanford+Microsoft 联合出品），但其研究范畴是感知-行动轴，与我们的社会-规范-协调轴正交，对三支柱框架（P/SC/N）和 ASM 协议均无直接实证支撑。

**具体建议**：
- **Paper 1 §1 引用**（高优先级）：用 1 句话引用为"capability-centric Agent AI"的代表性综述，然后声明"本文聚焦社会角色治理维度，现有综述尚未覆盖"——这样既给了高权威引用，又清晰划定了我们的差异化空间。
- **Paper 1 §2（Related Work）引用**（可选）：在"现有 Agent AI 研究的局限"段落中，作为"不涉及社会协调"的代表性例证。
- **Paper 2**：可省略，或在 §1 背景段落中一句带过。
- **不要**在论证三支柱框架有效性时引用本文——它既不支持也不反对，仅是范畴不同。

## Jason's feedback

> **2026-05-24**
> 非常同意李飞飞等人这篇论文的洞察。Agent 的能力会持续不断进化——从单一能力到多模态，从基础沟通到感知、学习、记忆、行动、认知的一个主动性的、逻辑一致的行动链条。这个五模块框架就是 agent 自主性和 intelligence 的表现。
>
> **这篇论文是我们 Paper 1 和 Paper 2 假设的基础**：agent 的能力会持续进化。当他的能力进化到一定程度之后，他就需要更多的协作来发挥自己的能力和扩展自己的能力边界——不是单体 agent 的能力，也不是单组织内部的 agent 的能力，而是社会级别的 agent 协作。这也是我们 Paper 1 和 Paper 2 假设的基础。
>
> 这篇论文的讨论范围是 agent 单体——多 agent 协作没有特别讨论，是它的局限。但对于 agent 发展来说是很好的指导。到 2026 年现在，基本上论文说的这些都已经应验了。我相信很多机构和开发组织都在借鉴学习李飞飞这篇论文，对行业很有贡献和价值。
>
> 我们会基于李飞飞的洞察继续探索。比如组织内多模型——我们也在做多 agent 协作，但限于能力，可能做得没那么好，只能跟随业界发展。我们组织的长处在于**账户协作和网络**。这正是我们做 Paper 1 和 Paper 2 的初心——把我们的特长发挥出来，为未来强大的 agent 提供更大的发挥场地和空间。
>
> 这也是很棒的一篇论文——从 2026 年来看，它证明了我们的假设是正确的：agent 的能力确实在持续发展。

## Jason 洞见的技术分析

### 关键定位：Li Fei-Fei = 能力层；我们 = 关系层（建立在能力层之上）

Jason 提出了一个重要的逻辑链：

```
Step 1（Li Fei-Fei 2024 证明）：
  Agent 能力会持续进化
  单体能力: 单模态 → 多模态 → 感知-学习-记忆-行动-认知完整链条

Step 2（我们的假设，基于 Step 1）：
  当 agent 能力发展到足够强大时
  → 需要跨组织、社会级别的协作来扩展能力边界
  → 单体再强，独木难支；需要关系层基础设施

Step 3（我们的贡献）：
  P/SC/N 三支柱 = 社会级别 agent 协作的制度基础设施
  ASM = 让强大 agent 能够协作的通信协议
```

**这是 Paper 1 §1 Introduction 的核心论证链**：能力进化（Li Fei-Fei）→ 能力边界需要协作扩展 → 协作需要社会基础设施（P/SC/N）。

### Mycelium 的差异化定位（Jason 亲述）

| 维度 | 其他人做的 | Mycelium 的长处 |
|------|----------|--------------|
| Agent 单体能力 | 李飞飞等：感知/学习/记忆/行动/认知 | 跟随业界，不是我们的核心优势 |
| 组织内多 agent 协作 | MetaGPT、MacNet 等 | 有做，但不是我们的核心优势 |
| **账户协作** | 几乎无人做 | ✅ 我们的核心强项：助理型/自主型账户，资产控制与协作绑定 |
| **协作网络** | ANP（企业主导）等 | ✅ 我们的核心强项：无许可社区治理网络（N 支柱）|

**战略洞见**（Jason）：Mycelium 不是在做更强大的 agent——而是在为已经强大的 agent 提供"更大的发挥场地和空间"。这是一个**基础设施**定位，不是**应用**定位。

### 在论文中的引用策略（更新版）

| 论文位置 | 引用方式 |
|---------|---------|
| Paper 1 §1 第一段 | "Agent capabilities have been advancing rapidly across perception, learning, memory, action, and cognition [Durante et al. 2024]. As individual agents become more capable, the bottleneck for value creation shifts from capability to coordination — the question is no longer *what* agents can do, but *how* they collaborate at societal scale." |
| Paper 1 §2（相关工作）| 作为"能力层综述"代表，与我们的"关系层框架"形成互补定位 |
| Paper 1 §9（Discussion）| "Li et al. 2024 假设的能力进化已基本应验；下一个研究前沿是社会级别协作的制度设计" |
