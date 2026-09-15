# 论文写作与 arXiv 提交计划

> **创建日期**：2026-05-20
> **目的**：基于 `01~04` 四篇研究文档的内容，整理为 arXiv 可投递的论文规划
> **关联**：[01-ai-agent-evolution-analysis.md](01-ai-agent-evolution-analysis.md) · [02-human-ai-collaboration-framework.md](02-human-ai-collaboration-framework.md) · [03-dual-network-experiment.md](03-dual-network-experiment.md) · [04-agent-communication-protocol.md](04-agent-communication-protocol.md)

---

## 一、总体策略：写 2 篇论文，同时提交 arXiv 预印本

**核心理由**：
- arXiv 预印本不需要 peer review，1-2 个工作日上线，有学术时间戳和 DOI 价值
- ZUAEC 8th 参赛 BP 可直接引用 arXiv 链接，增加学术背书
- 两篇定位清晰、内容互补，避免单篇内容过载或多篇内容稀薄

---

## 二、为什么是 2 篇而不是 3 篇

| 拆分方案 | 问题 |
|---------|------|
| 综述单独成篇 | doc01 覆盖 2025-2026 文献，独立成篇需大幅扩充 2024 年文献，工作量翻倍而贡献不显著 |
| 框架单独成篇 | doc02 没有综述支撑，框架论文缺少"文献背景 → 发现缺口 → 提出框架"的完整论证链 |
| 协议设计单独成篇 | doc04 可独立成篇（推荐方案的 Paper 2），但若拆出 doc03，则双网实验设计缺乏技术落地 |

**结论**：综述+框架天然是"发现问题+提出解法"的一篇论文结构；双网实验+通信协议天然是"系统架构+协议规范"的一篇论文结构。

---

## 三、Paper 1：理论框架论文（Conceptual Framework Paper）

### 类型定位

**不是纯综述，也不是实证研究，而是"基于系统性文献综述的理论框架论文"。**

学界三种论文类型对比：

| 类型 | 核心贡献 | 是否需要新数据/实验 |
|------|---------|------------------|
| Survey / 综述 | 系统整理已有工作 | ❌ |
| Empirical Research / 实证 | 实验数据验证假设 | ✅ |
| **Conceptual Framework / 理论框架** | **以文献为基础，发现缺口，提出新框架** | ❌（理论推演即可） |

本篇属于第三种，arXiv cs.AI / cs.CY 完全接受。范例：Chakraborty（2026）人-AI 共演化理论论文（arXiv:2604.22227）即为此类型。

### 建议标题

> *从早期智人到文明阶段：AI Agent 社会化的三要素框架——基于 2024-2026 年前沿文献的综述与分析*
>
> *From Early Sapiens to Civilization: A Three-Element Framework for AI Agent Socialization — A Survey and Analysis of 2024-2026 Frontier Literature*

### 内容来源

- **doc01**（综述部分）：2025-2026 年前沿文献综述、三路径量化对比、Mushroom.cv 博客类比的学术评估
- **doc02**（框架部分）："文明操作系统"三要素框架（协作协议 + 社会资本量化 + 无许可网络）

### 论文结构（建议）

1. **Introduction** — AI Agent 进化的社会学问题
2. **Literature Review** — 三路径研究集群（替代/人机协作/机机协作）
3. **Theoretical Foundations** — 演化博弈论、共演化理论、涌现理论
4. **The Structural Gap** — 当前研究的核心缺口：缺乏社会制度性嵌入
5. **Three-Element Framework** — 协作协议 + 社会资本量化 + 无许可网络
6. **Discussion** — 框架与现有理论的对应关系、潜在风险
7. **Conclusion & Future Work** — 双网实验设计预告（引出 Paper 2）

### 投稿分类

- 主分类：`cs.AI`（人工智能）
- 交叉分类：`cs.CY`（计算与社会）、`cs.MA`（多智能体系统）

### 工作量评估

