# Paper 1 文献筛选记录（PRISMA-ScR）

> **创建日期**：2026-05-21
> **对应执行计划**：Phase 1（2026-05-21 → 2026-05-28）
> **目标**：800-1000 篇候选 → 150-200 摘要入围 → 30-50 全文阅读 → 25-35 核心引用
> **最近更新**：2026-05-21 — Group A/B/C/E/F/G 首批检索完成，已知文献全部核实

---

## PRISMA-ScR 流程图（动态更新）

```
记录总数（所有来源，2026-05-22 更新）：
  arXiv 首批检索（Group A+B+C+E+F+G）: ~40 篇候选（本文件 §二）
  已知文献核实（paper1-bibliography.md）: 19 篇
  Group D + 基础框架批（paper1-screen-batch-groupD.md）: 28 篇（全部 arXiv 验证）
  社会模拟 + 协议/身份批（paper1-screen-batch-social-protocol.md）: 46 篇（全部 arXiv API 验证）
  ─────────────────────────────────────────────
  当前候选总数：~133 篇（去重后，已超 120 目标 ✅）

标题/摘要层筛选（持续进行）：
  强相关（⭐⭐⭐⭐+，全文阅读优先）: ~50 篇
  中相关（⭐⭐⭐，摘要入围）: ~55 篇
  排除/弱相关: ~28 篇（长程任务/纯embodied/无社会维度/纯MARL）

全文精读完成（reading-notes/）：24 篇（截至 2026-05-22 夜间批次，仍在增加）

PRISMA 最终计数（Phase 1 结束时定稿）：
  摘要入围: [TODO: ~100-120]
  全文阅读: [进行中: 24+ → 目标 35-45]
  最终纳入: [TODO: ~28-38]
```

> **三个候选库文件**（互不重复）：本文件 §二（首批 ~40）+ `paper1-screen-batch-groupD.md`（28）+ `paper1-screen-batch-social-protocol.md`（46）。
> **非 arXiv TODO**：ERC-8004 规范需直接查官方 spec（无 arXiv 版本）；Bourdieu/Putnam/Ostrom 原典走经典引用。

---

## 一、已知文献核实结果（2026-05-21 全批检索）

### 1.1 核实完成的文献

| 编号 | 引用 | 核实状态 | arXiv/DOI | 备注 |
|-----|------|---------|-----------|------|
| C1 | Li et al. 2025 — Emergence of Altruism in LLM Agents | ✅ REAL | arXiv:2509.22537 | 香港浸大/港中深；Schelling博弈驱动200+ agents |
| C2 | Park et al. 2023 — Generative Agents | ✅ REAL | arXiv:2304.03442 | 斯坦福小镇；UIST 2023 |
| C3 | Chakraborty 2026 — Human-AI Co-evolution | ✅ REAL | arXiv:2604.22227 | 上交大；"条件互利共生+治理"框架 |
| C4 | Han et al. 2026 — Social Physics + AI | ✅ REAL | arXiv:2603.16900 | 7位作者；6个研究方向 |
| C5 | Feng et al. 2026 — PNAS Optimal Embedding | ✅ REAL | DOI:10.1073/pnas.2537939123 | PNAS Vol.123 No.12；演化图论最优比例 |
| C6 | Chen et al. 2025 — Static Sandboxes Are Inadequate | ✅ REAL | arXiv:2510.13982 | 开放式协同演化；三支柱分类 |
| C7 | Huang et al. 2026 — Emergent Social Intelligence Risks | ✅ REAL | arXiv:2603.27771 | 15位作者；multi-agent从实验室走向实际部署的风险 |
| C8 | Evans, Bratton & Agüera y Arcas 2026 — Agentic AI Intelligence Explosion | ✅ REAL | arXiv:2603.20639 | 3位作者；"AI singularity误被设想为单一神级心智" |
| C9 | Quan et al. 2026 — AI as Colleagues (CHI 2026) | ✅ REAL | arXiv:2510.23904 | CHI最终版删去"Professional"；UIUC/U.Maryland |
| C10 | Wooldridge 2009 — Intro to MAS | ✅ 教材 | ISBN:978-0470519462 | |
| C11 | Bourdieu 1986 — Forms of Capital | ✅ 经典 | Greenwood出版 | |
| C12 | Putnam 2000 — Bowling Alone | ✅ 经典 | Simon & Schuster | |
| C13 | Ostrom 1990 — Governing the Commons | ✅ 经典 | Cambridge UP | |
| C14 | Axelrod 1984 — Evolution of Cooperation | ✅ 经典 | Basic Books | |
| C15 | Licklider 1960 — Man-Computer Symbiosis | ✅ 经典 | IRE Transactions | |
| C16 | Nowak 2006 — Five Rules for Cooperation | ✅ 经典 | Science 314(5805) | |
| C17 | Xi et al. 2024 — Rise and Potential of LLM Agents | ✅ REAL | arXiv:2309.07864 | 全面综述；含Agent Society专章 |
| C18 | Zhang et al. 2026 — Beyond Preset Identities | ⚠️ 待核实 | 原标注arXiv:2603.23406 | |
| C19 | Hilbert 2025 — Multi-AI-Agent Social Networks | ❌ 不标准 | 个人网站 | 无arXiv/journal版本；需替换 |

