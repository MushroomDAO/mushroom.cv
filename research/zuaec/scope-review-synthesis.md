# Scope-Review Synthesis & Paper 1/2 Organization Map

> **创建**：2026-05-22 | **状态**：🟡 living document（随阅读笔记增加持续追加）
> **用途**：把所有已全文精读的文献按主题聚类、记录核心意图、并映射到 Paper 1 / Paper 2 的具体位置；标注哪些**强化**我们的 P+SC+N 框架、哪些构成**张力/挑战**。
> **配套**：`paper1-reading-notes/`（逐篇笔记）、`paper1-literature-screen.md`（PRISMA 候选库）

---

## 0. 我们的框架锚点（映射时的坐标系）

- **范式**：AI agent = **社会角色承载者（role-bearing social agent）**，携带可验证委托人身份；**反对**把 agent 当作"可调用的能力容器"（capability container）。
- **三支柱**：
  - **P** = Collaboration Protocols（协作协议；Paper 2 = ASM）
  - **SC** = Quantified Social Capital（量化社会资本；Bourdieu + Putnam + Ostrom）
  - **N** = Permissionless Network（无许可网络拓扑）
- **可证伪命题**：P1–P5。
- **实证**：Mycelium Protocol（Sepolia 测试网 → 计划 OP 主网）。
- **§2 核心差异化论断**：已有工作把**单一**社会科学理论（Ostrom / Putnam / Parsons）分别套用到 agent；我们提供**首个统一、可证伪的三支柱框架**，并落到协议规范 + 量化声誉 + 无许可网络。

---

## 1. 主题聚类（已精读 14 篇）

### Cluster A — 范式批判：能力调用 vs 社会角色（Paper 1 §1/§2 骨架）
| 论文 | 一句话核心意图 | 对我们的作用 |
|------|--------------|------------|
| Chen et al. 2025（静态沙盒不足）| 静态 benchmark 无法建模社会复杂性，需开放式协同演化 | ✅ 支撑"能力调用范式不足"；提供"适应本体"概念 |
| Huang et al. 2026（15 种涌现风险）| 集体失败模式无法被 agent 级措施阻止，需机制级治理 | ✅✅ 最强实证：能力级不足 → 需 P+SC+N（机制级）；并入 Paper2 §6 威胁模型 |
| Song et al. 2024（Multi-Agents are Social Groups）| agent 集体应被视为受社会影响的社会群体 | ✅ §2 范式基石："agents 是社会群体"的实证 |
| Han et al. 2026（Social Physics + AI）| 用社会物理学研究 AI 群体的 6 个方向 | ✅ §1/§2 学科框架背书 |
| Park et al. 2023（Generative Agents）| 记忆流+反思+规划架构使 25 个沙盒 agent 涌现可信社会行为 | ✅ §2 "能力容器→社会能动"谱系的**经典过渡节点**；可信≠可问责（无可验证身份/协议/SC，封闭沙盒）正是我们填补处 |
| Haase & Pokutta 2025（六层能力连续体, v3 2026 living doc）| LLM-as-Tool→复杂自适应系统的 6 级能力定位 + OODA | ⚠️**生产性张力**：它是"能力定位"最系统的陈述 → 我们"社会角色定位"轴的最佳对照；它把 role 当 persona、protocol 仅作 L4 要求、SC 仅描述性，恰好留下 P/SC/N 缺口。引用其转述的 Han 2024（静态网络结构无法稳定 LLM 合作）佐证 N+SC |

