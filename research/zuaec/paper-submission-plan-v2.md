# 论文写作与 arXiv 提交计划 v2（修订版）

> **修订日期**：2026-05-20
> **修订依据**：合并 [paper-suggestions-local.md](paper-suggestions-local.md)（本地资深博导 review）+ [paper-suggestions-codex.md](paper-suggestions-codex.md)（Codex review）双重审阅结论
> **替代关系**：本文件作为 v1（[paper-submission-plan.md](paper-submission-plan.md)）的修订版，v1 保留用于历史对比
> **核心定位变化**：从"基于系统性文献综述的理论框架论文" → 修正为 **"Scoping Review + Conceptual Framework"** 类型

---

## 〇、修订动因（Why v2）

v1 计划的两个根本问题被双重审阅一致指出：

1. **学术诚信红线**：doc01-04 全部标注"来源：DeepSeek对话整理"，所有文献、数据、强判断必须独立核实，不能把 AI 对话当成已验证综述
2. **定位过高**：v1 自称"基于系统性文献综述"，但没有 systematic review 必备的检索策略、纳入排除标准、筛选流程——这会被审稿人直接判定为方法论造假

v2 通过 4 项硬性修订修复这些问题：
- 重定位 Paper 1 为 **scoping review** 而非 systematic review
- 建立 **文献核查清单（Verification Checklist）** 作为前置交付物
- **删除** doc01 第七节"对 Mushroom.cv 博客的评估"和 doc02-04 末尾"与 Mycelium Protocol 的关联"段落
- 降低 Paper 2 形式化承诺：从"定理+证明"降为"攻击者模型+安全分析"

---

## 一、双 review 的共识与分歧

### 1.1 高度共识（无需进一步讨论，直接落地）

| 议题 | 双方一致结论 |
|------|------------|
| AI 来源核实 | doc01-04 所有事实主张必须逐条回溯原始论文/标准；不可核实则删除或降级 |
| Mushroom.cv 博客评估章节 | 必须删除或彻底学术化（doc01 §七） |
| Mycelium Protocol 直接映射 | 学术论文中删除，最多在 Discussion 节作 "prototype implementation" 提及，并声明利益关系 |
| 2022-2024 文献缺口 | 必须补：ReAct (2022)、Generative Agents (2023)、AutoGPT/MetaGPT/AutoGen/CAMEL/CrewAI/AgentBench 等 |
| 经典文献缺口 | 必须补：Wooldridge MAS 教材、FIPA ACL、W3C DID/VC、ZK-SNARK 原始论文（Groth 2016）、Nostr NIPs |
| Paper 2 安全证明承诺 | 不要承诺 "PPT 敌手 + 定理+证明"；降为 "Adversary Model + Security Analysis" |
| Liveness 完全缺失 | 必须补：协议在 timeout/retry/abort/网络分区下的可终止性与可恢复性 |
| 两篇拆法 | 总体合理，但 Paper 1 和 Paper 2 的"三层架构"重复必须切硬边界 |
| 婚恋案例 | 移至 appendix 或 discussion，不放在协议论文主体 |

### 1.2 分歧点与最终裁决

| 议题 | Local 观点 | Codex 观点 | **v2 采纳** |
|------|---------|----------|----------|
| Paper 2 arXiv 主分类 | `cs.CR`（密码学是最大创新） | `cs.DC`（保守，避免引来更严苛密码学审查） | **`cs.DC`**（Codex 立场）。理由：当前阶段无密码学合作者保障，主投 `cs.CR` 是过度承诺；待形式化完成后再换主分类 |
| Paper 1 定位 | "Conceptual Framework Paper"（基于系统综述） | "Scoping Review + Conceptual Framework + Research Agenda" | **Codex 立场**。当前材料不符合 systematic review 方法论要求，scoping review 是更诚实的定位 |
| 社会学文献深度 | 强调 Putnam/Bourdieu/Ostrom/Habermas 必须显式对接 | 提及但未细化具体作者 | **采用 Local 的细化建议**：必须显式区分本文"量化社会资本"与 Bourdieu/Putnam 意义上的概念 |
| Hilbert (2025) 个人网站引用 | 标记为质量问题，需找正式版本或降级 | 未单独提及 | **采用 Local**：核实是否有 arXiv 版本，否则降级 |
| 是否考虑 3 篇拆法 | 不建议 | 仅当 doc03 发展为实际实验平台后才值得拆 | **保持 2 篇**，但 Codex 提到的"Framework + Experiment Platform + Protocol"三篇结构作为 Future Work 备选 |

