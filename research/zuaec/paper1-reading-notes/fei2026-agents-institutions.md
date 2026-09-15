# [Fei, Guo & Xiao 2026] When Agents Evolve, Institutions Follow
**Citation**: Chao Fei, Hongcheng Guo, Yanghua Xiao. "When Agents Evolve, Institutions Follow." arXiv:2604.27691v1 [cs.AI], 30 Apr 2026. (Preprint.)
**机构**: Chao Fei — KAUST；Hongcheng Guo & Yanghua Xiao — Fudan University
**arXiv**: https://arxiv.org/abs/2604.27691
**PDF**: papers/fei2026-agents-institutions.pdf
**Cluster**: Institutional / evolution cluster — Paper 1 §2（理论 landscape）与 §4（governance topology 对照）
**Status**: ✅ 全文已分析（2026-05-22）

## Core claim (一句话)
将七种历史政治制度（跨四种典型治理模式：pipeline / gated_pipeline / autonomous_cluster / consensus）形式化为可执行的多智能体治理规范 G=(P,A,S,T,F)，在统一 runtime（SocialSystemArena）上跨 3 个 LLM 与 2 个 benchmark 实证检验，证明 **治理拓扑（governance topology）是 MAS 性能的一阶决定因素**，且不存在普遍最优制度——最优拓扑随模型能力与任务结构系统性漂移。

## 研究问题
1. 不同治理结构（组织拓扑）如何影响 MAS 性能？答案是否随底层模型与任务而改变？
2. 历史政治制度能否作为多智能体治理的「结构化设计空间」被受控实证研究？
3. 结构复杂度（gate density ρ）何时改善质量、何时触发 runaway failure loop？

## 方法与主要内容
- **SocialSystemArena**：把历史制度（秦汉郡县、蒙古帝国、唐三省、苏联党政、美国联邦、江户幕藩、雅典民主）翻译成 declarative governance specs，落在统一 GovernanceRuntime 上执行。
- 治理规范 G=(P, A, S, T, F)：P=模式（pipeline / gated_pipeline / autonomous_cluster / consensus）；A=agents 集合；S/T/F 为状态、转移、终止/失败逻辑。
- 跨 3 个商用 LLM 后端（Minimax M2.5、Kimi K2.5、Gemini 2.5）× 2 个 benchmark 评测。
- **核心发现**：(1) 同一模型上最好与最差制度差距 >57 个百分点（PinchBench 57–61 pp）；(2) 制度排名跨模型/benchmark **不泛化**，每个组合的最优都不同；(3) gate density ρ 是治理 overhead 的有用预测量，结构复杂度收益递减甚至为负（gated 拓扑放大成本不提升质量）。
- 提出愿景：从 self-evolving agent 转向 **self-evolving multi-agent system**，需要一个动态重选/重配治理拓扑的 meta-governance 层。

## 论文未覆盖的范围（我们的差异化基础）
| Dimension | This paper (Fei 2026) | 我们的框架 (P/SC/N) |
|-----------|------------------------|----------------------|
| 治理来源 | 历史政治制度作为「拓扑模板」，外生指定给同质 agent pool | (SC) 角色与社会资本从 agent 互动中**内生量化**积累，非外部指派拓扑 |
| 协议层 (P) | 治理=消息流拓扑（pipeline/gate/cluster/consensus），无可验证的跨 agent **通信协议** | (P) ASM 作为 role-bearing agent 的显式协作协议，含可验证 principal 身份 |
| 社会资本 (SC) | 无量化社会资本；用 ρ（gate density）与百分点准确率衡量「治理 overhead」 | (SC) Bourdieu/Putnam/Ostrom 的**可量化**社会资本作为一阶机制 |
| 网络 (N) | 封闭实验台、固定 agent 集合、静态 spec，无 permissionless 进入/退出 | (N) Permissionless network，agent 可自由加入/离开、身份可验证 |
| 角色本体 | agent 是治理拓扑里的**可替换槽位（同质 pool）**，能力容器视角 | agent 是 **social role agent**（role-bearing，可验证 principal） |
| 理论整合 | 单一学科：组织理论 / 政治制度史（North, Ostrom, March-Simon 等被并列引用，但作为「拓扑灵感」而非整合框架）| 首个**统一、可证伪的三支柱框架（P1–P5）**，整合 Bourdieu+Putnam+Ostrom |

## Paper 1 区分段落（英文，~180词）
Fei, Guo, and Xiao (2026) provide the strongest empirical evidence to date that *organizational structure*, not merely individual agent capability, governs multi-agent performance—the best-vs-worst institution gap exceeds 57 percentage points within a single model. Their SocialSystemArena recasts seven historical political institutions as executable governance specifications G=(P,A,S,T,F) and shows that no single topology is universally optimal. We build directly on this "governance matters" finding but depart along three pillars. First, their governance is an *externally imposed topology* over a homogeneous, interchangeable agent pool—agents are slots in a message-flow graph, the very capability-container view our paradigm rejects. We instead treat agents as **social role agents** whose roles and standing are *endogenously accrued* rather than assigned. Second, they quantify only structural overhead (gate density ρ), whereas we operationalize **quantified social capital (SC)** in the Bourdieu–Putnam–Ostrom tradition as a first-order mechanism. Third, their arena is a closed, static testbed with a fixed agent set; we target a **permissionless network (N)** with verifiable principal identity and a collaboration protocol (P). Where Fei et al. borrow institutional history as topology inspiration, we offer the first unified, falsifiable three-pillar framework (P1–P5).

## Action items
- [ ] §2 引用为「governance-topology / institutional-design」代表作，支撑「prior work 应用单一学科（组织/制度理论）于 agents」的论点。
- [ ] §4 引用其 57pp gap 与「无普遍最优拓扑」发现，作为「结构 > 个体能力」的实证背书，同时点明其缺 P/SC/N。
- [ ] 可对照其 G=(P,A,S,T,F) 形式化，与 ASM 协议形式化做并列（相似形式，不同本体：拓扑 vs role-bearing 协议）。
- [ ] 注意其 Related Work §2.3 引用 Park 2023 + GovSim(Piatti 2024)，与我们的 social-simulation cluster 重叠，可交叉引用。

## Jason's feedback
> （请在此处写入你的feedback）