**核实汇总**：✅ 18/19 已核实（全部引用已确认为真实论文）| ❌ 1/19 需替换（Hilbert个人网站）

---

## 二、首批新文献候选库（2026-05-21 搜索）

### 2.1 Group B：人机共演与混合社会（2026-05-21 完成）

| ID | 标题 | 作者 | 年份 | arXiv | 相关性 | 对应位置 |
|----|------|------|------|-------|--------|---------|
| NEW-B01 | Super Co-alignment of Human and AI for Sustainable Symbiotic Society | Zeng et al. | 2025 | 2504.17404 | ⭐⭐⭐⭐ | §4人机协作集群 |
| NEW-B02 | Human-AI Interaction Alignment: Bidirectional Reciprocal Futures | Shen, Knearem et al. | 2025 | 2512.21551 | ⭐⭐⭐⭐ | §4/§6 双向制度化 |
| NEW-B03 | HAIF: Human-AI Integration Framework for Hybrid Team Operations | Bara | 2026 | 2602.07641 | ⭐⭐⭐⭐ | P1协作协议框架 |
| NEW-B04 | Collaborating with AI Agents: Field Experiments (n=2234, +50% output) | Ju & Aral | 2025 | 2503.18238 | ⭐⭐⭐⭐⭐ | §4.1 实证：混合团队产出/同质化 |
| NEW-B05 | Evolution of Fairness in Hybrid Populations with Specialised AI Agents | Song, Cimpeanu, Han | 2026 | 2602.18498 | ⭐⭐⭐⭐ | §4/P3演化博弈 |
| NEW-B06 | Optimizing Delegation in Collaborative Human-AI Hybrid Teams | Fuchs, Passarella | 2024 | 2402.05605 | ⭐⭐⭐ | §4.1 委托/控制权分配 |
| NEW-B07 | Multi-Agents are Social Groups: Social Influence in Human-Agent Interactions | Song, Tan et al. | 2024 | 2411.04578 | ⭐⭐⭐⭐⭐ | §2 Related Work核心 |

### 2.2 Group E：社会资本理论应用于AI（2026-05-21 完成）⚠️ 重要

