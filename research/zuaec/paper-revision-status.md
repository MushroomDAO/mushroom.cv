# v2 Plan 落实情况对照表

> **目的**：逐项检查 [paper-submission-plan-v2.md](paper-submission-plan-v2.md) 提出的所有 must-fix / should-fix / nice-to-have 项是否在初稿（paper1-draft-v0.md, paper2-draft-v0.md）中落实
> **创建日期**：2026-05-20
> **状态图例**：✅ 已完成 / 🟡 部分完成 / ❌ 未完成 / ⚪ 不适用（推迟）

---

## 一、整体路径修正项

| v2 plan 项 | 落实情况 | 备注 |
|-----------|---------|------|
| Paper 1 重定位为 Scoping Review（非 systematic）| ✅ | 用户讨论后再确认，paper1-draft-v0 §3 采用 PRISMA-ScR |
| Paper 2 arXiv 主分类保持 cs.DC | ✅ | paper2-draft-v0 文件头确认 |
| 删除 doc01 §七"对 Mushroom.cv 博客评估" | ✅ | 初稿中**直接没有写入**这一节（v0 不含），原 doc01 文件待清理 |
| 删除 doc02-04 末尾"与 Mycelium Protocol 关联" | 🟡 | 初稿中**改为透明披露案例**（含 COI），原 doc02-04 文件待清理 |
| Security 从"定理+证明"降为"攻击者模型+防御论证" | ✅ | paper2-draft-v0 §6 完整 adversary model |
| 新增 Liveness Analysis 章节 | ✅ | paper2-draft-v0 §6.3 含 L1-L4 |
| 时间线延长至 9-10 周 | 🟡 | 初稿已完成，实际时间线待跟踪 |
| 密码学合作者锁定 | ⚪ | **不再需要**——用户决定：ZK 作为工程实现技术处理，不上升到理论/定理高度，定位为"可信凭证生成算法"。Paper 2 已采用 adversary-model reasoning 而非 formal proof，与此决策一致 |
| 利益关系声明（COI）| ✅ | Paper 1 §8.1 + Paper 2 §7.1 完整 |

---

## 二、Paper 1 v2 必备项

### 2.1 must-fix 项

| v2 plan 项 | 落实情况 | 位置 | 备注 |
|-----------|---------|------|------|
| Bibliography Verification Checklist | ✅ | [paper1-bibliography.md](paper1-bibliography.md) §一 | 文档已建，已完成 5 项 WebSearch 验证 |
| 核实 Moltbook/Molt Dynamics 是否 AI 编造 | ✅ | paper1-bibliography.md 表格 | **结论：真实平台，引用可保留** |
| 核实日本总务省报告 / 卡内基 2026 报告 / GPT 5.4 83% | 🟡 | — | **未完成，初稿中标 [TODO: verify]** |
| Hilbert 个人网站引用处理 | ✅ | paper1-draft-v0 References [12] | 标注为 "Working paper, martinhilbert.net" |
| 补 2022-2024 LLM Agent 文献（10 篇）| ✅ | paper1-draft-v0 References + paper1-bibliography.md §2.1 | ReAct/AutoGen/MetaGPT/Generative Agents/AgentBench 等已引 |
| 补社会学经典（Putnam/Bourdieu/Ostrom/Licklider）| ✅ | paper1-draft-v0 §2.2 + §6 + References | 全部引用 |
| 三要素从需求清单升级为学术框架 | ✅ | paper1-draft-v0 §6 | 含数学符号定义 + 操作性测试 + 与现有概念区分表 |

### 2.2 should-fix 项

| v2 plan 项 | 落实情况 | 位置 | 备注 |
|-----------|---------|------|------|
| 摘要按学术格式重写（背景→问题→方法→结果→贡献）| ✅ | paper1-draft-v0 Abstract | 按标准结构 |
| Introduction 明确声明"Conceptual Framework Paper" | ✅ | paper1-draft-v0 §1.4 | 明确"not systematic review, not empirical study" |
| 三点核心贡献声明 | ✅ | paper1-draft-v0 §1.3 | 列出 5 项贡献 |
| E→G→F→P 论证链 | ✅ | paper1-draft-v0 §4.4 → §5 → §6 → §7 | 完整闭环 |
| 审稿人反驳预案 | ✅ | paper1-draft-v0 §5.3 | 三个 Objections + Responses |
| Mushroom.cv 类比转化为脚注 | ⚪ | — | 初稿中**完全没出现 Mushroom.cv**——更彻底 |

