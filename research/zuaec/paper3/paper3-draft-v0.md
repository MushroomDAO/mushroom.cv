# Paper 3 Draft v0

**题目（候选）**：*Standard Agent Design and ACN Integration: A Module Framework, Evaluation Criteria, and Engineering Patterns for Open Collaboration Networks*

**备选题目**：
- *From Agent to Collaborator: Defining Standard Agent Capabilities and Engineering Their Integration into Open Social Agent Networks*
- *ACN-Ready Agents: A Module Specification, Tiered Evaluation Standard, and Low-Friction Integration Framework*

**投稿目标**：arXiv preprint（配合 Paper 1 + Paper 2 作为三篇系列）；可考虑工程类会议（FSE IVR、ICSE NIER、middleware 相关）
**截止**：2026-08-31（与 Paper 1/2 同步提交 arXiv）

---

## 关于是否分拆为两篇

**结论：保持一篇，内部分两个部分（不分拆）**

- 时间约束：2026-08-31 前已有 Paper 1 + Paper 2；四篇不可行
- 逻辑完整性：agent 的设计决策直接决定接入 ACN 的能力——分拆会割裂这个因果链
- 学术分量：一篇工程系统论文（两部分）比两篇短文更有投稿竞争力
- **内部两部分**：Part I（标准 agent 定义）+ Part II（ACN 接入工程）各自有独立贡献，合并后互相强化

---

## 一、研究问题（更新版）

Paper 1 提出 P/SC/N 三支柱框架，Paper 2 定义 ASM 通信协议。两篇论文对接入 ACN 的 agent 能力有隐式假设，但从未定义"一个合格的 agent 应该具备什么"。

**Paper 3 解决两个串联问题**：

> **问题 A（定义）**：一个能够参与 ACN 协作的 agent，在工程上应该具备哪些模块和能力？业界评测标准是什么？
>
> **问题 B（接入）**：具备不同能力层级的 agent，如何以低摩擦、低成本、隐私保护的方式接入 ACN，并从中获得可持续协作价值？

**目标场景**（非学术研究场景，而是真实民生和商业场景）：
- 国际采购与销售（跨境贸易撮合）
- 产品增长与客户调研
- 常规商业活动提效（合同审查、供应商筛选、市场情报）
- 落后地区或资源受限场景的 AI 能力接入（低成本、低门槛）

---

## 二、研究框架：两部分结构

```
Part I: 标准 Agent 设计                Part II: ACN 接入工程
─────────────────────────────         ──────────────────────────────
§2 业界 agent 模块综述               §5 接入摩擦分析框架
§3 标准 agent 五模块框架             §6 最小化接入接口规范（ASM 对接）
§4 分层能力评测标准（Tier A/B/C）    §7 参考实现 & 验证（三个场景）
                                      §8 隐私保护与自由退出设计
```

Part I 的结论（哪个 Tier 的 agent 能接入 ACN）直接驱动 Part II 的设计。

---

## 三、Part I：标准 Agent 设计

### 3.1 Agent 的五个核心模块（综合 Li Fei-Fei 2024 + 业界调研）

**模块定义框架**（整合 Li Fei-Fei 五模块 + 当前工程实践）：

| 模块 | 核心功能 | 业界最佳实践参考 | 我们的扩展 |
|------|---------|--------------|---------|
| **M1：感知与输入**（Perception & Input）| 多模态输入解析；数据获取；环境感知 | Crawl4AI（网页→Markdown）；多模态 LLM | LAAS 本地数据过滤层 |
| **M2：规划与推理**（Planning & Reasoning）| 任务分解；目标追踪；决策 | LangGraph StateGraph；OpenHands CodeAct | 基于 ASM 协议角色约束的计划生成 |
| **M3：记忆**（Memory）| 短期/情节/语义/程序四层记忆 | Mem0；Letta；MemMachine | 本地隐私记忆；可携带声誉记忆（arXiv 2605.11032）|
| **M4：行动与工具**（Action & Tool Use）| 工具调用；代码执行；API 调用；链上交易 | MCP；smolagents CodeAgent；AgentKit | ASM 协议消息发送作为社会行动原语 |
| **M5：社会通信**（Social Communication）⭐ | agent 间协作；角色声明；声誉交换；任务委托 | CrewAI（角色定义）；A2A（任务委托）| **ASM 协议**（角色承载消息 + SC 声誉）|

**M5 是我们的核心创新**：现有框架（CrewAI/A2A/LangGraph）都有 M1-M4，但 **M5（社会通信）** 在开放无许可网络中缺乏标准——这正是 ASM 填补的空白。

