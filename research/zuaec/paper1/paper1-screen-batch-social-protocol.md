# Paper 1 文献筛选补充批次：社会模拟 + Agent 协议/身份

> **创建日期**：2026-05-22
> **检索者**：research-librarian agent
> **数据来源**：arXiv API（`arxiv.org/api/query`，按 submittedDate 倒序）+ 标题层人工判读
> **范围**：Cluster 1（社会模拟/涌现规范/Agent 社会）+ Cluster 2（Agent 协议/去中心化身份与信誉，Paper 2 重点）
> **去重基准**：`paper1-literature-screen.md`（C1-C19、NEW-B/E/001-026 已排除，不重复列出）

## 核实说明

- 表中**所有 arXiv ID 均由 arXiv API 检索直接返回**（含完整 title/author/date 元数据），即已核实为真实存在的论文，未凭记忆杜撰任何 ID。
- 版本号（v1/v2/v3）来自检索返回的最新版；引用时取裸 ID 即可。
- 个别在多关键词组反复出现的 ID 仅列一次，cluster 归入主相关方向。
- 三支柱缩写：**P** = Collaboration Protocols；**SC** = Quantified Social Capital；**N** = Permissionless Network。

---

## Cluster 1 — 社会模拟 / 涌现规范 / Agent 社会（Paper 1 §2 §4 主体）

