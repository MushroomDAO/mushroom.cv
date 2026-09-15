# Paper 1 文献筛选 — Batch Group D（Agent Foundations + 自我演化 + 旧范式对照）

> **创建日期**：2026-05-22
> **检索者**：research-librarian agent
> **对应执行计划**：Phase 1 / Group D（`paper1-literature-screen.md` §三 标注的 P1 待办）
> **范围**：自我演化/自我改进 LLM agents、基础 agent 框架（ReAct/AutoGen/MetaGPT/CAMEL/Voyager/AgentBench/Generative Agents 谱系）、LLM agent 综述（含 agent society/社会维度）、agent memory、role/persona 分配、多智能体编排框架、tool-use/能力调用框架（"旧范式"对照）。
> **核实方式**：每个 arXiv ID 均通过 WebSearch 命中其 abstract 页 / arXiv listing 确认标题一致。下表标 ✅verified = ID 已核实指向该标题；⚠️unverified = 未能逐一核实（本批无此类）。
> **去重**：已对照 `paper1-literature-screen.md` 中已收录的全部 ID，本表均为 NEW（不重复）。

---

## 一、候选库（28 篇 NEW）

| ID | Title | Authors | Year | arXiv ID | ⭐ | 相关性（pillar / 旧范式对照 / Paper§） |
|----|-------|---------|------|----------|----|---------------------------------------|
| D01 | A Survey of Self-Evolving Agents: What, When, How, and Where to Evolve on the Path to Artificial Super Intelligence | Gao, Geng, Hua, Hu et al. (27 authors) | 2025 | 2507.21046 ✅ | ⭐⭐⭐⭐⭐ | §2 背景综述：自我演化是 capability 进化主线；与"社会角色演化"对照，定位旧范式上限 |
| D02 | A Comprehensive Survey of Self-Evolving AI Agents: A New Paradigm Bridging Foundation Models and Lifelong Agentic Systems | Fang, Peng et al. (15 authors) | 2025 | 2508.07407 ✅ | ⭐⭐⭐⭐⭐ | §2 背景综述：另一权威自演化综述；其"统一反馈回路框架"可对照我们三支柱框架的差异 |
| D03 | EvolveR: Self-Evolving LLM Agents through an Experience-Driven Lifecycle | Wu, Rong et al. (11 authors) | 2025 | 2510.16079 ✅ | ⭐⭐⭐⭐ | 旧范式对照：自我改进=能力闭环（self-distillation），无社会角色/principal 身份维度 |
| D04 | Darwin Gödel Machine: Open-Ended Evolution of Self-Improving Agents | Zhang, Lu, Clune et al. | 2025 | 2505.22954 ✅ | ⭐⭐⭐⭐ | 旧范式对照：agent 自我重写代码=极致 capability 进化；缺社会嵌入，强化我们论点 |
| D05 | Gödel Agent: A Self-Referential Framework for Recursive Self-Improvement | Yin et al. | 2024 | 2410.04444 ✅ | ⭐⭐⭐ | 旧范式对照：递归自我改进；capability-centric |
| D06 | ReAct: Synergizing Reasoning and Acting in Language Models | Yao, Zhao, Yu, Du, Shafran, Narasimhan, Cao | 2022 | 2210.03629 ✅ | ⭐⭐⭐⭐ | 旧范式奠基：reasoning+acting 单 agent 范式；"capability invocation" 的源头之一 |
| D07 | Toolformer: Language Models Can Teach Themselves to Use Tools | Schick et al. | 2023 | 2302.04761 ✅ | ⭐⭐⭐⭐ | 旧范式对照：tool-use 奠基；agent=可调用能力容器的典型 |
| D08 | Tool Learning with Large Language Models: A Survey | Qu, Dai et al. | 2024 | 2405.17935 ✅ | ⭐⭐⭐⭐ | 旧范式对照综述：系统化"能力调用"研究全景；§2 用于刻画我们要超越的范式 |
| D09 | AutoGen: Enabling Next-Gen LLM Applications via Multi-Agent Conversation Framework | Wu, Bansal et al. (Microsoft/UW) | 2023 | 2308.08155 ✅ | ⭐⭐⭐⭐ | 旧范式编排框架：multi-agent conversation；P 协作协议背景，对照"无 principal 身份" |
| D10 | MetaGPT: Meta Programming for a Multi-Agent Collaborative Framework | Hong, Zhuge et al. | 2023 | 2308.00352 ✅ | ⭐⭐⭐⭐ | 旧范式编排框架：SOP 预设角色（≠可证身份的社会角色）；P 背景 + role 对照 |
| D11 | CAMEL: Communicative Agents for "Mind" Exploration of Large Language Model Society | Li, Hammoud, Itani, Khizbullin, Ghanem (KAUST) | 2023 | 2303.17760 ✅ | ⭐⭐⭐⭐⭐ | 关键对照：role-playing + inception prompting，"角色"是 prompt 假扮而非可证社会角色——直接反衬我们的 social role agency |
| D12 | Voyager: An Open-Ended Embodied Agent with Large Language Models | Wang, Xie et al. (MineDojo) | 2023 | 2305.16291 ✅ | ⭐⭐⭐ | 旧范式对照：lifelong skill 习得=能力积累；单 agent，无社会维度 |
| D13 | AgentBench: Evaluating LLMs as Agents | Liu, Yu et al. (THUDM) | 2023 | 2308.03688 ✅ | ⭐⭐⭐ | 旧范式评测：以"任务完成能力"度量 agent；对照我们主张的社会角色度量缺口 |
| D14 | A Survey on Large Language Model based Autonomous Agents | Wang, Ma, Feng, Zhang et al. | 2023 | 2308.11432 ✅ | ⭐⭐⭐⭐⭐ | §2 基础综述（profile/memory/planning/action 四件套）；刻画 capability 范式的标准画像 |
| D15 | Large Language Model based Multi-Agents: A Survey of Progress and Challenges | Guo, Chen, Wang et al. (IJCAI 2024) | 2024 | 2402.01680 ✅ | ⭐⭐⭐⭐ | §2 多智能体综述：profiling/communication/capacity；P 协作协议背景 |
| D16 | A Survey on LLM-based Multi-Agent System: Recent Advances and New Frontiers in Application | Chen, Liu, Han, Zhang, Liu | 2024 | 2412.17481 ✅ | ⭐⭐⭐ | §2 MAS 应用综述（含 simulate scenarios / generative agents 评估）|
| D17 | Multi-Agent Collaboration Mechanisms: A Survey of LLMs | Tran, Dao, Nguyen, Pham, O'Sullivan, Nguyen | 2025 | 2501.06322 ✅ | ⭐⭐⭐⭐ | P 协作协议：协作机制分类法；与 ASM 协作层对话 |
| D18 | Why Do Multi-Agent LLM Systems Fail? (MAST taxonomy) | Cemri, Pan, Yang et al. | 2025 | 2503.13657 ✅ | ⭐⭐⭐⭐ | §5 结构缺口：14 种失败模式（specification/inter-agent misalignment/verification）→ 论证需要角色与身份约束 |
| D19 | Agentic Large Language Models, a survey | Plaat, van Duijn, van Stein, Preuss, van der Putten, Batenburg | 2025 | 2503.23037 ✅ | ⭐⭐⭐⭐ | §2 综述：reason/act/interact 三分；第三类"interact→emergent social behavior"直接对接我们社会维度论点 |
| D20 | From Individual to Society: A Survey on Social Simulation Driven by LLM-based Agents | Mou, Ding et al. | 2024 | 2412.03563 ✅ | ⭐⭐⭐⭐⭐ | SC/N + §2：individual→scenario→society 三层；最贴近"agent society/社会维度"的综述 |
| D21 | AgentSociety: Large-Scale Simulation of LLM-Driven Generative Agents | (Tsinghua FIB Lab) | 2025 | 2502.08691 ✅ | ⭐⭐⭐⭐ | SC/N：1万+ agents、500万次交互；社会涌现（极化/UBI/外部冲击）实证基底 |
| D22 | A Survey on the Memory Mechanism of LLM-based Agents | Zhang, Bo, Ma, Li, Chen et al. | 2024 | 2404.13501 ✅ | ⭐⭐⭐ | 旧范式对照：memory 作为 agent 内部能力组件；对照"社会资本=外部关系记忆" |
| D23 | Memory for Autonomous LLM Agents: Mechanisms, Evaluation, and Emerging Frontiers | (multi-author) | 2026 | 2603.07670 ✅ | ⭐⭐⭐ | 同上，更新版 memory 综述；§2 capability 组件背景 |
| D24 | From Persona to Personalization: A Survey on Role-Playing Language Agents | Chen, Jiangjie et al. (18 authors) | 2024 | 2404.18231 ✅ | ⭐⭐⭐⭐⭐ | 关键对照：persona/role-playing 综述——"角色"=个性扮演（persona），系统性反衬我们"可证 principal 身份的社会角色"区别 |
| D25 | Agent Exchange: Shaping the Future of AI Agent Economics | (multi-author) | 2025 | 2507.03904 ✅ | ⭐⭐⭐⭐ | 旧范式对照 + N：把 agent 当作经济服务单元（拍卖/USP/ASP），即"capability-as-a-service" |
| D26 | When Agent Markets Arrive | (multi-author) | 2026 | 2604.06688 ✅ | ⭐⭐⭐ | N + 旧范式对照：agent-only 市场 + escrow/reputation/skill marketplace 雏形 |
| D27 | Magentic Marketplace: An Open-Source Environment for Studying Agentic Markets | (Microsoft Research) | 2025 | 2510.25779 ✅ | ⭐⭐⭐ | N：委托经济活动给 AI proxy 的多智能体市场环境；可对照我们 permissionless network |
| D28 | LLM-Powered AI Agent Systems and Their Applications in Industry | (multi-author) | 2025 | 2505.16120 ✅ | ⭐⭐ | §2 应用背景：software/physical/hybrid agent 系统分类（capability 视角）|

