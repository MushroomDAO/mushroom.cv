# 两篇论文的核心创新点（One-Sentence Pitch）

> **创建日期**：2026-05-20
> **最近更新**：2026-05-21（加入"7 层一致性视图"作为整体叙事框架）
> **目的**：用一句话锁定每篇论文的学术原创性。任何论文的接受度首先取决于这一句话能否说服审稿人"这是新东西、且值得发表"。
> **状态**：v0.2 — 范式定位锁定（"能力定位 vs 社会角色定位"）

---

## 〇、统一叙事：Agent 协作网络的 7 层一致性视图

整个项目（两篇论文 + Mycelium Protocol 工程）的核心从未变过：**提供一个 Agent 协作网络**。所有迭代都是对同一件事的**逐步精确化（zoom-in）**，不是方向转变。

```
                                Agent 协作网络
                       (Agent Collaboration Network)
                                     │
              "为 Agent 提供协作能力的网络基础设施"
                                     │
        ─────────────────────────────────────────────────
        │                            │                            │
    我们提供什么            为什么需要                       怎么实现
    (Paradigm)             (Diagnosis)                  (Realization)
```

### 7 层一致性视图

| 层级 | 描述 | Paper 归属 |
|------|------|----------|
| **L1 目标** | 提供 Agent 协作网络 | 两篇都用 |
| **L2 范式** | Agent 是社会角色代理人，不是能力容器 | Paper 1 §1 |
| **L3 诊断** | 现有协议（MCP/FIPA）只支持能力调用，缺社会层基础设施 | Paper 1 §2 + §5 |
| **L4 框架** | 三要素（P + SC + N）+ 制度理论根基 | Paper 1 §6-§7 |
| **L5 架构** | 双网 + 社会记忆层 + 授权机制 | Paper 2 §3 |
| **L6 协议** | ASM 三区块 + 状态机 + ZK | Paper 2 §4-§6 |
| **L7 实现** | Mycelium on Sepolia → OP mainnet | Paper 2 §7 |

**两篇论文 = 同一个 Agent 协作网络的两个不同 zoom level 的描述**：
- Paper 1 聚焦 **L1-L4**：从顶层目标到理论框架（What & Why）
- Paper 2 聚焦 **L5-L7**：从系统架构到具体实现（How）

### 所有迭代都是 zoom-in，不是 turn

| 迭代轮次 | 看似在变什么 | 实际是什么 |
|---------|----------|---------|
| Round 1：从"Agent Society" → "Agent 协作网络" | 改主题词 | **L2 范式的措辞精确化**（去除哲学争议） |
| Round 2：从"协作" → "长链路、跨组织协作" | 缩小范围 | **L1 目标的范围明确化** |
| Round 3：从"长链路" → "社会层级 vs 能力层级" | 增加对比维度 | **L3 诊断的精确化**（与现有方案划清边界） |
| Round 4：从"社会层级" → "携带真实社会身份" | 引入机制 | **L4 SC 维度的具体化**（身份绑定） |
| Round 5：从"携带凭证" → "社会角色定位" | 提炼为范式 | **L2 范式的最终凝练**（能力容器 vs 社会角色代理） |

**始终不变的核心**：
- 三要素框架（P + SC + N）从 DeepSeek 原始对话起就提出
- 双网架构 + ASM 协议 + Mycelium 实现从一开始就锚定
- "Agent 协作网络"作为顶层目标从未变过

---

## Paper 1：核心创新点

### Title（v0.2 锁定）

> *Three Pillars for an Agent Collaboration Network: A Paradigm Shift from Capability Invocation to Social Role Agency, with a Scoping Review of 2022-2026 Literature*
>
> 中文：*Agent 协作网络的三要素框架：从能力调用到社会角色代理的范式转换——基于 2022-2026 文献的 Scoping Review*



### 一句话陈述（v0.2 — 范式定位锁定）

**中文**：
> **传统 Agent 协议（MCP / FIPA ACL / AutoGen / OpenAI tools）把 Agent 定位为"可被调用的能力"；我们提出范式转换：把 Agent 定位为"承担社会角色的代理人"——携带所有者（个体/组织）声明的社会角色与可验证社会凭证（KYC、营业执照、历史信誉），在授权 scope 内、保护隐私、可追溯地按该角色与其他 Agent 持续协作。基于经典制度理论（Ostrom/Bourdieu/Putnam），我们提出可证伪的三要素框架——角色特定的协作协议、量化社会资本（Hist + Cred + Rel）、无许可网络——使 Agent 能完成需要调动社会资源的长链路经济与社交协作。**

**英文**：
> **Traditional agent communication protocols (MCP, FIPA ACL, AutoGen) position agents as invocable capabilities. We propose a paradigm shift: positioning agents as social actors with declared roles, carrying verifiable social credentials from their principal (individual or organization)—KYC, business licenses, historical reputation—and operating within explicit authorization scope, privacy constraints, and auditability. Grounded in classical institutional theory (Ostrom, Bourdieu, Putnam), we propose a falsifiable three-pillar framework—role-specific collaboration protocols, quantified social capital (history, credentials, relations), and permissionless networks—enabling agents to engage in long-chain economic and social transactions that require mobilizing social resources rather than merely invoking capabilities.**