---

## 二、Paper 1 修订版规划

### 2.1 修订后的类型定位

**v1 定位**：基于系统性文献综述的理论框架论文（Conceptual Framework Paper）
**v2 定位**：**Scoping Review + Conceptual Framework + Research Agenda**

差异：
- Scoping Review ≠ Systematic Review；不需要 PRISMA 流程图、纳入排除标准、检索数据库清单
- 允许更灵活的文献覆盖范围声明（"we review key works in 2022-2026"）
- 末节明确放 Research Agenda，承认论文是研究议程提案而非已完成结论

### 2.2 修订后的标题与摘要骨架

**中文标题**：
> *AI Agent 社会化的三要素框架：基于 2022-2026 年文献的 Scoping Review 与研究议程*

**英文标题**：
> *Three-Element Framework for AI Agent Socialization: A Scoping Review and Research Agenda Based on 2022-2026 Literature*

**摘要模板**（必须严格遵循）：
```
[背景] Agent 生态正从工具使用阶段迈向社会化协作阶段，但当前多智能体系统在
       规模与协作效能之间存在显著缺口（Yee et al. 2026: 协作成功率仅 6.7%）。
[问题] 缺乏对 Agent 社会化结构性缺口的系统分析，亦无可操作的理论框架。
[方法] 我们对 2022-2026 年间 [N] 篇前沿文献进行 scoping review，
       识别"替代/人机协作/机机协作"三个研究集群，
       并诊断出"缺乏社会制度性嵌入"为核心结构性缺口。
[提案] 我们提出 Agent Socialization 的三要素框架（协作协议、量化社会资本、
       无许可网络），给出每个要素的操作性定义和可测试命题。
[贡献] 1. Scoping review of 2022-2026 frontier literature
       2. A conceptual framework with testable propositions
       3. A research agenda for empirical validation
```

### 2.3 修订后的论文结构

| 章节 | v1 内容 | v2 修订 |
|------|--------|--------|
| 1. Introduction | AI Agent 进化的社会学问题 | 加 "Scope and Contributions" 子节明确论文边界 |
| 2. Literature Review | 三路径研究集群 | 重命名为 "Scoping Review Methodology and Findings"；说明文献筛选范围（关键词、年份、来源类型） |
| 3. Theoretical Foundations | 演化博弈论、共演化理论、涌现理论 | **新增**：社会资本理论（Putnam, Bourdieu, Lin）、制度经济学（Ostrom）、早期人机协作（Licklider 1960）的接入 |
| 4. The Structural Gap | 当前研究的核心缺口 | 论证"为什么纯机机协作面临根本性障碍，因此当前阶段人机协作是最优解"（修复 v1 的论证跳跃） |
| 5. Three-Element Framework | 三要素 | 每个要素必须含：**操作性定义**（Definition）+ **可测试命题**（Proposition）+ **边界条件**（Boundary）+ **与现有概念的区分**（e.g. 本文社会资本 vs Bourdieu 社会资本） |
| 6. Discussion | 框架与现有理论的关系 | 加 "Limitations and Threats to Validity" 子节 |
| 7. **~~对 Mushroom.cv 博客的评估~~** | （v1 §七）| **删除整节**，核心洞察可以保留为 "early Homo sapiens stage" 类比，但作为脚注，不再点名博客 |
| 8. Conclusion & Research Agenda | Paper 2 预告 | 明确写为 Research Agenda 而非简单未来工作；Paper 2 作为其中一个具体方向 |

### 2.4 必须建立的前置交付物

**A. Bibliography Verification Checklist**（文献核查清单）

对 doc01 中所有引用，逐条核实并标注核实状态：

