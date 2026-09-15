# CLAUDE.md — ZUAEC 论文写作工作目录

> **最近更新**：2026-05-22 | **当前阶段**：Phase 1（文献检索）🟢 候选池达标 + 核心精读完成

## 项目背景

本目录为**第八届浙江大学校友创新创业大赛（ZUAEC）**参赛项目准备两篇学术论文：

- **Paper 1**：*Three Pillars for an Agent Collaboration Network: A Paradigm Shift from Capability Invocation to Social Role Agency, with a Scoping Review of 2022-2026 Literature*
- **Paper 2**：*ASM: A Communication Protocol for Role-Bearing AI Agents in Open Collaboration Networks*（标题已去"去中心化/Decentralized"敏感词，2026-05-22）

截止：2026-08-31 两篇 arXiv 提交 + ZUAEC 报名完成（压缩后 9 周计划）。

## 当前进度快照（2026-05-22）

| 指标 | 状态 |
|------|------|
| Phase 0（决策对齐）| ✅ 完成，范式定位锁定 |
| Phase 1（文献检索）| 🟢 候选池 ~133 篇（>120 目标）+ 48 篇核心精读完成 |
| 候选文献池 | ~133 篇（screen §二 + `paper1-screen-batch-groupD.md` 28 + `paper1-screen-batch-social-protocol.md` 46，已去重）|
| 阅读笔记 | **48 篇**（2026-05-22 夜间 +34，并行 subagent 下载+精读）→ 见 `scope-review-synthesis.md` |
| PDF 存档 | 46 篇（`papers/`，已 gitignore）|
| 综合映射 | ✅ `scope-review-synthesis.md`（48 篇聚类 + Paper1/2 章节映射 + 竞争者/张力分析）|
| Paper 2 敏感词 | ✅ 已去"去中心化/Decentralized"（标题/关键词/小节/结论）|

**⚠️ Jason 待 review（夜间新增，优先级高）**：
1. `scope-review-synthesis.md` → **通读**，确认 Paper1/2 章节映射与竞争者差异化策略
2. **引用完整性高危项**（synthesis §3.8）：`2604.27271` 版本被替换、`2511.02841` 作者纠错、Coral 新竞争者、Shen 实为 workshop
3. `paper2-draft-v0.md` → 确认标题中性化（"Open" vs 备选 "Distributed/Permissionless"）
4. 48 篇 `paper1-reading-notes/*.md` → 各篇含 "Jason's feedback" 待填（尤其⚠️张力篇 `zhang2026-beyond-preset-identities.md`）
5. **承上**：`paper-innovation-points.md` v0.3 定位（"首次桥接"→"首个统一框架"——夜间精读已强化此论断，见 synthesis §3.3）

---

## 核心文档导航

| 文档 | 作用 |
|------|------|
| `progress.md` | **每次对话必读**，当前阶段、任务状态、下一步 |
| `master-execution-plan.md` | 9 周整体执行计划（Phase 0-8）|
| `paper-revision-status.md` | v2 plan 落实情况对照 |
| `paper1/` | **Paper 1 专属目录**：draft、bibliography、framework-logic、literature-screen、screen-batch 系列 |
| `paper2/` | **Paper 2 专属目录**：`paper2-draft-v0.md` |
| `paper3/` | **Paper 3 专属目录**：`paper3-draft-v0.md`、`agent-network-architecture.md`、PydanticAI 技术方案与里程碑 |
| `scope-review-synthesis.md` | **综合映射**（共享）：48 篇精读聚类 + Paper1/2 章节映射 + 竞争者/张力 |
| `talk-feedback.md` | **设计讨论追踪**（共享）：LAAS/SC/协作框架/安全基调/最优解引导等 Jason 亲述 |
| `industry-standards-reference.md` | **业界标准参考**（共享）：A2A/MCP/OpenAI/Anthropic 官方规范 |
| `paper1-reading-notes/` | **全文阅读笔记**（共享，174 篇，每篇含 Paper1/2/3 relevance + Jason feedback）|