### Cluster B — 制度/社会科学理论套用到 Agent（Paper 1 §2 理论竞争者）⚠️
| 论文 | 用的单一理论 | 我们的差异化 |
|------|------------|------------|
| Gupta et al. 2025（Ostrom 规范形成）| Ostrom（3/8 原则）| 仅 Ostrom、仿真假设非演绎命题、无协议/SC量化/无许可网络 |
| Ruan 2026（Parsons AGIL 架构）| Parsons AGIL | 仅 Parsons、概念架构无部署/无 SC 量化 |
| **Harre 2025（从企业到计算）**| 多理论综合（Price 方程多层选择 + Aoki 企业即计算 + Ostrom 8 原则 + Acemoglu 包容/榨取制度）| ⚠️**野心上最接近的竞争者**（也融合多理论含 Ostrom+多中心）。但把 AI 建模为可复制的推理单元/生产要素（=能力容器，fitness=部署频率）、量化的是 fitness 协方差而非社会资本、无可部署协议、无无许可网络、自承认无操作化可证伪命题。无 Bourdieu/Putnam |
| **Bracale et al. 2026（Institutional AI，实际标题含 "in Multi-Agent Cournot Markets"）**| Ostrom 制度语法（ADICO/ABDICO）+ 规范性 MAS/电子制度 | ⚠️**协议支柱(P)与可证伪性上最强的竞争者**，必须慷慨致谢：可部署可审计治理图清单 + Oracle/Controller 运行时，严格实验（N=90/条件）将合谋 tier 3.1→1.8、严重合谋 50%→5.6%（prompt-only "宪法"失效处）。但显式把 agent 当**黑箱能力容器**、量化市场结构合谋信号(HHI/CV)而非 SC、运行于封闭 2 厂双寡头 + 中心化外部强制（非无许可 N）、框定为对抗安全而非社会角色赋能。companion: Pierucci et al. 2026（2601.10599）待读 |

### Cluster C — 大规模社会涌现 / 内生倾向（Paper 1 §2/§4）
| 论文 | 核心意图 | 作用 |
|------|---------|------|
| Li et al. 2025（利他涌现）| 不同 LLM 内在利己/利他异质；留言板=规范机制 | ✅ "轻量社会层塑造集体行为"=我们 P+SC 的弱版；差异：我们量化 SC |
| Takata 2024（agent 个体性涌现）| 社会交互中自发涌现个体性 | ✅ N 维度 + 社会涌现 |
| Zhang et al. 2026（超越预设身份）| 预设身份脆弱、会被交互溶解；呼吁认知层对齐 | ⚠️**张力文献**：诊断相同（prompt 决定论失败），处方分叉（认知内化 vs 我们协议外化+SC 强制力）|

### Cluster D — 人机协作 / 共演化（Paper 1 §1/§4 + Paper 2 §6 治理）
| 论文 | 核心意图 | 作用 |
|------|---------|------|
| Ju & Aral 2025（n=2234 实地实验）| AI 队友使产出 +50% 但内容同质化 | ✅✅ §4.1 最强实证：混合团队收益 + 同质化风险 |
| Chakraborty 2026（条件互利共生）| 宏观人–AI 共存可达稳定均衡（ODE/Lyapunov）| ✅ §1 动机 + Paper2 §6 治理正式化背书；差异：宏观 vs 我们协议实现层 |
| Feng et al. 2026（PNAS 最优嵌入比例）| 演化图论给出 AI 嵌入社会的最优比例 | ✅ §4 网络 N 的定量依据 |

### Cluster E — 协议层（Paper 2 核心）
| 论文 | 核心意图 | 作用 |
|------|---------|------|
| ACPs 2025（Agent Collaboration Protocols）| IoA 的 agent 协作协议 | ✅ Paper2 §2 比较表核心竞争行；Paper1 §5 |
| Fleming 2025（分层协议架构, Cisco）| 在 HTTP/2/3 之上提出 OSI 式 L8（Agent Communication：信封/言语行为/交互模式）+ L9（Agent Semantic：语境握手/grounding/Ripple-Effect 共识）| ✅ Paper2 §2 分层/架构参照（前沿=**语义**互操作，与 ASM 的**社会角色能动**正交；ASM 3-block ≈ L8 信封 + 角色凭证块）；其 §5 语义层威胁（语义注入/语境投毒/语义降级）→ §6 对手输入；联邦 Schema-Authority = ASM 无许可 ZK 声誉的中心化对照 |
| Threat Modeling 2026（CIC/UNB+Mastercard，含 "Emerging...MCP/A2A/Agora/ANP"）| 首个跨协议威胁模型：12 漏洞×3 生命周期 + NIST 风险矩阵；MCP 实证 wrong-provider 执行 Violation Rate 高达 1.0（缺身份绑定）| ✅✅ Paper2 §6 **主要输入**：其分类支撑 ASM 8 攻击者交叉映射；VR=1.0/0.52 = ASM 角色/凭证密码学绑定的可引用动机；逐协议判定（MCP 高危、ANP 因 DID 低危）填充 §2 比较基线 |

