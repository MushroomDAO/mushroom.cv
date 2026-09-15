# [Chen et al. 2024] Internet of Agents: Weaving a Web of Heterogeneous Agents for Collaborative Intelligence

**Citation**: Chen, W., You, Z., Li, R., Guan, Y., Qian, C., Zhao, C., Yang, C., Xie, R., Liu, Z., & Sun, M. (2024). *Internet of Agents: Weaving a Web of Heterogeneous Agents for Collaborative Intelligence.* arXiv:2407.07061v2 [cs.CL], 10 Jul 2024. (Work in progress / preprint). Code: https://github.com/OpenBMB/IoA
**机构**: Tsinghua University (1); Peking University (2); Beijing University of Posts and Telecommunications (3); Tencent (4). 通讯作者 Zhiyuan Liu (THU)。
**arXiv**: https://arxiv.org/abs/2407.07061
**PDF**: papers/chen2024-internet-of-agents.pdf
**Cluster**: Pillar N（网络拓扑 / 异构 agent 集成）— Paper 1 §5（框架对照）+ Paper 2（协议对话对象，ASM 的最直接 baseline）
**Status**: ✅ 全文已分析（2026-05-22）

## Core claim (一句话)
受互联网启发，IoA 提出一个"即时通讯式"的中心化 server-client 平台，通过 agent 注册/发现协议 + 自治嵌套组队 + 有限状态机会话流控制，让分属不同生态、运行在不同设备上的异构第三方 agent 能动态组队协作，在 GAIA、开放指令、具身、RAG 四类任务上超越 SoTA baseline。

## 研究问题
现有 multi-agent 框架的三个根本局限：(1) **生态隔离**（只能用框架自定义的 agent，无法接入第三方）；(2) **单机模拟**（几乎都在单设备上仿真，脱离真实分布式场景）；(3) **僵化的通信与协调**（通信管道、组队、状态转移基本是 hard-code 的）。能否像互联网促进人类协作一样，建一个促进自治 agent 协作的通用平台？

## 方法与主要内容
- **架构**：server（中心枢纽）+ client（每个 agent 的 wrapper），各分三层（Interaction / Data / Foundation）。Server 管 agent 注册、发现、消息路由；用 Milvus 向量库做能力相似度检索；WebSocket 持久连接；SQLite 本地存储。
- **关键机制**：
  1. **Agent 注册与发现**：agent 注册时提交能力描述 d_i 存入 Agent Registry；`search_client` 基于语义匹配（BM25/dense retrieval）返回候选子集。
  2. **自治嵌套组队**：client 用 `search_client` + `launch_group_chat` 动态成团；子任务可递归生成 sub-group chat，形成树状结构，降低通信复杂度（c_nested ≤ c_full）。
  3. **自治会话流控制**：把 group chat 形式化为有限状态机 M=(S,Σ,δ,s₀,F)，5 状态（discussion / sync task / async task / pause&trigger / conclusion），对齐 Searle 言语行为理论（assertives/directives/commissives/declarations）。由 client 内 LLM 决定状态转移与 next speaker。
  4. **消息协议**：header（sender, state, comm_id）+ payload（goal, team_members, content, type, next_speaker, task_id/desc/conclusion, triggers 等）。
- **实验**：GAIA（4 个 ReAct agent，overall 40.0 超过 AutoGen 39.39）；153 条开放指令（对 AutoGPT 胜率 76.5%、对 Open Interpreter 63.4%）；RoCoBench 具身（5 任务中 4 项胜过专用的 Roco Dialog）；RAG（GPT-3.5 底座，异构知识池下逼近/超过 GPT-4）。
- **诚实披露的局限**：通信成本高（$0.99/task），LLM 常重复/复述消息（去重后省近 50%）；指出"现代 LLM 被对齐成好聊天助手，但未必被对齐成高效的通信 agent"。Security Block 当前几乎未实现（仅承认其在真实部署中防恶意 agent 的重要性）。

## 论文未覆盖的范围（我们的差异化基础）

| 维度 | IoA (This paper) | 我们的框架 (P/SC/N) |
|------|------------------|---------------------|
| 网络结构 | **中心化 server** 作为唯一枢纽（注册、发现、路由全经 server） | **N — Permissionless 去中心化网络**：无单一信任枢纽，任何 agent 可无许可加入/退出 |
| 准入 | server 端 Agent Register Rules + 未实现的 Security Block 控制接入 | **N — 无许可准入**：以加密身份 + 链上凭证替代中心化注册审批 |
| Agent 定位 | **能力容器**：agent = 一段能力描述 d_i + `run(task)->str` 接口；按工具/技能被检索调用 | **社会角色 agent**：agent 是持有角色、历史与责任的社会行动者，而非可替换的能力插件 |
| 协作选择依据 | 语义相似度匹配能力描述（Agent Contact 仅本地存"合作过谁"，无量化信任） | **SC — 量化社会资本**（Bourdieu/Putnam/Ostrom）：以可验证、可累积、可携带的信任/声誉资本作为组队与任务分配依据 |
| 信任与问责 | 无信任度量；恶意 agent 防护停留在"未来工作" | **SC + N**：声誉作为内生治理机制，跨任务可携带，承担越界惩罚 |
| 协议层级 | 应用层消息协议（IM 式 group chat 语义） | **P — 协作协议**：定义角色协商、社会资本结算与网络级治理的协议栈，非仅消息路由 |
| 持久性 | 协作以 group chat / task 为单位，结束即止；agent 间关系不沉淀为社会结构 | 关系沉淀为**持久社会网络结构**（社会资本随交互累积） |

## Paper 1 区分段落（~200词，英文）
Chen et al.'s Internet of Agents (IoA) is the strongest engineering instantiation of the "weave a web of agents" vision, and our framework should be read as a direct response to it. IoA solves *capability orchestration*: a centralized server registers heterogeneous third-party agents by capability description, retrieves them by semantic similarity, and routes their messages through an IM-like finite-state group chat. Crucially, in IoA an agent *is* its capability container — a description plus a `run(task)->str` hook — discovered and discarded per task, with no persistent social standing. Three structural choices mark the boundary our work crosses. First, IoA is architecturally centralized (a single server is the registry, matchmaker, and router), whereas our **Permissionless Network (N)** removes the trusted hub and lets agents join without gatekeeper approval. Second, IoA selects collaborators by semantic capability match and explicitly defers trust/security to "future work"; our **Quantified Social Capital (SC)** makes verifiable, accumulable, portable reputation the substrate for teaming and accountability. Third, IoA's protocol is a message-routing layer, while our **Collaboration Protocols (P)** govern role negotiation and social-capital settlement. IoA's own finding — that LLMs are aligned to be chatbots, not efficient *communicating* agents — is precisely the gap a role-bearing, SC-bearing protocol is meant to close. IoA is thus a supporting baseline, not a competitor.

## Action items
- [ ] Paper 2 §Related Work / Baseline：将 IoA 列为 ASM 协议最直接的对照框架，明确"中心化能力编排 vs 去中心化角色承载协议"的三点结构差异（centralization / capability-container / message-only protocol）。
- [ ] Paper 1 §5：用 IoA 作为"capability invocation 范式"的代表案例，对照三要素框架表格。
- [ ] 引用 IoA 自承的局限（通信成本、LLM 未被对齐为高效通信 agent、Security Block 未实现）作为"为何需要 P+SC+N"的外部佐证。
- [ ] 借用其通信复杂度公式 c_nested ≤ c_full（嵌套组队降边数）作为网络层可扩展性论证的参照。

## Jason's feedback
> （请在此处写入你的feedback）
