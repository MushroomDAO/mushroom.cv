# Agent 协作网络 — 核心逻辑与架构（v0.2）

> **来源**：基于 [01-ai-agent-evolution-analysis.md](01-ai-agent-evolution-analysis.md) ~ [04-agent-communication-protocol.md](04-agent-communication-protocol.md) 四篇原始研究文档 + [project-concept.md](project-concept.md) 整理
> **创建日期**：2026-05-20
> **最近更新**：2026-05-21（加入 7 层一致性视图作为整体导览）
> **定位**：工程项目本身的架构基线文档（独立于学术论文，但为 Paper 2 提供 reference implementation）
> **状态**：v0.2 — 范式定位锁定（"能力定位 vs 社会角色定位"）
> **关联**：[paper-innovation-points.md](paper-innovation-points.md) §〇（7 层视图） · [paper2-draft-v0.md](paper2-draft-v0.md) §7

---

## 〇、整体导览：7 层一致性视图

**核心范式**：传统 Agent 是"能力的容器"（capability container），我们的 Agent 是"承担社会角色的代理人"（social role agent）——携带所有者的真实社会身份与可验证凭证，在授权 scope 内、保护隐私、可追溯地代办具体事务。

| 层级 | 描述 | 文档归属 |
|------|------|--------|
| **L1 目标** | 提供 Agent 协作网络 | 本文档 §一 + Paper 1/2 §1 |
| **L2 范式** | Agent 是社会角色代理人，不是能力容器 | Paper 1 §1.0 |
| **L3 诊断** | 现有协议（MCP/FIPA）只支持能力调用，缺社会层基础设施 | Paper 1 §2 + §5 |
| **L4 框架** | 三要素（P + SC + N）+ 制度理论根基 | Paper 1 §6-§7 |
| **L5 架构** | 双网 + 社会记忆层 + 授权机制 | **本文档 §三 + Paper 2 §3** |
| **L6 协议** | ASM 三区块 + 状态机 + ZK | Paper 2 §4-§6 |
| **L7 实现** | Mycelium on Sepolia → OP mainnet | **本文档 §五 + Paper 2 §7** |

**本文档主要聚焦 L1、L5、L7**：项目愿景、系统架构、实现状态。理论框架（L2-L4）和协议规范（L6）请参见对应论文文档。

---

## 一、项目愿景

### 1.1 一句话定义

> **用区块链基础设施 + AI Agent 构建一个去中心化的 Agent 协作网络，让 Agent 承担其所有者（个体/组织）声明的社会角色，携带可验证社会凭证，在授权 scope 内代办具体经济与社会事务。**

**范式区分**（与现有方案的根本不同）：

| 维度 | 传统 Agent（能力定位）| 我们的 Agent（社会角色定位）|
|------|------------------|----------------------|
| 本质 | 能力的容器（capability container）| 社会角色的代理人（social role agent）|
| 被如何使用 | 被调用（API call）| 按角色行动（acts in role）|
| 携带什么 | API spec + 模型权重 | 所有者真实社会身份 + 凭证 + 角色声明 |
| 协议性质 | RPC / 工具调用 | 角色特定的协作协议 |
| 运行模式 | 单次请求-响应 | 持续、自主、按角色长期运行 |
| 示例 | "生成一张图" | "代我们外贸公司处理采购" |
| 现有方案 | MCP / FIPA ACL / AutoGen | **目前缺失，我们填补** |

### 1.2 价值主张

| 受益方 | 当前痛点 | 网络提供的价值 |
|--------|---------|--------------|
| 普通用户 | AI Agent 工具孤岛，无法跨工具协作；自己不可控、不可信 | 一个入口接入多 Agent；行为链上可追溯 |
| 中小企业 | AI 工具 SaaS 订阅昂贵；数据上传第三方风险 | 开源自部署，本地数据主权；按使用付费而非订阅 |
| 内容创作者 | 单 Agent 能力有限，多 Agent 串联需自己开发 | 现成的协作协议，配置即用 |
| Agent 开发者 | 提供好 Agent 难以获得收益 | 链上自动结算，按调用次数分润 |

### 1.3 与现有方案的根本差异

| 维度 | 我们 | OpenAI / Anthropic 平台 | LangChain 等框架 |
|------|------|---------------------|----------------|
| 数据主权 | 用户本地，不强制上云 | 数据上传云端 | 取决于部署 |
| 行为可验证 | 链上记录，可审计 | 黑盒 | 无原生支持 |
| 协作结算 | Agent 之间自动链上结算 | 无原生结算机制 | 无 |
| 角色权限 | Registry 合约去中心化管理 | 平台中心化控制 | 应用层管理 |
| 准入 | 无许可（任何人可接入）| 平台审批 | — |
| 跨 Agent 协作 | 通过协作协议 | 仅同平台 Agent | 框架内 |

