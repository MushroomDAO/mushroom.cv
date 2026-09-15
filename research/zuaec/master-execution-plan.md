# 主执行计划：Paper 1 + Paper 2 + Mycelium Protocol 协同推进

> **创建日期**：2026-05-20
> **目标**：在 2026 年 8 月 31 日（ZUAEC 报名截止）前，完成 Paper 1 arXiv 提交 + Paper 2 初稿 + Mycelium Protocol 主网部署
> **总时长**：~~14 周~~ → **修订为 9 周**（2026-05-20 → 2026-07-22），基于 7-8 小时/天（≈50 小时/周）投入重新标定
> **审阅者**：导师（学术判断）+ Codex（结构性反馈）— 不需要额外外部审阅者
> **投稿路径**：Plan A 为主（arXiv → AAMAS/ICDCS → Journal），Plan B/C 备用仅在 A 被拒时触发
> **关键约束**：ZK 由作者自行实现（不需要密码学合作者）；ZUAEC 报名截止时 BP 中可引用 arXiv 论文链接

---

## 一、文献检索策略（Literature Retrieval Strategy）

### 1.1 关键词矩阵

按主题分 7 组，每组优先级标注：

#### Group A：AI Agent 核心（必读）

| 关键词 | 备注 |
|--------|------|
| `"AI agent"` + `"evolution"` | 核心主题 |
| `"LLM agent"` + `"emergence"` | Emergence + LLM Agent |
| `"autonomous agent"` + `"society"` | Agent 社会化 |
| `"agentic AI"` + `"intelligence explosion"` | 与 Evans 等对话 |
| `"multi-agent system"` + `"socialization"` | 与 Li et al. 2026 对话 |

#### Group B：人机协作（必读）

| 关键词 | 备注 |
|--------|------|
| `"human-AI collaboration"` + `"hybrid society"` | 与 Chakraborty 对话 |
| `"human-AI co-evolution"` | 共演化理论 |
| `"centaur"` + `"hybrid actor"` | Evans 等的术语 |
| `"AI as colleague"` | Quan et al. 2026 |
| `"governance"` + `"AI agents"` | 治理维度 |

#### Group C：机机协作（必读）

| 关键词 | 备注 |
|--------|------|
| `"multi-agent simulation"` | Moltbook, Smallville |
| `"agent altruism"` + `"emergence"` | Li et al. 2025 |
| `"agent collusion"` + `"emergent risks"` | Huang et al. 2026 |
| `"generative agents"` | Park et al. 2023 |
| `"open-ended co-evolution"` + `"LLM"` | Chen et al. 2025 |

#### Group D：能力进化（重要）

| 关键词 | 备注 |
|--------|------|
| `"ReAct"` + `"reasoning"` | LLM Agent 起点 |
| `"self-evolving"` + `"LLM agent"` | EvolveR 等 |
| `"tool use"` + `"LLM"` | 工具使用范式 |
| `"AutoGPT"` OR `"AutoGen"` OR `"MetaGPT"` | 多智能体框架 |
| `"agent benchmark"` | AgentBench 等 |

#### Group E：社会科学经典（必读）

| 关键词 | 备注 |
|--------|------|
| `"social capital"` + `"Bourdieu" OR "Putnam"` | 社会资本理论 |
| `"institutional embedding"` | 制度嵌入 |
| `"commons governance"` + `"Ostrom"` | 公地治理 |
| `"man-computer symbiosis" Licklider` | 人机协作奠基 |
| `"evolution of cooperation" Axelrod OR Nowak` | 演化博弈 |

#### Group F：协议与通信（Paper 2 重点）

| 关键词 | 备注 |
|--------|------|
| `"FIPA ACL"` + `"agent communication"` | 经典协议 |
| `"Model Context Protocol"` MCP | Anthropic MCP |
| `"DIDComm"` + `"agent messaging"` | 去中心化通信 |
| `"Nostr"` + `"protocol"` | Nostr 规范 |
| `"agent communication language"` | 通信语言综述 |

#### Group G：身份与声誉（Paper 2 重点）

