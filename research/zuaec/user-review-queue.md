# Jason 的 Review 队列（What You Need to Read & Decide）

> **创建日期**：2026-05-20
> **目的**：按优先级排好你需要 review 的文档，标注每份文档需要你做出的决策与反馈
> **预期总耗时**：4-6 小时（不含 Paper 1/2 全文阅读则 2-3 小时）

---

## 一、必读顺序总览

```
[最优先]                                              [最后读]
   ↓                                                    ↓
1. 创新点 → 2. 系统架构 → 3. 执行计划 → 4. v2 plan
            → 5. 修订状态 → 6. 投稿刊物 → 7. Paper 1 draft → 8. Paper 2 draft
```

**核心建议**：先读前 3 份（约 1 小时），完成关键决策；论文 draft 可以稍后阅读。

---

## 二、逐份文档 review 任务

### 📕 #1：[paper-innovation-points.md](paper-innovation-points.md)

**优先级**：🔴 最高
**预期阅读时间**：15 分钟
**为什么先读这个**：这是两篇论文的"灵魂"。one-liner 没定下来，后面所有写作都是无锚之木。

**需要你的决策**：
- ✅ **Paper 1 的 one-liner 是否接受？**
  > "We bridge AI agent research with classical institutional theory... diagnose that current multi-agent AI systems lack institutional embedding—not capability, not data, not alignment—and propose the first falsifiable three-pillar framework..."
- ✅ **Paper 2 的 one-liner 是否接受？**
  > "We present ASM, the first agent communication protocol that simultaneously addresses verifiable human-authorization, privacy-preserving reputation accumulation, and permissionless multi-agent coordination..."
- ✅ **联合 pitch 中"Agent 社会工程学"作为新学科**——这个野心合适吗？

**回复方式**：直接在文档下回复 "OK" 或提出修改建议；或在 Claude Code 里和我说"Paper 1 的 one-liner 改成 XXX"。

---

### 📗 #2：[agent-network-architecture.md](agent-network-architecture.md)

**优先级**：🔴 最高
**预期阅读时间**：30-40 分钟
**为什么读**：这是 Mycelium Protocol 工程项目的架构基线，决定 Paper 2 §7 的实现描述

**需要你的决策**（见文档 §10 的 6 个问题）：

1. **价值主张表格**（§1.2）是否准确？是否漏掉关键场景？
2. **核心抽象单元表格**（§3.3）是否完整？是否需要加 Group / Organization 抽象？
3. **用户视角流程**（§4.1）以"录会议"为例是否合适？是否换为更贴近 ZUAEC 评审的场景（例如"中小企业数字化转型"）？
4. **实现状态矩阵**（§5.1）的 ✅ / ⬜ 标注是否准确？有无遗漏？
5. **路线图时间节点**（§8）是否符合实际产品规划？
6. **关键设计决策**（§9）是否覆盖你最初的设计直觉？有无遗漏？

**回复方式**：建议在每个问题下面直接写 1-2 句反馈，或者口头告诉我修改方向。

---

### 📘 #3：[master-execution-plan.md](master-execution-plan.md)

**优先级**：🟠 高
**预期阅读时间**：20 分钟
**为什么读**：这是从今天到 2026-08-31（ZUAEC 报名截止）的 14 周计划

**需要你的决策**：

1. **时间线是否现实？**（§二 Phase 0-8 总览）
   - 你每周能投入多少小时？（计划假设：约 15-20 小时/周）
   - 6 月底前完成 Paper 1 v1 是否可行？
2. **分工是否合理？**（§三）
   - Claude 承担的工作清单是否合理？
   - 有无你希望 Claude 做但目前没列入的？
3. **风险清单**（§四）
   - 是否还有其他风险？
   - 哪些缓解措施需要现在就准备？
4. **是否需要外部审阅者？**
   - 浙大有合适的人可以邀请吗？
   - 或者你的圈子里有合适的学术朋友？

**回复方式**：可以告诉我你的实际每周可用工时，我会重新校准 Phase 时长。

---

### 📙 #4：[paper-submission-plan-v2.md](paper-submission-plan-v2.md)

**优先级**：🟡 中
**预期阅读时间**：15 分钟
**为什么读**：你之前 review 过 v1，这是 v2（合并两次 review 后的修订计划）

**需要你的决策**：
- 大方向已定，重点 check 是否有需要进一步调整的地方
- 时间线与 master-execution-plan.md 不一致时以哪份为准？（建议 master-execution-plan.md 为准）

**回复方式**：如果完全 OK 就跳过；有疑问再问我。

---

### 📓 #5：[paper-revision-status.md](paper-revision-status.md)

**优先级**：🟡 中
**预期阅读时间**：10 分钟
**为什么读**：v2 plan 的各项 must-fix / should-fix 在初稿中是否落实

**需要你的决策**：
- ✅ 95% 已落实，看看是否有遗漏
- 未完成的 10 条文献核实（§4.1），你计划什么时候做？（建议 Phase 1 期间集中处理）

---

### 📔 #6：[target-venues.md](target-venues.md)

**优先级**：🟡 中（可推迟到 7 月前再细看）
**预期阅读时间**：15 分钟
**为什么读**：决定我们最终投哪里

**需要你的决策**：
1. **Plan A/B/C 你倾向哪个？**
   - Plan A：先 arXiv → AAMAS 2027 / ICDCS 2027（推荐）
   - Plan B：直接投 Frontiers of CS 或 DAPPS（保守）
   - Plan C：等数据充分后投顶会（激进）
2. **是否需要中文圈认可（如 Frontiers of CS）作为备选？**
3. **ZUAEC BP 中如何描述目标 venue**？（"计划投稿 AAMAS"? "已提交 arXiv"?）