### 3.2 跨切面关注（Cross-Cutting Concerns）

除五个功能模块外，一个合格的 ACN-ready agent 还需要：

| 关注点 | 要求 | 实现参考 |
|-------|------|---------|
| **身份与账户**（Identity）| ERC-8004 NFT + 助理型/自主型账户 + 链上注册 | ElizaOS keypair；AgentKit wallet |
| **声誉与信用**（Reputation & Credit）| SBT 声誉载体 + SuperPaymaster credit 机制 | Communify（我们的）；AgentReputation（FSE 2026）|
| **安全与隐私**（Security & Privacy）| 本地推理；DP 噪声；沙盒执行；ZK（可选）| smolagents E2B；Phi-4 mini 本地部署 |
| **自进化**（Self-Evolution）| 从协作历史学习；策略更新 | EvoAgentX；IML 范式（arXiv 2601.11974）|
| **审计与可追溯**（Auditability）| 事件流记录；行动可归因 | OpenHands 事件流；LangGraph 时间旅行 |

### 3.3 分层能力评测标准（Tier A/B/C）

**Tier A（基础接入）**：能参与 ACN 最基本的协作任务

| 能力维度 | Tier A 要求 | 验证方式 |
|---------|-----------|---------|
| M1 感知 | 能处理文本输入；能调用至少一个数据源 | 功能测试 |
| M2 规划 | 能执行线性任务序列（无分支）| 任务完成率 |
| M3 记忆 | 有工作记忆（上下文窗口）；有基础情节记忆（跨会话）| 记忆召回测试 |
| M4 行动 | 能调用 MCP 工具；能生成 ASM 格式消息 | 协议合规测试 |
| M5 社会通信 | 能发送/接收 ASM 消息；有基础声誉分（≥0）| ASM 协议验证 |
| 身份 | 有 ERC-8004 NFT；有 SBT；能签名 | 链上验证 |
| 安全 | 私钥本地存储；基础消息加密（ECDHE）| 安全审计 |

**Tier B（中阶协作）**：能参与复杂、多轮、跨 agent 的协作任务

| 能力维度 | Tier B 要求 |
|---------|-----------|
| M1 感知 | 多模态输入；自适应数据获取（Crawl4AI 级别）|
| M2 规划 | 动态任务分解；处理中途状态变化 |
| M3 记忆 | 四层记忆完整；跨会话语义检索；可携带记忆 |
| M4 行动 | 代码即行动（CodeAct）；链上交易能力 |
| M5 社会通信 | LAAS 特征提取 + DP 保护；声誉阈值 ≥ 基础值；能协商协议 |
| 身份 | credit 机制接入；助理型/自主型账户 |
| 自进化 | 能从协作历史提取经验；有策略更新机制 |

**Tier C（高阶自治）**：能作为编排者/验证者参与高复杂度任务（未来目标）

| 能力维度 | Tier C 要求 |
|---------|-----------|
| M2 规划 | 生成并优化多 agent 工作流（EvoAgentX 级别）|
| M5 社会通信 | 能担任 Coordinator 角色；能管理子 agent 委托链 |
| 自进化 | Darwin Gödel Machine 级别的自我代码修改 |

**Paper 3 聚焦 Tier A 的完整定义 + Tier B 的部分设计**；Tier C 列为 Future Work。

### 3.4 业界评测基准（与 ACN 场景对齐）

| 基准 | 测量内容 | 与 ACN 场景的关联 |
|------|---------|----------------|
| SWE-Bench Verified | 代码任务解决率（OpenHands 72%，Tier C 参考）| 技术 agent 能力基线 |
| AgentBench | 多场景综合任务评测 | 通用 agent 能力 |
| **ACN-Bench（我们提出）** | 在三个验证场景下的协作任务完成率 | **Paper 3 的核心评测**：求职推荐 / 社交匹配 / 外贸采购 |
| 接入摩擦指标（FI）| 从零到首次成功协作的时间 + 成本 | Paper 3 创新指标 |

---

## 四、Part II：ACN 接入工程

### 4.1 接入摩擦分析框架（Integration Friction Index, IFI）

**接入摩擦** = agent 从"独立运行"到"成功参与第一次 ACN 协作任务"的综合成本：

```
IFI = f(时间成本, 经济成本, 隐私暴露面, 锁定风险)
      × Tier修正系数

时间成本T: 从零配置到首次协作完成的小时数
经济成本E: 计算资源 + Gas 费用（美元）
隐私暴露面P: 离开设备的原始数据比例（目标 P=0）
锁定风险L: 退出 ACN 时丢失的不可迁移数据比例（目标 L=0）
```

