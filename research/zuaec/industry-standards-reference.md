# 业界标准与权威来源参考文档

> **用途**：Paper 1 + Paper 2 的业界引用来源；确保 ASM 设计与业界标准兼容并有创新
> **最后更新**：2026-05-25

---

## 1. Google A2A（Agent-to-Agent Protocol）

### 官方来源
| 资源 | URL |
|------|-----|
| 官方规范站点 | https://a2a-protocol.org/latest/specification/ |
| GitHub 组织 | https://github.com/a2aproject |
| 主仓库 | https://github.com/a2aproject/A2A |
| 规范文档 | https://github.com/a2aproject/A2A/blob/main/docs/specification.md |
| 示例仓库 | https://github.com/a2aproject/a2a-samples |

### 版本与治理
- **当前版本**：v1.0.0（2025年发布）；历史版本：0.3.0、0.2.6、0.1.0
- **发布时间**：2025年4月（Google发起），2025年6月捐献给 **Linux Foundation** 中立治理
- **许可证**：Apache 2.0
- **规模**：22,000+ GitHub Stars，50+ 合作伙伴，SDK 覆盖 Python / JavaScript / Java / Go / .NET

### 核心定义
A2A 解决"agent 如何委托任务给另一个 agent"的问题——跨供应商、跨框架、不暴露内部记忆/工具/逻辑。**与 MCP 互补**：MCP 连接 agent 与工具/资源；A2A 连接 agent 与 agent。

### 关键技术规范

| 特性 | 细节 |
|------|------|
| **传输协议** | HTTP + Server-Sent Events (SSE) + JSON-RPC 2.0；也支持 gRPC |
| **Agent Cards** | 每个 agent 发布的元数据文档：身份、能力/技能、端点、认证要求——支持动态发现 |
| **Tasks** | 有状态工作单元，完整生命周期：SUBMITTED → WORKING → COMPLETED / FAILED / CANCELED 等 |
| **Messages & Parts** | 消息含 Parts，支持：文本、文件、结构化数据、原始字节 |
| **Artifacts** | Task 产生的输出物 |
| **异步更新** | 三种模式：轮询（Get Task）/ 实时流（SSE）/ 推送（Webhook）|
| **认证** | API Key、HTTP Auth、OAuth 2.0、OpenID Connect、mutual TLS |
| **Wire 格式** | Protocol Buffers（规范性定义在 `spec/a2a.proto`）|
| **引用标准** | RFC 2119、HTTP、JSON-RPC 2.0、gRPC |

### 设计核心原则
- **互操作性**：LangGraph、CrewAI、Semantic Kernel 等均可对话
- **不透明性保护**：agent 协作不暴露内部实现
- **企业级**：安全、监控、审计内置
- **异步优先**：长任务是一等公民

### ASM 与 A2A 的关系（论文定位）
A2A 解决"谁给谁委托任务"；ASM 解决"谁扮演什么角色、凭什么信任"。
- A2A = 任务委托协议（Task Delegation）
- ASM = 角色身份 + 声誉信任 + 协作规范（Role Identity + Social Trust + Collaboration Norms）

**Paper 2 §2 建议引用语**：
> "A2A [Linux Foundation 2025] defines task delegation between opaque agents via Agent Cards and stateful Task objects — an essential capability layer. ASM complements A2A by providing what it explicitly omits: semantic role identity (role-bearing message headers), social trust accumulation (SC pillar reputation), and norm-governed participation (P pillar protocol constraints). A2A and ASM are designed to operate at different layers and are mutually compatible."

---

## 2. Anthropic MCP（Model Context Protocol）

### 官方来源
| 资源 | URL |
|------|-----|
| 官方公告 | https://www.anthropic.com/news/model-context-protocol |
| 规范站点 | https://modelcontextprotocol.io/specification/2025-11-25 |
| GitHub 组织 | https://github.com/modelcontextprotocol |
| 规范仓库 | https://github.com/modelcontextprotocol/modelcontextprotocol |
| Server 仓库 | https://github.com/modelcontextprotocol/servers |
| 权威 Schema | https://github.com/modelcontextprotocol/specification/blob/main/schema/2025-11-25/schema.ts |

### 版本与治理
- **当前版本**：2025-11-25（使用 ISO 日期字符串作为版本号）
- **初始发布**：2024年11月25日（Anthropic 发布）
- **治理移交**：2025年12月捐献给 Linux Foundation 旗下 **Agentic AI Foundation (AAIF)**，由 Anthropic、Block、OpenAI 联合创立
- **创作者**：David Soria Parra 和 Justin Spahr-Summers

