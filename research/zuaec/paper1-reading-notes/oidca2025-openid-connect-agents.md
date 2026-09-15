# [Nagabhushanaradhya 2025] OpenID Connect for Agents (OIDC-A) 1.0
**arXiv**: 2509.25974 | **Year**: 2025 | **Authors**: Subramanya Nagabhushanaradhya | **Venue**: arXiv preprint (technical specification)
**Cluster**: Agent Identity & Authentication Protocols
**Status**: Full read

## Core Claim
OIDC-A extends OpenID Connect with five categories of standardized claims (agent identity, delegation, capability, trust, attestation) to fill the gap left by OAuth 2.0/OIDC which were designed for human users and cannot represent LLM-based agent identity, delegation chains, or hardware attestation.

## Key Evidence / Numbers
- Defines 5 claim categories: Core Agent Identity (agent_type, agent_model, agent_version, agent_provider, agent_instance_id), Delegation & Authority (delegator_sub, delegation_chain, delegation_purpose, delegation_constraints), Capability & Trust (agent_capabilities, agent_trust_level, agent_attestation, agent_context_id)
- 6 primary extension mechanisms over base OIDC
- Delegation chain implemented as ordered arrays with mandatory scope reduction at each step
- Attestation framework supports JWT-based, TPM 2.0, and Intel SGX formats, compatible with IETF RATS standards
- Adds discovery endpoints for attestation verification and capability enumeration
- Emphasizes strong asymmetric authentication (not shared secrets) for agents
- Requires full delegation chain validation at every interaction point (Zero Trust Architecture)
- Reference implementation: https://github.com/subramanya1997/oidc-a/

## Paper 1 Relevance
- **§2 (Paradigm Shift)**: Concrete evidence that existing identity infrastructure (OAuth 2.0, OIDC) was built for capability-invocation patterns (human→app), not social role agency. OIDC-A's emergence signals industry recognition of the gap — supports our "old paradigm fails" framing.
- **§4 (SC Pillar)**: `agent_trust_level` and `agent_attestation` claims are a primitive form of quantified social capital — cite as "industry starting point" that lacks the persistent, cross-network reputation that SC pillar requires.
- **§5 (P Pillar)**: Delegation chain and delegation_constraints directly relate to protocol-level role assignment and authority scope — cite as foundational identity substrate that ASM's P layer builds upon.

## Paper 2 Relevance
- **§3 (ASM Architecture — Principal Identity)**: OIDC-A is the closest prior work to ASM's verifiable principal identity component. ASM should explicitly compare: OIDC-A provides authentication but no reputation-weighted routing, no role-bearing message headers, and no permissionless registration. Cite as "complementary identity layer" — ASM could ride atop OIDC-A for authentication while adding SC routing.
- **§4 (Protocol Specification)**: The delegation_chain array structure and scope-reduction enforcement directly inform ASM's principal chain field design. Adopt or cite the ordered-array pattern.
- **§5 (Security Analysis)**: Zero Trust principle (verify at every interaction) aligns with ASM's per-hop verification requirement — cite OIDC-A as grounding for this design choice.

## Verdict
⭐⭐⭐⭐⭐ | The single most directly relevant identity standard for Paper 2 — OIDC-A defines the authentication substrate that ASM's principal identity layer must either adopt, extend, or explicitly differentiate from.

## Jason's feedback

> **2026-05-24**
> OAuth 2.0 演进到 OIDC 是个好的发展，但 OIDC-A 在细节上有几个问题。
>
> **我们的 agent 身份方案**：我们有自研的 agent 账户（助理型和自主型两种），加上 ERC-8004 NFT。在此基础上我们自建了双向查询注册表——既能查一个人类拥有哪些 agent，也能查一个 agent 是哪个人类拥有的。这两个维度构成完整的 agent 身份体系，合规入口在账户层面。
>
> **问题 1：强制唯一 agent DID 是多余的**。OAuth 2.0 从来没有要求每个 HTTP 请求必须有唯一身份——它是在 session 层面处理授权的。OIDC-A 要求每个 agent 有唯一 DID，但这个设计其实是多余的，或者说是在 agent 层面引入了 OAuth 本来不需要的东西。
>
> **问题 2：model 版本和供应商字段限制了 agent 的发展**。未来的 agent 会用多个模型协作，不会是单一模型。把 agent_model、agent_version、agent_provider 这些字段固定在身份层，会限制未来多模型 agent 的发展。这些字段应该是运行时属性，而不是身份的一部分。
>
> **亮点 1：delegation chain（委托链）概念很好**，我们也会设计这个。比如说一个 agent 被委托了某些权限，它在子委托时只能缩减权限，不能扩大。类比到我们的场景：agent 能承诺什么、能回答什么问题，都是有约束的——这个设计思路值得借鉴。
>
> **问题 3：capability claims 限制了 agent 的能力边界**。未来的 agent 可能什么都能做，把能力声明固定在身份里反而是对能力的限制。能力应该是动态发现的，不是静态声明的。
>
> **最大问题：trust level 从信任模型角度来看是危险的**。没有人会相信 agent 自己声明的信任等级。这是一个纯粹自我声明的字段，在零信任架构里没有任何意义。更准确的原则是 **"verify not trust"**——每次交互都重新验证，不依赖预先声明的信任等级。OIDC-A 一方面要求 Zero Trust（每次交互都验证完整委托链），另一方面又提供 `agent_trust_level` 字段——这两个设计是自相矛盾的。你既然每次都重新验证了，还要预先声明信任级别干什么？
>
> **亮点 2：hardware attestation（硬件证明）**是可选的，没有特别的创新，但方向是对的。
>
> **亮点 3：sub-agent 概念很好**，我们也会设计。一个 agent 可以在授权范围内生成子 agent 来分解任务。
>
> **核心洞见**：agent 身份必须和财务资产控制绑定——这是 agent 协作的基础。没有资产控制的 agent 身份是没有意义的。