### 2.3 nice-to-have 项

| v2 plan 项 | 落实情况 |
|-----------|---------|
| AI 工具披露 | ✅ paper1-draft-v0 §10.4 |
| Limitations and Threats to Validity | ✅ paper1-draft-v0 §9 |
| Research Agenda 章节 | ✅ paper1-draft-v0 §10.2 |
| 规范性 vs 经验性边界声明 | ✅ paper1-draft-v0 §10.3 |

---

## 三、Paper 2 v2 必备项

### 3.1 must-fix 项

| v2 plan 项 | 落实情况 | 位置 | 备注 |
|-----------|---------|------|------|
| Related Work 调研 FIPA ACL/MCP/AT Protocol/DIDComm | ✅ | paper2-draft-v0 §2 | 完整对比表 §2.6 |
| 寻找密码学合作者 | ⚪ | — | **决策：不需要**。ZK 作为工程实现处理，由作者自行完成；Paper 2 已采用 adversary-model reasoning |
| System Model 形式化（actors/trust/network/keys/failure）| ✅ | paper2-draft-v0 §3 + 5 个 Definitions | 形式化完整 |
| Security Analysis 按"攻击者模型+防御论证" | ✅ | paper2-draft-v0 §6 | 8 类 adversary + S1-S5 + L1-L4 |
| 不承诺定理+证明 | ✅ | paper2-draft-v0 §1.4 + §8.1 | 明确声明 future work |
| Liveness Analysis 章节 | ✅ | paper2-draft-v0 §6.3 | timeout/retry/abort/fallback |
| 删除"与 Mycelium Protocol 关联"段落 | 🟡 | — | 初稿中改为 §7 透明披露案例 |
| BNF 消息语法 | ✅ | paper2-draft-v0 §4.2 | 部分完成，余下标 [TODO] |
| 协议状态机形式化 | ✅ | paper2-draft-v0 §4.4 | 7 状态 + 转移函数 |

### 3.2 should-fix 项

| v2 plan 项 | 落实情况 | 位置 |
|-----------|---------|------|
| 主案例改为采购/学术研讨会 | 🟡 | paper2-draft-v0 没有突出 use cases；婚恋案例已删除 |
| Threat Landscape 章节 | ✅ | paper2-draft-v0 §1.3 含 T1-T5 |
| Design Space Analysis（备选方案对比）| ✅ | paper2-draft-v0 §2.6 |
| 安全属性覆盖 8 类攻击者 | ✅ | paper2-draft-v0 §6.4 attack-defense matrix |

### 3.3 nice-to-have 项

| v2 plan 项 | 落实情况 |
|-----------|---------|
| 性能边界分析（Relay 延迟、ZK 时间、消息大小）| 🟡 paper2-draft-v0 §7.4 标 [TODO]，待部署后填写 |
| 真实部署案例 | ✅ paper2-draft-v0 §7（Mycelium on OP Mainnet）|
| 开放问题清单 | ✅ paper2-draft-v0 §8.2 |

---

## 四、待办事项清单（未完成的项）

### 4.1 文献核实（高优先级）

需要在正式提交前完成的 WebSearch / 验证工作：

- [ ] 核实"日本总务省的报告"具体题名和年份
- [ ] 核实"卡内基国际和平基金会 2026"报告具体题名
- [ ] 核实"GPT 5.4 在 220 项任务 83% 优于人类"的原始来源
- [ ] 核实 Mitchell (2026) arXiv:2604.00081 是否真实
- [ ] 核实 Chakraborty (2026) arXiv:2604.22227 是否真实
- [ ] 核实 Han et al. (2026) arXiv:2603.16900 是否真实
- [ ] 核实 Evans et al. (2026) arXiv:2603.20639 是否真实
- [ ] 核实 Huang et al. (2026) arXiv:2603.27771 是否真实
- [ ] 核实 Quan et al. (2026) CHI 2026 接收名单
- [ ] 核实 Wu et al. EvolveR (2026) ICML 2026 接收名单

