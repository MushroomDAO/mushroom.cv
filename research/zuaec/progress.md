# Progress — ZUAEC 论文写作进度

> **最近更新**：2026-05-22（夜间大批次完成）
> **目标（双轨并行）**：
> 1. **研究轨**：2026-08-31 前完成 Paper 1 + Paper 2 arXiv 提交 + ZUAEC 报名
> 2. **开发轨（先行 & 并行）**：Mycelium 产品开发实际早于两篇 paper 已经在进行；论文是对正在进行的研究与设计的形式化沉淀。最终目标除报名参赛外，还要在 2026-08-31 前让相关开发产品**至少完成 2 轮迭代**、在线上达到"基础可用"（满足基本使用）。
> 注：写 paper 与做产品是同一件事的两面——配 PR / 配 per 的过程即研究与设计；研究稳定后提交 paper 草稿时，开发已并行展开。

---

## 当前状态速览

| 项目 | 状态 |
|------|------|
| 整体阶段 | **Phase 1：文献密集检索**（2026-05-21 → 2026-05-28）|
| Paper 1 初稿 | ✅ v0 完成（`paper1-draft-v0.md`）|
| Paper 2 初稿 | ✅ v0 完成（`paper2-draft-v0.md`）|
| 已下载 PDF | **123 篇**（`papers/` 目录，含 Li Fei-Fei 2401.03568）|
| 阅读笔记 | **173 篇**（`paper1-reading-notes/`）— 夜间 +34 + 批次二 +79 + 批次三 +47 篇（已去除1篇重复）|
| 候选文献池 | **全部已读完**（~186 篇候选已全部生成笔记）|
| 综合映射 | ⚠️ `scope-review-synthesis.md`（基于原 48 篇，待更新纳入新 79 篇）|
| 已核实文献 | 18/19（`paper1-bibliography.md`）|

---

## Phase 完成状态

| Phase | 名称 | 状态 | 截止 |
|-------|------|------|------|
| Phase 0 | 决策与对齐周 | ✅ **完成** | 2026-05-21 |
| Phase 1 | 文献密集检索 | 🟡 **进行中** | 2026-05-28 |
| Phase 2 | Paper 1 v1 撰写 | ⬜ 未开始 | 2026-06-11 |
| Phase 3 | Paper 1 内部 review + 修订 | ⬜ 未开始 | 2026-06-18 |
| Phase 4 | Paper 1 arXiv 提交 | ⬜ 未开始 | 2026-06-25 |
| Phase 5 | Paper 2 v1 撰写 | ⬜ 未开始 | 2026-07-09 |
| Phase 6 | Mycelium 主网部署（并行）| 🟡 进行中 | 2026-08-12 |
| Phase 7 | Paper 2 review + arXiv | ⬜ 未开始 | 2026-07-22 |
| Phase 8 | ZUAEC BP 整合 + 报名 | ⬜ 未开始 | 2026-08-31 |

---

## Phase 0 完成情况（已交付）

- ✅ Paper 1 v0 初稿（Scoping Review + Framework 定位）
- ✅ Paper 2 v0 初稿（ASM 协议规范定位）
- ✅ Codex review v1 完成（`paper-review-codex-v1.md`）
- ✅ Must-Fix 映射到各 Phase（`codex-feedback-todo-plan.md`）
- ✅ 范式重定位：Paper 1 = "能力定位 vs 社会角色定位"范式论文
- ✅ Paper 1/2 标题锁定
- ✅ mainnet 表述修正（"Sepolia testnet with planned OP mainnet"）
- ✅ 19/19 已知文献核查（18 真实 + 1 需替换：Hilbert 个人网站）
- ✅ 11 篇 PDF 下载到本地 `papers/`
- ✅ 9 篇全文阅读笔记（`paper1-reading-notes/`）
- ⬜ Jason 的 user-review-queue 9 项决策（待 Jason 完成）

---

## Phase 1 当前任务清单（本周）

### 文献检索目标
- [ ] arXiv 系统检索（Group A-G 全部关键词）→ 累计候选 500+ 篇
- [ ] Google Scholar 引用追踪 → 补充 200 篇
- [ ] 标题筛选（候选 → 150-200 摘要入围）
- [ ] 摘要阅读（150-200 → 80-100 入围）
- [ ] 全文阅读优先级排序

### 已完成的检索（2026-05-21）
- ✅ Group A（AI Agent 核心）首批检索
- ✅ Group B（人机协作）首批检索 → 7 篇候选（NEW-B01 ~ B07）
- ✅ Group C（机机协作）首批检索
- ✅ Group E（社会科学经典）首批检索 → 包含 NEW-E01（Gupta et al. Ostrom+LLM）
- ✅ Group F（协议与通信）首批检索
- ✅ Group G（身份与声誉）首批检索
- 当前候选总数：~64 篇（目标：500+，Phase 1 第 1 天结果正常）