| 引用 | 类型 | v1 来源标注 | v2 核实状态 | 备选处理 |
|------|------|---------|----------|---------|
| 日本总务省报告 | 机构报告 | 无年份/标题/链接 | ❌ 必须核实 | 找不到则删除 |
| 卡内基国际和平基金会 2026 报告 | 机构报告 | 无具体标题 | ❌ 必须核实 | 找不到则降级为"working paper" |
| GPT 5.4 在 220 项任务 83% 优于人类 | 量化主张 | 无来源 | ❌ 必须核实 | 找不到则删除该论断 |
| Moltbook "77 万 vs 90704" 数据矛盾 | 量化主张 | 同一论文给出矛盾数字 | ⚠️ 必须核实哪个准确 | 修正后引用 |
| Hilbert (2025) `martinhilbert.net` | 文献质量 | 个人网站非同行评审 | ⚠️ 找 arXiv 版本 | 找不到则降级引用语气 |
| Chen 等 (2025) "开放式共演化" | 引用 | doc03 提及但 doc01 参考文献中无 | ❌ 补全引用 | — |

**B. 2022-2024 文献补强清单**（must-cite list）

最少补充以下文献，按优先级：

| 文献 | 优先级 | 用途 |
|------|------|------|
| Yao et al. (2022) ReAct | 必须 | LLM Agent 起点 |
| Park et al. (2023) Generative Agents (Stanford Smallville) | 必须 | doc01 §5.1 已提及但参考文献缺失 |
| Wu et al. (2023) AutoGen | 必须 | 多智能体框架基础 |
| Hong et al. (2023) MetaGPT | 必须 | 多智能体协作 |
| Liu et al. (2023) AgentBench | 必须 | Agent 评估基线 |
| Putnam (2000) Bowling Alone | 必须 | 社会资本理论 |
| Bourdieu (1986) The Forms of Capital | 必须 | 社会资本理论原始来源 |
| Ostrom (1990) Governing the Commons | 必须 | 制度治理理论 |
| Licklider (1960) Man-Computer Symbiosis | 必须 | 人机协作奠基 |
| Wooldridge (2009) MAS 教材 | 推荐 | 多智能体经典 |

---

## 三、Paper 2 修订版规划

### 3.1 修订后的类型定位

**v1 定位**：Protocol Design Paper（架构与协议设计论文）
**v2 定位**：**Protocol Specification Paper**（协议规范论文，更聚焦）

核心差异：
- 把"双网架构"（doc03 内容）从主要贡献降为 **System Model / Background**
- 把"ASM 协议规范 + ZK 声誉系统"提升为 **唯一核心贡献**
- 婚恋案例移至 appendix，正文主案例改为采购或学术研讨会组织

### 3.2 修订后的标题与贡献声明

**中文标题**：
> *ASM：面向去中心化 Agent 协作的原生通信协议——身份、授权与隐私保护声誉系统*

**英文标题**：
> *ASM: A Native Communication Protocol for Decentralized Agent Collaboration with Identity, Authorization, and Privacy-Preserving Reputation*

**贡献声明**（替换 v1 的模糊表述）：
> Our contributions are threefold:
> 1. A threat-aware dual-network model for human-anchored agent collaboration
> 2. An ASM message syntax and finite state machine for verifiable agent interactions
> 3. A privacy-preserving reputation analysis using ZK-based credential aggregation

### 3.3 修订后的论文结构