| 关键词 | 备注 |
|--------|------|
| `"decentralized identifier"` DID | W3C DID |
| `"verifiable credentials"` VC | W3C VC |
| `"EIP-8004"` OR `"agent NFT identity"` | 链上 Agent 身份 |
| `"zero-knowledge"` + `"reputation"` | ZK 声誉 |
| `"BBS+ signature"` | BBS+ |
| `"cryptographic accumulator"` | 累加器 |

### 1.2 检索数据库与目标数量

| 数据库 | 用途 | 每个关键词获取 | 总目标 |
|--------|------|-------------|-------|
| **arXiv** (cs.AI, cs.CY, cs.MA, cs.MAS, cs.DC, cs.CR) | 主战场 | top 30 by relevance | ~500 候选 |
| **Google Scholar** | 引用追踪 + 经典文献 | top 50 by citations | ~200 候选 |
| **ACM Digital Library** | CHI / CSCW / UIST | top 20 | ~100 候选 |
| **IEEE Xplore** | IEEE 会议 | top 20 | ~100 候选 |
| **DBLP** | 作者追踪 | 关键作者历年发表 | ~50 候选 |

**总候选库目标：~800-1000 篇**

### 1.3 三层筛选漏斗（Pipeline）

```
Layer 0：原始候选库（800-1000 篇）
  ↓ 标题筛选（按 I1-I4 / E1-E4 criteria）
Layer 1：标题入围（~150-200 篇）
  ↓ 摘要筛选
Layer 2：摘要入围（~80-100 篇）
  ↓ 全文阅读
Layer 3：纳入 Paper 1 scoping review（30-50 篇）
  ↓ 深度引用
Layer 4：核心引用文献（25-35 篇，写入 References）
```

### 1.4 每日工作量（Daily Quota）

> **修订后节奏：7-8 小时/天，约 50 小时/周**

| 阶段 | 标题筛选 | 摘要阅读 | 全文阅读 | 深度笔记 |
|------|---------|---------|---------|---------|
| Phase 1 密集采集（3-4天）| 150-200/day | 40/day | 3/day | 2/day |
| Phase 1 消化（3-4天）| 50/day | 20/day | 5/day | 3/day |

**7-8 小时/天对应能力：每周文献检索约 50-60 篇全文阅读；写作日 3,000-5,000 词**

### 1.5 笔记模板（每篇全文阅读后产出）

```markdown
# [Author Year] Short Title

**Citation**: <BibTeX 或完整引用>
**arXiv/DOI**: <link>
**Cluster**: Replacement / Human-AI / Machine-Machine / Methodology / Sociology
**Status**: Read / In progress / Skim only

## Core claim (一句话)

## Methodology (论文用什么方法得出结论)

## Key findings (3-5 条)

## Relation to our framework
- Supports/Refutes which proposition (P1-P5)?
- Cites in our §X
- Quote-worthy passages

## Limitations (作者的或我们的批评)

## Action items
- [ ] Cite in Paper 1 §X
- [ ] Verify data point X
- [ ] Use Y as comparison baseline
```

---

## 二、整体阶段拆解（Phase Decomposition）

### Phase 0：决策与对齐周（Week 1: 2026-05-20 → 2026-05-21） ✅ COMPLETE

**目标**：所有关键决策定稿，进入执行模式

| 子任务 | 责任 | 输入 | 输出 | 工时 |
|-------|------|------|------|------|
| Jason 完成 7 份文档 review（顺序见 user-review-queue.md）| Jason | 全部规划文档 | review 反馈表 | 4-6 小时 |
| 确认 Paper 1/2 创新点 one-liner | Jason | paper-innovation-points.md | 定稿 one-liner | 30 分钟 |
| 确认 agent-network-architecture.md 中 6 个 review 问题 | Jason | architecture.md §10 | 6 条决策 | 1 小时 |
| Codex review Paper 1 v0 + Paper 2 v0 | Claude | 两份初稿 | review 报告（2 份） | 自动 |
| 整合 Codex 反馈生成修订项清单 | Claude | Codex review 报告 | revision items list | 自动 |

