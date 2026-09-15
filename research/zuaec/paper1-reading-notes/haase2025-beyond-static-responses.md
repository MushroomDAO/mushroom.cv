# [Haase & Pokutta 2025] Beyond Static Responses: Multi-Agent LLM Systems as a New Paradigm for Social Science Research

**Citation**: Jennifer Haase, Sebastian Pokutta. "Beyond Static Responses: Multi-Agent LLM Systems as a New Paradigm for Social Science Research." arXiv:2506.01839v3 [cs.MA]. 标注日期 June 2, 2025（v3 修订于 18 May 2026），27 pages。"Living document"（作者声明会持续更新）。
**机构**: Weizenbaum Institute & Humboldt-Universität zu Berlin（Haase）；TU Berlin & Zuse Institute Berlin（Pokutta）。资助：DFG MATH+（EXC-2046/1）、BMBF（Weizenbaum-Institute, 16DII133）。
**arXiv**: https://arxiv.org/abs/2506.01839
**PDF**: papers/haase2025-beyond-static-responses.pdf
**Cluster**: 分类/综述框架文献（Agentic-LLM 能力分层谱系）。支持 Paper 1 §2 范式综述——可直接作为"能力定位 vs 社会角色定位"对比的**官方坐标系**（其六层是能力定位的最系统表述）。
**Status**: ✅ 全文已分析（2026-05-22）；标题核实一致

## Core claim (一句话)
提出一个六层（Level 0–5）发展连续谱，按功能阈值（记忆整合、自主性、规划与协调、自适应学习）并对齐 OODA 循环，把 LLM 系统从"无状态工具"分类到"复杂自适应系统"，为社会科学研究中 LLM 智能体的能力、需求与认识论角色提供概念脚手架。

## 研究问题
计算社会科学如何超越静态、反应式的 LLM 应用（无记忆、无自主、无交互），系统化理解 LLM 智能体系统？如何用统一框架对现有系统分类、厘清其方法论边界，并平衡变革潜力与可复现性/伦理/涌现偏见等挑战？

## 方法与主要发现
**方法**：概念性框架 + 文献映射综述（scoping-style），非实证。核心贡献是 Table 1（六层连续谱）与 Table 2（各层社会科学应用 + 文献映射）。

**六层框架（Table 1）**：
- L0 LLM-as-Tool：无状态文本生成（仅"Act"阶段）
- L1 LLM-as-Role：记忆整合，一致 persona（Observe→Act）
- L2 Agent-like LLM：目标驱动任务自主（Observe→Orient→Act）
- L3 Fully Agentic LLM：环境接口 + 规划协调（完整 OODA）
- L4 Multi-Agent System：多智能体协调（OODA + Learning）——需 orchestration layer、**agent communication protocols**、共享内存/blackboard、角色分化
- L5 Complex Adaptive System：涌现 + 自适应（动态 OODA + Learning + Emergence）——需**去中心化架构**、大规模 agent 群体、反馈循环、自适应/演化机制

**关键发现/论点**：
- L0–L2 已广泛落地（自动化提效）；L3 反而稀缺（维护单个连贯 agent 开销大）；L4–L5 最有前景但欠开发。
- 高层系统价值从"效率"转向"认识论创新"（epistemic innovation）：规模化测试理论命题、模拟规范形成/冲突/政策效应。
- L5 引用 Park et al. 2023（Generative Agents）、GenSim、S³、Artificial Leviathan（霍布斯社会契约）、GOVSIM、AgentSociety 等作为社会动力学涌现案例。
- **批判反思（§4.2）**：可复现性（随机性 + prompt 敏感）、多智能体新失败模式（冲突/误协调/合谋，引 Hammond 2025、Chan 2023b）、表征偏见（西方语料）、缺乏方法论标准化。Han et al. 2024：静态网络结构无法稳定 LLM agent 间的合作。

## 论文未覆盖的范围（我们的差异化基础）