---

## 二、核心问题（要解决的真实问题）

借鉴 [01-ai-agent-evolution-analysis.md](01-ai-agent-evolution-analysis.md) §5.3 的结论 — 当前多 Agent 系统的核心障碍是**缺乏共享社会记忆和制度化交换机制**。我们要解决：

1. **Agent 工具孤岛**：各工具互不相通，无法协同
2. **数据和行为不可信**：AI 结果无法验证，易被篡改
3. **成本和门槛高**：需要技术能力和资金才能使用
4. **协作无法自动结算**：Agent 之间的服务交换缺乏信任机制
5. **缺乏可累积的信誉**：每次交互"从零开始"，无法积累社会资本

---

## 三、系统总体架构

### 3.1 三层架构（宏观视图）

```
┌─────────────────────────────────────────────────────────┐
│  应用层（Agent Tools Layer）                              │
│  微信客服 / 研究助手 / 图片精灵 / 合同雷达 / 财务速记 …    │
│  ← 用户实际使用的 Agent 产品                              │
├─────────────────────────────────────────────────────────┤
│  协作协议层（Collaboration Protocol Layer）              │
│  可定义协作流程 + Agent 角色注册 + 任务路由 + 结果验证 +   │
│  ASM 通信协议                                            │
│  ← Paper 2 主要描述对象                                  │
├─────────────────────────────────────────────────────────┤
│  区块链基础层（Mycelium Protocol Base Layer）             │
│  AirAccount（无 Gas）+ SuperPaymaster + Registry +       │
│  GToken + 社会记忆层（链上事件 + Merkle 历史）             │
│  ← 已部分实现，Sepolia 测试通过                            │
└─────────────────────────────────────────────────────────┘
```

### 3.2 双网模型（与 Paper 2 一致）

```
┌──────────────────────────────────────────┐
│  人类子网 A                                │  ← 社会诉求 + 社会资本源头
│  - 用户 AirAccount                        │
│  - 人类签发的授权 VC（VC_auth）            │
│  - 链上身份（DID + 钱包）                  │
└────────────────┬─────────────────────────┘
                 │ 授权（VC_auth via Registry.sol）
                 ▼
┌──────────────────────────────────────────┐
│  社会记忆层（Social Memory Layer）          │  ← 不可篡改协作历史
│  - Ethereum/Optimism mainnet 链上账本     │
│  - Merkle 历史聚合                        │
│  - 信誉凭证（VC_rep）的累加器              │
│  - 协作事件索引                            │
└────────────────┬─────────────────────────┘
                 │ ZK proofs over history
                 ▼
┌──────────────────────────────────────────┐
│  Agent 子网 B                              │  ← 协议监管的自由活动空间
│  - Agent NFT 身份（EIP-8004 / ERC-721）   │
│  - Nostr Relay 集群（discovery 层）        │
│  - libp2p / WebRTC（negotiation 层）       │
│  - ASM 消息协议                            │
└──────────────────────────────────────────┘
```

### 3.3 核心抽象单元

| 抽象 | 定义 | 在系统中的实现 |
|------|------|--------------|
| **Human (h)** | 真实人类用户 | AirAccount + 链上 DID |
| **Agent (a)** | 人类授权运行的 AI 程序 | Agent NFT + 服务端进程 |
| **Authorization Relation (h→a)** | 人类授权 Agent 的关系 | VC_auth 凭证（链上）|
| **Collaboration Event** | Agent 间一次完整协作 | 链上 event log + Merkle 证明 |
| **Reputation Credential (VC_rep)** | 协作伙伴互签的评价凭证 | ERC-721 / SBT NFT |
| **Settlement** | 协作完成后的价值流转 | GToken (ERC-20) 转账 |

---

## 四、关键流程

### 4.1 用户视角的流程（"我要订一份会议纪要"）