| 章节 | v1 内容 | v2 修订 |
|------|--------|--------|
| 1. Introduction | 当前协议局限 | 加 "Threat Landscape" 子节，提出协议必须解决的 5 类威胁 |
| 2. Background & Related Work | Nostr、EIP-8004、ZK-SNARK | **强化**：必须含 design-space analysis 对比 FIPA ACL、MCP、AT Protocol、Matrix、DIDComm、libp2p pubsub |
| 3. System Model | （v1 称为 Architecture）| **重命名+形式化**：定义 actors、trust assumptions、network model、key lifecycle、failure model |
| 4. Protocol Specification | ASM 消息格式 | **加 FSM**：状态机（S, s₀, δ, F）+ 消息语法 BNF + 留言→直连两阶段的形式化定义 |
| 5. **Security Analysis** | v1 称为 "Security Analysis" 但有"定理+证明" | **降级承诺**：改为 Adversary Model + 5 类攻击的防御论证；不写 "定理+证明" |
| 6. **Liveness Analysis** | **v1 完全缺失** | **必须新增**：timeout、retry、abort、fallback relay、eventual settlement |
| 7. Use Cases | 采购 + 婚恋 | 主案例：**采购**或**学术研讨会组织**；婚恋移至 appendix |
| 8. Discussion & Limitations | 工程挑战 | 加性能边界讨论（Relay 检索延迟、ZK 生成时间、消息大小） |
| 9. Conclusion | "HTTP 时刻"宏大类比 | **压缩**：宏大类比仅保留 Introduction 一小段，不再作为结论核心 |
| ~~与 Mycelium Protocol 的关联~~ | v1 doc04 末尾 | **删除**，可在 Discussion 末以"open-source implementation exploration"一句话提及，并声明利益关系 |

### 3.4 Security Analysis 必须覆盖的威胁模型

完整覆盖以下 8 类攻击者（v1 只提了 4 类，Codex 补充更完整）：

| 攻击者类型 | 攻击能力 | 防御机制 | 剩余风险声明 |
|----------|---------|---------|----------|
| 恶意 Agent | 伪造消息、违约 | 消息签名 + Merkle 历史不可篡改 | — |
| 合谋 Agent 集团 | 互相签发好评刷声誉 | 要求 K 个独立协作伙伴 | 待量化 K 的合理取值 |
| 恶意/审查 Relay | 拒绝特定消息、伪造索引 | 多 Relay 冗余 + DHT 索引 | 不解决全局审查 |
| 被盗密钥 | 冒充合法 Agent | 密钥轮换 + 撤销列表 | 撤销前的损失不可逆 |
| 恶意授权人（人类节点） | 故意授权 Agent 实施危害 | 责任链可追溯 | 不解决人类层面的法律责任 |
| 被动监听者 | 推断 Agent 真实授权者 | ZK 证明保护身份 | 假设 ZK 方案安全 |
| 垃圾请求者 | 留言轰炸耗尽资源 | 留言抵押 + PoW | 抵押额度需经济博弈分析 |
| 资源强者 | 利用算力快速累积声誉 | 时间衰减 + 协作伙伴多样性要求 | 不完全消除先发优势 |

### 3.5 Liveness Analysis 必须覆盖的场景

| 故障场景 | 协议行为 | 形式化要求 |
|---------|---------|---------|
| 对方 Agent 不响应 | timeout → abort | 定义最大等待时间 t_max |
| 单 Relay 宕机 | 切换至 fallback relay | 定义 fallback 列表与切换条件 |
| 网络分区 | 协议进入 eventual settlement 状态 | 在部分同步网络下保证诚实 Agent 不无限等待 |
| ZK 证明生成超时 | 协议降级或重试 | 定义重试上限 |
| WebRTC 建连失败 | 回退到 Relay 加密直连 | 定义降级路径 |
| 协议中途崩溃 | 部分完成的协作如何处理 | 定义 partial-commit 与回滚规则 |

---

## 四、删改清单（必须从 doc01-04 中删除/修改的内容）

### 4.1 必须删除（不可保留）

| 位置 | 内容 | 删除原因 |
|------|------|---------|
| doc01 §七 | "对 Mushroom.cv 博客的评估" | 商业推广嫌疑，学术中立性受损 |
| doc02 末尾 | "与 Mycelium Protocol 的关联"对照表 | 同上 |
| doc03 末尾 | "与 Mycelium Protocol 的关联"对照表 | 同上 |
| doc04 末尾 | "与 Mycelium Protocol 的关联"对照表 | 同上 |
| doc04 §10 | "HTTP 时刻"作为结论的主要证据 | 类比可保留在 Introduction 一小段，不能作为结论 |

### 4.2 必须降级或限定（保留但减弱）

