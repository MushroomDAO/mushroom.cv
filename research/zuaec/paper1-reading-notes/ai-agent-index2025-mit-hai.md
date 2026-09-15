# [AI Agent Index 2025 — MIT/HAI] The 2025 AI Agent Index: Documenting Technical and Safety Features of Deployed Agentic AI Systems
**arXiv**: 2602.17753 | **Year**: 2025 | **Authors**: MIT/HAI team (multi-author) | **Venue**: MIT/Stanford HAI (preprint)
**Cluster**: Industry Ecosystem Baseline & Governance
**Status**: Full read (ar5iv succeeded)

## Core Claim
A structured index of 30 deployed state-of-the-art agentic AI systems across 1,350 annotation fields reveals a severe transparency gap: developers freely publish capability benchmarks while withholding safety evaluations, creating fragmented accountability and concentration of control in three foundation model providers.

## Key Evidence / Numbers
**Scope:**
- **30** state-of-the-art deployed agents indexed
- **1,350** annotation fields per agent
- **198 of 1,350 fields (14.7%)** had no publicly available information
- **24 of 30 agents (80%)** released or received major agentic updates in 2024–2025 — confirms rapid ecosystem growth

**Safety & Transparency Gaps:**
- Only **4 agents** provide agent-specific system cards: ChatGPT Agent, OpenAI Codex, Claude Code, Gemini 2.5
- **25 of 30 agents (83%)** disclose no internal safety results
- **23 of 30 agents (77%)** have no third-party testing documentation
- Only **9 of 30 agents (30%)** report capability benchmarks at all
- **18 of 30 agents (60%)** operate bug bounties/vulnerability disclosure programs

**Technical Infrastructure (Protocol Relevance):**
- **20 of 30 agents (67%)** support Model Context Protocol (MCP) — MCP adoption as baseline
- **23 of 30 agents (77%)** are fully closed-source
- **21 of 30 agents (70%)** rely exclusively on GPT, Claude, or Gemini models

**Geographic Distribution:**
- **21 agents (70%)** from US-incorporated companies
- **5 agents (17%)** from China-incorporated companies
- Only **1 of 5 Chinese agents (20%)** document safety frameworks

**Autonomy Levels:**
- **5 of 30 agents (17%)** operate at L4–L5 autonomy (limited mid-execution intervention)
- **3 of 30 agents (10%)** maintain turn-based L1–L3 autonomy

**Web Conduct:**
- **21 of 30 agents (70%)** have no documented default disclosure behavior
- Only **7 of 30 agents (23%)** publish stable User-Agent strings and IP ranges
- **6 of 30 agents (20%)** explicitly ignore robots.txt standards
- **5 of 30 agents (17%)** have documented security incidents or reported security concerns
- Prompt injection vulnerabilities documented in **2 of 5** browser agents

**Agent Categories:**
- 12 Chat Applications with Agentic Tools (e.g., Claude Code)
- 5 Browser-Based Agents (Perplexity Comet, ChatGPT Atlas, ByteDance TARS)
- 13 Enterprise Workflow Agents

## Paper 1 Relevance
**§1 (Motivation)**: The ecosystem-baseline statistics are essential for motivating the Three Pillars. The 83% safety non-disclosure + 77% closed-source + 70% MCP dependency collectively illustrate why current single-provider hub-and-spoke architectures are inadequate — no shared trust, no interoperability standard, no permissionless participation. This is the empirical foundation for the "paradigm shift" claim.

**§5 (Deployment evidence)**: The 67% MCP adoption figure is a reference point showing that protocol-level adoption is possible at scale, but MCP alone is insufficient (no identity, no reputation, no trust layer).

Key tension for Paper 2: The 70% no-disclosure behavior + 6 robots.txt violators shows that without a protocol that encodes trust/identity (ASM), even rapid adoption can entrench bad practices.

## Paper 2 Relevance
**Direct**: The 67% MCP adoption baseline and 77% closed-source concentration are the foil against which ASM is positioned as an open-source, permissionless alternative. "30 deployed agents, 77% closed" → ASM provides the missing open layer.

## Verdict
⭐⭐⭐⭐⭐ | Definitive ecosystem baseline — the 30-agent index with 1,350 fields provides the most comprehensive empirical snapshot of the deployed agent landscape; essential citation for Paper 1 §1 and the contrast argument for Paper 2.

## Jason's feedback

> **2026-05-25**
> 这个调研算是一个反例——展示了当前生态系统的问题所在。
>
> 77% 闭源是必然的，我们是完全开源的，而且是 Apache 2.0 开源协议。
>
> **83% 不披露内部安全评测**——这个我们需要借鉴。我们要把安全评测做出来，至少从这个论文的视角来看什么是安全评测、应该评测哪些方面，包括可以参考的安全框架等等。这个借鉴过来作为我们的安全评测的基础。
>
> MCP 肯定是要使用的，这是毋庸置疑的。
>
> **市面上没有、但我们有的东西**：
>
> **身份层**：我们有助理型和自主型两种账户，包括 agent 的 ID 和 NFT（EIP-8004），以及核心的 agent registry，包括合规的入口，和他们独有的 account——这些都属于身份。
>
> **声誉层**：我们为此建立了 reputation 体系。这个 reputation 体系需要和 SuperPaymaster reputation 合约对接。对接的核心是每一个 agent 必须有一个 SBT——不同于 EIP-8004 的 NFT，这个 SBT 是 SuperPaymaster 和 agent account 我们自研体系的一个 reputation 的载体。包括未来不仅有 reputation，我们还有 credit——credit 是组织之间的相互授信（mutual credit limits）。
>
> **信任层**：这个需要协议来实现。一个是我们拆分的协议，再一个是每个协议的入口都有公共数据结构和自定义数据结构，只有通过这些才能够发起不同协议的交互，比如说找工作等等。
>
> **模型策略**：我们的模型会是多个模型的组合，肯定不是一家模型。同时将以开源模型——DeepSeek v4.0 Pro——为主。当然也支持自定义模型。