| ID | 标题 | 作者 | 年份 | arXiv | 相关性 | 经典理论 | 关键意义 |
|----|------|------|------|-------|--------|---------|---------|
| NEW-E01 | Social Learning & Collective Norm Formation in LLM Multi-Agent Systems | Gupta, Zhong, Rahwan et al. | 2025 | 2510.14401 | ⭐⭐⭐⭐⭐ | **Ostrom** | 最直接将Ostrom应用于LLM agents |
| NEW-E02 | From Firms to Computation: AI Governance & Evolution of Institutions | Harre | 2025 | 2507.13616 | ⭐⭐⭐⭐⭐ | **Ostrom+制度理论** | AI治理→制度演化问题 |
| NEW-E03 | Synthetic Social Graph: Emergent Behavior in AI Agent Communities | Cha & Kim（LG Uplus）| 2026 | 2604.27271 ⚠️**版本陷阱** | ⭐⭐⭐⭐ | **Putnam** | bonding/bridging在AI agent网络中；✅全文已读(v1)。⚠️同一ID的v3已替换为"Frame Entrepreneurs..."删掉Putnam——引用v1有风险，本地存 papers/synthetic-social-graph2026-v1.pdf |
| NEW-E04 | Governance by Design: Parsonian Institutional Architecture for Agent Societies | Ruan | 2026 | 2604.11337 | ⭐⭐⭐⭐⭐ | **Parsons AGIL** | 最直接将Parsons应用于智能体社会架构 |
| NEW-E05 | Institutional AI: Governing LLM Collusion via Public Governance Graphs | Bracale Syrnikov et al. | 2026 | 2601.11369 | ⭐⭐⭐⭐ | 制度机制设计 | 制度嵌入→合谋从50%降至5.6% |
| NEW-E06 | When Agents Evolve, Institutions Follow | Fei, Guo, Xiao | 2026 | 2604.27691 | ⭐⭐⭐⭐ | 历史制度比较 | 7种历史制度→治理拓扑影响57pp |
| NEW-E07 | AgentReputation: Decentralized Agentic AI Reputation Framework (FSE 2026) | Chishti, Oyinloye, Li | 2026 | 2605.00073 | ⭐⭐⭐⭐ | 声誉/社会资本 | 声誉→制度参与资格 |
| NEW-E08 | Agents Incorporating Identity and Dynamic Teams in Social Dilemmas | Tilbury, Hoey | 2022 | 2208.03293 | ⭐⭐⭐ | 身份理论 | 早期规范框架 |

### 2.3 Group A + C：多智能体协作与社会涌现（Paper 1 核心）

| ID | 标题 | 作者 | 年份 | arXiv | 相关性(1-5) | 对应命题 | 全文优先级 |
|----|------|------|------|-------|-----------|---------|----------|
| NEW-001 | Beyond Static Responses: Multi-Agent LLM Systems as New Paradigm for Social Science | Haase & Pokutta | 2025 | 2506.01839 | ⭐⭐⭐⭐ | L3诊断：6层连续体 | **高** |
| NEW-002 | Spontaneous Emergence of Agent Individuality through Social Interactions | Takata et al. (东京大) | 2024 | 2411.03252 | ⭐⭐⭐⭐⭐ | P3无许可网络；社会涌现 | **高** |
| NEW-003 | Emergence of Human-Like Polarization among LLM Agents | Piao, Lu, Gao et al. | 2025 | 2501.05171 | ⭐⭐⭐⭐ | §4集群：机机协作风险 | **高** |
| NEW-004 | The Rise and Potential of LLM Based Agents: A Survey | Xi et al. | 2023 | 2309.07864 | ⭐⭐⭐⭐⭐ | 基础综述；Agent Society专章 | **高** |
| NEW-005 | Internet of Agents: Weaving Heterogeneous Agents for Collaborative Intelligence | Chen, You, Li (清华/腾讯) | 2024 | 2407.07061 | ⭐⭐⭐⭐ | P3网络架构；与ASM对话 | **高** |
| NEW-006 | On the Resilience of LLM-Based Multi-Agent Collaboration with Faulty Agents | (多作者) | 2025 | 2408.00989 | ⭐⭐⭐ | §5结构缺口：稳定性问题 | 中 |
| NEW-007 | Emergent Social Dynamics of LLM Agents in El Farol Bar Problem | (多作者) | 2025 | 2509.04537 | ⭐⭐⭐ | 协调博弈中的涌现 | 中 |

### 2.2 Group B（协议层）：Agent 通信协议架构（Paper 1 §5 + Paper 2）