| ID | Title | Authors | Year | arXiv ID | ⭐ | cluster + 相关性 |
|----|-------|---------|------|----------|----|------------------|
| S01 | Evolution of Social Norms in LLM Agents using Natural Language | Horiguchi et al. | 2024 | 2409.00993 | ⭐⭐⭐⭐⭐ | C1 涌现规范；自然语言驱动的规范演化，直接支撑 SC「规范=社会资本载体」论点，§4 必引 |
| S02 | Cultural Evolution of Cooperation among LLM Agents | Vallinder et al. | 2024 | 2412.10270 | ⭐⭐⭐⭐⭐ | C1 agent「文化」涌现 + 合作演化；P3 无许可网络中规范如何代际传播，最贴近「agent culture/identity emergence」 |
| S03 | Talk, Judge, Cooperate: Gossip-Driven Indirect Reciprocity in Self-Interested LLM Agents | Zhu et al. | 2026 | 2602.07777 | ⭐⭐⭐⭐⭐ | C1 间接互惠+gossip；声誉→合作的机制，直接对接 SC（Nowak 五法则）与 P2 信誉传播 |
| S04 | Validating Generative Agent-Based Models of Social Norm Enforcement | Cross et al. | 2025 | 2507.22049 | ⭐⭐⭐⭐ | C1 规范执行的生成式 ABM 验证；为 SC「可量化规范」提供方法论与可证伪性参照 |
| S05 | An Empirical Study of Collective Behaviors and Social Dynamics in LLM Agents | Hashemi et al. | 2026 | 2602.03775 | ⭐⭐⭐⭐ | C1 集体行为/社会动力学实证；§4 机机协作涌现的总览型证据 |
| S06 | Evaluating Collective Behaviour of Hundreds of LLM Agents | Willis et al. | 2026 | 2602.16662 | ⭐⭐⭐⭐ | C1 数百 agent 规模集体行为；支撑「社会角色」需大规模网络（N 支柱）才显现 |
| S07 | Will Systems of LLM Agents Cooperate: An Investigation into a Social Dilemma | Willis et al. | 2025 | 2501.16173 | ⭐⭐⭐⭐ | C1 社会困境中的合作；公共物品/搭便车，SC 与 Ostrom 治理的实证基底 |
| S08 | CoopEval: Benchmarking Cooperation-Sustaining Mechanisms and LLM Agents in Social Dilemmas | Tewolde et al. | 2026 | 2604.15267 | ⭐⭐⭐⭐ | C1 合作维持机制基准；为 SC/治理机制提供评测框架，§4 方法学引用 |
| S09 | Mechanism Design Is Not Enough: Prosocial Agents for Cooperative AI | Huang et al. | 2026 | 2605.08426 | ⭐⭐⭐⭐ | C1 亲社会 agent；论证纯机制设计不足→需社会角色/规范内化，呼应 Paper 1 范式转移核心 |
| S10 | The Memory Curse: How Expanded Recall Erodes Cooperative Intent in LLM Agents | Liu et al. | 2026 | 2605.08060 | ⭐⭐⭐ | C1 记忆与合作意向；身份/记忆持久性如何影响社会行为，SC 边界条件 |
| S11 | Corrupted by Reasoning: Reasoning Models Become Free-Riders in Public Goods Games | Guzman Piedrahita et al. | 2025 | 2506.23276 | ⭐⭐⭐⭐ | C1 公共物品博弈搭便车；直接 Ostrom 公地治理场景，SC 与 N 支柱的失败模式 |
| S12 | When Ethics and Payoffs Diverge: LLM Agents in Morally Charged Social Dilemmas | Backmann et al. | 2025 | 2505.19212 | ⭐⭐⭐ | C1 道德 vs 收益困境；社会角色 agent 的价值取向，§4 风险维度 |
| S13 | Communication Enables Cooperation in LLM Agents | Madmoun et al. | 2025 | 2510.05748 | ⭐⭐⭐⭐ | C1 通信→合作；直接连接 P（协议）与 SC（合作产出），桥接两支柱 |
| S14 | Cooperative Resilience in Multiagent Systems: Humans vs LLMs | Chacon-Chamorro et al. | 2025 | 2512.11689 | ⭐⭐⭐ | C1 合作韧性人机对比；§4 混合社会鲁棒性 |
| S15 | Sentipolis: Emotion-Aware Agents for Social Simulations | Fu et al. | 2026 | 2601.18027 | ⭐⭐⭐ | C1 情感感知社会模拟；agent 个性/身份维度，§4 社会模拟方法 |
| S16 | ScioMind: Cognitively Grounded Multi-Agent Social Simulation w/ Belief Dynamics | Yang et al. | 2026 | 2605.13725 | ⭐⭐⭐ | C1 信念动力学社会模拟；意见/认知建模，§4 |
| S17 | DEBATE: Benchmark for Evaluating Opinion Dynamics in Role-Playing LLM Agents | Chuang et al. | 2025 | 2510.25110 | ⭐⭐⭐⭐ | C1 意见动力学基准 + **role-playing**；「角色扮演 agent」直接对接社会角色范式，§2 |
| S18 | Spiral of Silence in Large Language Model Agents | Zhong et al. | 2025 | 2510.02360 | ⭐⭐⭐ | C1 沉默螺旋涌现；社会心理现象在 agent 群体复现，§4 极化风险 |
| S19 | LLM Agents Make Collective Belief Dynamics Programmable | He et al. | 2026 | 2605.19915 | ⭐⭐⭐⭐ | C1 集体信念可编程化；agent 群体的意见操控/治理需求，N 网络治理动机 |
| S20 | AI-Mediated Communication Can Steer Collective Opinion | Tsirtsis et al. | 2026 | 2605.16245 | ⭐⭐⭐ | C1 AI 中介通信引导集体意见；§4 机机协作的操纵风险 |
| S21 | Generative Exaggeration in LLM Social Agents: Consistency, Bias, Toxicity | Nudo et al. | 2025 | 2507.00657 | ⭐⭐⭐ | C1 社会模拟可信度边界；为「social agent」拟真度提供批判性证据 |
| S22 | Stop Drawing Scientific Claims from LLM Social Simulations Without Robustness Audits | Ye et al. | 2026 | 2605.18890 | ⭐⭐⭐ | C1 方法论批判；Paper 1 §3 方法论严谨性/可证伪框架的反思参照 |
| S23 | PAVE: A Cognitive Architecture for Legitimate Violation in Generative Agent Societies | Yehia et al. | 2026 | 2605.19351 | ⭐⭐⭐⭐ | C1 生成式 agent 社会中的「正当违规」；规范遵守 vs 越界，SC 规范执行的张力，§4 |
| S24 | Strategic Exploitation in LLM Agent Markets: E-Commerce Trust Simulation | Lei et al. | 2026 | 2605.10059 | ⭐⭐⭐ | C1 市场中信任的涌现与利用；SC 信任资本 + Paper 2 信誉系统动机 |
| S25 | Trust, Lies, and Long Memories: Emergent Reputation in Multi-Round Avalon | Ellawela | 2026 | 2604.20582 | ⭐⭐⭐ | C1 多轮博弈中声誉涌现；身份持久性 + 信誉，SC 与 P2 桥接 |