## 技术体系深度提取（Jason 亲述）

### 我们 vs 市场的三层差异

| 层次 | 市场现状（30 个 agent 索引）| 我们的方案 |
|------|--------------------------|---------|
| **身份层** | 70% 依赖 GPT/Claude/Gemini 单一供应商；无标准 agent 身份 | EIP-8004 NFT + 助理型/自主型双账户 + Agent Registry + 合规入口 |
| **声誉层** | 83% 无安全评测；无跨系统信任记录 | SBT（声誉载体）+ SuperPaymaster 合约对接 + 未来扩展 Credit |
| **信任层** | 67% 仅 MCP（无身份/声誉）；77% 闭源无可信基础 | 协议公共数据结构 + 自定义数据结构双重准入门槛 |

### 身份体系详细架构（Jason 亲述）

```
Agent 身份体系（两个维度）:
  维度 1 — 链上 NFT 身份:
    EIP-8004 NFT: agent 的唯一链上标识（可转让，代表所有权）
    Agent Registry: 双向查询（人→agent列表 / agent→人类所有者）
    合规入口: 账户层面满足监管要求（法律主体绑定）

  维度 2 — 账户类型:
    助理型账户: 使用人类账户资产，在人类约束下行动
    自主型账户: 独立账户，独立资产控制，有独立 ID
    → 两类账户都绑定到人类所有者（agent 不是法律主体）
```

### 声誉体系详细架构（Jason 亲述）

```
声誉体系（两层结构）:

  Layer 1 — Reputation（声誉分）:
    载体: SBT（Soul Bound Token）— 不可转让，绑定 agent 身份
    区别于: EIP-8004 NFT（可转让，代表所有权）
    计算: 基于协作历史，通过 SuperPaymaster reputation 合约更新
    范围: 当前版本，v1

  Layer 2 — Credit（授信额度，未来功能）:
    含义: 组织之间的相互授信（mutual credit limits）
    区别于 Reputation: Reputation 是历史声誉；Credit 是前向授权额度
    例子: A 组织授予 B 组织 10,000 USDC 的信用额度，可先履约后结算
    状态: v2 规划中
```

### 信任层（协议准入门槛）详细机制

每个协议（如求职推荐协议、外贸采购协议）都有两层数据结构：

```
协议准入结构:
  公共数据结构（Public Fields）:
    - 协作意图类型（job_referral / procurement / social_matching）
    - 最低声誉要求（min_reputation_score）
    - 协议版本（protocol_version）
    → 任何 agent 都必须满足；不满足则拒绝进入

  自定义数据结构（Custom Fields）:
    - 特定于协议的业务数据（岗位要求、采购规格、匹配条件）
    - 由协议设计者定义
    → 满足公共结构后，再验证自定义字段
```

**Jason 的设计逻辑**：两层准入 = 两道门。第一道门保证合规性和最低信任；第二道门保证业务匹配性。

### 模型策略（Jason 亲述）

| 选择维度 | 策略 |
|---------|------|
| 供应商多样性 | 多模型组合，绝不单一依赖一家 |
| 首选模型 | DeepSeek v4.0 Pro（开源，可本地部署，成本可控）|
| 扩展性 | 支持自定义模型接入 |
| 开源优先 | 与 Apache 2.0 开源协议定位一致 |

### 安全评测借鉴清单（Jason 要求从此论文提取）

基于 AI Agent Index 1,350 字段，我们需要覆盖的安全评测维度：

| 评测维度 | MIT/HAI 发现的缺口 | 我们的对应设计 |
|---------|-----------------|-------------|
| **系统卡披露** | 仅 4/30 有 agent-specific system card | ASM 协议要求每个 agent 有可机器读取的能力描述（ADP 扩展）|
| **安全评测公开** | 83% 不披露 | Paper 2 设计安全分析章节（§6）；公开评测方法论 |
| **第三方测试** | 77% 无第三方测试文档 | 社区审计机制（开源代码 + 公开 relay 可被任何人测试）|
| **Prompt 注入防御** | 2/5 浏览器 agent 有漏洞 | ASM 消息格式结构化（非自然语言），降低 prompt injection 面 |
| **robots.txt 合规** | 6/30 违反 | relay 节点行为规范作为准入条件之一 |
| **漏洞披露机制** | 60% 有 bug bounty | 开源社区 issue tracker + 安全披露流程 |

### Paper 1/2 引用策略

| 论文位置 | 引用方式 |
|---------|---------|
| Paper 1 §1（现状批判）| "MIT/HAI Agent Index [2025] surveys 30 deployed agents: 83% disclose no safety evaluations, 77% are closed-source, 70% depend on a single foundation model provider. This concentration and opacity is precisely what the P/SC/N framework addresses: open protocol (P), verifiable social capital (SC), and permissionless network participation (N)." |
| Paper 2 §2（差异化）| "Of 30 deployed agents, 67% adopt MCP but none provide reputation-weighted routing, cross-system identity, or permissionless protocol participation [MIT/HAI 2025]. ASM provides all three." |