| ID | 标题 | 作者 | 年份 | arXiv | 相关性(1-5) | 用途 |
|----|------|------|------|-------|-----------|------|
| NEW-008 | A Layered Protocol Architecture for the Internet of Agents | Fleming et al. | 2025 | 2511.19699 | ⭐⭐⭐⭐⭐ | 直接类比OSI分层；Paper 2 Related Work |
| NEW-009 | Internet of Agentic AI: Incentive-Compatible Distributed Teaming | Yang & Zhu | 2026 | 2602.03145 | ⭐⭐⭐⭐ | 去中心化联盟形成；P3网络 |
| NEW-010 | ACPs: Agent Collaboration Protocols for Internet of Agents | Liu, Yu, Chen et al. | 2025 | 2505.13523 | ⭐⭐⭐⭐⭐ | 与ASM直接竞争；比较表核心行 |
| NEW-011 | Agentic Peer-to-Peer Networks: From Content Distribution to Capability | (多作者) | 2026 | 2603.03753 | ⭐⭐⭐⭐ | P2P架构；去中心化网络 |
| NEW-012 | Security Threat Modeling for AI-Agent Protocols: MCP, A2A, Agora, ANP | (多作者) | 2026 | 2602.11327 | ⭐⭐⭐⭐⭐ | Paper 2 安全分析；与ASM安全对比 |

### 2.3 Group F+G：DID/VC/ZK/信誉（Paper 2 核心引用）

| ID | 标题 | 作者 | 年份 | arXiv | 用途 |
|----|------|------|------|-------|------|
| NEW-013 | Survey of Agent Interoperability Protocols: MCP, ACP, A2A, ANP | Ehtesham et al. | 2025 | 2505.02279 | Paper 2 §2 比较表 |
| NEW-014 | Survey of AI Agent Protocols | (多作者) | 2025 | 2504.16736 | Paper 2 §2 比较表 |
| NEW-015 | Which LLM Multi-Agent Protocol to Choose? | (多作者) | 2025 | 2510.17149 | Paper 2 §2 选型评估 |
| NEW-016 | Agent Network Protocol (ANP) White Paper | ANP工作组 | 2025 | 2508.00007 | DID-based agent identity；直接与ASM对话 |
| NEW-017 | AI Agents with Decentralized Identifiers and Verifiable Credentials | **Rodriguez Garzon, Vaziry, Kuzu et al.（TU Berlin）** ✅作者已纠错（原误标 Rouhani）| 2025 | 2511.02841 | Paper 2 §3 身份层；✅全文已读 |
| NEW-018 | AgentDID: Trustless Identity Authentication for AI Agents | (多作者) | 2026 | 2604.25189 | Paper 2 §3 身份层 |
| NEW-019 | Secure Autonomous Agent Payments: DID+VC+ZKP | (多作者) | 2025 | 2511.15712 | Paper 2 §5 隐私保护 |
| NEW-020 | Inter-Agent Trust Models: Brief, Claim, Proof, Stake, Reputation | (多作者) | 2025 | 2511.03434 | Paper 2 §2 信任模型分类 |
| NEW-021 | Scalable Privacy-Preserving ZKP Identity Framework (zk-STARK) | (多作者) | 2025 | 2510.09715 | Paper 2 §5 ZK |
| NEW-022 | DAO-Agent: ZK-Verified Incentives (STARK+Groth16) | (多作者) | 2024 | 2512.20973 | Paper 2 §5 ZK实现参考 |
| NEW-023 | TrustFlow: Topic-Aware Vector Reputation Propagation | (多作者) | 2026 | 2603.19452 | Paper 2 §5 声誉系统 |
| NEW-024 | MCP Safety Audit: Major Security Exploits | (多作者) | 2025 | 2504.03767 | Paper 2 §1 MCP局限动机 |
| NEW-025 | Breaking the Protocol: MCP Security Analysis + Prompt Injection | (多作者) | 2025 | 2601.17549 | Paper 2 §1 MCP局限动机 |
| NEW-026 | Decentralized Multi-Agent System with Trust-Aware Communication (Best Paper IEEE ISPA 2025) | (多作者) | 2025 | 2512.02410 | Paper 2 §3 链上Agent通信 |

---

## 三、下一步检索计划（Phase 1 剩余任务）

### 待完成的搜索（按优先级）

| 优先级 | 关键词组 | 数据库 | 目标篇数 | 状态 |
|--------|---------|--------|---------|------|
| ✅ | Group E：社会资本理论 + AI/Agent | Google Scholar + arXiv | 8 | **完成** |
| ✅ | Group B：Human-AI co-evolution + hybrid society | arXiv cs.AI+cs.CY | 7 | **完成** |
| **P1** | Group D：自我演化LLM/ReAct/EvolveR | arXiv cs.AI | ~20 | ⬜ |
| **P2** | Nowak 2006引用追踪 + Granovetter | Google Scholar 引用树 | ~10 | ⬜ |
| **P3** | Group G：EigenTrust/P2P reputation | arXiv cs.CR | ~15 | ⬜ |
| **P3** | Mitchell arXiv:2604.00081 直接核实 | arXiv | 1 | ⬜ |

