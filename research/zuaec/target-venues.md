# 目标投稿刊物清单（Target Venues）

> **创建日期**：2026-05-20
> **目的**：为 Paper 1（理论框架）与 Paper 2（协议设计+实现）确定有学术地位的投稿目标
> **决策约束**：
> - 不投密码学顶会（用户决定 ZK 作为工程实现）
> - 时间窗口：2026 年 7-8 月 arXiv 预印 → 后续 2026 Q4 / 2027 Q1 正式投稿
> - 需要兼顾学术影响力与中文圈认可度（ZUAEC 评审）

---

## 一、Paper 1 候选刊物（Conceptual Framework + Scoping Review）

主题：AI Agent 进化方向、人机协作框架、计算社会科学
arXiv 主分类：cs.AI，交叉：cs.CY、cs.MA

### 1.1 顶级会议（A+）

| Venue | 类型 | 影响力 | 适配度 | 投稿周期 | 备注 |
|-------|------|-------|-------|---------|------|
| **AAAI** | 综合 AI 顶会 | CCF-A / CORE-A* | ⭐⭐⭐⭐⭐ | 摘要 8 月，全文 9 月 → 2 月通知 | 接受 Position Paper track；CCF 推荐顶会 |
| **IJCAI** | 综合 AI 顶会 | CCF-A / CORE-A* | ⭐⭐⭐⭐ | 通常 1 月截稿 → 4 月通知 | 与 AAAI 等级相当，IJCAI 偏理论 |
| **AAMAS** | 多智能体顶会 | CCF-B / CORE-A | ⭐⭐⭐⭐⭐ | 10 月截稿 → 1 月通知 | **最匹配 venue**——多智能体核心 |
| **NeurIPS** | 机器学习顶会 | CCF-A / CORE-A* | ⭐⭐⭐ | 5 月截稿 → 9 月通知 | 偏经验性论文，理论框架接受度较低 |

### 1.2 顶级期刊（A）

| Venue | 类型 | 影响力 | 适配度 | 投稿周期 | 备注 |
|-------|------|-------|-------|---------|------|
| **JAIR** (Journal of AI Research) | 开放期刊 | CCF-B（实际声誉高于此）| ⭐⭐⭐⭐ | rolling submission | 接受综述与框架论文；OA 免费 |
| **ACM Computing Surveys (CSUR)** | 综述顶刊 | CCF-A | ⭐⭐⭐⭐⭐ | rolling | **Scoping Review 最佳归宿**；IF 23.8 |
| **AI Magazine** | AAAI 旗下 | — | ⭐⭐⭐ | rolling | 偏综述、立场文章；学术地位较 JAIR 弱 |
| **Frontiers of Computer Science** | 综合 CS | CCF-B | ⭐⭐⭐ | rolling | **中文圈认可度高**（中国 CS 学会推荐）|

### 1.3 跨学科与社会科学相关

| Venue | 类型 | 影响力 | 适配度 | 备注 |
|-------|------|-------|-------|------|
| **AI & Society** (Springer) | 跨学科期刊 | SCI/SSCI | ⭐⭐⭐⭐ | 适合"AI 社会影响"主题；IF 3.0+ |
| **PNAS** (Nexus) | 跨学科顶刊 | 顶级 | ⭐⭐ | 难度高，需要更强实证 |
| **Patterns** (Cell Press) | 数据科学 | SCI | ⭐⭐⭐ | 适合 data/insight oriented 综述 |
| **CHI** (Computer-Human Interaction) | HCI 顶会 | CCF-A | ⭐⭐⭐ | 偏 HCI 视角；与你的协作主题部分相关 |
| **CSCW** | 协作系统顶会 | CCF-A | ⭐⭐⭐⭐ | **Computer-Supported Cooperative Work**——非常匹配；CCF-A 顶会 |

### 1.4 推荐策略

**Plan A（推荐）**：
1. **第一步**：2026 年 7-8 月提交 arXiv（cs.AI + cs.CY + cs.MA）
2. **第二步**：根据反响选择正式投稿目标：
   - 若 arXiv 引用反响好 → **AAMAS** 或 **CSCW**（两者都很匹配，截稿期不同可错峰）
   - 若想快速发表 → **JAIR**（rolling，预估 6-12 个月）
   - 若想顶刊 → **ACM Computing Surveys**（Scoping Review 是 CSUR 的核心 review type）

**Plan B（保守）**：直接投 **Frontiers of Computer Science**（中文 CS 学会推荐 + rolling submission + 6 个月内通常有决定）