## "Verify Not Trust"原则深度解析（技术分析）

### Jason 洞见的核心矛盾

OIDC-A §4.3 (`agent_trust_level`) 与其零信任要求是逻辑矛盾：

```
OIDC-A 的矛盾：
  设计 A: Zero Trust → 每次交互必须验证完整 delegation chain
  设计 B: agent_trust_level = "high" / "medium" / "low" → 自我声明的静态等级

如果执行了 A，B 有什么用？
如果依赖了 B，还需要执行 A 吗？
```

**"Verify not Trust" 原则**（Jason）：
- 信任级别是自我声明的 → 没有机制保证真实性 → 无法作为安全依据
- 正确做法：每次交互时验证可验证凭证（VC），通过验证则可信，不通过则拒绝
- 等价于零信任架构的正确实现：不存储/缓存信任状态，只验证当前凭证

**对 ASM 的启示**：
- ASM 不设计 `trust_level` 字段
- 取而代之：`VC_protocol`（协议合规 VC）+ `VC_rep`（声誉范围 VC）每次验证
- SC 声誉分不是"信任级别"，而是**历史行为的量化记录**（可更新，基于验证事件）

### 我们的 agent 身份 vs OIDC-A 对比

| 维度 | OIDC-A 方案 | 我们的方案 |
|------|------------|---------|
| **身份基础** | 唯一 agent_instance_id（自颁发或 IdP 颁发）| ERC-8004 NFT（链上，去中心化，不依赖 IdP）|
| **账户类型** | 未区分 | 助理型（使用人类账户资产）/ 自主型（独立账户）|
| **双向查询** | 无 | 双向注册表：人→agent 列表，agent→人类所有者 |
| **模型绑定** | agent_model / agent_version 固化在身份层 | 运行时属性，不在身份层；支持多模型 agent |
| **委托链** | ordered array，强制权限缩减 ✅ | 借鉴此设计，加入 ASM 协议头 |
| **信任声明** | agent_trust_level（自声明）❌ | 不设此字段；改用 VC 每次验证 |
| **能力声明** | agent_capabilities（静态）⚠️ | 动态协议发现（结构化 JSON，不是 OIDC claim）|
| **硬件证明** | TPM 2.0 / Intel SGX（可选）| 可选扩展；v1 不强制（消费级设备为主）|
| **合规入口** | IdP 层（中心化身份提供者）| 账号层（链上 + 法律主体绑定）|

### 可借鉴 vs 需规避的设计

| 设计 | 借鉴/规避 | ASM 处理 |
|------|---------|---------|
| Delegation chain ordered array + 权限缩减 | ✅ 借鉴 | ASM `principal_chain` 字段采用相同逻辑 |
| Zero Trust 每次验证 | ✅ 借鉴 | ASM 每跳验证 VC_protocol + VC_rep |
| ECDHE 端到端加密（与 ANP 相同）| ✅ 借鉴 | ASM 传输层采用 ECDHE/X25519 |
| Sub-agent delegation 概念 | ✅ 借鉴（待设计）| ASM v2 中设计 sub-agent 权限继承 |
| 强制唯一 agent DID | ❌ 规避 | 我们用 ERC-8004 NFT，不强制唯一 DID per session |
| agent_model / agent_version 在身份层 | ❌ 规避 | 运行时属性，不固化在身份层 |
| agent_trust_level（自声明信任等级）| ❌ 规避 | 完全不使用；改用验证-驱动的 SC 声誉 |
| agent_capabilities（静态能力声明）| ⚠️ 谨慎 | 协议能力动态声明（`protocol_capabilities` JSON），不是静态 OIDC claim |

### Paper 2 §3 建议引用语

> "OIDC-A [Nagabhushanaradhya 2025] identifies the correct gap — OAuth 2.0 was designed for human-to-application delegation, not agent-to-agent — and the delegation chain with mandatory scope reduction is a design we directly adopt. However, the `agent_trust_level` claim contradicts the Zero Trust mandate OIDC-A itself enforces: if every interaction requires full delegation chain verification, a static trust level declaration adds no security and creates false assurance. ASM does not carry trust level fields. Instead, per-hop verification of VC_protocol and VC_rep operationalizes 'verify, not trust' as a protocol guarantee rather than an advisory claim."
