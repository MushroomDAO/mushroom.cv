# [Rodriguez Garzon et al. 2025] AI Agents with Decentralized Identifiers and Verifiable Credentials

**Citation**: Sandro Rodriguez Garzon, Awid Vaziry, Enis Mert Kuzu, Dennis Enrique Gehrmann, Buse Varkan, Alexander Gaballa & Axel Küpper (2025). *AI Agents with Decentralized Identifiers and Verifiable Credentials*. arXiv:2511.02841. Technische Universität Berlin (Service-centric Networking / T-Labs), Germany.
**机构**: TU Berlin — Service-centric Networking / Telekom Innovation Laboratories (T-Labs), Germany
**arXiv**: https://arxiv.org/abs/2511.02841
**PDF**: papers/rouhani2025-did-vc-agents.pdf （8 页 conference-style）

> ⚠️ **作者署名更正（必读）**：任务 brief 写作者为 "Rouhani et al. 2025"。**标题正确**，但**作者错误**——本论文真实作者为 **Rodriguez Garzon, Vaziry, Kuzu et al. (TU Berlin)**，无 Rouhani。引用时务必用真实作者。slug 文件名 `rouhani2025-...` 保留以匹配任务约定，但 bibliography 必须用正确作者。

**Cluster**: Paper 2 §3 identity layer（DID/VC for agents）
**Status**: ✅ 全文已分析（2026-05-22）

## Core claim (一句话)
当前 LLM agent 无法在 A2A 对话之初建立**差异化信任**；本文提出一个概念框架 + 原型多 agent 系统，给每个 agent 配一个 **ledger-anchored W3C DID** + 一组第三方签发的 **W3C Verifiable Credentials (VCs)**，使 agent 在对话开始时即可证明 DID 所有权（认证）并通过自发交换 DID-bound VCs 建立跨域信任——但评估揭示：一旦把安全流程**完全交给 agent 的 LLM 自主控制**，可靠性出现明显局限。

## 研究问题
- 如何让自主、可互操作的 agent 在跨个人/组织边界对话时**自动建立信任**，而非依赖预共享凭证或中心化注册？
- 把原本为**自然人**自主主权身份（SSI）设计的 W3C DID/VC 标准迁移到 AI agent 上，是否技术可行？局限在哪？

## 方法与主要内容
- **概念框架**：每个 agent = self-sovereign 身份 = 1 个 ledger-anchored DID + N 个第三方签发 VC。
- **原型架构**：
  - DID documents 存于**分布式账本**（distributed ledger），保证 key material 跨安全域可信、高可用、防篡改；agent 可自主更新 key、用 VC 时**无需 issuer 在线**。
  - 每个安全域部署 **DIF Universal Resolver** 实例（REST 端点）解析 DID。
  - 信任建立用 **DIF Presentation Exchange / presentation proof protocol** + JSON-LD 编码 VC，双向交换 Verifiable Presentation (VP)。
  - 对话起始 agent 互证 DID 所有权（认证）+ 自发交换 DID-bound VCs（跨域信任）。
- **评估**：原型实现证明**技术可行**；但发现当 agent 的 LLM **单独全权**控制安全流程时存在局限（LLM 不可靠地执行安全程序）。
- **Related Work**：对比 Chaffer et al. ETHOS (SSI for agents)、South et al.（authenticated delegation）、AgentFacts model (Raskar et al. 2025)、Hossen et al.、Zou et al. BlockA2A。本文区别在于把 VC 交换直接整合进 A2A 对话起始握手。

## 与我们框架的关系（差异化）

| 维度 | 本文 (Garzon et al. DID/VC) | 我们的 ASM (Paper 2) |
|------|------------------------------|----------------------|
| 身份基元 | W3C DID + 第三方 VC（认证 + 跨域信任） | DID/VC 之上 + **角色 (role) 与人类授权绑定** |
| 角色 | "role" 仅出现 9 次，无角色-能力状态机 | **角色承载 agent**：角色绑定 + 协作状态机驱动 |
| 信誉 | "reputation" 仅 1 次，且是引用 AgentFacts，**本文无信誉机制** | **ZK reputation**（隐私保护信誉证明） |
| 隐私 | selective disclosure 仅 1 次提及，**无 ZK** | zero-knowledge proof 信誉/属性披露 |
| 人类授权 | "human" 4 次，无 human-authorization 绑定结构 | **role + human-authorization binding**（授权链） |
| 信任建立 | 一次性 VP 交换握手（静态信任快照） | **collaboration state machines**（动态多方协作状态） |
| 准入 | DID + 可信第三方 issuer（半中心化信任锚） | **permissionless multi-party** |
| 角色定位 | **SUPPORT（§3 identity layer 基础设施 + 被超越的 baseline）** | 引用其作为 DID/VC 标准基线，论证 ASM 的增量 |

**定位**：**SUPPORT + baseline-to-differentiate-from（非竞争者）**。它确立了 agent DID/VC 标准栈（Paper 2 §3 身份层可直接引为基础设施），但**明确缺少** ASM 的四个核心增量：(1) 角色 + 人类授权绑定；(2) ZK reputation；(3) 协作状态机（动态多方）；(4) permissionless。其评估暴露的"LLM 全权控制安全流程不可靠"恰是 ASM 用**协议层状态机 + 授权绑定**约束 LLM 自由度的动机。

## 区分/引用段落（~150-200词，英文）
> Rodriguez Garzon et al. (2025, arXiv:2511.02841) establish a foundational DID/VC stack for AI agents: each agent holds a ledger-anchored W3C DID plus third-party-issued W3C Verifiable Credentials, exchanged via DIF Presentation Exchange at the onset of an agent-to-agent dialogue to bootstrap cross-domain trust. We adopt their DID/VC primitives as the identity substrate of ASM's §3 identity layer. ASM departs along four axes their work does not address. First, where they bind credentials to an agent's *identity*, ASM binds credentials to *roles* and to an explicit *human-authorization* chain, so that a credential attests not merely "who" but "acting-as-what, authorized-by-whom." Second, their framework contains no reputation mechanism (the single mention defers to AgentFacts); ASM contributes *zero-knowledge reputation* proofs. Third, their trust model is a one-shot VP-exchange snapshot, whereas ASM drives interaction through *collaboration state machines* for dynamic, multi-party sessions. Fourth, their trust anchors require commonly trusted third-party issuers; ASM targets *permissionless multi-party* settings. Notably, their evaluation finds that leaving security procedures to an agent's LLM "in sole charge" is unreliable—precisely the failure mode ASM constrains via protocol-level state machines and authorization binding.

## Action items
- [ ] 在 Paper 2 §3（identity layer）引用本文为 agent DID/VC 标准化的代表性原型，作为我们身份基底的先例。
- [ ] 在 Paper 2 Related Work / 差异化表中列为 baseline，明确 ASM 四增量（角色+人类授权绑定 / ZK reputation / 协作状态机 / permissionless）。
- [ ] 引用其"LLM in sole charge is unreliable"评估结论，作为 ASM 用协议层约束 LLM 自由度的动机。
- [ ] **修正 bibliography**：作者为 Rodriguez Garzon et al.（TU Berlin），非 Rouhani。
- [ ] 顺带核查 Related Work 中提到的对手工作：Chaffer ETHOS、South et al. authenticated delegation、Raskar AgentFacts、Zou BlockA2A——可能是 Paper 2 需要区分的相邻文献。

## Jason's feedback
> （请在此处写入你的feedback）