| 任务 | 工作量 |
|------|-------|
| 补充 2024 年相关文献（约 10-15 篇） | 5-7 天 |
| 撰写 Introduction + Conclusion | 2-3 天 |
| 完善综述格式（参考文献规范化、表格优化） | 2-3 天 |
| 框架部分形式化表达（定义、命题） | 3-5 天 |
| 内部 review + 修订 | 2-3 天 |
| **总计** | **约 2-3 周** |

---

## 四、Paper 2：协议设计论文（Protocol Design Paper）

### 类型定位

**不是标准 DSR（Design Science Research）格式**——DSR 是信息系统领域（IS）的方法论框架，不是 CS/AI 主流。投 arXiv cs.DC / cs.CR 不需要套 DSR 模板。

更接近的类型：**"Architecture / Protocol Design Paper"（架构与协议设计论文）**，在计算机网络与分布式系统领域是标准的论文形式。

### 需要 vs 不需要

| 内容 | 是否需要 | 说明 |
|------|---------|------|
| 完整可运行代码 | ❌ 不需要 | arXiv preprint 不要求 |
| **伪代码** | ✅ 建议有 | ASM 消息处理流程、ZK 证明生成逻辑用伪代码描述即可 |
| **形式化定义** | ✅ 越好越好 | 用数学符号定义协议状态机、安全性质——这是协议论文的核心贡献 |
| **安全性分析** | ✅ 需要 | 证明 ZK 方案的性质（Zero-Knowledge、Soundness），定理 + 非正式证明即可 |
| 实现与实验 | ⬜ 可选 | 有更好，无亦可发 preprint；peer review 阶段可能被要求补充 |

### 形式化定义示例（应包含的形式）

```
定义 1（Agent 身份）：
Agent a ≜ (did_a, pk_a, VC_a)，其中：
- did_a ∈ {0,1}* 是去中心化身份标识符
- pk_a 是公钥
- VC_a = {vc_1, vc_2, ...} 是由授权者 h ∈ H 签发的可验证凭证集合

定义 2（ASM 消息）：
m ≜ (IA, CR, II)，其中：
- IA: 身份与授权舱（Identity & Authorization Capsule）
- CR: 能力与资源声明（Capability & Resource Manifesto）
- II: 交互意图与证明载荷（Interaction Intent & Proof Payload）

定理 1（隐私性 / Privacy）：
对于任意 PPT 敌手 A，在 ASM 协议下，
A 无法从 Agent 发布的 Nostr Event 中推断出其授权者 h 的真实身份，
除非以可忽略概率破解底层 ZK-SNARK 方案。

定理 2（不可伪造性 / Unforgeability）：
任意 Agent a' 无法伪造 a 的协作历史凭证，
除非控制至少 K 个独立协作伙伴的私钥。
```

### 建议标题

> *去中心化 Agent 社会网络：双网架构、授权机制与原生通信协议设计*
>
> *Decentralized Agent Social Networks: Dual-Network Architecture, Authorization Mechanisms, and Native Communication Protocol Design*

### 内容来源

- **doc03**（系统架构部分）：双网架构（人类子网 A + 社会记忆层 + Agent 子网 B）、领养/绑定授权机制
- **doc04**（协议规范部分）：ASM 消息格式、Nostr Relay + EIP-8004 + ZK 声誉的技术选型与论证

### 论文结构（建议）

1. **Introduction** — 当前多智能体通信协议的局限
2. **Background & Related Work** — Nostr、EIP-8004、ZK-SNARK、多智能体协调
3. **System Architecture** — 双网架构 + 社会记忆层 + 授权机制（形式化定义）
4. **ASM Protocol Specification** — 三区块消息格式 + 伪代码 + 状态机
5. **Security Analysis** — 隐私性、不可伪造性、抗女巫攻击、抗投机的定理与证明
6. **Use Cases** — 全球采购、婚恋匹配两个应用案例
7. **Discussion** — 工程挑战（Relay 索引、留言抵押、ZK 实时性）
8. **Conclusion** — Agent 社会网络的"HTTP 时刻"

### 投稿分类

- 主分类：`cs.DC`（分布式与并行计算）
- 交叉分类：`cs.CR`（密码学与安全）、`cs.MA`（多智能体系统）

### 工作量评估