### 核心定义
MCP 解决"LLM 如何连接外部工具和数据资源"的问题——类比 **LSP（Language Server Protocol）**：LSP 统一了 IDE 的语言支持，MCP 统一了 AI 应用的工具接入。

### 关键技术规范

| 特性 | 细节 |
|------|------|
| **传输** | JSON-RPC 2.0 消息；有状态连接 |
| **架构** | 三方：**Hosts**（LLM 应用）↔ **Clients**（连接器）↔ **Servers**（上下文/能力提供者）|
| **Server 原语** | **Resources**（数据/上下文）/ **Prompts**（模板工作流）/ **Tools**（可执行函数）|
| **Client 原语** | **Sampling**（服务器发起 LLM 调用）/ **Roots**（URI/文件系统边界查询）/ **Elicitation**（请求用户输入）|
| **Tasks**（2025-11-25新增）| 追踪长时任务的新抽象；客户端可查询状态 |
| **安全** | 显式用户同意模型；工具调用必须用户审批 |
| **引用标准** | BCP 14 / RFC 2119 / RFC 8174、JSON-RPC 2.0、LSP（设计灵感）|

### ASM 与 MCP 的关系（论文定位）
MCP = agent 与工具/资源的垂直连接（纵向）；ASM = agent 与 agent 的水平协作（横向）。
两者不竞争，互补。

**Paper 2 §2 建议引用语**：
> "MCP [Anthropic 2024, v2025-11-25] standardises how agents access tools and resources — the vertical integration layer. ASM addresses the orthogonal horizontal layer: how agents collaborate with each other, negotiate roles, accumulate social trust, and govern participation in open networks. An agent participating in ASM-governed collaboration may simultaneously use MCP to access its own tools."

---

## 3. OpenAI 治理实践

### 官方来源
| 资源 | URL |
|------|-----|
| OpenAI 页面 | https://openai.com/index/practices-for-governing-agentic-ai-systems/ |
| PDF 直链 | https://cdn.openai.com/papers/practices-for-governing-agentic-ai-systems.pdf |
| Semantic Scholar | https://www.semanticscholar.org/paper/Practices-for-Governing-Agentic-AI-Systems-Shavit-Agarwal/0002c42e8d7bfeafc431c4ed9f6318f223bbf58b |

### 引用格式
> Shavit, Y., Agarwal, S., Brundage, M., et al. (2023). *Practices for Governing Agentic AI Systems.* OpenAI, December 2023.

### 核心定义
Agentic AI = 能够"在有限直接监督下追求复杂目标"的系统。四个核心特征：目标复杂性、环境复杂性、适应性、独立执行。

### 七大治理实践

| # | 实践 | 核心思想 |
|---|------|---------|
| 1 | **适用性评估** | 部署前评估系统是否适合特定使用场景 |
| 2 | **约束行动空间** | 在定义的能力边界内运行；不可逆行动需特殊控制 |
| 3 | **设定默认行为** | 未被直接指令时的明确默认行为；优先可逆操作；最小足迹原则 |
| 4 | **确保可解释性** | 向用户提供行动台账；不阻断操作的可解释性 |
| 5 | **自动监控** | 渐进式部署 + 每阶段异常检测；跨 agent 网络的越界行为检测 |
| 6 | **可归因性** | 至少一个人类对每个未补偿的伤害负责；唯一标识符 + 审计日志 |
| 7 | **可中断性** | 随时可靠关闭机制；状态快照支持回滚 |

### 三方信任模型
**开发者**（设置限制）→ **运营者**（在限制内部署）→ **用户**（在运营者边界内行动）
- 多 agent 链：子 agent 必须认证编排者指令，抵抗 prompt 注入
- 动态权限委托链，层级授权

### 关键空白（直接支持我们的研究）
论文明确指出**互操作性标准尚缺**，是未来需求——直接为 ASM 提供动机引用。

**Paper 1 §1 / Paper 2 §1 建议引用语**：
> "Shavit et al. (2023) identify seven governance practices for agentic systems, including attributability (every agent action traceable to a responsible human) and interruptibility. Crucially, the paper explicitly notes the absence of interoperability standards as a gap requiring future work. ASM directly addresses this gap: role-bearing message headers provide attributability at the protocol level; the SC pillar's verifiable reputation implements accountability across agent boundaries."

---

## 4. Anthropic 多 agent 系统工程实践

### 官方来源
- **Anthropic Engineering Blog**: https://www.anthropic.com/engineering/built-multi-agent-research-system

### 关键数据
- **性能提升**：比单体 agent 提升 **90.2%**
- **Token 消耗**解释了 80% 的性能方差（瓶颈在 context 利用）
- **架构**：LeadResearcher（编排者）+ 专业化子 agent（CitationAgent 等）