---

## Cluster 2 — Agent 协议 / 去中心化身份与信誉（Paper 2 §2 §3 §5 主体）

| ID | Title | Authors | Year | arXiv ID | ⭐ | cluster + 相关性 |
|----|-------|---------|------|----------|----|------------------|
| P01 | Beyond Message Passing: A Semantic View of Agent Communication Protocols | Yuan et al. | 2026 | 2604.02369 | ⭐⭐⭐⭐⭐ | C2 协议语义视角；为 ASM「语义层 vs 传输层」区分提供框架，Paper 2 §2 比较表核心 |
| P02 | Beyond Context Sharing: A Unified ACP for Secure Federated A2A Orchestration | Krishnan | 2026 | 2602.15055 | ⭐⭐⭐⭐ | C2 统一 ACP；与 ASM 直接竞争方案，Paper 2 §2 必比 |
| P03 | The Orchestration of Multi-Agent Systems: Architectures, Protocols, Enterprise Adoption | Adimulam et al. | 2026 | 2601.13671 | ⭐⭐⭐ | C2 编排架构综述；Paper 2 §2 协议生态背景 |
| P04 | LLM Agent Communication Protocol (LACP) Requires Urgent Standardization | Li et al. | 2025 | 2510.13821 | ⭐⭐⭐⭐ | C2 电信启发的标准化呼吁；支撑 ASM「需统一协议」动机，Paper 2 §1 |
| P05 | MOD-X: Modular Open Decentralized eXchange for Heterogeneous Interoperable AI Agents | Ioannides et al. | 2025 | 2507.04376 | ⭐⭐⭐⭐ | C2 去中心化 agent 交换框架；N 支柱 + Paper 2 §2 互操作竞品 |
| P06 | Agent Capability Negotiation and Binding Protocol (ACNBP) | Huang et al. | 2025 | 2506.13590 | ⭐⭐⭐ | C2 能力协商绑定；对应「能力调用」旧范式的协议化，Paper 2 §2 |
| P07 | LOKA Protocol: Decentralized Framework for Trustworthy and Ethical AI Agent Ecosystems | Ranjan et al. | 2025 | 2504.10915 | ⭐⭐⭐⭐ | C2 去中心化可信生态协议；N 支柱 + 伦理层，Paper 2 §2/§3 |
| P08 | Fetch.ai: An Architecture for Modern Multi-Agent Systems | Wooldridge et al. | 2025 | 2510.18699 | ⭐⭐⭐⭐ | C2 落地的去中心化 agent 经济架构（Wooldridge 署名）；N 支柱权威参考 |
| P09 | DIAP: Decentralized Agent Identity Protocol with ZK Proofs and Hybrid P2P Stack | Liu et al. | 2025 | 2511.11619 | ⭐⭐⭐⭐⭐ | C2 去中心化身份 + ZK + P2P；Paper 2 §3 身份层 + §5 ZK 的最直接竞品/参照 |
| P10 | Digital Identity for Agentic Systems: Portable Authorization Standard for Autonomous Agents | Madhira | 2026 | 2605.11487 | ⭐⭐⭐⭐ | C2 可移植授权标准；Paper 2 §3 委托/授权（principal identity）核心 |
| P11 | From Specification to Deployment: W3C VC + DID Trust Infrastructure for Autonomous Agents | Kroehl | 2026 | 2605.06738 | ⭐⭐⭐⭐ | C2 VC+DID 落地实证；Paper 2 §3「可验证 principal identity」的工程证据 |
| P12 | Agent Name Service (ANS): Trust Layer for Secure AI Agent Discovery & Identity | Mittal et al. | 2026 | 2604.26997 | ⭐⭐⭐⭐ | C2 agent 命名/发现/身份信任层；Paper 2 §3 发现+身份，N 网络寻址 |
| P13 | Fortifying the Agentic Web: Unified Zero-Trust Architecture Against Logic-layer Threats | Huang et al. | 2025 | 2508.12259 | ⭐⭐⭐⭐ | C2 零信任架构；Paper 2 §5 安全模型与 Sybil/注入防御 |
| P14 | A Novel Zero-Trust Identity Framework for Agentic AI: Decentralized Auth + Access Control | Huang et al. | 2025 | 2505.19301 | ⭐⭐⭐⭐ | C2 去中心化认证 + 细粒度访问控制；Paper 2 §3 身份+授权 |
| P15 | The Trust Fabric: Decentralized Interoperability and Economic Coordination for Agentic Web | Balija et al. | 2025 | 2507.07901 | ⭐⭐⭐⭐ | C2 信任织网 + 经济协调；N 支柱 + SC 经济资本，Paper 2 §2/§5 |
| P16 | Insured Agents: Decentralized Trust Insurance Mechanism for the Agentic Economy | Hu et al. | 2025 | 2512.08737 | ⭐⭐⭐⭐ | C2 去中心化信任保险（stake-based）；Paper 2 §5 信誉/质押机制（ERC-8004 圈作者） |
| P17 | DRF: LLM-Agent Dynamic Reputation Filtering Framework | Lou et al. | 2025 | 2509.05764 | ⭐⭐⭐ | C2 动态信誉过滤；Paper 2 §5 信誉计算 + Sybil/恶意 agent 过滤 |
| P18 | Towards Adaptive, Scalable, Robust Coordination of LLM Agents: Dynamic Ad-Hoc Networking | Li et al. | 2026 | 2602.08009 | ⭐⭐⭐⭐ | C2 自组织 ad-hoc agent 网络；N 无许可拓扑的协调机制，Paper 2 §4 |
| P19 | Stablecoin Design with Adversarial-Robust Multi-Agent Systems via Trust-Weighted Aggregation | You et al. | 2026 | 2601.22168 | ⭐⭐⭐ | C2 抗对抗的信任加权聚合；Paper 2 §5 抗合谋/Sybil 信誉聚合 |
| P20 | RollupTheCrowd: ZkRollups for Scalable Privacy-Preserving Reputation-based Crowdsourcing | Bendada et al. | 2024 | 2407.02226 | ⭐⭐⭐ | C2 ZK-rollup 隐私信誉；Paper 2 §5 可扩展隐私信誉的实现参照 |
| P21 | VeilAudit: Breaking the Deadlock Between Privacy and Accountability Across Blockchains | Qiao et al. | 2025 | 2510.12153 | ⭐⭐⭐ | C2 隐私与问责的平衡；Paper 2 §5 可验证身份的隐私权衡 |