| 任务 | 工作量 |
|------|-------|
| 形式化定义（协议状态机、消息格式） | 5-7 天 |
| 伪代码（ASM 处理流程、ZK 证明生成） | 3-5 天 |
| 安全性定理与证明 | 5-7 天 |
| Background & Related Work | 3-5 天 |
| Use Cases 形式化描述 | 2-3 天 |
| 内部 review + 修订 | 3-5 天 |
| **总计** | **约 3-4 周** |

---

## 五、两篇对比一览

| 维度 | Paper 1 | Paper 2 |
|------|---------|---------|
| **类型** | Conceptual Framework | Protocol Design |
| **核心贡献** | 三要素框架（理论） | ASM + Nostr + ZK 协议规范（系统） |
| **关键写作内容** | 文献综述 + 缺口分析 + 框架论证 | 形式化定义 + 安全性分析 + 伪代码 |
| **难度** | 中（重在文献功夫） | 中高（重在形式化能力） |
| **arXiv 主分类** | cs.AI / cs.CY | cs.DC / cs.CR |
| **工作量** | 2-3 周 | 3-4 周 |
| **数据/实验需求** | 无 | 无（建议有理论分析） |

---

## 六、时间线规划

| 节点 | 时间 | Paper 1 | Paper 2 |
|------|------|---------|---------|
| 起草 Outline | 5月底 | ⬜ | ⬜ |
| 初稿完成 | 6月初 | ⬜ | — |
| 初稿完成 | 6月中 | — | ⬜ |
| 内部 review | 6月下旬 | ⬜ | ⬜ |
| arXiv 提交 | 6月底-7月初 | ⬜ | ⬜ |
| 公开链接可引用 | 7月初 | ⬜ | ⬜ |
| **ZUAEC BP 引用** | 8月前 | ✅ | ✅ |

---

## 七、起草顺序建议

**先 Paper 1，后 Paper 2。**

理由：
1. Paper 1 结构更清晰、门槛相对低，可以先出初稿建立写作节奏
2. Paper 1 的"Future Work"部分自然引出 Paper 2 的双网实验与协议设计，两篇形成引用闭环
3. Paper 2 需要的形式化能力门槛更高，先完成 Paper 1 可以为 Paper 2 预留更充分的精力

---

## 八、行动清单

### Paper 1（理论框架）

- [ ] 检索补充 2024 年相关文献（10-15 篇，关键词：multi-agent systems, human-AI collaboration, social simulation, agent socialization）
- [ ] 起草 Outline（章节标题、每章核心论点）
- [ ] 撰写 Introduction 和 Conclusion
- [ ] 将三要素框架部分形式化（定义、命题、必要假设）
- [ ] 完成初稿（建议 12000-15000 字）
- [ ] 内部 review（请 1-2 位领域研究者过目）
- [ ] arXiv 提交（cs.AI 主分类）

### Paper 2（协议设计）

- [ ] 编写 ASM 消息格式的形式化定义（含状态机图）
- [ ] 编写双网架构的形式化模型
- [ ] 撰写关键算法伪代码（ZK 证明生成、Nostr 消息发布与检索、信誉证明）
- [ ] 撰写安全性定理与证明（隐私性、不可伪造性、抗女巫、抗投机）
- [ ] Background & Related Work 章节
- [ ] 完成初稿（建议 10000-12000 字）
- [ ] 内部 review
- [ ] arXiv 提交（cs.DC 主分类）

---

## 九、风险与备选方案

### 风险

1. **时间紧张**：若 7 月前完不成两篇，至少应优先完成 Paper 1，确保有一篇可在 BP 中引用
2. **形式化能力**：Paper 2 的安全性证明对密码学背景要求较高，可能需要外部协作者
3. **文献检索**：2024 年文献补充工作量可能被低估，建议提前 1 周开始

### 备选方案

- **方案 A（推荐）**：两篇都完成，同时提交 arXiv
- **方案 B（保守）**：只完成 Paper 1，Paper 2 作为 Working Paper 在 BP 中以"in preparation"标注
- **方案 C（最简）**：合并为一篇综合性论文（约 18000-20000 字），但论点容易稀释，不推荐