### 4.2 最小化接入接口规范（Minimal ACN Interface, MAI）

**Tier A agent 接入 ACN 需要实现的最小接口集**：

```
必须实现（MUST）:
  1. ASM 消息生成: 能生成合规的 ASM 消息头（角色声明 + VC_protocol）
  2. 身份验证: ERC-8004 NFT 注册 + 私钥签名能力
  3. relay 连接: 能连接至少一个 Nostr relay（Websocket）
  4. 协议执行: 能执行至少一个 ASM 场景协议（如采购协议 v1）

应该实现（SHOULD）:
  5. SBT 声誉查询: 能查询和展示自身声誉分
  6. ECDHE 加密: 端到端消息加密
  7. 基础记忆: 跨会话的对话历史存储

可选实现（MAY）:
  8. LAAS 集成: 本地特征提取 + DP 保护
  9. Credit 接入: SuperPaymaster credit 机制
  10. ZK 证明: 高价值场景的身份声明
```

### 4.3 快速上手路径（针对不具备 Tier A 能力的普通 agent）

**从零到 Tier A 的工程路径**：

```
Step 1 (≤1小时): 安装 ACN-Agent SDK（我们提供）
Step 2 (≤2小时): 生成 ERC-8004 身份（Quickstart CLI）
Step 3 (≤4小时): 注册一个场景协议（选择：采购/推荐/匹配）
Step 4 (≤1天):  完成首次测试协作任务（在测试网上）
Step 5 (≤1周):  迁移到主网，累积基础声誉（≥3次协作）
```

### 4.4 隐私保护与自由退出设计

**隐私原则**：
- 原始业务数据（聊天记录、合同、联系人）= 永远不离开本地
- 只有 LAAS 提取的特征向量（+DP 噪声）进入网络
- agent 身份（ERC-8004 NFT）= 链上，公开
- 声誉分（SBT）= 链上，公开
- 协作内容（ASM 消息体）= ECDHE 加密，只有对方可解

**自由退出设计**：
- 声誉（SBT）属于 agent 所有，不因退出而消失
- 协议数据（ASM 消息历史）= 本地加密存储，可导出
- relay 无锁定：可随时切换到其他 Nostr relay
- credit 余额：退出前自动结算

### 4.5 参考实现技术栈（ACN-Agent v0.1）

```
基础模型层:     DeepSeek V3.2 (服务端) / Qwen3 30B-A3B (本地隐私)
工具访问层:     MCP 2025-11-25 标准
任务委托层:     A2A v1.0 (跨 agent 任务委托)
社会通信层:     ASM 协议（Paper 2，角色承载消息 + SC 声誉）⭐ 我们的核心
记忆系统:       Mem0（情节+语义）+ 本地加密存储（程序记忆）
身份层:         ERC-8004 NFT + SBT（Communify）+ Nostr keypair
数据获取:       Crawl4AI（网页数据摄取）
安全沙盒:       smolagents E2B / Docker 隔离执行
自进化:         IML 范式（arXiv 2601.11974）+ EvoAgentX 优化循环
链上交互:       AgentKit action provider 模式
```

---

## 五、核心创新点（更新版）

| 创新点 | 描述 | 差异化依据 |
|--------|------|---------|
| **C1：五模块 + 跨切面标准**| 首次将 M5 社会通信定义为 agent 第五个核心模块；将身份/声誉/隐私/自进化定为跨切面关注点 | 现有框架（CrewAI/LangGraph 等）无 M5 定义 |
| **C2：Tier A/B/C 分层评测标准**| 按能力层级定义可操作的评测检查清单，而非单一 benchmark 分数 | 现有评测（SWE-Bench 等）只测能力，不测协作合规 |
| **C3：IFI 接入摩擦指标**| 首次量化"从独立 agent 到 ACN 协作者"的工程成本 | 无现有研究量化 agent 网络接入摩擦 |
| **C4：MAI 最小接入接口规范**| 定义 Tier A agent 接入 ACN 的最小实现清单（MUST/SHOULD/MAY）| ASM 协议（Paper 2）的工程落地规范 |
| **C5：参考实现 ACN-Agent v0.1**| 开源参考实现（DeepSeek + ASM + Mem0 + ERC-8004）覆盖三个验证场景 | 论文 + 可运行代码双重贡献 |

---

## 六、章节结构（更新版）

