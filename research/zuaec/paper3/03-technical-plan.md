# ACN-Agent 技术方案与开发里程碑（Pi 底座）

> **用途**：Paper 3 的工程落地方案。把 Paper 1（P/SC/N）+ Paper 2（ASM）的设计，以 Pi（pi-mono）为底座，落地为一个真实可运行、标杆能打的 agent。包含：架构设计 + feature→Pi 能力映射 + 可行性分析 + 4+1 阶段里程碑（每阶段怎么开发、怎么测试）。
> **底座**：Pi（`@earendil-works/*`，TypeScript，MIT）
> **配套**：见 `01-feature-requirements.md`（需求清单）、`02-pi-research.md`（Pi 调研）
> **最后更新**：2026-05-26

---

## 一、总体架构：ACN-Agent on Pi

```
┌─────────────────────────────────────────────────────────────┐
│                      ACN-Agent (我们的产物)                    │
│                                                                │
│  ┌──────────────────────────────────────────────────────┐   │
│  │  Pi Agent Core (@earendil-works/pi-agent-core)         │   │
│  │  Agent 类 + 事件流 + 工具调用 + 状态管理                  │   │
│  └──────────────────────────────────────────────────────┘   │
│         │ 通过 5 个钩子注入我们的能力 ↓                          │
│                                                                │
│  ① transformContext ──→ LAAS 特征提取 + DP 噪声 + 记忆召回      │
│  ② convertToLlm ──────→ ASM 消息过滤（控制头不进 LLM）         │
│  ③ beforeToolCall ────→ 安全分层 Layer 0-4 + 权限阻断          │
│  ④ afterToolCall ─────→ 审计标记 + 声誉更新触发                 │
│  ⑤ streamFn ──────────→ 路由本地模型 / 经 relay 传输           │
│                                                                │
│  自定义消息类型 (declaration merging):                          │
│    asm_role_declaration / asm_reputation / asm_verification    │
│                                                                │
│  AgentTool 集 (我们实现):                                       │
│    [web3] erc8004_register, sbt_query, credit_settle (viem)    │
│    [net]  nostr_publish, nostr_subscribe (nostr-tools)         │
│    [data] crawl4ai_fetch, mcp_* (数据获取/工具)                 │
│    [asm]  asm_send, asm_handshake (协议原语)                   │
│                                                                │
│  ┌──────────────────────────────────────────────────────┐   │
│  │  Pi AI (@earendil-works/pi-ai) — 统一 LLM 层            │   │
│  │  本地: Ollama/vLLM (Qwen3/Phi-4) │ 云: DeepSeek/Claude  │   │
│  └──────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
         │                          │                    │
    本地设备(私钥/原始数据)      Nostr relay 网络        以太坊链(ERC-8004/SBT)
    数据永不出本地              ECDHE 加密消息          身份+声誉锚定
```

**核心设计原则**：不 fork Pi，不对抗框架。所有 ACN 能力通过 Pi 的 5 个扩展钩子 + 自定义消息类型 + AgentTool 注入。ACN-Agent = Pi + 我们的钩子实现 + 我们的工具集 + 我们的协议层。

---

## 二、Feature → Pi 能力映射（逐项可行性）

### 2.1 五模块映射

| 模块 | 需求 | Pi 落地方式 | 可行性 |
|------|------|-----------|--------|
| M1 感知 | 文本/数据/多模态 | pi-ai 原生多模态输入；Crawl4AI 作为 AgentTool | ✅ 高 |
| M1.4 LAAS 过滤 | 数据不出本地 | `transformContext` 做本地特征提取；`beforeToolCall` 阻断泄露 | ✅ 高 |
| M2 规划 | 任务分解/重规划 | Pi agent loop（turn 循环）；多轮 tool 调用 | ✅ 高 |
| M3 记忆 | 四层记忆 | `transformContext` 注入召回；自建存储（Pi 不含记忆）| ⚠️ 中（需自建）|
| M4 行动 | 工具/链上交易 | AgentTool + viem + MCP | ✅ 高 |
| M5 社会通信 ⭐ | ASM 协议 | **自定义消息类型 + convertToLlm + asm_* 工具** | ✅ 高（核心契合）|