中文版：
> **本文将 AI Agent 研究与经典制度理论（Ostrom、Bourdieu、Putnam）相桥接，诊断出当前多智能体 AI 系统的根本缺口是缺乏"制度性嵌入"——不是能力、数据、或对齐问题——并基于 2022-2026 年文献的 PRISMA-ScR scoping review，提出第一个可证伪的"三要素框架"（协作协议、量化社会资本、无许可网络）来填补这一缺口。**

### 关键词分解（构成原创性的 5 个元素）

> **⚠️ v0.3 更新（2026-05-21）**：Phase 1 文献检索发现已有论文将单个社会学理论应用于AI agents（Gupta et al. 2025 用Ostrom；Ruan 2026 用Parsons AGIL）。因此"Bridge"的论断已从"首次桥接"降级为"首个统一框架"。这实际上**加强**了论文——证明方向正确，缺的是我们提供的统一性。

1. ~~**"Bridge"** — 跨学科桥接（这是大多数现有工作不做的）~~ → **修订**：这已有人在做（Gupta, Ruan, Harre等），我们的原创性在于"整合"而非"首次桥接"
2. **"Diagnose"** — 提出明确的诊断：不是能力问题，不是数据问题，不是对齐问题，**是缺乏统一制度性基础设施的问题**（**现有单点应用缺乏这个统一诊断**）
3. **"First unified falsifiable framework"** — 首次将Ostrom/Bourdieu/Putnam三个理论**整合**为可证伪命题（**这是与现有单点应用的关键差异**）
4. **"Three-pillar framework"** — 具体框架名称（**给后续研究者一个可引用、可批评的目标**）
5. **"PRISMA-ScR"** — 方法论严谨（**与单纯 narrative review 区分**）

### 与同类工作的差异（v0.3 — 更新加入新发现的竞争文献）

| 同类工作 | 它的贡献 | 我们的不同 |
|---------|---------|----------|
| Gupta et al. (2025) arXiv:2510.14401 | Ostrom原则→LLM多智能体规范涌现 | 单个理论的单点应用；我们整合三个理论为统一框架 |
| Ruan (2026) arXiv:2604.11337 | Parsons AGIL→智能体社会架构（16格） | 描述性架构；我们的P1-P5是可证伪命题（科学化升级）|
| Harre (2025) arXiv:2507.13616 | Ostrom+制度理论→AI治理演化 | 宏观治理层；我们关注微观协作基础设施 |
| Chakraborty (2026) 共演化理论 | 人-AI共演化的治理动力学 | 我们提供**三要素的结构性分析**（不仅是动力学）|
| Han et al. (2026) 社会物理学议程 | 提出6个研究方向 | 我们提供**统一的诊断框架**（不是议程清单）|
| Feng et al. (2026) PNAS 最优嵌入 | 数学证明Agent比例 | 我们**将其推广为命题P3**，并嵌入更大框架 |
| Wooldridge MAS 教材 | 多智能体系统经典 | 我们**接入社会学维度**并提供可操作的三要素框架 |

**核心差异化（一句话）**：
> 现有工作（Gupta/Ruan/Harre等）证明"制度理论应用于AI是可行的"（单点验证）；我们的贡献是"第一个将Ostrom、Bourdieu、Putnam三者整合为单一可证伪框架，并进行系统性诊断和Scoping Review验证"。

---

## Paper 2：核心创新点

### Title（v0.2 锁定）

**Primary (A)**：
> *ASM: A Communication Protocol for Role-Bearing AI Agents in Decentralized Collaboration Networks*
>
> 中文：*ASM：去中心化协作网络中角色承载型 AI Agent 的通信协议*

**Backup (B)** — 保留用于后续 venue-specific 调整：
> *ASM: Operationalizing the Role-Bearing Agent Paradigm — Verifiable Identity, Privacy-Preserving Reputation, and Permissionless Coordination*



### 一句话陈述（v0.2 — 范式定位锁定）

**中文**：
> **我们设计 ASM 协议，操作化"角色承载型 Agent" 范式：把可验证社会角色与凭证的密码学绑定、角色特定的协作状态机（采购、求偶、学术合作等）、隐私保护声誉积累、无许可多方协调整合为联合设计目标，使 Agent 能在授权 scope、隐私约束、可追溯三重保障下，按所有者声明的社会角色与其他 Agent 持续协作完成具体经济与社会事务，跨越现有能力调用协议（MCP / FIPA ACL）的边界，并提供公链 reference implementation。**