### Cluster F — 综述/背景（Paper 1 §1）
| 论文 | 核心意图 | 作用 |
|------|---------|------|
| Xi et al. 2024（LLM agent 综述）| 全面综述，含 Agent Society 专章 | ✅ §1 背景 + §2 基础引用 |

---

## 2. Paper 1 ↔ Paper 2 章节映射（已精读部分）

| 论文 | Paper 1 | Paper 2 | 支撑/张力 |
|------|---------|---------|----------|
| Xi 2024 | §1 背景, §2 | — | 支撑 |
| Chen 2025 | §2（能力调用不足）, §4 未来 | — | 支撑 |
| Huang 2026 | §2（最强实证）| §6 威胁模型 | 支撑 |
| Song 2024 | §2（范式基石）| — | 支撑 |
| Han 2026 | §1/§2 框架 | — | 支撑 |
| Gupta 2025 | §2（Ostrom 竞争者）, §6 | — | 支撑（差异化）|
| Ruan 2026 | §2（Parsons 竞争者）| — | 支撑（差异化）|
| Li 2025 | §2（社会层塑造行为）| — | 支撑 |
| Takata 2024 | §2/§4（社会涌现, N）| — | 支撑 |
| Zhang 2026 | §2（⚠️ 角色脆弱性）| — | **张力**（需正面反驳）|
| Ju & Aral 2025 | §4.1（实证：收益+同质化）| — | 支撑 |
| Chakraborty 2026 | §1 动机 | §6 治理 | 支撑 |
| Feng 2026 | §4（N 定量）| — | 支撑 |
| ACPs 2025 | §5 | §2 比较表 | 支撑（竞争）|
| Park 2023（Generative Agents）| §2（过渡节点）| §2 baseline | 支撑 |
| Haase 2025（六层连续体）| §2（能力定位对照轴）| — | **生产性张力** |
| Harre 2025（企业到计算）| §2（多理论竞争者）| — | **竞争**（差异化）|
| Bracale 2026（Institutional AI）| §2（P+可证伪竞争者）| §6 治理对比 | **强竞争**（差异化）|
| Fleming 2025（分层架构）| §5 | §2 分层参照 + §6 语义威胁 | 支撑（竞争）|
| Threat Modeling 2026 | — | §6 主要输入 + §2 基线 | 支撑 |
| CAMEL 2023 | §2（role-as-persona 靶子）| §2 通信 baseline | 支撑（靶子）|
| Mou 2024（Individual→Society 综述）| §2（领域图+SC/N锚）| — | 支撑（+轻张力）|
| Chen 2024（Internet of Agents）| §5 | §2 最直接 baseline | 支撑（中心化能力调用对照）|
| Piao 2025（极化涌现, 1000+ agents）| §4（机机协作风险）| — | 支撑 via 张力（开放无治理→极化）|
| Wang 2024（LLM autonomous agents 综述）| §1/§2（旧范式画像）| — | 支撑（靶子："role"=prompt 里的 profile 字符串）|
| Yao 2022（ReAct）| §1 谱系 + §2 对照 | — | 支撑（靶子：单 agent 能力增强，零社会/角色/身份维度）|
| Zeng 2025（超对齐）| §1 动机 + §4 | §6? | 支撑（差异化：内部认知对齐 vs 我们网络化 P/SC/N）|
| Shen 2026（双向对齐, ⚠️CHI workshop 提案）| §1/§4 | — | 支撑+张力（勿过度引用为方法；引其综述 2406.09264 / ValueCompass 2409.09586）|
| Ehtesham 2025（互操作协议综述 MCP/ACP/A2A/ANP）| — | §2 比较表（传输/发现轴）| 支撑（baseline；明确点名"agent 协作信任框架"未解）|
| Hu & Rong 2026（Inter-Agent Trust Models, AAAI26）| — | §2 比较表（信任轴）| 支撑（六模型信任分类；ASM 的 ZK 声誉回应其指出的 ERC-8004 隐私/Sybil 弱点）|

> **Paper 2 §2 比较网格 = Ehtesham（传输/发现/身份轴）× Hu&Rong（Brief/Claim/Proof/Stake/Reputation/Constraint 信任轴）**；ASM 定位 = 绑定角色（非仅身份）+ ZK 声誉 + 无许可多方 + 人类授权可问责。ERC-8004 规范需直接查官方（非 arXiv）。