### 全文阅读笔记已完成（127 篇）→ 详见 `scope-review-synthesis.md`（待更新）

**2026-05-22 夜间批次一（+34 篇，并行 subagent）**：
- 理论竞争者：Harré、Bracale（制度语法）、Fei（制度拓扑）
- 旧范式靶子：CAMEL、AutoGen、MetaGPT、ReAct、AgentBench、Wang 综述等
- 社会涌现：Park、Cultural-Evolution、Norm-Evolution-NL、Gossip（间接互惠）、Putnam（⚠️v1→v3替换）
- 人机协作：Zeng、Shen(⚠️workshop)、Quan、Evans、Song、HAIF、Piao、Haase
- Paper 2 协议/身份：Ehtesham/Hu&Rong、Fleming、ThreatModel、DIAP、Insured-Agents、Semantic-View、TU-Berlin DID/VC、IoA

**2026-05-22 今日批次二（+79 篇，6-agent 并行精读）**，覆盖：
- **⭐⭐⭐⭐⭐ 新发现（Paper 2 核心竞争者 & SC 证据）**：
  - `chang2025-anp-whitepaper.md` — **ANP（Ant Group）= Paper 2 主要直接竞争者**，Agent Network Protocol
  - `mast2025-why-multiagent-fails.md` — MAST 14 类失败模式，直接支持 Paper 1 §1 问题动机
  - `agentsociety2025-large-scale-simulation.md` — 10K agents + 5M 交互，最大规模涌现证据
  - `mechanism-design-not-enough2026.md` — 机制设计不足以保证合作，支持 P 支柱
  - `coopeval2026-cooperation-benchmark.md` — 第一个合作能力 benchmark
  - `communication-enables-cooperation2025.md` — 明确通信→合作因果链
  - `wooldridge2025-fetchai-architecture.md` — Fetch.ai 工业落地实例（Paper 2 案例）
  - `li2025-lacp-standardization.md` — LACP 标准化提案（Paper 2 竞争者格局）
  - `radosevich2025-mcp-safety-audit.md` + `maloyan2025-mcp-protocol-security.md` — MCP 安全漏洞（Paper 2 §6 ThreatModel）
  - `seliuchenko2026-trustflow.md` — 话题感知声誉路由（SC 支柱直接对应）
  - `liu2026-when-agent-markets-arrive.md` — 3.2× 财富增益 + 42% 争议率（经济证据）
  - `agentreputation2026-fse-decentralized.md` — FSE 2026 同行评审声誉系统
  - `agentic-p2p2026-content-to-capability.md` — P2P agent 网络架构
  - `toolformer2023-language-models-tools.md` — 工具调用开创性论文（旧范式基准点）
  - `lifeifei2024-agent-ai-survey-multimodal.md` — Li Fei-Fei 多模态具身综述（与我们**正交互补**，非支持）
- 工业报告批次（industry-facts）：SWE-bench 93.9% SOTA、McKinsey 88% 采用率等 28 篇候选
- 扩展主题批次（expanded-topics）：agent 专业化、认知架构、域级 agent、经济机制 25 篇候选

**⚠️ 引用完整性高危项（Jason 必看）**：
1. `2604.27271` 版本被替换（v1 Putnam → v3 删 Putnam）；本地存 v1，需声明版本
2. `2511.02841` 作者纠错（非 Rouhani，实为 TU Berlin Rodriguez Garzon 等）
3. ANP（`chang2025-anp-whitepaper.md`）= ASM 的**主要竞争者**，Paper 2 §2 需重点差异化
4. Shen `2512.21551` 实为 CHI workshop 提案，勿过度引用
5. `wang2026-agentic-p2p-networks.md` 与 `agentic-p2p2026-content-to-capability.md` 疑似重复（均指 2603.03753），需去重

### 待完成全文阅读（Phase 1 目标：已超额完成 127 篇）
- [x] Group A：ReAct ✅, AutoGen ✅, MetaGPT ✅, AgentBench ✅（均已完成）
- [x] Group B：NEW-B01~B07 ✅（批次二已覆盖）
- [x] Group C：Chakraborty ✅, Chen ✅, Huang ✅, Li ✅, Zhang ✅
- [ ] 完成 PRISMA-ScR N 值记录（`paper1-literature-screen.md` 中 [TODO] 部分）
- [ ] 更新 `scope-review-synthesis.md` 纳入新 79 篇的聚类映射

---

## 紧急待办（Jason 需要决策）