### 2.2 跨切面映射

| 关注点 | Pi 落地方式 | 可行性 |
|-------|-----------|--------|
| 身份 ERC-8004 | AgentTool（viem 签名/注册）| ✅ 高 |
| SBT 声誉 | AgentTool（viem 查询/更新 SuperPaymaster）| ✅ 高 |
| 安全分层 | `beforeToolCall` 阻断 + `transformContext` 过滤 + `output-guard`（Pi 有）| ✅ 高 |
| DP 噪声 | `transformContext` 内注入（自建 DP 库）| ⚠️ 中（需自建）|
| 沙盒 | Pi bash-executor + E2B/Docker | ✅ 高 |
| 自进化 | Pi coding-agent 自扩展（read/write/edit）+ skills.ts | ⚠️ 中（探索）|
| 审计 | 事件流 subscribe + 消息历史序列化 | ✅ 高 |

### 2.3 网络层映射

| 需求 | Pi 落地方式 | 可行性 |
|------|-----------|--------|
| Nostr relay 连接 | nostr-tools 作 AgentTool；或 `streamFn` 经 relay 中继 | ✅ 高 |
| 多 relay / 切换 | nostr-tools 多 relay 池 | ✅ 高 |
| 声誉加权路由 | relay 客户端逻辑（自建）+ SBT 查询 | ⚠️ 中（自建）|

**总体可行性结论**：✅ **高度可行**。70% 的需求 Pi 有原生支持或干净钩子；30% 需自建（记忆存储、DP 噪声、声誉路由、自进化探索），但都是独立模块，不依赖改 Pi 源码。最大风险项是自进化（EVO.*），列为后期/探索。

---

## 三、关键技术决策

| 决策点 | 选择 | 理由 |
|-------|------|------|
| 语言/运行时 | TypeScript / Node（Pi 原生）| Pi 是 TS；viem + nostr-tools 均 TS 原生 |
| web3 库 | **viem**（不用 ethers.js）| 符合项目技术栈规范（见 memory）|
| 本地模型 | Ollama（开发）/ vLLM（生产）| pi-ai OpenAI-compatible 原生支持 |
| 本地隐私模型 | Qwen3 30B-A3B / Phi-4 mini | LAAS 本地推理 |
| 云模型 | DeepSeek V3.2（pi-ai 一等公民）/ Claude | 复杂推理 |
| relay | Nostr（nostr-tools）| N 支柱去中心 + relay 可靠性 |
| 记忆 | 自建（Context 序列化为基础）+ 可选 Mem0 | Pi 不含记忆 |
| 工具 schema | TypeBox（Pi 用）| 类型安全 + 运行时验证 |
| ASM 消息 | 自定义 AgentMessage 类型 | Pi declaration merging |
| 测试模型 | 待确认 Pi mock（FunctionModel?）/ 否则自建 stub | 见里程碑测试策略 |

---

## 四、开发里程碑（4 + 1 阶段）

> 总目标：先做出 **Tier A 最小可行 agent**（能注册身份、连 relay、按一个场景协议完成首次协作），再逐步补 Tier B。每个里程碑都可独立 demo + 测试。

### 里程碑 M1：Pi 底座 + 身份骨架（Tier A 地基）

**目标**：ACN-Agent 能跑起来，有链上身份，能用本地+云模型完成本地任务。

**开发内容**：
1. 搭 monorepo，封装 `pi-agent-core` 为 `acn-agent` 包
2. 接入 pi-ai：本地模型（Ollama + Qwen3）+ 云模型（DeepSeek）双通道
3. `erc8004_register` 工具（viem）：生成密钥对、注册 ERC-8004 NFT、签名
4. 私钥本地加密存储（SEC.1）——私钥永不进 agent context
5. 会话持久化：Context 序列化 + sessionId
6. 工作记忆（Pi 原生）+ 基础情节记忆（本地 SQLite/文件）