| 维度 | This paper (六层能力谱) | 我们的框架（P/SC/N） |
|------|----------------------|---------------------|
| 定位轴 | **能力定位**（capability ladder）：按 OODA/记忆/自主性区分 agent"能做什么" | **社会角色定位**：agent 是承载可验证委托人身份的 role-bearing 社会行动者，区分"代表谁、对谁问责" |
| 角色 (Role) | L1 "LLM-as-Role" = persona/人格一致性（Big Five 等），角色是行为风格 | 角色 = 制度性社会角色（principal identity + 问责），不是 persona 风格 |
| 协议 (P) | L4 提到"agent communication protocols"为架构需求，但**未指定语义/凭证/可验证性** | **协作协议（P）**为核心设计对象：ASM 定义角色声明、可验证消息、委托链 |
| 社会资本 (SC) | 借社会交换理论(SET)/社会契约论分析涌现合作，但 SC **不是可累积的内生状态变量** | **量化社会资本（SC）**（Bourdieu/Putnam/Ostrom）：可累积、可转移、驱动准入与权重 |
| 网络 (N) | L5 提"去中心化架构"为技术需求，研究语境仍是封闭仿真沙盒 | **无许可网络（N）**：真实开放网络，permissionless 准入，链上抗审查 |
| 目的 | 服务社会科学**研究**（把 agent 当研究工具/被试） | 构建真实**生产性协作网络**（agent 是经济/社会主体，非实验被试） |
| 可证伪性 | 框架是分类脚手架，非可证伪命题 | P1–P5 五条可证伪命题 + Mycelium 实证锚定（Sepolia→OP） |

## Paper 1 §2 区分段落（~200词）
Haase and Pokutta (2025) offer the most systematic capability taxonomy to date: a six-level continuum (LLM-as-Tool through Complex Adaptive System) structured by functional thresholds—memory, autonomy, planning, adaptive learning—and mapped to Boyd's OODA loop, anchored by an extensive literature mapping for computational social science. We adopt their continuum as a useful coordinate system, but our three-pillar framework reframes the very axis of classification. Their ladder is a *capability* ladder asking what an agent can do; ours is a *social-role* axis asking whom an agent represents and to whom it is accountable. Where their "LLM-as-Role" (Level 1) means persona consistency, our notion of role means an institutional, verifiable principal identity. On Protocols (P), they list "agent communication protocols" merely as a Level-4 architectural requirement without specifying message semantics, credentials, or verifiability—gaps our ASM protocol fills. On Social Capital (SC), they invoke social-exchange and social-contract theory to *describe* emergent cooperation, yet social capital is never an accumulable, transferable, endogenous state variable; we make quantified social capital (Bourdieu/Putnam/Ostrom) precisely that. On Network (N), they cite "decentralized architecture" as a Level-5 technical need while their research context remains closed simulation sandboxes, whereas we target a permissionless, censorship-resistant network grounded in Mycelium Protocol (Sepolia→OP).

## Action items
- [ ] Paper 1 §2：把其六层谱作为"**能力定位**"的代表性、最系统化表述直接引用，并明确对照我们的"**社会角色定位**"轴——这是我们 v0.2 范式重定位的核心对照对象。
- [ ] Paper 1 §2：引用其 L4"agent communication protocols 是架构需求"——论证现有文献只把协议当技术需求而非定义对象，为 Paper 2 (ASM) 留出缺口。
- [ ] Paper 1 §3（SC 论证）：引用其用 SET/社会契约论"描述"涌现合作，对比我们把 SC 作为可累积内生变量——凸显从"描述涌现"到"设计内生激励"的跃迁。
- [ ] 引用 Han et al. 2024（经其转述）："static network structure cannot stabilize cooperation among LLM agents"——支持我们 N（无许可动态网络）+ SC（资本激励）的必要性论证。
- [ ] 引用其批判反思（可复现性、多智能体合谋失败模式、表征偏见）——支持我们"可验证身份 + 量化问责"作为治理回应。
- [ ] 注意 v3 修订日期为 2026-05-18（living document），引用时需标版本号 v3 与访问日期。

## Jason's feedback
> （请在此处写入你的feedback）