**关键决策点**：
- ✅ Scoping Review 路径锁定
- ✅ Paper 2 不投 cs.CR，主投 cs.DC
- ✅ ZK 由作者自行实现
- ⬜ 论文 one-liner 最终措辞
- ⬜ 系统架构 v0 中 6 个待定问题
- ⬜ Codex review 反馈是否全部采纳

### Phase 1：文献密集检索（Week 2: 2026-05-21 → 2026-05-28）🟡 IN PROGRESS

**目标**：完成 800 候选库 → 100 摘要入围 → 30-50 全文阅读

| 子任务 | 责任 | 输入 | 输出 | 工时 |
|-------|------|------|------|------|
| arXiv API 检索（Group A-E）| Jason | 关键词矩阵 §1.1 | 800 篇候选 metadata | 5 小时 |
| Google Scholar 引用追踪 | Jason | Group A-E 关键文献的引用网络 | 200 篇补充 | 4 小时 |
| 标题筛选（Layer 0 → Layer 1）| Jason | 1000 篇候选 | 150-200 篇入围 | 8 小时 |
| 摘要阅读（Layer 1 → Layer 2）| Jason | 150-200 篇 | 80-100 篇入围 + 摘要笔记 | 12 小时 |
| 全文阅读优先排序 | Jason + Claude | 80-100 篇 + 框架相关性 | 30-50 篇优先级清单 | 2 小时 |
| 全文阅读 + 笔记（5 篇/天 × 6 天）| Jason | 30-50 篇 | 30-50 份阅读笔记 | 25 小时 |

**Phase 1 输出**：
- `paper1-literature-screen.md`：完整筛选流程记录（PRISMA-ScR 流程图）
- `paper1-reading-notes/`：30-50 个独立笔记文件（按 §1.5 模板）
- `paper1-bibliography.md` 更新：每条引用核实状态升级

### Phase 2：Paper 1 v1 撰写（Week 3-4: 2026-05-29 → 2026-06-11）

**目标**：基于阅读笔记，从 v0 升级到 v1（所有 [TODO] 消除，引用核实）

| 子任务 | 责任 | 输入 | 输出 | 工时 |
|-------|------|------|------|------|
| §3 PRISMA-ScR 方法论补完（含流程图 N 值）| Claude | 筛选记录 | §3 v1 | 2 小时 |
| §4 三集群综述深化（每集群引用 8-12 篇）| Claude + Jason | 阅读笔记 | §4 v1 | 8 小时 |
| §5 结构性缺口论证强化 | Claude | 阅读笔记 + 框架逻辑 | §5 v1 | 4 小时 |
| §6 三要素框架与经典文献对接 | Claude | Bourdieu/Putnam/Ostrom 笔记 | §6 v1 | 6 小时 |
| §7 P1-P5 命题与文献证据对应表 | Claude + Jason | 全部笔记 | §7 v1 | 4 小时 |
| §8 Mycelium 案例完善（部署 status）| Claude | 项目进度 | §8 v1 | 2 小时 |
| §10 Research Agenda 5 个方向定稿 | Claude + Jason | 全部内容 | §10 v1 | 3 小时 |
| Abstract 与 Introduction 重写 | Claude | one-liner + 全文 | v1 abstract | 2 小时 |
| References 完整化（Tex/BibTeX 格式）| Claude | 阅读笔记 | references.bib | 4 小时 |
| 一致性检查（命题与综述的引用对应）| Jason | v1 全文 | 一致性 checklist | 2 小时 |

**Phase 2 输出**：`paper1-draft-v1.md`（~12000-15000 词，无 [TODO]）

### Phase 3：Paper 1 internal review + 修订（Week 5: 2026-06-12 → 2026-06-18）

**目标**：Paper 1 v1 → v2（提交 arXiv 前的版本）