**Plan C（激进）**：投 **AAAI 2027** Position Paper Track（如果 8 月前完成）

---

## 二、Paper 2 候选刊物（Protocol Design + Implementation + Data）

主题：去中心化 Agent 通信协议、ZK 凭证、Nostr+EIP-8004
arXiv 主分类：cs.DC，交叉：cs.MA、cs.SE

### 2.1 顶级系统会议（A+）

| Venue | 类型 | 影响力 | 适配度 | 投稿周期 | 备注 |
|-------|------|-------|-------|---------|------|
| **NSDI** (USENIX) | 网络系统顶会 | CCF-A / CORE-A* | ⭐⭐⭐⭐ | 9 月截稿 / 5 月截稿（两轮）| **要求实证数据**——需 Mycelium 部署数据 |
| **SOSP/OSDI** | 操作系统顶会 | CCF-A / CORE-A* | ⭐⭐ | 5 月截稿 | 难度高；系统类论文金标准 |
| **EuroSys** | 系统会议 | CCF-B / CORE-A | ⭐⭐⭐⭐ | 11 月截稿 | 偏欧洲；接受新协议设计 |
| **ICDCS** (IEEE) | 分布式系统顶会 | CCF-B / CORE-A | ⭐⭐⭐⭐⭐ | 12 月截稿 → 3 月通知 | **非常匹配**——分布式系统协议设计典型 venue |

### 2.2 区块链 / Web3 类会议（B+）

