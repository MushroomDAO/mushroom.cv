# [Kasirzadeh, Gabriel 2025] Characterizing AI Agents for Alignment and Governance

**arXiv**: 2504.21848 | **Year**: 2025 | **Authors**: Atoosa Kasirzadeh, Iason Gabriel | **Venue**: arXiv preprint (cs.CY + cs.AI + eess.SY)
**Cluster**: Governance & Regulation / Agent Typology
**Status**: Full read

## Core Claim
Effective governance of AI agents requires a four-dimensional characterization framework (autonomy, efficacy, goal complexity, generality) that produces "agentic profiles" spanning a spectrum from narrow task-specific assistants to highly autonomous general-purpose systems — bridging technical properties with non-technical governance requirements.

## Key Evidence / Numbers
- Four dimensions of characterization:
  1. **Autonomy** — degree of independent action without human instruction
  2. **Efficacy** — capability to achieve intended goals reliably
  3. **Goal complexity** — breadth and nestedness of objectives the agent pursues
  4. **Generality** — range of domains/tasks the agent can operate across
- Framework produces "agentic profiles" — multi-dimensional signatures enabling comparison across agent types
- Explicitly maps from technical dimensions to governance challenges (cross-cutting technical and non-technical governance challenges per agentic profile)
- Spectrum framing: continuous rather than categorical — avoids the brittleness of binary "safe/unsafe" classifications
- Authors: Kasirzadeh (AI safety/philosophy, previously DeepMind); Gabriel (Iason Gabriel, DeepMind AI safety lead, co-author of DeepMind's alignment work)

## Paper 1 Relevance
**§5 (Governance — all three pillars, especially N)**: This is the highest-priority governance paper for Paper 1. Kasirzadeh & Gabriel's four dimensions provide a principled basis for situating our three-pillar framework — specifically, our N (Permissionless Network) pillar addresses agents at the high-autonomy, high-generality end of their spectrum, where governance challenges are most acute and existing frameworks most strained. Our SC pillar (Social Capital) can be framed as a governance mechanism for managing the autonomy dimension — quantified reputation tracks whether an agent's actual behavior matches its claimed efficacy. Our P pillar (Protocols) addresses the goal-complexity dimension — role-bearing protocols constrain the space of goals agents can legitimately pursue in a collaboration context. Paper 1 §5 should explicitly adopt their "agentic profile" vocabulary and show how P/SC/N operate as governance mechanisms for high-profile agents in permissionless networks.

## Paper 2 Relevance
**§6 (Threat Model / Governance)**: The four dimensions map directly onto ASM threat categories:
- **Autonomy** → threat: agents act outside sanctioned role scope (role boundary violations)
- **Efficacy** → threat: agents misrepresent capability (capability fraud)
- **Goal complexity** → threat: agents pursue hidden sub-goals while appearing cooperative (goal masking)
- **Generality** → threat: highly general agents are harder to constrain to protocol-defined roles (scope creep)
ASM §6 should structure its threat taxonomy around these four dimensions, then show how ASM protocol mechanisms (role declarations, capability attestations, message validation) address each.

## Verdict
⭐⭐⭐⭐⭐ | The most conceptually foundational governance paper for Paper 1 §5; Kasirzadeh & Gabriel's four-dimensional agentic profile framework provides the principled vocabulary to situate our P/SC/N pillars and structure ASM §6's threat taxonomy — must-cite for both papers.

## Jason's feedback

> **2026-05-24**
> 理解一下这个论文：通用性越高、自主性越高、情境嵌入性越高、目标导向性越高，风险越高，是这个意思。
>
> 我们做的 agent 协作网络确实要控制风险，目标是提升人类协作效率，同时防止 agent 卷钱跑路等风险。一个维度一个维度讨论：
>
> **1. 目标导向性（Goal-directedness）**：开放世界的目标导向性是最大风险。比如"帮我挣 100 万"，agent 可能通过杀人抢劫来实现。我们的解决方案：通过协议拆分成小目标，降低风险。同时有协议的数据验证标准——不符合就不允许进入协议。对目标导向性，我们是显著拆分目标，并通过协议的公共维度和个性维度限制准入门槛，这是降低风险的。
>
> **2. 情境嵌入性（Situatedness）**：agent 对现实世界的影响力。我们关注两点：第一，是否有独立账户和独立资产——我们提供两种：助理型（依附人类账户，在人类约束下行动）和自主型（有独立账户，理论上可完整支配）。无论哪种，我们都有最基础的场景限定。落到技术方案上：跟哪个合约、跟哪个具体对象交互，都是严格限定的。这控制了情境嵌入性的范围——不可能参与所有情景。限制账户、限制额度、限制交互场景，控制风险，同时赋予了在限制额度下做交易的能力，但交易对象和模式是被限定的。
>
> **3. 自主性（Autonomy）**：最值得探讨的地方——究竟让他能做什么，在什么范围内做可能的涌现或创新。论文一和论文二还没有完整设计出来。但核心观点是有的：有人类控制、有监督、包括自我学习和自进化的能力，我们也具备。市面上优秀的机制我们都会去尝试学习和借鉴。总结：受控的自主性 + 自我进化。
>
> **4. 通用性（Generality）**：前面已经回答了。通过把场景拆分、把协议拆分成具体的交互方式，通用性是大大降低了的。目前论文一和论文二是限定场景的，未来有研究成果后可能开放更大场景。
>
> 总结：通过对四个维度的评估，我们有一定的开放性，但也确实通过各种方式限定了风险。

## 四维度 × 我们框架的对照（论文使用版）

| Kasirzadeh 维度 | 高风险状态 | 我们的控制机制 | 论文位置 |
|----------------|----------|-------------|---------|
| **目标导向性** | 开放世界目标（"挣 100 万"）| 协议拆分为小目标；公共+个性维度双重准入门槛；双方确认机制 | Paper 1 §6（P 支柱）|
| **情境嵌入性** | agent 影响所有现实世界场景 | 助理型/自主型两种账户；限定交互合约和对象；限制额度 | Paper 1 §6（N 支柱准入）+ Paper 2 §3 |
| **自主性** | 完全无人监督 | 受控自主性：人类监督 + 场景限定 + 自进化在边界内；[TODO: 详细设计待补充] | Paper 1 §9（Discussion）|
| **通用性** | 任意领域通用 | 场景协议化：每个协议对应一个具体场景，当前版本严格限定；未来可扩展 | Paper 2 §4（协议规范）|

**在论文中的核心引用方式（Paper 1 §9 - Discussion）**：
> "Kasirzadeh & Gabriel (2025) propose a four-dimensional governance profile for AI agents: autonomy, situatedness, goal-directedness, and generality. The P/SC/N framework addresses all four. The P pillar (collaboration protocols) decomposes open-ended goal-directedness into protocol-bounded micro-goals with dual-party confirmation. The N pillar's permissionless entry controls situatedness through tiered account types (assistant vs. autonomous) and scene-specific interaction constraints. The SC pillar's reputation accumulation creates economic incentives against autonomous goal-seeking beyond authorized scope. Generality is deliberately constrained to validated scenario protocols in v1; the framework is extensible as empirical evidence accumulates."

**⚠️ 待设计项**：自主性维度的详细设计（"在什么范围内允许涌现/创新"）在 Paper 1/2 中尚未完整表达，需在 v1 撰写时补充。