| 位置 | 内容 | 处理方式 |
|------|------|---------|
| doc01 引言 | "GPT 5.4 在 220 项任务 83% 优于人类" | 找到出处则保留并引用；找不到则删除该断言 |
| doc01 §5.1 | Moltbook "77 万 vs 90704" 数据矛盾 | 核实后修正为单一正确数字 |
| doc01 参考文献 | Hilbert (2025) 个人网站 | 找 arXiv 版本则升级；找不到则改为"working paper" |
| doc03 §一 | "社会子宫"、doc03 §五"全新的社会有机体" | 类比压缩到一句话，不作为核心论证 |
| doc04 婚恋案例 | "灵魂音乐向量"、"模拟约会" | 移至 appendix |

### 4.3 必须补充（前置工作）

| 类别 | 工作量 | 截止 |
|------|------|------|
| Bibliography Verification Checklist 完成 | 5-7 天 | Paper 1 起草前 |
| 2022-2024 文献补强（10 篇必读） | 7-10 天 | Paper 1 起草前 |
| 社会学基础文献接入（Putnam/Bourdieu/Ostrom/Licklider） | 3-5 天 | Paper 1 起草前 |
| Related Work 调研（FIPA ACL/MCP/AT Protocol/DIDComm） | 5-7 天 | Paper 2 起草前 |
| W3C DID/VC、Nostr NIPs、EIP 引用核实 | 2-3 天 | Paper 2 起草前 |

---

## 五、修订后时间线

v1 时间线被双重审阅判定为"严重低估"。v2 时间线如下（按保守估计 + 风险缓冲）：

| 阶段 | 节点 | Paper 1 | Paper 2 |
|------|------|---------|---------|
| 第 1 周 (5/20-5/27) | 前置核查 | Bibliography Verification Checklist | Related Work 调研启动 |
| 第 2-3 周 (5/28-6/10) | 文献补强 | 2022-2024 文献 + 社会学基础 | DID/VC/Nostr/EIP 标准引用 |
| 第 4-5 周 (6/11-6/24) | 初稿 | 各章节初稿 | System Model + FSM 形式化 |
| 第 6 周 (6/25-7/1) | 初稿（续） | 三要素操作性定义 + 命题 | Security Analysis + Liveness |
| 第 7 周 (7/2-7/8) | 内部 review | Paper 1 内部 review | Paper 2 内部 review |
| 第 8 周 (7/9-7/15) | 修订 | Paper 1 终稿 | Paper 2 修订 |
| 第 9 周 (7/16-7/22) | 提交 | Paper 1 arXiv 提交 | Paper 2 终稿 |
| 第 10 周 (7/23-7/29) | 提交（缓冲） | （已上线）| Paper 2 arXiv 提交 |

**关键依赖**：Paper 2 第 4-6 周需要 **密码学/安全方向合作者**，否则 Security Analysis 部分将是最大短板。这是 v2 的硬性前提。

---

## 六、修订后的 arXiv 子版块

| 论文 | v1 主分类 | v2 主分类 | v2 交叉分类 | 变化说明 |
|------|--------|--------|----------|---------|
| Paper 1 | cs.AI | **cs.AI** | cs.CY, cs.MA | 保持不变 |
| Paper 2 | cs.DC | **cs.DC** | cs.CR, cs.MA | 采纳 Codex 立场（保守）；待 Security Analysis 充实后再考虑换主分类至 cs.CR |

---

## 七、修订后的备选方案

### 方案 A（推荐 / 主线）
两篇都完成，Paper 1 在 7/22 前提交 arXiv，Paper 2 在 7/29 前提交。前提：找到密码学合作者。

### 方案 B（保守 / 保底）
只完成 Paper 1（scoping review + framework）按时提交。Paper 2 以 "in preparation" 在 BP 中标注。若 BP 急需引用，可考虑：
- Paper 1 摘要中提及 ASM 协议作为 ongoing work
- 在 GitHub 发布 ASM 协议技术草案文档（非 arXiv）

### 方案 C（最简 / 不推荐）
合并为一篇 ~20000 字 "Position Paper + Protocol Sketch"。代价：Paper 2 的协议规范不能宣称成熟贡献，只能作为 design implications。Codex 明确表示"不作为首选"。