---

## 工作习惯约定

- Jason 问"下一步做什么"→ 读 `progress.md`，报告当前阶段 + 具体下一任务
- 每完成一个阶段/任务 → 更新 `progress.md`
- 文献引用 → 未核实前必须标 `[TODO: verify]`，不得直接写入论文为已核实
- 论文写作语言 → 正文英文，内部文档中文

---

## Academic Research Skills（ARS）使用指南

已安装插件：`academic-research-skills`（Imbad0202/academic-research-skills）

### 四大核心技能

#### 1. `/ars-lit-review` — 文献综述
**用途**：针对某一主题做多 agent 文献检索与综述
```
/ars-lit-review "AI agent socialization"
/ars-lit-review "decentralized agent communication protocols"
```
- 支持 Semantic Scholar API 验证引用（Tier 0 核实）
- 反幻觉协议：禁止从 LLM 记忆直接引用，必须检索验证

#### 2. `/ars-plan` — 完整论文 Pipeline 规划
**用途**：启动 10 阶段学术 Pipeline，管理从选题到发表的全流程
```
/ars-plan
```
- 强制完整性关卡（Stage 2.5 + Stage 4.5 不可跳过）
- 支持跨 session 的 Material Passport 状态接续

#### 3. `/ars-outline` — 论文大纲
**用途**：根据主题和贡献声明生成论文结构
```
/ars-outline
```

#### 4. `/ars-abstract` — 摘要撰写
**用途**：按学术格式（背景→问题→方法→结果→贡献）写 Abstract
```
/ars-abstract
```

#### 5. `/ars-revision` — 修订模式
**用途**：根据 review 反馈进行定向修订
```
/ars-revision
```

#### 6. `/ars-revision-coach` — 修订路线图
**用途**：分析 review 意见，生成修订优先级路线图（不直接修改文稿）
```
/ars-revision-coach
```

#### 7. `/ars-reviewer` — 多视角同行评审
**用途**：模拟 Editor + 3 位 Reviewer + Devil's Advocate 审稿
```
/ars-reviewer
```
- 决策标准：≥80 接受 / 65-79 小修 / 50-64 大修 / <50 拒稿
- Devil's Advocate 阈值：4/5 以上才接受让步

#### 8. `/ars-citation-check` — 引用核查
**用途**：核实引用列表中的文献是否真实存在
```
/ars-citation-check
```
- 7 类幻觉 checklist
- 声明-引用忠实度审计（v3.8）

#### 9. `/ars-mark-read` — 标记已读文献
**用途**：在文献库中记录人工阅读信号
```
/ars-mark-read [citation-key]
```

#### 10. `/ars-disclosure` — AI 使用声明
**用途**：生成符合目标期刊规范的 AI 工具使用声明
```
/ars-disclosure
```

#### 11. `/ars-format-convert` — 格式转换
**用途**：将论文草稿转为 LaTeX / DOCX / PDF / Markdown
```
/ars-format-convert
```
- 支持 APA 7.0（默认）、Chicago、IEEE、Vancouver 等

### 本项目推荐工作流

```
Phase 1（文献检索）  →  /ars-lit-review
Phase 2（论文撰写）  →  /ars-outline → /ars-abstract → 手动写作
Phase 3（内部评审）  →  /ars-reviewer
Phase 4（修订）      →  /ars-revision-coach → /ars-revision
Phase 4.5（诚信关卡）→  /ars-citation-check
Phase 5（格式化）    →  /ars-format-convert
提交前              →  /ars-disclosure
```

### 重要约束
- **引用核实是 Jason 的责任**，`/ars-citation-check` 辅助但不替代人工判断
- **Semantic Scholar API 验证**为 Tier 0，通过即可标为 ✅；否则标 ⚠️ 等待人工核实
- 所有通过 ARS 写出的内容，正式提交前必须过一次 `/ars-reviewer`
