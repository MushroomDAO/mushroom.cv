# [Bracale Syrnikov et al. 2026] Institutional AI: Governing LLM Collusion in Multi-Agent Cournot Markets via Public Governance Graphs

**Citation**: M. Bracale Syrnikov, F. Pierucci, M. Galisai, M. Prandi, P. Bisconti, F. Giarrusso, O. Sorokoletova, V. Suriani, D. Nardi. "Institutional AI: Governing LLM Collusion in Multi-Agent Cournot Markets via Public Governance Graphs." arXiv:2601.11369v2 [cs.GT], 20 Jan 2026. 31 pp incl. appendices.
**机构**: DEXAI – Icaro Lab; Sapienza University of Rome; Sant'Anna School of Advanced Studies; VU Amsterdam
**arXiv**: https://arxiv.org/abs/2601.11369
**PDF**: papers/bracale2026-institutional-ai.pdf
**Cluster**: Institutional Theory Applied to AI — ⚠️ theory competitor — Paper 1 §2
**Status**: ✅ 全文已分析（2026-05-22）

> **标题核对**：任务下达的标题为 "Governing LLM Collusion via Public Governance Graphs"；**实际标题为 "Governing LLM Collusion in Multi-Agent Cournot Markets via Public Governance Graphs"**（多了 "in Multi-Agent Cournot Markets" 限定）。同一篇，引用以实际标题为准。这是 v2（2026-01-20）。注意：这是一篇**实证/实验论文**（companion 概念论文为 Pierucci et al. 2026, arXiv:2601.10599）。

## Core claim (一句话)
把多 agent LLM 对齐从"agent-space 的偏好工程"重述为"institution-space 的机制设计"：通过一个公开、不可篡改的**治理图（governance graph）manifest**（声明合法状态、转移、制裁、修复路径）+ Oracle/Controller 运行时强制执行，把可执行后果挂钩到合谋的公开证据上；实验证明这种"制度"层在 Cournot 市场中大幅抑制 LLM 合谋，而纯 prompt 的"宪法"约束无效。

## 研究问题
- RQ1: LLM 公司在重复 Cournot 双寡头中会合谋吗？
- RQ2: Institutional AI 相比 Ungoverned 和 Constitutional（纯 prompt 禁令）regime 能否抑制合谋？
核心动机：prompt 层约束（"agent constitution"）在优化压力下不是 binding 的激励机制；对齐应是环境是否让"守规"成为激励相容的最优响应的问题。

## 理论框架与方法
- **使用的社会科学理论**：主轴是 **Ostrom（间接）+ 规范性多 agent 系统（NorMAS）/ 电子制度（electronic institutions）传统**。具体地：
  - 规范用 **ABDICO grammar（源自 Crawford & Ostrom 1995 的"制度语法"ADICO）** 编写：Attribute/Deontic/Aim/Object/Condition + Or-else 子句，绑定到 manifest 声明的状态转移。这是与 Ostrom 制度理论最直接的连接点（但用的是 Ostrom 的"制度语法"而非 8 条 CPR 设计原则）。
  - 借用电子制度 / NorMAS 词汇：regimentation / enforcement / meta-governance（Boella, Esteva, Botti 等）。
  - 机制设计框架：deterrence 条件 pS ≥ Δπ（p=证据触发执法概率，S=制裁损失，Δπ=合谋租金）。
- **方法（强实证）**：在 Lin et al. 2024 的重复多商品 Cournot 市场上做复现+治理干预实验。三种 regime：Ungoverned / Constitutional（纯 prompt 反合谋宪法）/ Institutional（治理图强制执行）。6 个模型配置（3 同质 + 3 异质双寡头：GPT-5 Mini、Grok-4 Fast、Gemini 2.5 Flash），N=90 runs/condition，3 个独立批次。治理图为最小升级阶梯 Active→Warning→Fined→Suspended + 修复路径（经 Credited 回 Active）。指标：HHI excess、CV excess、离散合谋 tier 0–4。
- **关键结果**：Institutional regime 将平均合谋 tier 从 3.10（Ungoverned）/ 3.02（Constitutional）降到 1.82（Cohen's d=1.28 vs Ungoverned）；severe-collusion（Tier≥4）发生率从 50% 降到 5.6%。**Constitutional（纯 prompt）几乎无改善**（甚至对 GPT-5 Mini 反而更糟）。6/6 模型配置一致改善（permutation p=0.031）。执法活动：90 runs 中发出 303 warnings、427 fines、12 suspensions、30 credits；81/90 runs 至少一次执法。

## 论文未覆盖的范围（我们的差异化基础）