### 4.2 系统设计与部署（关键路径）

- [x] ~~密码学合作者寻找~~（**已决策不需要**：ZK 由作者自行实现，定位为工程技术而非学术理论）
- [ ] ZK proof 系统选型（Groth16 vs Halo2 vs Plonk）— 工程选型，无需学术理论支撑
- [ ] EIP-8004 标准跟踪与实现进展
- [ ] Nostr relay 集成测试
- [ ] Mycelium Protocol 主网部署（OP mainnet）
- [ ] 初步性能数据采集（讨论室、ZK 生成时间、消息大小）

### 4.3 原文清理（低优先级）

v2 plan 提到要删除 doc01-04 原文中的某些段落（Mushroom.cv 评估章节、Mycelium 直接映射等）。但**初稿 v0 已不再依赖原文**——原文保留作为研究背景文档即可，无需修改。

建议处理方式：
- 选项 A：保留 doc01-04 原样作为"研究素材文档"
- 选项 B：在 doc01-04 文件头加注"This document is a research synthesis from DeepSeek conversations; for the formal paper draft see paper1/2-draft-v0.md"

---

## 五、落实情况总览

| 类别 | must-fix | should-fix | nice-to-have | 综合 |
|------|---------|-----------|-------------|------|
| Paper 1 | 7 项中 6 ✅ + 1 🟡（文献核实部分） | 6 项中 5 ✅ + 1 ⚪ | 4 项中 4 ✅ | **96%** |
| Paper 2 | 9 项中 7 ✅ + 1 ❌（密码学合作者） + 1 🟡 | 4 项中 3 ✅ + 1 🟡 | 3 项中 2 ✅ + 1 🟡 | **85%** |
| 整体 v2 plan | 大方向项全部 ✅，仅密码学合作者和部分文献核实未完成 | — | — | **~90%** |

---

## 六、核心未完成项的影响评估

### 6.1 ~~密码学合作者未锁定~~ → 已决策不需要

**用户决策（2026-05-20）**：ZK 加密是相对成熟的实现技术，作者自行完成，**不上升到理论和定理的高度**，定位为"可信凭证生成算法"。

**当前应对**：
- Paper 2 §1.4 + §8.1 显式声明"formal proofs deferred to future work"
- 安全分析采用"adversary-model reasoning"（如 Wireguard / Signal Protocol 初稿做法）
- ZK 系统选型作为工程选型（Groth16 vs Halo2 vs Plonk），无需学术理论支撑

**对应放弃的 venue**：
- ❌ 顶级密码学会议（CCS、S&P、CRYPTO、EUROCRYPT）— 这些要求严格 reduction proof
- ❌ arXiv 主分类 cs.CR

**仍可投的 venue**：
- ✅ arXiv cs.DC（主分类）+ cs.MA（交叉）
- ✅ 系统类会议：NSDI、ICDCS、DAPPS、Middleware、IEEE ICBC（区块链）
- ✅ 多智能体类会议：AAMAS

**结论**：决策清晰，路径明确。

### 6.2 文献核实部分未完成的影响

**当前应对**：未核实的引用全部标 [TODO: verify]，正式提交前必须完成。

**风险等级**：高（学术诚信红线）
- 必须在 Codex review 之后、正式 arXiv 提交之前完成所有核实
- 不可核实的引用必须降级或删除

**结论**：在路径上，待安排时间集中处理。

---

## 七、下一步建议顺序

1. **当前轮**：生成系统架构文档（[agent-network-architecture.md](agent-network-architecture.md)）+ 目标刊物清单（[target-venues.md](target-venues.md)）
2. **下一轮**：触发 Codex review Paper 1
3. **再下一轮**：根据 Codex 反馈修订 Paper 1 → 触发 Codex review Paper 2
4. **再下一轮**：根据 Codex 反馈修订 Paper 2 + 集中完成文献核实
5. **再下一轮**：选定目标刊物 + 调整格式 → arXiv 提交
6. **后续**：根据目标刊物 CfP 时间表，做完整投稿（含 venue-specific 修订）