| Venue | 类型 | 影响力 | 适配度 | 备注 |
|-------|------|-------|-------|------|
| **IEEE ICBC** (Int'l Conf on Blockchain) | 区块链 | 区块链领域顶会 | ⭐⭐⭐⭐⭐ | 7 月截稿 → 11 月通知；**与 Mycelium 实现高度匹配** |
| **AFT** (Advances in Financial Technologies) | 金融科技 | ACM | ⭐⭐⭐⭐ | 8 月截稿；适合代币经济学 |
| **DAPPS** (IEEE Decentralized Applications) | 去中心化应用 | IEEE | ⭐⭐⭐⭐ | 3 月截稿；**新兴 venue，竞争小，匹配度高** |
| **FC** (Financial Cryptography) | 金融密码学 | CCF-C | ⭐⭐⭐ | 偏密码学，但我们不强调 |
| **Middleware** (ACM/IFIP) | 中间件 | CCF-B | ⭐⭐⭐⭐ | 5 月截稿；适合 Agent 通信中间件 |

### 2.3 多智能体相关

| Venue | 类型 | 影响力 | 适配度 | 备注 |
|-------|------|-------|-------|------|
| **AAMAS** | 多智能体顶会 | CCF-B / CORE-A | ⭐⭐⭐⭐⭐ | **可与 Paper 1 同投不同 track**；10 月截稿 |
| **AAMAS Workshop on Engineering Multi-Agent Systems (EMAS)** | Workshop | — | ⭐⭐⭐⭐ | 门槛低，适合协议规范初稿 |

### 2.4 期刊

| Venue | 类型 | 影响力 | 适配度 | 备注 |
|-------|------|-------|-------|------|
| **IEEE TPDS** (Transactions on Parallel and Distributed Systems) | 分布式系统顶刊 | CCF-A / SCI | ⭐⭐⭐⭐ | 适合系统协议设计；IF 5.6 |
| **ACM TWEB** (Transactions on the Web) | Web 系统 | CCF-B / SCI | ⭐⭐⭐ | 适合"Agent 协作网络"主题 |
| **ACM TOIT** (Transactions on Internet Technology) | 互联网技术 | CCF-B / SCI | ⭐⭐⭐ | 适合协议规范 |
| **Future Generation Computer Systems** | 未来计算 | SCI | ⭐⭐⭐⭐ | IF 7.5+；接受 Agent + Blockchain 主题 |

### 2.5 推荐策略

**Plan A（推荐 — 双向投稿）**：
1. **第一步**：2026 Q4 提交 arXiv（cs.DC + cs.MA）
2. **第二步**：根据 Mycelium 主网部署进度：
   - 若有 3 个月以上真实运行数据 → **ICDCS 2027** 或 **NSDI 2027 Fall**
   - 若数据较少 → **IEEE ICBC 2027** 或 **DAPPS 2027**
3. **第三步**：扩展版本投期刊 **IEEE TPDS** 或 **Future Generation Computer Systems**

**Plan B（保守）**：直接投 **DAPPS 2027**（新兴 venue，竞争小，匹配度高）

**Plan C（激进）**：等数据充分后投 **NSDI 2027** 或 **SOSP 2027**

---

## 三、投稿路径推荐总结

### 3.1 短期（2026 Q3 - 2026 Q4）

| 论文 | 行动 | 时间 |
|------|------|------|
| Paper 1 | 提交 arXiv（cs.AI 主） | **2026 年 7-8 月** |
| Paper 2 | 提交 arXiv（cs.DC 主） | **2026 年 9-10 月** |

arXiv 提交后即可用于 ZUAEC BP 引用（"已发表为 arXiv preprint"）。

### 3.2 中期（2026 Q4 - 2027 Q2）

| 论文 | 主推 venue | 备选 |
|------|-----------|------|
| Paper 1 | **AAMAS 2027** 或 **CSCW 2027** | JAIR / Frontiers of CS |
| Paper 2 | **ICDCS 2027** 或 **IEEE ICBC 2027** | DAPPS 2027 / EMAS 2027 |

### 3.3 长期（2027 Q3 - 2028）

期刊扩展版本：
- Paper 1 期刊版 → **ACM Computing Surveys**（scoping review 升级）或 **AI & Society**
- Paper 2 期刊版 → **IEEE TPDS** 或 **Future Generation Computer Systems**

---

## 四、特别建议：与 ZUAEC 评审的协同

ZUAEC 评审看重学术地位 + 工程落地 + 商业前景三者结合。建议在 BP 中：

1. 明确列出**已提交 arXiv 的两篇论文**（提供 arXiv ID）
2. 提及**目标投稿期刊 / 会议**（即便未发表，也显示学术规划）：
   - "Paper 1 计划投稿 ACM Computing Surveys 或 AAMAS 2027"
   - "Paper 2 计划投稿 ICDCS 2027 或 IEEE ICBC 2027"
3. 强调三者的协同：
   - **Paper 1** 提供理论框架（Three Pillars）
   - **Paper 2** 提供协议规范（ASM Protocol）
   - **Mycelium Protocol** 提供工程实现（已在主网部署）

这种"理论 + 规范 + 实现"三件套是其他参赛项目难以企及的优势。

---

## 五、投稿前必备 checklist

| 任务 | Paper 1 | Paper 2 |
|------|---------|---------|
| 完成所有 [TODO: verify] 引用核实 | ⬜ | ⬜ |
| PRISMA-ScR 流程图（实际 N 值）| ⬜ | — |
| Mycelium 主网部署完成 | — | ⬜（强烈推荐）|
| 基础性能数据采集 | — | ⬜ |
| Codex review v2 完成 | ⬜ | ⬜ |
| 内部 reviewer 反馈 1 轮 | ⬜ | ⬜ |
| 英文润色 | ⬜ | ⬜ |
| LaTeX 排版（如目标 venue 要求）| ⬜ | ⬜ |
| 利益冲突声明 | ⬜ | ⬜ |
| Author contributions 声明 | ⬜ | ⬜ |
| 数据 / 代码 availability 声明 | ⬜ | ⬜ |

---

## 六、关键日期参考（2026 - 2027 投稿截止）

| Venue | 2027 截稿 | 通知 |
|-------|---------|------|
| AAAI 2027 | 2026 年 8 月（摘要）/ 9 月（全文） | 2027 年 1-2 月 |
| IJCAI 2027 | 2027 年 1 月 | 2027 年 4 月 |
| AAMAS 2027 | 2026 年 10 月 | 2027 年 1 月 |
| CSCW 2027 | 2026 年 4 月（Round 1）/ 11 月（Round 2）| 6-7 个月后 |
| ICDCS 2027 | 2026 年 12 月 | 2027 年 3 月 |
| IEEE ICBC 2027 | 2027 年 1 月 | 2027 年 4 月 |
| DAPPS 2027 | 2026 年 12 月 ~ 2027 年 1 月 | 2027 年 3 月 |
| NSDI 2027 Fall | 2027 年 5 月 | 2027 年 9 月 |
| Middleware 2027 | 2026 年 5 月 | 2026 年 9 月 |

**注**：具体日期以各 venue 官网 CfP 为准。建议在 7 月前完成 arXiv 提交，以便后续按 venue 截稿期灵活选择。

---

*配套文档：[paper-submission-plan-v2.md](paper-submission-plan-v2.md) · [paper-revision-status.md](paper-revision-status.md)*