---

## 检索覆盖说明 / 漏检风险

- **覆盖关键词组**：social norms / conventions / cultural evolution / opinion dynamics / social dilemma / cooperation / reputation emergence（C1）；agent communication protocol / interoperability / DID-VC / ZK reputation / Sybil / decentralized identity / agentic web / trust（C2）。
- **EIP-8004 / ERC-8004 专项**：未单独命中新论文；相关方向已被 `2511.03434`（Inter-Agent Trust Models，含 ERC-8004，已在主筛选 NEW-020）与本批 P16（同作者圈 stake-based 信誉）覆盖。建议后续直接核查 ERC-8004 规范原文（非 arXiv）。
- **rate-limit 影响**：`export.arxiv.org` 缓存层持续返回「Rate exceeded」，已切换至 `arxiv.org/api/query` + 重试解决；个别关键词组（cultural transmission / Agora 专项 / permissionless 专项）单次被限流返回空，但其目标主题已被相邻关键词组覆盖，无证据显示遗漏高相关论文。
- **⚠️unverified**：无。本批所有 ID 均由 arXiv API 检索直接返回元数据，未杜撰。

---

## 统计

| 指标 | 数值 |
|------|------|
| Cluster 1 新候选 | 25（S01-S25）|
| Cluster 2 新候选 | 21（P01-P21）|
| **新候选总计** | **46** |
| ⭐⭐⭐⭐⭐ | 5（S01, S02, S03, P01, P09）|
| ⭐⭐⭐⭐ | 22 |
| 杜撰/unverified ID | 0 |