```
用户（Human h）
  │
  │ Step 1: 通过 App 表达意图
  ▼
"帮我录会议 + 生成纪要 + 发到 Notion"
  │
  │ Step 2: App 在 Registry 查询相关 Agent
  ▼
找到：录音 Agent / 转写 Agent / 摘要 Agent / Notion 集成 Agent
  │
  │ Step 3: App 生成 Collaboration Protocol P_meeting
  ▼
P_meeting = (Roles, Messages, States, Verification, Settlement)
  │
  │ Step 4: 用户签发 VC_auth 授权给参与 Agent
  ▼
VC_auth(h → 录音Agent, scope=audio_capture, budget=0.1 GToken)
VC_auth(h → 摘要Agent, scope=text_processing, budget=0.5 GToken)
...
  │
  │ Step 5: App 启动 Protocol P_meeting
  ▼
录音 Agent → 转写 Agent → 摘要 Agent → Notion 集成 Agent
（每一步链上记录 + 互相签发 VC_rep）
  │
  │ Step 6: 完成后自动结算
  ▼
GToken 按 P_meeting 规则分配给参与 Agent
用户收到 Notion 链接 + 链上回执
```

### 4.2 Agent 视角的流程（"我是一个录音 Agent，寻找协作"）

```
Agent a_recording
  │
  │ Step 1: 在 Nostr Relay 发布存在声明
  ▼
ASM message {
  IA: ZK-proof("我有有效授权，能力 audio_capture"),
  CR: capability "audio_capture rating 4.5+",
        budget commitment > 0
  II: PROPOSE_COLLABORATION for {meeting_recording}
}
  │
  │ Step 2: 检索其他 Agent 的存在声明
  ▼
发现 a_transcript（转写 Agent，rating 4.8）
  │
  │ Step 3: 给 a_transcript 留言
  ▼
ASM message {kind: DM, action: DELEGATE_REQUEST}
  │
  │ Step 4: a_transcript 接受 → 建立 WebRTC 直连
  ▼
完成 propose / accept / execute 三阶段
  │
  │ Step 5: 完成 → 互签 VC_rep
  ▼
a_recording ← VC_rep(rating: 5) ← a_transcript
a_recording → VC_rep(rating: 5) → a_transcript
  │
  │ Step 6: 各自更新声誉累加器
  ▼
新的 VC_rep 加入本地 credential set
下次发布 IA 时可证明"我有至少 K 个独立伙伴的高评价"
```

---

## 五、组件功能定义（已实现 / 待实现矩阵）

### 5.1 区块链基础层（Mycelium Protocol）

| 组件 | 功能 | 实现状态 | 备注 |
|------|------|---------|------|
| **AirAccount** | 无 Gas 用户账户，EIP-4337 标准 | ✅ Sepolia 已部署 | 配合 SuperPaymaster |
| **SuperPaymaster** | Gas 赞助合约 | ✅ Sepolia 已部署 | 支持企业/Agent 赞助 |
| **Registry.sol** | Agent 角色注册 + 权限管理 | ✅ Sepolia 已部署 | 当前支持 KMS/DVT/ENDUSER 角色 |
| **GToken (ERC-20)** | 协作票据 + 治理代币 | ✅ Sepolia 已部署 | 0x4e6A1125... |
| **SaleContractV2** | 售票合约（动态里程碑+12%）| ✅ Sepolia 已部署 | 已通过 20 个 E2E 测试 |
| **aPNTs** | Aggregated Personal Network Tokens（积分）| ✅ Sepolia 已部署 | 0x4C4EC2e8... |
| **BuyHelper** | EIP-3009 Gasless 购买中继 | ✅ Sepolia 已部署 | 0x578D6f74... |
| **AirAccountDelegate** | Type-4 委托合约 | ✅ Sepolia 已部署 | — |
| **VC_auth Registry** | 人类→Agent 授权凭证 | ⬜ 待设计 | Paper 2 §3.3 |
| **VC_rep Registry** | Agent←→Agent 互评凭证 | ⬜ 待设计 | Paper 2 §5 |
| **Reputation Accumulator** | 链上声誉累加器 | ⬜ 待设计 | Camenisch-Lysyanskaya 构造 |
| **Mainnet 部署** | OP Mainnet 上线 | ⬜ 计划中 | 见 docs/mainnet-launch/ |

### 5.2 协作协议层（Protocol Layer）

| 组件 | 功能 | 实现状态 | 备注 |
|------|------|---------|------|
| **Collaboration Protocol DSL** | YAML/JSON 定义协作流程 | ⬜ 待设计 | 见 [project-concept.md](project-concept.md) 示例 |
| **ASM Message Codec** | ASM 三区块编解码 | ⬜ 待实现 | CBOR 二进制格式 |
| **Nostr Relay Integration** | Relay 集群对接 | ⬜ 待实现 | 优先复用现有 Nostr 公共 relay |
| **libp2p Layer** | 直连 negotiation | ⬜ 待实现 | WebRTC 优先 |
| **ZK Proof Generation** | 浏览器端 ZK 证明生成 | ⬜ 待选型 | Groth16 vs Halo2 vs Plonk |
| **State Machine Runtime** | 协议状态机执行器 | ⬜ 待实现 | TypeScript/Rust 双版本 |
| **Reputation ZK Module** | 声誉 ZK 证明模块 | ⬜ 待实现 | 包含 accumulator + threshold proofs |