| 章节 | 内容 | 部分 |
|------|------|------|
| §1 Introduction | 问题动机；Paper 3 与 Paper 1/2 的关系；贡献列表 | — |
| §2 Background & Related Work | 业界 agent 框架综述（CrewAI/OpenHands/Agno/ElizaOS 等）；记忆系统；自进化机制 | — |
| §3 Five-Module Standard Agent Framework | M1-M5 + 跨切面关注点 定义 | **Part I** |
| §4 Tiered Capability Evaluation Standard | Tier A/B/C 检查清单；ACN-Bench 评测方法 | **Part I** |
| §5 Integration Friction Analysis | IFI 指标定义；现有框架接入 ACN 的摩擦评估 | **Part II** |
| §6 Minimal ACN Interface Specification | MAI（MUST/SHOULD/MAY）；快速上手路径 | **Part II** |
| §7 Reference Implementation & Validation | ACN-Agent v0.1 架构；三场景实验（采购/推荐/匹配）| **Part II** |
| §8 Privacy & Exit Design | 数据本地化；退出机制；锁定风险评估 | **Part II** |
| §9 Discussion | 局限性；Tier C 路线图；自进化路线图；生态扩展 | — |
| §10 Conclusion | 贡献总结 | — |

---

## 七、与业界框架的借鉴与超越

| 框架 | 借鉴什么 | 超越什么 |
|------|---------|---------|
| **CrewAI** | role + goal + backstory 角色定义原语（最接近社会角色代理）| 跨组织开放无许可网络；ASM 标准协议替代临时角色定义 |
| **OpenHands** | CodeAct 范式；事件流审计架构（可追溯性）| 社会协作层；M5 社会通信模块 |
| **Agno** | 无状态 agent + runtime 拥有持久状态 | LAAS 隐私层；ASM 协议集成 |
| **ElizaOS** | character file 持久身份；Nostr keypair；插件注册 | ASM 角色协议 + SC 声誉体系 |
| **LangGraph** | 时间旅行调试；有状态任务图；Human-in-the-Loop | ASM 消息协议 |
| **AgentKit** | action provider 抽象；经济代理接入 | ERC-8004 + SBT + credit 声誉体系 |
| **smolagents** | ~1000 LoC 可审计核心；代码即行动；沙盒安全 | 开放网络协作协议层 |
| **EvoAgentX** | TextGrad/AFlow 优化循环 | 与 ASM 协作历史结合的社会驱动自进化 |
| **Crawl4AI** | MCP server 模式；自适应停止 | LAAS 本地过滤（数据不出境）|
| **Hermes 4.3** | 开源工具调用；ChatML 格式；公开训练数据方法论 | 基于 ACN 场景的特定微调 |

---

## 八、关键学术引用

| 论文/来源 | arXiv / URL | 引用点 |
|---------|------------|--------|
| CodeAct (NeurIPS 2024) | — | 代码即行动范式 |
| Survey of Self-Evolving Agents | 2507.21046 | 自进化机制综述 |
| Multi-Layered Memory Survey | 2603.29194 | 四层记忆架构 |
| Rethinking Memory Mechanisms | 2602.06052 | 记忆机制反思 |
| MemMachine | 2604.04853 | 保真记忆防污染 |
| Portable Agent Memory | 2605.11032 | 跨 agent 记忆迁移 |
| ElizaOS | 2501.06781 | Web3 agent 身份 |
| The Trust Fabric | 2507.07901 | 去中心化可信声明 |
| AgentFlux | 2510.00229 | 云训练/本地推理解耦 |
| Gödel Agent | 2410.04444 | 自参考自改进 |
| Intrinsic Meta-Learning | 2601.11974 | IML 自进化范式 |
| A2A Protocol v1.0 | a2a-protocol.org | 任务委托层标准 |
| MCP 2025-11-25 | modelcontextprotocol.io | 工具访问层标准 |
| Li Fei-Fei et al. 2024 | 2401.03568 | 五模块框架（M1-M4 基础）|
| AgentReputation (FSE 2026) | 2605.00073 | 声誉系统竞争工作 |

---

## 九、开放问题

- [ ] M5 社会通信模块是否需要一个独立的"社会通信能力"benchmark（ACN-Bench 设计）
- [ ] IFI 的具体计算公式（时间/成本/隐私/锁定四维度的权重如何设定）
- [ ] Tier A/B/C 判定工具（自动化检查 vs 人工审核）
- [ ] 参考实现 ACN-Agent v0.1 的开发优先级（Tier A 完整 > Tier B 部分）
- [ ] 自进化路径：IML 范式在 ACN 协作历史上的具体实现方案
- [ ] 落后地区/资源受限场景的专项设计（低功耗设备、低带宽、低 Gas 场景）