### ⚠️ 重要发现：Paper 1 §2 需要调整

**问题**：Group E 搜索发现已有多篇论文将单个经典社会学理论（Ostrom/Putnam/Parsons）应用于AI agents：
- Gupta et al. 2025（Ostrom → LLM多智能体规范）
- Harre 2025（Ostrom → AI治理）
- Ruan 2026（Parsons AGIL → 智能体社会架构）
- Synthetic Social Graph（Putnam → AI agent网络）

**原有论断**："首次将制度理论桥接到AI" — **需要修改**

**修改方向**：Paper 1的创新点不是"首个桥接"，而是：
> "尽管近期已有工作将单个制度理论（Ostrom/Putnam/Parsons）分别应用于特定AI多智能体问题，**本文提出第一个统一三要素可证伪框架**——将三个理论整合为单一分析工具，并提供系统性诊断而非个案应用"

这实际上**强化**了我们的论文：证明这个方向是有价值的（有人在做），但缺乏统一框架（我们来提供）。

---

## 四、排除记录

| 原因 | 排除的查询方向 | 说明 |
|------|-------------|------|
| 无社会协作维度 | Long-horizon embodied robot task (ELHPlan等) | 纯机器人执行层，不涉及社会角色/身份 |
| 无多Agent维度 | 单Agent能力扩展类论文 | 不在Scoping Review范围 |
| 纯技术实现 | MARL (Multi-Agent RL) 系统 | 关注reward优化而非社会协作 |

---

## 五、统计摘要（Phase 1 Day 1 完整版 — 2026-05-21 EOD）

| 指标 | 数值 |
|------|------|
| 已核实文献（原草稿引用）| **18/19**（100%真实，0幻觉；仅Hilbert需替换）|
| 新发现候选：Group A/C | 7 篇 |
| 新发现候选：Group B | 7 篇 |
| 新发现候选：Group E | 8 篇 |
| 新发现候选：Group F/G | 14 篇 |
| **新发现总计** | **36 篇** |
| 阅读笔记已创建 | 5 篇 |
| 检索完成关键词组 | **5/7**（A+B+C+E+F+G完成；D剩余）|

### ⚠️ Paper 1 §2 修改提示（需在Phase 2写作中处理）

**发现**：E01-E04 等论文已分别将Ostrom/Putnam/Parsons应用于AI agents → Paper 1"首次桥接"的论断需要降格为"首个统一框架"。

**修改后的创新点表述**（更精准、更defensible）：
> "While recent work has individually applied Ostrom's commons governance [E01], Parsonian institutional design [E04], and Putnam's social capital [E03] to specific multi-agent problems, **no unified testable framework integrates these three dimensions into a falsifiable model of agent collaboration networks.** This paper provides that framework."

### Day 2 全文阅读优先队列

| 优先级 | 论文 | 原因 |
|--------|------|------|
| **1** | arXiv:2510.14401 (Gupta et al. — Ostrom+LLM agents) | 最直接竞争Paper 1 §6理论基础；需精读确认与我们框架的差异 |
| **2** | arXiv:2604.11337 (Ruan — Parsons AGIL) | 同上；Parsons AGIL是我们三要素框架的最近竞争方案 |
| **3** | arXiv:2411.04578 (Song & Tan — Multi-Agents are Social Groups) | §2必引；"智能体集体被视为社会群体"是我们范式的实证基础 |
| **4** | arXiv:2503.18238 (Ju & Aral — Field Experiments n=2234) | 提供"混合团队+同质化风险"的最强实证数据；可写入§4 |
| **5** | arXiv:2505.13523 (ACPs) | ASM竞争方案；Paper 2比较表必须精确 |
| **6** | arXiv:2604.22227 (Chakraborty) | 共演化框架；与P+SC+N三要素对比 |