### 5.3 应用层（Agent Tools — 公共物品 8 件套）

参见 [docs/public-goods/](../../docs/public-goods/) 完整设计文档：

| Agent | 目标用户 | 实现状态 | 备注 |
|-------|---------|---------|------|
| 微信客服 Agent | 中小商家 | 设计完成 | docs/public-goods/agents/01-wechat-customer-service.md |
| 研究助手 Agent | 研究生/顾问 | 设计完成 | 02-research-assistant.md |
| 图片精灵 Agent | 电商/创作者 | 设计完成 | 03-image-sprite.md |
| 合同雷达 Agent | 自由职业者/SMB | 设计完成 | 04-contract-radar.md |
| 财务速记 Agent | 个体户 | 设计完成 | 05-finance-quicknote.md |
| 会议秘书 Agent | 创业团队 | 设计完成 | 06-meeting-secretary.md |
| 健康提醒 Agent | 个人 | 设计完成 | 07-health-reminder.md |
| 社区问答 Agent | 社区运营 | 设计完成 | 08-community-qa.md |

**注**：应用层 Agent 是"使用"协作网络的产品；网络本身的核心价值是赋能任意第三方开发新 Agent。

---

## 六、技术栈选型说明

### 6.1 区块链选择：Ethereum + Optimism

| 选择 | 理由 |
|------|------|
| 主网部署在 Optimism | 低 gas + EVM 兼容 + 主流 L2 |
| 关键合约 cross-chain 到 Ethereum mainnet | 安全性 + 长期可信 |
| 兼容 ERC-4337（账户抽象）| 用户无需持有 ETH，符合"低门槛"目标 |

### 6.2 通信层选择：Nostr + libp2p

| 选择 | 理由 |
|------|------|
| **Nostr** 用于 discovery 层 | 真去中心化（已部署的公共 relay 网络）；适合"留言阶段" |
| **libp2p** 用于 negotiation 层 | 模块化 P2P 栈；NAT 穿透好；适合"直连阶段" |
| **WebRTC** 作为 libp2p transport | 浏览器原生支持，部署友好 |

### 6.3 密码学选择：BBS+ + ZK-SNARK + Merkle Accumulators

| 选择 | 理由 |
|------|------|
| **BBS+ 签名** | 支持选择性披露的可验证凭证 |
| **Groth16 ZK-SNARK** | 证明小、验证快；生态成熟 |
| **Camenisch-Lysyanskaya Accumulator** | 高效成员证明，适合声誉聚合 |
| 备选：**Halo2** | 无需 trusted setup；待评估 |

### 6.4 身份选择：DID + EIP-8004

| 选择 | 理由 |
|------|------|
| **W3C DID** | 跨平台身份标准 |
| **EIP-8004**（NFT 绑 DID）| 链上可验证 Agent 身份 + 人类授权关系 |
| 若 EIP-8004 实现未稳定，fallback 到 **ERC-721 + 自定义绑定** | 务实路径 |

---

## 七、与 Paper 1/2 的关系

### 7.1 学术论文 vs 工程项目

| 维度 | Paper 1 (Three Pillars Framework) | Paper 2 (ASM Protocol) | 本工程项目 (Mycelium Protocol) |
|------|----------------------------------|---------------------|-----------------------------|
| 抽象层次 | 概念框架 | 协议规范 | 具体实现 |
| 范围 | 任何 Agent 协作系统 | 任何符合 ASM 协议的实现 | 一个具体实现 |
| 是否商业化 | 否 | 否 | 是（但保持开源）|
| 时间线 | 学术 publication 时间表 | 学术 publication 时间表 | 工程开发时间表 |

### 7.2 三者的双向映射

```
Paper 1 (三要素 P/SC/N)
       ↓ 概念实例化
Paper 2 (ASM Protocol Specification)
       ↓ 实现实例化
Mycelium Protocol (本工程项目)
       ↑ Reference Implementation (供学术验证)
       ↑ Empirical Anchor (供论文引用真实数据)
```

### 7.3 引用规范

- Paper 1 §8 引用本架构（作为透明披露案例）
- Paper 2 §7 引用本架构（作为 reference implementation）
- 本工程项目代码 README 引用 Paper 1 / Paper 2（一旦发表）

---

## 八、路线图

### Phase 0：当前（2026 Q2，已完成大部分）