### 方案 D（远期 / Codex 提议）
三篇拆法（仅作为远期目标）：
- Paper A：Scoping review + framework
- Paper B：双网实验平台与评估方案（需要真实实验数据）
- Paper C：ASM/ZK protocol

**v2 不采纳方案 D 作为当前目标**，因 doc03 尚未发展出实际实验设计、伦理审批、数据采集方案。

---

## 八、写作伦理与披露

正式论文中必须包含以下声明：

### 8.1 AI 工具披露

```
Author Note / Acknowledgements:

Initial brainstorming and outline drafting were assisted by Large Language Model
(DeepSeek-Chat). All literature citations, data claims, and theoretical
arguments have been independently verified by the authors. The framework
contribution and protocol design are original work by the authors.
```

### 8.2 利益关系声明（Conflict of Interest）

```
The author(s) participate in the Mycelium Protocol open-source project,
which is mentioned as a potential implementation case in this paper.
This paper's framework and protocol design are vendor-neutral and do not
depend on the specific implementation choices of Mycelium Protocol.
```

### 8.3 数据可获取性声明（Data Availability）

```
This paper does not present empirical data. All cited literature is publicly
available through the references listed.
```

---

## 九、修订后的 Top-5 行动清单

### Paper 1（修订版）

| 优先级 | 事项 | 完成截止 |
|------|------|--------|
| must-fix | 完成 Bibliography Verification Checklist（核实所有事实主张） | 第 1 周末 |
| must-fix | 补 2022-2024 + 社会学基础文献（共 ~15 篇必读） | 第 3 周末 |
| must-fix | 删除 doc01 §七"对 Mushroom.cv 博客评估"章节 | 起草前 |
| must-fix | 三要素框架升级为"定义+命题+边界+与现有概念区分" | 第 5 周末 |
| should-fix | 重定位为 Scoping Review，摘要按学术格式重写 | 起草时 |

### Paper 2（修订版）

| 优先级 | 事项 | 完成截止 |
|------|------|--------|
| must-fix | 完成 Related Work 调研（FIPA ACL/MCP/AT Protocol 对比） | 第 2 周末 |
| must-fix | 寻找并锁定密码学/安全方向合作者 | **第 1 周末（最高优先级，决定方案 A 是否可行）** |
| must-fix | System Model 形式化（actors/trust/network/keys/failure） | 第 5 周末 |
| must-fix | Security Analysis 按"攻击者模型 + 防御论证"格式，不承诺定理+证明 | 第 6 周末 |
| must-fix | Liveness Analysis 补充（timeout/retry/abort/fallback） | 第 6 周末 |
| must-fix | 删除所有 "与 Mycelium Protocol 的关联" 段落 | 起草前 |

---

## 十、v2 与 v1 关键差异总览

| 维度 | v1 | v2 |
|------|----|----|
| Paper 1 类型 | 基于系统综述的理论框架 | Scoping Review + Framework + Research Agenda |
| Paper 2 类型 | Protocol Design Paper | Protocol Specification Paper |
| Paper 2 arXiv 主分类 | cs.DC | cs.DC（保持，但理由变化：原因从"分布式系统是核心"改为"暂不承诺密码学主分类"） |
| 文献覆盖 | 主要 2025-2026 | 必须覆盖 2022-2026 + 社会学经典 |
| Bibliography 核实 | 无明确要求 | **必备前置交付物** |
| Mushroom.cv 博客评估 | 保留 | **删除** |
| Mycelium Protocol 映射 | 保留 | **删除**，仅在 Discussion 一句话提及 |
| Security 承诺 | 定理 + 非正式证明 | Adversary Model + 防御论证（无定理） |
| Liveness | 未提及 | **必备章节** |
| 婚恋案例 | 正文 | Appendix |
| 时间线 | 2-3 周 / 3-4 周 | 9-10 周（含前置核查 + 内部 review + 修订） |
| 关键依赖 | 无明确 | **密码学合作者**为方案 A 的硬性前提 |
| 利益关系声明 | 未提及 | **必备伦理声明** |

---

*本修订计划基于双重 review（local + Codex）的合并审阅产出。v1 文件 [paper-submission-plan.md](paper-submission-plan.md) 保留用于历史对比。*