| 子任务 | 责任 | 输入 | 输出 | 工时 |
|-------|------|------|------|------|
| Codex review Paper 1 v1 | Claude | v1 | review 报告 | 自动 |
| 内部审阅者邀请 + 反馈收集 | Jason | v1 | 2-3 份外部反馈 | 协调时间 |
| 综合反馈修订 | Claude + Jason | review 反馈 | v2 | 8 小时 |
| 英文润色（如需要）| Claude | v2 | v2 polished | 6 小时 |
| LaTeX 排版（arXiv 模板）| Claude | v2 | tex/pdf | 4 小时 |

**关键决策点**：
- ⬜ 是否邀请外部审阅者
- ⬜ 是否需要英文 native speaker 润色

### Phase 4：Paper 1 arXiv 提交（Week 6: 2026-06-19 → 2026-06-25）

**目标**：Paper 1 上线 arXiv，获得 arXiv ID

| 子任务 | 责任 | 输入 | 输出 | 工时 |
|-------|------|------|------|------|
| arXiv 账户与 endorsement（如首次提交）| Jason | — | arXiv 账户 | 1 小时（含 endorsement 等待）|
| 上传 + metadata 填写 | Jason | tex/pdf | arXiv submission | 2 小时 |
| arXiv 公开后 announce（个人主页/Twitter/微信）| Jason | arXiv ID | 学术圈通知 | 1 小时 |

**Phase 4 输出**：Paper 1 arXiv ID（如 `arXiv:2607.XXXXX`），可立即用于 ZUAEC BP

### Phase 5：Paper 2 v1 撰写（Week 7-8: 2026-06-26 → 2026-07-09）

**目标**：基于 Paper 1 锁定的框架 + Mycelium 部署进度，完成 Paper 2 v1

| 子任务 | 责任 | 输入 | 输出 | 工时 |
|-------|------|------|------|------|
| §2 Related Work 深化（FIPA ACL/MCP/DIDComm 全文阅读）| Jason + Claude | Group F-G 关键词检索 | §2 v1 | 8 小时 |
| §3 双网模型形式化加固 | Claude | architecture.md | §3 v1 | 4 小时 |
| §4 ASM 协议规范完整化（BNF 完整 + FSM 图）| Claude | v0 + 实现讨论 | §4 v1 | 8 小时 |
| §5 隐私保护声誉系统（含 ZK 工程实现讨论）| Jason + Claude | ZK 选型决策 | §5 v1 | 6 小时 |
| §6 Security Analysis 完整化（含每种攻击的详细分析）| Claude + Jason | 8 类攻击者模型 | §6 v1 | 8 小时 |
| §7 Mycelium 部署案例（基于真实测试网/主网数据）| Jason | 部署进度 | §7 v1 + 初步性能数据 | 6 小时 |
| References 完整化 | Claude | Group F-G 笔记 | references.bib | 4 小时 |

**Phase 5 输出**：`paper2-draft-v1.md`（~10000-12000 词）

### Phase 6：Mycelium 主网部署 + 数据采集（并行，贯穿 Week 5-12）

**这是 Paper 2 最重要的支撑工作。** 真实部署数据将作为 §7 核心证据。

| 子任务 | 责任 | 时间 |
|-------|------|------|
| 主网部署计划执行（docs/mainnet-launch/）| Jason 团队 | Week 5-7 |
| ASM Codec MVP 实现 | Jason 团队 | Week 7-9 |
| Nostr Relay 集成测试 | Jason 团队 | Week 8-10 |
| ZK Proof MVP（Groth16）| Jason | Week 9-11 |
| 2 个 demo Agent（转写 + 摘要）跑通 | Jason 团队 | Week 10-12 |
| 性能数据采集（discovery 延迟 / ZK 生成时间 / 消息大小）| Jason 团队 | Week 11-12 |

### Phase 7：Paper 2 review + arXiv 提交（Week 9: 2026-07-10 → 2026-07-22）

**目标**：Paper 2 v1 → v2 → arXiv，赶在 ZUAEC 8/31 报名截止前