### 可借鉴的工程创新（Jason 注：这是 agent 内部创新，我们做的是 agent 间协作）

| 工程创新 | 含义 | 对我们的借鉴 |
|---------|------|------------|
| **认知专业化**（非纯功能模块化）| 角色定义基于认知特征，不只是任务分工 | Paper 1 "社会角色代理"的概念基础 |
| **同步协调**（简单胜于异步）| 同步调度在工程上更简单可靠 | ASM 消息确认机制设计参考 |
| **Rainbow Deployment** | 长任务的有状态部署策略 | relay 节点的状态持久化设计参考 |
| **CitationAgent 专门角色** | 验证类 agent 独立存在 | ASM 中 Verifier 角色类型的设计依据 |
| **Token 是性能瓶颈** | 90.2% 提升中 token 消耗是主因 | ASM 消息压缩/精简设计的工程动机 |

---

## 5. Agentic Design Patterns（21 核心模式）

### 来源
- 项目：《Agentic Design Patterns》中文翻译项目（系统梳理 AI Agent 系统设计的 21 个核心模式）

### 21 个核心模式

| # | 模式 | 与我们的关联 |
|---|------|------------|
| 1 | 提示链（Prompt Chaining）| ASM 消息序列设计 |
| 2 | 路由（Routing）| SC 声誉加权路由核心 |
| 3 | 并行化（Parallelization）| N 支柱多 relay 并发 |
| 4 | 反思（Reflection）| agent 自评估机制 |
| 5 | 工具使用（Tool Use）| MCP 层 |
| 6 | 规划（Planning）| Coordinator 角色设计 |
| 7 | **多智能体协作（Multi-Agent Collaboration）** | Paper 1 + Paper 2 核心 ← |
| 8 | 记忆管理（Memory Management）| LAAS 本地记忆层 |
| 9 | 学习与适应（Learning and Adaptation）| SC 声誉动态更新 |
| 10 | **模型上下文协议（MCP）** | 工具层标准 ← |
| 11 | 目标设定与监控（Goal Setting and Monitoring）| 协议入口的双重数据结构 |
| 12 | 异常处理与恢复（Exception Handling）| relay 故障恢复机制 |
| 13 | **人机协同（Human-in-the-Loop）** | 助理型账户的人类监督 ← |
| 14 | 知识检索（RAG）| LAAS 本地知识库 |
| 15 | **智能体间通信（Inter-Agent Communication / A2A）** | Paper 2 ASM 协议核心 ← |
| 16 | 资源感知优化（Resource Aware Optimization）| relay 负载均衡 |
| 17 | 推理技术（Reasoning Techniques）| agent 决策能力（假设 OK）|
| 18 | **安全防护模式（Guardrails / Safety Patterns）** | Paper 2 §6 安全分析 ← |
| 19 | **评估与监控（Evaluation and Monitoring）** | ACN 评估框架 ← |
| 20 | 优先级排序（Prioritization）| relay 路由权重计算 |
| 21 | （其他模式）| — |

**标注 ← 的是与我们论文直接相关的核心模式**

---

## 6. 业界来源在论文中的位置汇总

| 来源 | Paper 1 位置 | Paper 2 位置 |
|------|------------|------------|
| A2A v1.0.0 | §4 N 支柱相关工作 | §2 协议对比表（主要对比对象之一）|
| MCP 2025-11-25 | §4 P 支柱工具层 | §2 协议对比表（工具层，与 ASM 互补）|
| OpenAI Shavit et al. 2023 | §1 动机（互操作性空白）+ §5 治理 | §1 问题定义 |
| Anthropic Multi-Agent Blog | §3 能力进化证据 | §1 工程动机（90.2% 提升）|
| Agentic Design Patterns | §2 相关工作（设计模式层）| §3/§4 ASM 设计参考 |

---

## 7. Jason 的 ASM 兼容性设计原则

基于以上调研，ASM 的设计必须：

1. **与 A2A 互补不竞争**：A2A 做任务委托，ASM 做角色信任；两者可在同一系统中共存
2. **与 MCP 共存**：agent 可同时使用 MCP（访问工具）和 ASM（与其他 agent 协作）
3. **满足 OpenAI 七大治理实践**：特别是可归因性（链上 SBT）和可中断性（relay 断路机制）
4. **超越 A2A 的创新点**：
   - Agent Cards（A2A）→ ASM 增加**角色类型**和**声誉阈值要求**
   - Task 生命周期（A2A）→ ASM 增加**双向确认机制**和**声誉更新触发**
   - 无信任机制（A2A）→ ASM 的 **SC 支柱**（量化社会资本）
   - 无开放网络（A2A 假设已知 agent）→ ASM 的 **N 支柱**（无许可准入）