**怎么测试**：
- 单元：每个工具独立测（mock LLM；用 Pi 的测试工具或自建 stub model）
- 集成：agent 启动 → 生成身份 → 在 **测试网**（Sepolia）注册 ERC-8004 → 完成一个纯本地任务（如"总结这个文件"）
- 验收：`agent.state` 有有效身份；私钥不出现在任何 LLM 调用的 context 里（用 `convertToLlm` 输出断言）

**交付**：能在测试网注册身份、用本地模型完成任务的 agent CLI。

---

### 里程碑 M2：ASM 消息 + relay 连接（Tier A 核心）⭐

**目标**：两个 ACN-Agent 能通过 Nostr relay 交换签名的 ASM 消息，完成双向确认握手，且原始数据不出本地。

**开发内容**：
1. **ASM 消息作自定义类型**（declaration merging）：`asm_role_declaration` / `asm_reputation_assertion` / `asm_verification_challenge`
2. `convertToLlm`：过滤 ASM 控制头（只让协作内容进 LLM）
3. `asm_send` / `asm_handshake` 工具：生成/解析 ASM 消息，角色声明（M5.1/M5.2/M5.5）
4. ECDHE 端到端加密（SEC.2）
5. `nostr_publish` / `nostr_subscribe` 工具（nostr-tools，NET.1）
6. **LAAS 安全分层**：`beforeToolCall` 阻断会发送原始数据的工具；`transformContext` 做本地数据过滤（SEC.3, M1.4）
7. MCP 工具接入（M4.1）
8. 一个演示场景协议（SCN.4，如求职推荐/社交匹配）

**怎么测试**：
- 单元：ASM 消息编解码、签名验证、ECDHE 加解密
- 集成：本地起一个 Nostr relay（如 `nostr-rs-relay` docker）→ 两个 agent 实例 → A 发起握手 → B 确认 → 完成一轮 ASM 协作
- **安全测试（关键）**：注入一个试图发送原始数据的 prompt → 断言 `beforeToolCall` 阻断 → 断言离开本地的 payload 只含特征向量，无原始数据
- 验收：两 agent 完成签名握手 + 一轮协作；抓包确认无明文原始数据出境

**交付**：两个 agent 跨 relay 完成一次完整 ASM 协作的 demo。**这是论文 §7 参考实现的核心 demo。**

---

### 里程碑 M3：声誉 + 记忆 + 场景协议（Tier A 完整 → Tier B 起步）

**目标**：agent 完成多轮协作，声誉链上更新，记忆跨会话持久，跑通采购场景。

**开发内容**：
1. `sbt_query` / `sbt_update` 工具（viem + SuperPaymaster）：声誉查询/更新（REP.1/REP.4/ID.2）
2. **声誉可验证**（REP.4）——杜绝来源悖论：声誉必须密码学签名，不接受自我声明
3. 四层记忆完整：情节/语义（自建或 Mem0）+ 程序记忆（含安全疫苗库）（M3.2-3.4）
4. DP 噪声注入（SEC.4）——`transformContext` 内
5. 双向 registry（ID.4）：human↔agent 双向查
6. 采购场景协议 + ZK 资质证明（SCN.1）
7. 声誉加权路由（NET.4）

**怎么测试**：
- 单元：声誉计算、DP 噪声（验证 ε 预算）、记忆召回准确率
- 集成：agent 完成 3 轮采购协作 → 链上声誉随每轮更新 → 重启 agent → 验证记忆/声誉持久
- 场景测试：采购撮合 e2e（供应商 agent + 采购 agent + ZK 验证）
- 验收：跨会话记忆召回 > 阈值；链上声誉正确累积；采购场景跑通

**交付**：完整 Tier A agent + 采购场景 demo + 声誉系统。

---

### 里程碑 M4：自进化 + 信用 + 进阶（Tier B 完整）

**目标**：agent 从协作历史学习，信用机制可用，多场景覆盖。

**开发内容**：
1. 自扩展：agent 提议/编辑自己的工具（基于 Pi coding-agent 的 read/write/edit + skills.ts）（EVO.1/EVO.2）
2. Credit 机制（REP.3）：声誉换 gas-free 额度，坏账扣声誉
3. TrustFlow 话题加权（REP.2）
4. 沙盒执行（SEC.5，E2B/Docker）
5. 多 relay + 全局状态广播（NET.2/NET.5）——实现"最优解方向引导"
6. 剩余场景（SCN.2 客户调研 / SCN.3 落后地区低成本接入）