| Fei 2026（Agents Evolve, Institutions Follow）| §2 制度景观 + §4（结构>能力, >57pp 差距）| — | 支撑（结构重要）+ 竞争（拓扑模板套同质能力容器，无统一框架/SC/协议/N）|
| Evans 2026（下一次智能爆炸：城市非神脑）| §1 动机（强支撑）| — | 强支撑（"智能是复数/社会的"；甚至说"身份不如履行角色协议重要"——支撑角色中心性，⚠️见 §3.6）；我们操作化其愿景 |
| AutoGen 2023（对话编程）| §2/§5 | §2 baseline | 支撑（靶子：role=设计期配置标签，无身份/声誉/问责；"去中心化"=软件模块化非网络 N）|
| Quan 2026（Towards AI as Colleagues / MultiColleagues, CHI26）| §1 动机 + §4 | — | 支撑+缺口（HCI 证明社会角色有价值，但 colleague 是"感觉到的"主观、无持久身份/SC、问责留白"moral crumple zones"）；我们把"感觉的同事"变"结构性同事" |
| Gossip 2026（ALIGN：八卦驱动间接互惠, ICML26）| §SC 支柱 | §5 声誉 | 支撑（声誉/间接互惠涌现，但是涌现/语言/局部/未量化/不可移植）；其虚假八卦攻击=我们 SC 抗操纵动机 |
| DIAP 2025（去中心化 agent 身份协议, ZJU/ANP）| — | §3 身份 + §5 ZK 直接竞争 | 竞争（绑 IPFS CID + Noir ZK 仅证密钥控制）；ASM 加：角色+人类授权绑定、ZK 声誉累积、角色状态机；⚠️DIAP 电路为占位符无证明（原型）；同校 ZJU 工作 |
| Cultural Evolution of Cooperation 2024（Vallinder/Hughes DeepMind, Donor Game）| §2（SC 支柱）| — | 支撑（跨代涌现间接互惠规范，但模型依赖、声誉故意不编码、封闭同质、无量化资本）|
| Norm Evolution in NL 2024（UTokyo, Axelrod Norms Game）| §2（SC 支柱）| — | 支撑+张力（连二阶 metanorm 都涌现，但 n=7 封闭、初值依赖、自由聊天≠可互操作协议、无可累积资本）|

> **§2 "规范涌现"括号**：Cultural-Evolution 2024 + Norm-Evolution-NL 2024 + Gupta 2025 + Li 2025 共同证明"规范/声誉能涌现"——但都是**涌现/描述性、封闭、未量化、不可移植**。我们的差异 = **工程化、量化、可移植**的 SC + 协议强制(P) + 无许可基底(N)。

| MetaGPT 2023（SOP 角色框架, ICLR24）| §2（比 CAMEL 更精致的 role-as-config）+ §3 | §2 baseline | 支撑（靶子："SOP 角色=设计期槽位，agent 即其 SOP"；自改进只编辑私有约束 prompt 无共享声誉；AgentStore 非无许可）|
| AgentBench 2023（能力评估基准, ICLR24）| §2/§3（能力度量范式）| — | 支撑（靶子：29 LLM×8 环境全任务成功率；**结构性无视声誉/信任/角色保真/纵向社会地位**，每任务重置不携带）→ 是我们 §3"可证伪命题/部署数据评估 vs 能力 benchmark"的关键对照 |
| Insured Agents 2025（信任保险机制, Oxford/UCOBRC）| — | §2/§5 声誉竞争 | 竞争（质押+保险市场+TEE 审计，子博弈完美均衡）；其 §4 自列"proof-carrying ZK/MPC"为开放问题=ASM intent-proof 块的卖点；ASM 用 ZK accumulator 声誉替代保险中介+脆弱 TEE |
| Semantic View of Protocols 2026（18 协议综述, 3 层分类）| §5 | §2 理论脚手架 + §5 比较 | **互补**（提供 communication/syntactic/semantic 分层 + 命名技术债：performative 歧义/本体 grounding/会话管理）；ASM 定位语义层；其揭示最近竞争者 **Coral（DID+链上声誉）**——ASM 用 ZK accumulator 声誉（不披露历史即可验证）区分 |