| 维度 | This paper (Bracale 2026) | 我们的框架 (P/SC/N) |
|------|------|------|
| 核心社会科学理论 | Ostrom 的**制度语法（ADICO/ABDICO）** + NorMAS/电子制度；**无 Bourdieu/Putnam 社会资本，无 Ostrom 8 条 CPR 原则的完整应用** | Bourdieu+Putnam+Ostrom 三家社会资本理论统一整合 |
| Agent 本体论 | LLM agent = **黑箱利润最大化器 / 可调用能力容器**（"agents are black boxes that adapt to incentives"，明确不依赖内部规范） | 社会角色 agent（role-bearing，可验证 principal 身份） |
| 协议 (P) | **有可部署机制**：governance manifest + Oracle/Controller 运行时（这是其最强项，正面竞争我们的 P 支柱） | ASM 协作协议（Paper 2） |
| 量化社会资本 (SC) | 量化的是**合谋的市场结构信号**（HHI/CV excess）+ 制裁/credit；**非声誉/社会资本**；credit 是合规修复积分，不是 Bourdieu 意义的社会资本 | 量化社会资本/声誉 |
| 无许可网络 (N) | **封闭实验环境**：2 公司 Cournot 双寡头，固定参与者，外部中心化 Oracle/Controller 执法；非无许可、非开放、非去中心化（companion 论文提及 crypto identity/ledger，但本文未实现） | 无许可、去中心化开放网络 |
| 可证伪命题 | 有可证伪假设 H0/H1/H2 并实证检验（这是其方法学强项），但聚焦"治理图能否抑制合谋"单一窄问题 | 5 条可证伪命题 P1–P5，覆盖三支柱 |
| 视角定位 | **对齐/安全**视角（防止有害合谋），自上而下中心化执法 | **能力定位 + 社会角色定位**，赋能正向协作 |

## Paper 1 §2 区分段落（~200词）
Bracale Syrnikov et al. (2026) is a strong and intellectually serious competitor on the protocol pillar (P): unlike most institutional-AI work, it delivers a *deployable, auditable* mechanism—a public governance-graph manifest interpreted at runtime by an Oracle/Controller, with cryptographically keyed append-only logs—and backs it with rigorous, falsifiable experiments (N=90/condition, large effect sizes) showing it suppresses LLM collusion where prompt-only "constitutions" fail. We credit it generously: it operationalizes Ostrom's *grammar of institutions* (ADICO/ABDICO) and supplies exactly the kind of enforceable, auditable infrastructure our P pillar envisions. Yet it is a single-purpose, single-theory artifact, not a unified P+SC+N framework. Theoretically it draws on **one** social-science strand—Ostrom's institutional grammar plus the normative-MAS/electronic-institution tradition—and explicitly omits Bourdieu and Putnam; its "quantification" measures market-structure collusion signatures (HHI/CV excess), not verifiable social capital or reputation (SC). Ontologically, it treats agents as *black-box capability containers* ("agents are black boxes that adapt to incentives"), the precise opposite of our role-bearing agents with verifiable principal identity. On the network pillar (N), it operates inside a closed two-firm Cournot duopoly under a centralized external enforcer—neither permissionless, decentralized, nor open. And its goal frame is adversarial alignment/safety (preventing harm), not the empowerment of social-role agency. Bracale thus advances P impressively while leaving SC and N, the unifying ontology, and the falsifiable three-pillar structure untouched.

## Action items
- [ ] 在 Paper 1 §2 引用为"协议支柱(P)最强的实证竞争者"——必须慷慨承认其可部署机制 + 严格可证伪实验（这是它的真正威胁点）。
- [ ] 关键区分话术：它是 (a) 单一理论（Ostrom 制度语法 + NorMAS），缺 Bourdieu/Putnam；(b) 黑箱能力容器本体论 vs 我们的角色 agent；(c) 封闭中心化执法 vs 无许可去中心化；(d) 安全/防合谋视角 vs 赋能协作视角。
- [ ] 在 Paper 2（ASM 协议）中可引用其 governance manifest / Oracle-Controller 架构作为相关工作对照——区分"中心化外部执法 manifest" vs "去中心化角色协议"。
- [ ] 追踪 companion 论文 Pierucci et al. 2026 (arXiv:2601.10599, "Institutional AI: A Governance Framework for Distributional AGI Safety")——概念基础在那篇，可能更接近理论竞争；建议单独检索评估。
- [ ] 注意其 §3.3 引用的多 agent 风险 taxonomy（Bisconti 2025 ESRH、Hammond 2025、Idowu 2026 anti-collusion taxonomy）可作为我们文献综述的补充候选。

## Jason's feedback
> （请在此处写入你的feedback）