**英文**：
> **We present ASM, an agent communication protocol that operationalizes the role-bearing agent paradigm: integrating cryptographic binding of social roles and credentials, role-specific collaboration state machines (procurement, partnership formation, academic collaboration), privacy-preserving reputation accumulation, and permissionless multi-party coordination as joint design goals. ASM enables agents to engage in long-chain social and economic transactions—on behalf of declared principals (individuals or organizations) within authorization scope, privacy constraints, and auditability—that current capability-based protocols (MCP, FIPA ACL) cannot support, with a reference implementation on public blockchain (currently Sepolia testnet with planned OP mainnet).**

中文版：
> **本文提出 ASM，首个同时实现可验证人类授权、隐私保护声誉积累、与无许可多智能体协作三者的 Agent 通信协议——在公链上部署了 reference implementation，将"制度性嵌入"框架工程化落地。**

### 关键词分解（构成原创性的 4 个元素）

1. **"Simultaneously"** — 三个属性同时满足（**目前没有任何已有协议做到，详见 §2.6 对比表**）
2. **"Verifiable human-authorization"** — 把人类授权变成可验证关系（**填补 FIPA ACL / MCP 的核心空白**）
3. **"Privacy-preserving reputation"** — 用 ZK 实现隐私保护（**对应 eBay/EigenTrust 评分制的革命**）
4. **"Deployed reference implementation"** — 不只是规范，是真实部署（**与纯协议规范论文的关键差异**）

### 与同类工作的差异（六维度对比表，已在 paper2-draft-v0 §2.6）

| 协议 | 结构化消息 | 加密身份 | 人类授权 | 隐私声誉 | 无许可 | 多方协调 |
|------|----------|---------|---------|---------|--------|---------|
| FIPA ACL | ✅ | ❌ | ❌ | ❌ | ❌ | ✅ |
| Anthropic MCP | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ |
| DIDComm | ✅ | ✅ | ⚠️ | ❌ | ⚠️ | ❌ |
| Nostr | ⚠️ | ✅ | ❌ | ❌ | ✅ | ⚠️ |
| EigenTrust | ❌ | ❌ | ❌ | ❌ | ⚠️ | ❌ |
| **ASM** | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |

ASM 是唯一全 ✅ 的协议。

---

## 三、两篇论文的联合贡献（Combined Pitch）

把两篇论文当成一个 portfolio 卖给学术界，one-liner：

> **We provide a complete Agent Collaboration Network stack: positioning agents as social role agents (not capability containers), diagnosing the missing institutional infrastructure (Paper 1, L1-L4), specifying the ASM protocol for role-bearing collaboration (Paper 2, L5-L6), and demonstrating with a public-blockchain reference implementation (Mycelium Protocol, L7—currently Sepolia testnet with planned OP mainnet).**

中文：
> **我们提供完整的 Agent 协作网络栈：把 Agent 定位为承担社会角色的代理人而非能力容器，诊断现有协议缺失的制度性基础设施（Paper 1，覆盖 L1-L4 范式/诊断/框架），规范 ASM 协议作为角色承载型协作的实现（Paper 2，覆盖 L5-L6 架构/协议），并通过公链 reference implementation 落地（Mycelium Protocol，L7 实现层，当前在 Sepolia 测试网，OP mainnet 部署计划中）。**

### 价值主张（严谨版）

**对个体**：
> 你声明你的社会角色（如"想找伴侣的 28 岁单身"），授权你的 Agent 携带你的可验证社会凭证（年龄、婚况、兴趣向量等），在隐私保护下与其他 Agent 按"求偶协议"持续匹配；你只在 Agent 找到合适候选时介入做最终判断。

**对组织**（外贸公司案例）：
> 公司声明"外贸采购方"角色，营业执照与 KYC 凭证绑定到该公司的 Agent；该 Agent 在公司授权下按"采购协议"持续与全球供应商的 Agent 接洽，对方可通过 ZK 证明验证公司资质，整个询盘-报价-比对过程压缩至几分钟。

**一句话定调（最强版）**：
> **传统 Agent 是"能力的容器"，我们的 Agent 是"承担社会角色的代理人"——携带你的真实社会身份与信誉，按你授权的角色代你办具体的事。**

**最简化（用于 BP）**：
> **Agent 不只调用能力，更承担社会角色。**

---

## 四、给 Jason 的 review 问题

请确认或修改：

1. **Paper 1 的一句话**：你认为"诊断为制度问题（不是能力/数据/对齐）"是足够强、足够有挑战性的论断吗？还是太抽象？
2. **Paper 2 的一句话**：强调"首个同时实现三者"是足够清晰的差异点吗？审稿人会不会反问"为什么之前没人做？"
3. **联合 pitch**：把两篇当 portfolio 卖、提"Agent 社会工程学"作为新学科——这个野心合适吗？还是降到"框架 + 协议"两件套？
4. **要不要在 abstract 中直接用这些 one-liner？** 当前 paper1-draft-v0 abstract 偏长，可以剪短到围绕 one-liner 展开。

定稿后这两句一句话会作为：
- 每篇 abstract 的第一句
- arXiv 提交时的 "Comments" 字段
- ZUAEC BP 中描述论文贡献的标准说辞
- 与潜在合作者沟通时的电梯演讲