> **新增待查竞争者**：Coral（DID + on-chain reputation，由 Semantic-View 综述揭示）→ Paper 2 §2/§5 需对比。**标题修正**：Insured Agents = "Decentralized Trust Insurance **Mechanism** for Agentic Economy"（Hu+Chen, 非 ERC-8004 提案人）。

| Self-Evolving Agents 综述 2025（55pp）| §1/§2（统一但非社会的 foil）| — | 支撑（靶子）：其"统一反馈循环框架"统一的是**能力自我改进**，我们统一的是**社会嵌入(P/SC/N)**——直接守护我们"首个统一框架"论断 |
| From Persona to Personalization 综述 2024（TMLR）| §2（role-as-persona 定义性 foil）| — | 支撑（靶子）：其"role"=可表演的 persona，judged by 可信度；我们=可验证可问责的社会角色——**可信度轴 vs 问责轴**的最干净对比 |
| Song 2026（混合种群公平性演化, Phil.Trans.R.Soc.A）| §4 + SC/N | — | **强支撑**："AI 处于**执行角色**驱动公平 >> 建模角色"=**角色/位置胜过亲社会性**的形式化弹药，直接撑 role-bearing；其延后声誉/结构网络/学习=P/SC/N |
| HAIF 2026（人–AI 整合框架, Bara 单作者）| §4 + P | — | 支撑+张力：Design-Science 委托矩阵+自治分级，但**无可验证身份/无可移植声誉/无无许可网络**，§12 明确排除 agent 间编排、问责锚定到具名人类 → 边界："HAIF 治理**企业内**AI，我们治理**跨网络**角色承载 agent" |
| Synthetic Social Graph 2026 ⚠️v1（Cha&Kim, LG Uplus, Putnam）| §2 SC（Putnam 支柱）+ N | — | 支撑（不是竞争）：首个 agent-only 平台社会学审计（Moltbook 184k 帖），用 Putnam bonding/bridging；"注意力 bonding 无交换 bonding"（互惠 3.8% vs 人类 10-30%）=我们 SC 量化机制的问题陈述。⚠️**版本陷阱**（见 §3.8）|
| Rouhani→实为 TU Berlin 2025（DID+VC for agents）| — | §3 身份 baseline | 支撑/baseline：DID+VC+账本锚定+DIF Presentation Exchange；缺 ASM 四增量（角色+人类授权绑定/ZK 声誉/协作状态机/无许可）；其"LLM 独自负责安全不可靠"=ASM 动机 |

---

## 3. 关键张力 / 审稿风险（必须在写作中正面处理）

1. **Zhang et al. 2026（角色脆弱性）**：审稿人最可能的质疑——"既然预设身份会被交互溶解，为何坚持持久角色？" 反驳策略：双方诊断一致（prompt 决定论失败）；处方互补（他们=认知层内化，我们=协议外化 + SC 经济强制力）；其 café "软制度无强制力"正是 SC 填补的缺口。
2. **§2 创新点降级**：已有 Gupta(Ostrom)/Ruan(Parsons) 等单理论应用 → 不能说"首次桥接"，改为"**首个统一三支柱可证伪框架**"。
3. **理论竞争者密度上升**：制度理论套用 AI 的工作 2025-2026 快速增加。最强两个：
   - **Bracale 2026** = 协议(P)+可证伪性最强竞争者（可部署治理图 + N=90 实验降合谋 50%→5.6%）。护城河：我们 = role-bearing 社会赋能（非黑箱安全）+ 量化 SC（非市场结构信号 HHI/CV）+ 无许可 N（非中心化双寡头）+ 统一三支柱。
   - **Harre 2025** = 野心/多理论综合最接近（含 Ostrom+多中心）。护城河：我们有可部署协议 + 量化 SC + 无许可 N + 操作化 P1–P5（它自承认都没有）。