| 子任务 | 责任 | 工时 |
|-------|------|------|
| Codex review Paper 2 v1 | Claude | 自动 |
| 内部反馈整合 → v2 | Claude + Jason | 8 小时 |
| 英文润色 | Claude | 6 小时 |
| LaTeX 排版 | Claude | 4 小时 |
| arXiv 提交 | Jason | 2 小时 |

### Phase 8：ZUAEC BP 整合（Week 14 同时进行）

| 子任务 | 责任 | 工时 |
|-------|------|------|
| BP 中引用 Paper 1 + Paper 2 arXiv ID | Jason | 2 小时 |
| BP 中加入"理论+协议+实现三件套"叙事 | Jason | 4 小时 |
| 提交浙大校友身份认证（如未完成）| Jason | 2 小时 |
| 在 zuaec.zju.edu.cn 完成报名 | Jason | 1 小时 |

---

## 三、分工说明（Division of Labor）

### Jason 必须亲自做的（不可委托）

| 类别 | 任务 | 理由 |
|------|------|------|
| 决策 | 所有"⬜ 关键决策点"标注的事项 | 涉及战略方向 |
| 学术诚信 | 文献核实（每条引用必须人工验证）| AI 不能验证 hallucination |
| 工程实现 | Mycelium 主网部署 + ZK MVP | 项目核心代码 |
| 学术诚信 | 论文最终 sign-off | 作者署名责任 |
| 关系建立 | 内部审阅者邀请 + 外部合作者沟通 | 人际关系 |
| 学术 ID | arXiv 账户 + endorsement | 学术身份 |

### Claude 可以承担的

| 类别 | 任务 |
|------|------|
| 写作 | 所有论文章节初稿 + 修订 + 英文润色 |
| 文献处理 | 摘要总结 + 笔记模板填充 + BibTeX 格式化 |
| 形式化 | 数学定义 + 状态机 + BNF 语法 |
| 一致性检查 | 命题与综述对应关系 + 引用核对 |
| 文档管理 | 各阶段 deliverable 生成 + README 更新 |
| 排版 | LaTeX 模板填充 + arXiv 元数据准备 |
| 第三方 review 触发 | Codex review 调度 |

### 协作模式（Jason + Claude）

| 任务 | 协作方式 |
|------|---------|
| 论文章节修订 | Jason 提出修订方向 → Claude 实现 → Jason 验证 |
| 框架打磨 | Jason 提出反思 → Claude 形式化 → Jason 审阅 |
| 文献筛选 | Jason 标题筛选 → Claude 协助摘要总结 → Jason 决定全文阅读 |
| 工程对接 | Jason 提供实现进度 → Claude 更新论文 §7/§8 |

---

## 四、关键里程碑（Milestones）与风险

### 里程碑

| 日期 | 里程碑 | 检验标准 |
|------|--------|---------|
| 2026-05-27 | Phase 0 完成 | 所有决策定稿，Codex review 完成 |
| 2026-06-09 | Phase 1 完成 | 30-50 篇全文阅读 + 笔记 |
| 2026-06-23 | Paper 1 v1 完成 | 无 [TODO]，~12000 词 |
| 2026-06-30 | Paper 1 v2 完成 | 内部 review 整合 |
| 2026-07-07 | **Paper 1 上线 arXiv** | 获得 arXiv ID |
| 2026-07-21 | Paper 2 v1 完成 | 无 [TODO]，~10000 词 |
| 2026-08-12 | Mycelium 主网核心功能上线 | OP mainnet 可访问 |
| 2026-08-25 | Paper 2 v2 完成 | 含真实部署数据 |
| **2026-08-31** | **Paper 2 上线 arXiv + ZUAEC 报名完成** | 报名截止前完成 |

### 风险清单

| 风险 | 等级 | 缓解 |
|------|------|------|
| 文献检索耗时超预期 | 高 | 严格执行每日 quota；保留 1 周 buffer |
| Mycelium 主网部署延期 | 中 | Paper 2 §7 可降级为测试网数据 + 主网计划 |
| Codex review 反馈大幅修订 | 中 | 各 Phase 留 30% 修订 buffer |
| 个人精力不足 | 高 | 必要时砍 Paper 2 范围，先保 Paper 1 |
| arXiv endorsement 延迟 | 中 | Phase 0 即提交 endorsement 请求 |
| ZK 工程实现遇阻 | 中 | 降为 trusted setup 版本 + 标记 future work |