### 高优先级（Phase 2 开始前必须完成）
1. **ANP 差异化策略** ✅：已更新 `chang2025-anp-whitepaper.md`，加入治理层差异（Linux/Nostr vs Windows 类比）；Paper 2 §2 建议引用语已写好
2. **Duplicate note 去重** ✅：已删除 `wang2026-agentic-p2p-networks.md`，保留 `agentic-p2p2026-content-to-capability.md`（⭐⭐⭐⭐⭐，更详细）
3. **scope-review-synthesis.md 更新**：当前版本只含原始 ~14 篇，需更新纳入新笔记的聚类映射；**注意：个人笔记已经是单独文件格式**（173 个 .md 文件），synthesis 只需做映射索引
4. **2506.01438 已撤稿**：从候选池移除（已由 2505.10468 覆盖）
5. **cheng2026-three-pillar 命名冲突**：Cheng et al. 2026（TAT 三支柱）与我们框架同名，Paper 1 §5 需要专门回应
6. **Paper 2 §5 重写** ✅（2026-05-23）：已将 ZK-SNARK 主路径替换为 LAAS + DP 噪声主路径（§5.1–5.7 全部重写）；ZK 保留为可选扩展（§5.6）；同步更新 Abstract、Keywords、Contributions、Limitations、Deployment Stack

### 中优先级（Paper 1 v1 完成前）
4. **Hilbert 个人网站引用**：找 arXiv 版本替换，或降级为 "working paper"
5. **arXiv endorsement**：尽早申请（避免 Phase 4 被卡）
6. **ZK 选型（降级）** ✅：ZK 已降为可选扩展（Bulletproofs/Halo2），DP 噪声为主路径（Paper 2 §5 已重写）
7. **user-review-queue.md** 中 9 项决策完成

### 新批次审阅
8. **`paper1-screen-batch-industry-facts.md`**（28 篇工业报告候选）→ Jason 决定哪些纳入精读
9. **`paper1-screen-batch-expanded-topics.md`**（25 篇 arXiv 新检索）→ Jason 决定哪些纳入精读

---

## 关键里程碑

| 日期 | 里程碑 |
|------|--------|
| **2026-05-28** | Phase 1 完成：30-50 篇全文笔记 |
| **2026-06-11** | Paper 1 v1（无 [TODO]，~12000 词）|
| **2026-06-18** | Paper 1 v2（内部 review 整合）|
| **2026-07-07** | **Paper 1 上线 arXiv** |
| **2026-07-21** | Paper 2 v1（无 [TODO]，~10000 词）|
| **2026-08-25** | Paper 2 v2（含真实部署数据）|
| **2026-08-31** | **Paper 2 arXiv + ZUAEC 报名完成** |

---

## 文献核查状态

| 状态 | 数量 | 说明 |
|------|------|------|
| ✅ 已核实 | 18 | 真实论文，可直接引用 |
| ⚠️ 需处理 | 1 | Hilbert 个人网站（需找 arXiv 版本）|
| ❌ 需核实 | 多条 | paper1-draft-v0.md 中标 [TODO: verify] 的引用 |

需要在 Paper 1 v1 完成前全部清零：
- [ ] 日本总务省报告（具体题名/年份）
- [ ] 卡内基国际和平基金会 2026 报告
- [ ] GPT 5.4 在 220 项任务 83% 优于人类（原始来源）
- [ ] Mitchell (2026) arXiv:2604.00081
- [ ] Evans et al. (2026) arXiv:2603.20639
- [ ] Quan et al. (2026) CHI 2026 接收确认
- [ ] Wu et al. EvolveR (2026) ICML 2026 接收确认

---

## 下次对话时 Jason 问"下一步做什么"的回答模板

**当前阶段**：Phase 1 接近尾声（文献检索 127 篇完成，目标超额），可准备过渡到 Phase 2

**下一个具体任务**（按优先级）：
1. **[最高优先级]** 更新 `scope-review-synthesis.md`：将新增 79 篇笔记纳入聚类 + Paper1/2 章节映射（可由 subagent 完成初稿）
2. **[高优先级]** Paper 1 v1 撰写准备：基于 127 篇笔记 + synthesis，开始填写 Paper 1 §1~§6 的 [TODO] 空白段落
3. **[Paper 2 紧急]** ANP vs ASM 差异化表格：`chang2025-anp-whitepaper.md` 是直接竞争者，在 Paper 2 §2 添加对比网格
4. **[收尾]** 去重 `wang2026` / `agentic-p2p2026` 两个可能重复的笔记（均指 2603.03753）
5. **[Jason 决策]** 审阅 `paper1-screen-batch-industry-facts.md`（28篇）和 `paper1-screen-batch-expanded-topics.md`（25篇），决定哪些值得精读