---

## 二、最高价值（建议全文精读，⭐⭐⭐⭐⭐）

1. **D11 CAMEL (2303.17760)** — "role-playing + inception prompting" 是 capability 范式里"角色"的最经典实现；其"角色=prompt 假扮"恰是我们 social role agency 要超越的对象，必引于 §2 / 旧范式对照。
2. **D24 From Persona to Personalization (2404.18231)** — 角色扮演语言 agent 的权威综述；系统性地把"persona/role"定义为个性扮演与个性化，正是我们要区分的"role-as-persona"vs"role-as-verifiable-social-agency"。
3. **D20 From Individual to Society (2412.03563)** — 最贴近 agent society / 社会维度的综述（individual→scenario→society 三层），SC/N 支柱的综述锚点。
4. **D14 LLM-based Autonomous Agents survey (2308.11432)** — capability 范式标准画像（profile/memory/planning/action），用于在 §2 精确刻画"我们要超越的旧范式"。
5. **D02 Comprehensive Survey of Self-Evolving AI Agents (2508.07407)** — 自演化最权威综述，提出"统一反馈回路框架"；与我们"统一三支柱可证伪框架"形成框架级对照（强化创新点 v0.3 表述）。

---

## 三、检索备注

- **arXiv API 直连不可用**：本沙箱中 `curl http://export.arxiv.org/api/query` 返回空、WebFetch 对 arXiv 触发 HTTP 429。本批全部改用 **WebSearch**，每个 ID 至少命中一次 arXiv abstract 页（`arxiv.org/abs/<id>`）并核对标题一致后方才记录。
- **未能核实的 ID**：本批无 ⚠️unverified 条目（28/28 均核实）。
- **作者字段**：部分多作者论文以"(multi-author)"或首作者+et al. 记，未逐一展开（与现有筛选表风格一致）。
- **去重确认**：D01–D28 的 arXiv ID 均不在 `paper1-literature-screen.md` 已收录列表内。
- **下一步建议**：D18 (Why MAS Fail) 与 D11/D24 (role-playing) 可优先纳入 Day 2 全文阅读队列，因其分别支撑 §5 结构缺口论证与 §2 旧范式角色对照。