**回复方式**：先选 Plan，细节后续调整。

---

### 📕 #7：[paper1-draft-v0.md](paper1-draft-v0.md)（English）

**优先级**：🟠 高（但建议放在前 3 份之后读）
**预期阅读时间**：45-60 分钟
**为什么读**：这是论文真身，所有规划都为它服务

**需要你的反馈**：
- **方向是否正确？** Three-Pillar Framework 是不是你想表达的？
- **章节结构是否需要调整？**
- **§8 Mycelium Protocol 透明披露**——你看着 COI 声明是否舒服？
- **§10.4 AI 工具披露**——你接受这种披露表述吗？
- **References 列表中有没有让你觉得"这篇我没看过/不熟悉"的？**

**回复方式**：
- 高层反馈："整体方向 OK，但 §X 想改成 XXX"
- 章节级反馈：每章 1-3 条意见
- 不需要逐字逐句改，那是后续工作

---

### 📗 #8：[paper2-draft-v0.md](paper2-draft-v0.md)（English）

**优先级**：🟠 高（建议读完 #7 后再读）
**预期阅读时间**：45-60 分钟

**需要你的反馈**：
- **ASM 协议的描述是否准确？** §4 三区块 + 状态机
- **§7 Mycelium 部署案例**——技术栈选型是否需要调整？
- **§6 攻击者模型**——8 类是否覆盖你想到的所有威胁？

**回复方式**：同 #7。

---

## 三、决策清单（Decision Items）

按优先级排序，必须在 Phase 0 结束前（5/27）完成：

| 决策项 | 文档位置 | 默认建议 | 影响 |
|--------|---------|---------|------|
| Paper 1 one-liner | innovation-points #1 | 接受当前版本 | 决定论文定位 |
| Paper 2 one-liner | innovation-points #1 | 接受当前版本 | 决定论文定位 |
| 联合 pitch（Agent 社会工程学）| innovation-points #1 | 谨慎采用 | 决定野心程度 |
| 系统架构 6 个问题 | architecture #10 | 见各题 | 决定 §7 实现描述 |
| 每周可投入小时数 | execution-plan §五 | 15-20 小时 | 决定时间线 |
| 是否邀请外部审阅者 | execution-plan §四 | 建议至少 1 位 | 决定 review 深度 |
| arXiv 主分类确认 | venues / drafts | cs.AI + cs.DC | 决定读者群 |
| 投稿 Plan A/B/C | venues §三 | Plan A | 决定中长期路径 |
| 是否需要英文润色 | execution-plan Phase 3 | 暂不需要 | 决定预算 |

---

## 四、Review 流程建议

### 推荐节奏（最快路径）

**Today / Tonight（如果你今天还有时间）**：
- 阅读 #1 创新点（15 分钟）→ 直接告诉我 one-liner 接不接受
- 阅读 #2 系统架构 §10 的 6 个问题（30 分钟）→ 给出 6 条反馈

**Tomorrow**：
- 阅读 #3 执行计划（20 分钟）→ 告诉我可投入工时
- 阅读 #6 投稿刊物（15 分钟）→ 选 Plan

**This week**：
- 阅读 #7 Paper 1 draft（60 分钟）→ 给章节级反馈
- 阅读 #8 Paper 2 draft（60 分钟）→ 给章节级反馈

**Phase 0 结束（5/27）前**：
- 完成所有 9 项决策清单

---

### 简化版（如果你没时间）

只读 #1 + #2 §10 + #3 §三（分工部分），其他先信任 Claude 的默认建议，等 Phase 1/2 完成后再回头看。

最低决策需求：
1. one-liner 接受？
2. 架构 6 个问题中至少 #3 和 #4（场景 + 实现状态）
3. 每周可投入工时

---

## 五、Codex review 时机

**等你完成 #1 + #2 + #3 之后**，我会触发 Codex review：
- Paper 1 draft v0
- Paper 2 draft v0
- 全套规划文档

Codex review 会评估：
1. PRISMA-ScR §3 方法论是否到位
2. §6 三要素定义与 §7 命题的逻辑一致性
3. §8 Mycelium Protocol 案例的 COI 处理是否符合学术规范
4. §4 综述的论据强度
5. 整体写作 tone

Codex 反馈到达后，我会基于反馈+你的反馈，启动 Phase 1（文献检索）。

---

## 六、给你的"决策模板"

下面是你可以直接复制并填写的决策模板。直接告诉我你的回复，我会按这个执行：

```
# Jason 的 Review 反馈（Phase 0）

## #1 创新点
Paper 1 one-liner: [接受 / 修改为：XXX]
Paper 2 one-liner: [接受 / 修改为：XXX]
联合 pitch（Agent 社会工程学）: [采用 / 不采用 / 改为：XXX]

## #2 系统架构 6 个问题
1. 价值主张表格: [OK / 修改为：XXX]
2. 抽象单元: [OK / 加 Group / 加 Organization / XXX]
3. 用户视角流程例子: [录会议 OK / 改为：XXX]
4. 实现状态矩阵: [OK / 修改：XXX]
5. 路线图时间: [OK / 调整：XXX]
6. 设计决策: [OK / 补充：XXX]

## #3 执行计划
每周可投入: [N 小时]
分工: [OK / Claude 还应做：XXX]
外部审阅者: [邀请：XX 老师 / 不邀请 / 待定]
风险补充: [无 / XXX]

## #6 投稿
Plan: [A / B / C]
中文 venue 备选: [需要 / 不需要]
BP 措辞: [按你建议 / 改为：XXX]

## 总体
是否触发 Codex review: [立即 / 等 Paper 1/2 draft 读完后再触发]
```

---

*完成上述 review 后，我会按你的反馈继续推进 Phase 1（文献检索）。*