### 应急预案

如果 6 月底 Paper 1 v1 仍未完成：
- 砍掉 Paper 2 内部细节工作，全力推 Paper 1
- 把 Paper 2 标为 "in preparation" 在 BP 中提及

如果 Mycelium 主网 8 月仍未上线：
- Paper 2 §7 用 Sepolia 测试网数据
- 在 §7.5 明确"主网部署计划中"

---

## 五、每周节奏建议（Weekly Rhythm）

| 时间块 | 任务 |
|-------|------|
| 周一 上午 | 计划周任务 + 与 Claude 对齐 |
| 周一-周五 上午 | 文献阅读 / 论文修订（5 小时/天） |
| 周一-周五 下午 | Mycelium 项目代码（按团队节奏） |
| 周六 上午 | 周 review + Claude 同步进度 |
| 周六 下午 | 自由探索 / 与外部审阅者沟通 |
| 周日 | 休息 / 准备下周 |

---

## 六、输入输出汇总表

| 阶段 | 主要输入 | 主要输出 | 决策点 |
|------|---------|---------|--------|
| Phase 0 | 当前所有规划文档 | Jason review 反馈 + Codex review 报告 | 7 项决策 |
| Phase 1 | 关键词矩阵 | 30-50 篇全文笔记 + PRISMA-ScR 流程图 | 笔记纳入 Paper 1 与否 |
| Phase 2 | 阅读笔记 | Paper 1 v1（无 [TODO]） | 章节结构调整 |
| Phase 3 | v1 + 反馈 | Paper 1 v2 + LaTeX | 是否外部 review |
| Phase 4 | v2 | arXiv 提交 | metadata 选择 |
| Phase 5 | Paper 1 + 部署进度 | Paper 2 v1 | 是否含真实数据 |
| Phase 6 | 工程进度 | 部署数据 | 主网 vs 测试网 |
| Phase 7 | v1 + 反馈 | Paper 2 v2 + arXiv | metadata 选择 |
| Phase 8 | arXiv 链接 | ZUAEC BP + 报名 | BP 措辞 |

---

## 七、与 ZUAEC 评审的协同

ZUAEC 8th 评审标准（推测）：
- 技术创新性：✅ Paper 1/2 + Mycelium 三件套
- 学术影响力：✅ arXiv preprint + 目标顶会（AAMAS/ICDCS）
- 商业前景：✅ Agent 工具公共物品 + Token 经济
- 团队执行力：✅ Sepolia 已部署 + 主网计划

**BP 关键叙事**：
> "我们不是仅有想法，而是同时有 (1) 学术论文 [arXiv links]，(2) 协议规范 [arXiv link]，(3) 公链 reference implementation。这是 ZUAEC 历届罕见的'理论+规范+实现'完整闭环。"

---

## 八、配套文档（在本目录下）

| 文档 | 作用 |
|------|------|
| [paper-innovation-points.md](paper-innovation-points.md) | one-liner 创新点 |
| [user-review-queue.md](user-review-queue.md) | Jason 需 review 的文档队列 |
| [paper-submission-plan-v2.md](paper-submission-plan-v2.md) | 论文规划主文档 |
| [paper-revision-status.md](paper-revision-status.md) | v2 plan 落实情况 |
| [paper1-draft-v0.md](paper1-draft-v0.md) | Paper 1 初稿 |
| [paper2-draft-v0.md](paper2-draft-v0.md) | Paper 2 初稿 |
| [paper1-bibliography.md](paper1-bibliography.md) | 文献核查清单 |
| [paper1-framework-logic.md](paper1-framework-logic.md) | 框架逻辑映射 |
| [agent-network-architecture.md](agent-network-architecture.md) | 工程系统架构 |
| [target-venues.md](target-venues.md) | 投稿目标刊物 |