- ✅ 区块链基础层在 Sepolia 测试网验证
- ✅ Gasless 流程跑通（EIP-3009 + BuyHelper）
- ✅ 8 个应用层 Agent 设计文档完成
- 🟡 论文初稿完成（待 Codex review）

### Phase 1：OP Mainnet 上线（2026 Q3）

- ⬜ 完成主网部署计划（见 docs/mainnet-launch/MAINNET-DEPLOY.md）
- ⬜ Registry V2 设计（含 VC_auth/VC_rep 数据结构）
- ⬜ ASM Codec MVP（CBOR 编解码）
- ⬜ Nostr relay 集成测试
- ⬜ Paper 1 提交 arXiv

### Phase 2：第一个完整 Agent 协作 Demo（2026 Q4）

- ⬜ 选 2 个最简单的 Agent（如：转写 + 摘要）跑通 ASM 协议
- ⬜ ZK 证明系统集成（先用 trusted setup 版本）
- ⬜ 性能初步数据采集
- ⬜ Paper 2 提交 arXiv

### Phase 3：Agent 生态启动（2027 上半年）

- ⬜ 公共物品 8 件套陆续上线
- ⬜ 第三方开发者文档 + SDK
- ⬜ 声誉系统稳定运行
- ⬜ ZUAEC 总决赛参赛（如晋级）

### Phase 4：跨平台互通（2027 下半年起）

- ⬜ 与 FIPA ACL 桥接
- ⬜ 与 MCP 桥接
- ⬜ 跨链部署研究

---

## 九、关键设计决策（含理由）

### 9.1 为什么是"协作协议"而不是"中心化平台"？

参见 Paper 1 §6.1 操作性定义。中心化平台缺乏：
- 第三方独立验证能力（V）
- 跨平台可移植性
- 用户对数据的最终控制权

### 9.2 为什么需要"量化社会资本"而不是简单评分？

- 简单评分（如 5 星制）易被刷分
- 量化社会资本（Hist + Cred + Rel）是**可验证的行为历史集合**，无法仅靠刷分操作
- 详见 Paper 1 §6.2 与 Paper 2 §5

### 9.3 为什么坚持"无许可"？

- 任何中心化审批都会成为治理失败点（详见 Hilbert 关于 AI 网络偏见的研究）
- 无许可 + 协议层治理 = 数字化的 Ostrom 公地
- 但承认 P4（无许可无治理 → 同质化）的风险

### 9.4 为什么用 Nostr 而不是 IPFS / 自建 relay？

- Nostr 是**已部署的公共 relay 网络**（数百个 public relay），冷启动成本低
- IPFS 适合内容存储，不适合实时消息
- 自建 relay = 中心化倾向（与无许可原则冲突）

### 9.5 为什么 ZK 而不是明文记录？

- 明文记录 = 隐私泄露（用户授权关系全网可见）
- ZK 既保隐私又保可验证性
- 接受 ZK 生成的实时性挑战（详见 Paper 2 §8.1）

---

## 十、需要 Jason review 的关键问题

请就以下问题给出确认或修改意见：

1. **§1.2 价值主张表格**：受益方和痛点是否准确？是否漏掉关键场景？
2. **§3.3 核心抽象单元表格**：是否完整？是否需要加 Group / Organization 抽象？
3. **§4.1 用户视角流程**：以"录会议"为例是否合适？是否换为更贴近 ZUAEC 评审的场景？
4. **§5.1 实现状态矩阵**：✅ / ⬜ 的标注是否准确？有无遗漏？
5. **§8 路线图**：时间节点是否符合实际产品规划？
6. **§9 关键设计决策**：是否覆盖你最初的设计直觉？有无遗漏？

review 完后，本文档定稿后将作为 Paper 2 §7 的 reference implementation 引用依据。

---

## 十一、附录：原始输入文档对应关系

| 原始文档 | 对应本架构章节 |
|---------|--------------|
| [01-ai-agent-evolution-analysis.md](01-ai-agent-evolution-analysis.md) §5.3 | §二 核心问题 |
| [02-human-ai-collaboration-framework.md](02-human-ai-collaboration-framework.md) §二 三要素框架 | §一 项目愿景 + §三 三层架构 |
| [03-dual-network-experiment.md](03-dual-network-experiment.md) §一 社会子宫 + §四 三层结构 | §三 双网模型 + 社会记忆层 |
| [04-agent-communication-protocol.md](04-agent-communication-protocol.md) 全文 | §六 技术栈选型 + §四 关键流程 |
| [project-concept.md](project-concept.md) | §一 项目愿景 + §五 组件功能 + 应用层 |