4. **Haase 2025 的"能力定位"轴**：审稿人可能问"社会角色定位 vs 能力连续体定位有何本质区别？" 答复：能力定位回答"agent 能做什么"，社会角色定位回答"agent 在协作网络中是谁、对谁负责、积累了什么声誉"——后者才是长链社会经济交易的前提。
5. **Piao 2025 = 经验性威胁模型**：开放无治理 agent 社会自发极化、结晶化；外生干预一旦结晶即失效 → 正是我们 SC/治理必须**内生且持久**的理由。
6. **Evans 2026 的"角色>身份"措辞**：Evans 说"agent 的身份不如其履行角色协议的能力重要"。这**支撑**我们的角色中心性（P=角色协议），但与我们强调"可验证委托人身份"略有张力。调和：可验证身份不是为了 agent 本身的"个性"，而是为了**问责链与声誉归属**（SC 必须挂靠到持久身份才能累积/防 Sybil）——即身份服务于角色与声誉，而非相反。可在 §1/§2 用 Evans 背书"角色协议"，同时用 Sybil/问责论证身份必要性。
7. **Quan/Shen = HCI 侧"感觉的社会角色"**：审稿人可能说"agents 当同事已有 HCI 工作"。差异：他们测主观社会临场感（10 分钟单 app），无持久身份/量化 SC/问责机制；我们提供结构性机制。

> **标题/版本修正（写引用时务必用准确版本）**：Evans 2026 = "Agentic AI and the **next** intelligence explosion"；Quan 2026 = "**Towards AI as Colleagues: Multi-Agent System Improves Structured Ideation Processes**"（无 "Professional"，系统名 MultiColleagues, N=20）；Fei = KAUST+Fudan v1；Gossip = Zhu et al. ICML 2026；DIAP = Liu et al. ZJU/Binjiang/ANP。

8. **⚠️ 引用完整性高危项（夜间核查发现，Jason 必看）**：
   - **arXiv:2604.27271 版本被替换**：v1(2026-04-29)="The Synthetic Social Graph...(Putnam)"（我们要的），但**同一 ID 的 v3(2026-05-12) 已变成 "Frame Entrepreneurs in an AI Agent Community"，完全删掉 Putnam/社会资本**。默认 pdf 现在给 v3。→ 引用 v1 即引用"被替换的预印本"，有风险。本地已存 `papers/synthetic-social-graph2026-v1.pdf`（v1）。备选替代：2602.13458 / 2604.09561 / 2510.19299 / 2604.06199（需另核）。
   - **arXiv:2511.02841 作者纠错**：screen 文件原标 "Rouhani et al." **错误**；实际作者 = Rodriguez Garzon, Vaziry, Kuzu et al.（TU Berlin）。已在 paper1-literature-screen.md 修正。
   - 提醒：所有夜间笔记的引用元数据以**实际 PDF 首页**为准；正式提交前过一遍 `/ars-citation-check`。

---

## 4. 进度与待补
**已精读并入本图（24 篇）**：本波新增 Park2023, Haase2025, Harre2025, Bracale2026, Fleming2025, ThreatModel2026, CAMEL2023, Mou2024, Chen2024(IoA), Piao2025。
**下一波（Wave 3+，已知高价值未读）**：
- Group D 基础经典：ReAct(2210.03629), AutoGen(2308.08155), MetaGPT(2308.00352), AgentBench(2308.03688), Voyager(2305.16291), 自我演化综述(2508.07407), From Persona to Personalization(2404.18231), LLM autonomous agents 综述(2308.11432)
- 人机协作/共演化：Zeng 超对齐(2504.17404), Shen 双向对齐(2512.21551), HAIF(2602.07641), Song 公平性演化(2602.18498)
- 制度/演化：Fei When Agents Evolve(2604.27691), AgentReputation(2605.00073 ⚠️验证), Pierucci companion(2601.10599)
- 协议/身份（Paper2）：Agent 互操作综述(2505.02279), AI Agent 协议综述(2504.16736), Inter-Agent Trust Models(2511.03434), ANP 白皮书(2508.00007), DID+VC for agents(2511.02841)
- 前沿立场：Evans 智能爆炸(2603.20639), Quan AI as Colleagues(2510.23904)

**数据修正**：Bracale 2026 实际标题含 "in Multi-Agent Cournot Markets"；Haase 2025 为 v3 (2026-05-18 living doc)，引用需带版本+访问日期；Mou 2024 = "From Individual to Society: A Survey on Social Simulation Driven by LLM-based Agents"（Fudan/ECNU/HIT/SII）。

> 每当 `paper1-reading-notes/` 新增一篇，就回填到 §1 聚类、§2 映射表、（如有张力）§3。
