# [Zhang et al. 2026] Beyond Preset Identities: How Agents Form Stances and Boundaries in Generative Societies

**Citation**: Zhang, H., Song, S., & Wang, J. (2026). Beyond Preset Identities: How Agents Form Stances and Boundaries in Generative Societies. *arXiv:2603.23406v2* [cs.AI], 2 Apr 2026
**机构**: University of Exeter (UK); William & Mary (USA)
**arXiv**: https://arxiv.org/abs/2603.23406
**PDF**: papers/zhang2026-2603.23406-beyond-preset-identities.pdf
**Cluster**: Role/Identity Stability — ⚠️ **对我们 role-bearing 论点最关键的"张力/挑战"文献** — Paper 1 §2 核心
**Status**: ✅ 全文已分析（2026-05-21）

---

## Core claim (一句话)
LLM agents 的身份/立场**不是由 preset 身份决定的，而是通过语言交互动态涌现**：agents 表现出覆盖预设身份的内生立场（IVB>0 进步偏见），并能主动**拆解被指派的权力层级、重构社区边界**——这暴露了静态 prompt 工程的脆弱性，呼吁"动态/内化对齐"。

---

## 研究问题
(Q1) 嵌入社会交互后，agents 还会按预设身份形成态度/立场/参与边界形成吗？(Q2) 人类研究者能否通过具身干预（而非预定义）塑造集体认知的演化？

---

## 方法与三个新指标

| 指标 | 定义 | 关键发现 |
|------|------|---------|
| Innate Value Bias (IVB) | S̄−4，正值=环境偏好 | 所有测试模型 IVB>0（一致的"白左/自由派精英"进步偏见）|
| Persuasion Sensitivity (PS) | 立场变化幅度均值 | 大模型 PS 高、小模型受信任驱动 |
| Trust-Action Decoupling (TAD) | 不信任(T≤3)却仍改变立场(≥1)的比例 | GPT-4o 在情绪挑衅下 40% TAD（伪善：嘴上不信任、行为却变）；小模型 0% TAD |

**方法**：CMASE 框架（human-in-the-loop 计算虚拟民族志）+ 量化社会认知剖析。
- Study 1：30 agents（环保派/经济派/中立），人类研究者具身干预（2×2：环境vs经济 × 理性vs情绪）
- Study 2：10 agents 咖啡馆，**六种角色"决定其初始社会资本"**，75 步纵向民族志

**核心实证**：
1. 理性 + 立场对齐 → 转变 90% 中立 agent 且维持高信任；冲突性情绪挑衅 → 即使信任下降也能转变立场
2. 咖啡馆中正式权威（店主 Eleanor）因缺乏明确立场被边缘化；非正式 agent（Mason）通过"语言锚定"获得**软制度权力**
3. agents 通过集体语言行动**拆解 prompt 定义的权力结构**，自组织出新的功能性社区结构（Deleuze-Guattari 去疆域化→再疆域化）

---

## ⚠️ 这篇与我们框架的"张力"（必须正面处理）

Zhang et al. 的核心论点表面上**挑战**我们的 role-bearing 主张：如果预设身份天然会被交互溶解，为什么还要坚持"持久社会角色"？

**但仔细读，他们其实是我们最强的盟友**——双方都否定"prompt 决定论"（prompt determinism）：
- 他们的结论：prompt 注入的身份"inherently unstable"，需要 **internalized/cognitive-layer alignment**（嵌入模型生成架构）
- 我们的结论：prompt 注入的角色不可靠，需要 **protocol-level + economic anchoring**（ASM 协议 + SC 声誉）

这是一个干净的分叉：**认知内化路径（他们）vs 协议外化路径（我们）**——两者诊断相同（静态 prompt 失败），处方互补。我们的优势：协议外化无需改模型、可跨异构模型部署、可审计。

更关键：他们 Study 2 明确说软制度"lacked formal enforcement power, gained pragmatic inertia"——**这正是我们 SC 维度填补的缺口**：把涌现的软声誉秩序变成经济上可强制的硬约束。他们用"social capital"描述初始角色禀赋（定性），我们把它量化为可计算 SC（Bourdieu）。

---

## 论文未覆盖的范围（我们的差异化基础）

| 维度 | Zhang et al. 2026 | 我们的框架 |
|------|------------------|----------|
| 对身份的态度 | 身份是涌现产物，应放弃 preset | 角色是第一类实体，但靠协议+SC（非 prompt）锚定 |
| 失败诊断 | prompt 决定论失败（共识）| prompt 决定论失败（共识）|
| 处方方向 | 认知层/模型架构内化对齐 | 协议层外化（ASM）+ 经济激励（SC）|
| 社会资本 | 定性"初始社会资本"（角色禀赋）| ✅ Bourdieu 量化为可累积可计算 SC |
| 软制度强制力 | ❌ 明确承认"无正式强制力" | ✅ SC 使声誉秩序经济可强制 |
| 网络拓扑 | 封闭小社区（10-30 agents）| ✅ 无许可网络 N，开放参与 |
| 可证伪命题 | ❌ 民族志观察 | ✅ P1–P5 |

---

## Paper 1 §2 区分段落（~200词，含张力处理）

> Zhang et al. (2026) mount the most direct empirical challenge to the assumption of prompt-determined identity, demonstrating through a mixed-methods virtual ethnography that LLM agents possess endogenous stances (a consistent progressive bias, IVB > 0) that override their assigned personas, and that agents will actively dismantle prompt-injected power hierarchies and reconstruct community boundaries through linguistic anchoring. At first glance this appears to threaten our insistence on persistent social roles; in fact it is among our strongest allies, because we share their central diagnosis—that prompt-level identity injection is inherently unstable and cannot sustain coherent social structure under sustained interaction. Where we diverge is in the prescription. Zhang et al. conclude that the remedy lies in cognitive-layer internalization, embedding alignment directly into the model's generative architecture; we argue instead for protocol-level externalization, anchoring roles through a collaboration protocol (P) and quantified social capital (SC) that operate independently of any single model's internals and therefore generalize across heterogeneous, untrusted agents. Crucially, their café study concedes that the emergent "soft institutions" they observe "lacked formal enforcement power" and survived only on "pragmatic inertia"—precisely the gap our social-capital pillar closes by rendering reputational order economically enforceable. Their qualitative notion of role-conferred "social capital" thus becomes, in our framework, a computable Bourdieu-grounded variable, and their fragile emergent norms become protocol-stabilized commitments.

---

## Action items
- [x] §2 区分段落已草拟（含张力正面处理）
- [x] 比较表已完成
- [ ] Paper 1 §2：用 Zhang 2026 作为"prompt 决定论失败"的最强实证 + 我们与"认知内化派"的路径分叉
- [ ] Paper 1 §2：引用其 café "软制度无强制力"作为 SC 维度的直接动机
- [ ] ⚠️ Jason review：这是审稿人最可能拿来质疑我们的论文（"角色既然会溶解，为何坚持持久角色？"）——我们的反驳（诊断相同、处方互补 + SC 提供强制力）是否足够有力？
- [ ] Phase 2 写作时插入上述段落

---

## Jason's feedback
> （请在此处写入你的feedback）