**怎么测试**：
- 单元：credit 结算逻辑、坏账触发、TrustFlow 向量加权
- 集成：agent 跑 N 轮协作后，验证其策略/工具有可测量的改进（用固定任务集前后对比，类似 DGM 的 benchmark 验证）
- 验收：自扩展产生可用新工具；credit 借还闭环；落后地区场景在低带宽/低 Gas 下可用

**交付**：Tier B agent + 自进化能力 + 多场景。

---

### 里程碑 M5（Future Work）：Tier C / 协议自进化

- Coordinator 角色 + 委托链管理（LDP 式分层委托）
- 协议参数自进化（高频被接受方案→默认值，链上版本化）—— **协作模式迭代，非制度**
- ZK 证明扩展（SEC.6）
- Darwin Gödel 级自我代码修改

列为论文 §9 Future Work + 路线图。

---

## 五、测试策略总览

| 层次 | 方法 | 工具 |
|------|------|------|
| 单元测试 | 每个工具/钩子独立测；mock LLM | vitest（Pi 用）+ stub model |
| 集成测试 | agent + 本地 relay + 测试网合约 | docker（nostr-rs-relay）+ Sepolia |
| 安全测试 | 注入泄露 prompt → 断言阻断；抓包验证无原始数据出境 | beforeToolCall 断言 + 网络抓包 |
| 场景 e2e | 三场景（推荐/采购/调研）全流程 | 多 agent 实例编排 |
| 协作质量 | ACN-Bench：协作任务完成率 + 接入摩擦 IFI | 自建 benchmark |
| 自进化验证 | 固定任务集前后对比（DGM 式实证）| benchmark + 历史回放 |

**关键测试原则**（呼应 talk-feedback 安全基调）：
- 每个里程碑都有一条**"数据不出本地"断言测试**（抓包/context 审计）
- 每个链上操作都先在**测试网**验证再上主网
- 声誉相关测试必须验证**密码学可验证性**（防来源悖论）

---

## 六、与论文 Paper 3 章节的对应

| 论文章节 | 本方案对应 |
|---------|----------|
| §3 五模块框架 | 第二节 Feature→Pi 映射（M1-M5）|
| §4 Tier A/B/C 评测 | 第四节里程碑（M1-M2=Tier A，M3-M4=Tier B，M5=Tier C）|
| §5 接入摩擦 IFI | 测试策略中的 IFI 度量 |
| §6 MAI 最小接口 | M2 交付的 ASM+身份+relay 最小集 |
| §7 参考实现 & 验证 | M2/M3 的 demo（**ACN-Agent v0.1 = Pi 底座**）|
| §8 隐私与退出 | LAAS 分层 + 安全测试 + relay 无锁定 |
| §9 Future Work | 里程碑 M5 |

---

## 七、待 Jason 决策 / 下一步确认项

1. **MCP 原生支持**：Pi 是否原生支持 MCP client/server 待确认（影响 M4.1 工具接入方式）——需查 pi.dev/docs 或问社区
2. **记忆方案**：自建（Context 序列化基础）vs 集成 Mem0——建议 M1 先自建轻量版，M3 再评估 Mem0
3. **测试 mock**：Pi 是否有 TestModel/FunctionModel 等 LLM mock——若无需自建 stub（不阻塞）
4. **SuperPaymaster 合约接口**：声誉/credit 的合约 ABI 需对齐（你已有 Communify 实现）
5. **里程碑节奏**：是否按 M1→M2→M3→M4 顺序，还是先打通 M2（ASM+relay）做最小 demo 再回填 M1 细节
6. **开源策略**：ACN-Agent 是否在 Pi 之上独立开源（Apache 2.0，符合项目 license 规范）

> 这些确认完，即可进入 M1 实际编码。建议先打通 **M2 的最小 demo（两 agent 跨 relay 完成 ASM 握手）**——这是整个 Paper 3 最有说服力的 "标杆能打" 证据。
