# [Harré 2025] From Firms to Computation: AI Governance and the Evolution of Institutions

**Citation**: Michael S. Harré. "From Firms to Computation: AI Governance and the Evolution of Institutions." arXiv:2507.13616v1 [cs.HC], 18 Jul 2025 (title page dated July 21, 2025). 44 pp incl. appendices.
**机构**: School of Computer Science, Centre for AI Trust and Governance, University of Sydney
**arXiv**: https://arxiv.org/abs/2507.13616
**PDF**: papers/harre2025-firms-to-computation.pdf
**Cluster**: Institutional Theory Applied to AI — ⚠️ theory competitor — Paper 1 §2
**Status**: ✅ 全文已分析（2026-05-22）

> **标题核对**：与任务下达的标题完全一致（"From Firms to Computation: AI Governance and the Evolution of Institutions"）。v1，单作者。无差异。

## Core claim (一句话)
将三个既有理论框架——多层级选择（MLS）、Aoki 的"企业即内生计算"、Ostrom 的共池资源（CPR）设计原则——综合成一个进化博弈论框架，把 AI 治理重述为：制度规则作为"对齐算子（alignment operators）"调制嵌套博弈中的多层级 Price 方程协方差结构，从而在 human-AI 混合组织中通过选择压力筛选出促进合作的制度安排。

## 研究问题
当 agential AI（自主决策、追求目标、影响制度环境的 AI）进入经济组织成为战略行动者时，传统组织行为与制度演化框架如何扩展？具体聚焦"agential-alignment problem (AAP)"：如何确保半自主 agent（人类与算法）的行动服务于组织目标而非狭隘自利。作者把 AI 安全/对齐定位在更宏观的 MLS–制度演化框架内。

## 理论框架与方法
- **使用的社会科学理论（多个，但以制度经济学+进化论综合为主轴）**：
  1. **多层级选择理论（MLS）+ Price 方程**：核心数学工具。把组织绩效变化分解为组间选择 + 组内选择项；并扩展到 human-AI 组织，新增"AI 组内选择项"和两个"跨 agent 交互协方差项"（Eq. 2）——这是论文声称的主要技术创新（附录 B 详尽展开）。
  2. **Aoki 的企业理论**：企业=分布式信息处理结构/超模博弈集合 {G1...Gn}，制度=博弈的内生均衡。提供微观基础。
  3. **Ostrom 的 8 条 CPR 设计原则**：被重新诠释为"对齐算子"（alignment operators），调制 Price 方程的协方差结构。附录 A 提出 11 条 AI 版设计原则（在 Ostrom 8 条基础上加：算法透明、价值对齐机制、自适应实验）。
  4. **Acemoglu 的包容性 vs 榨取性制度**：用于分析权力分配如何塑造 AI 治理轨迹（Table 2）。
- **方法**：纯理论综合 + 形式化建模（Price 方程、replicator dynamics Eq. 5、规则配置适应度 Vj = fj(π*) − cj 含 Williamson 交易成本项 cj）；一个 Prisoner's Dilemma 渐进式制裁的 worked example（§3，λki 惩罚项把背叛变为劣势策略）；四个定性案例研究（算法交易公司、Amazon 排班失败、ICANN 多利益相关方治理、Maine 龙虾渔业自组织）。
- **关键结果**：无实证数据，无实验。结果是概念性的——证明 MLS + Aoki + Ostrom 可以形式上统一为一个嵌套博弈上的多层级 Price 方程；制度规则本身受 replicator 选择压力筛选；提出 top-down/bottom-up 规则权衡（附录 C）和政策杠杆（§7）。Open research question 明确承认跨 agent 协方差项"如何用真实组织数据 operationalise"仍未解决。

## 论文未覆盖的范围（我们的差异化基础）

| 维度 | This paper (Harré 2025) | 我们的框架 (P/SC/N) |
|------|------|------|
| 核心社会科学理论 | 综合 MLS（进化论）+ Aoki + Ostrom + Acemoglu，但**经济学/进化论主轴**，无 Bourdieu/Putnam 社会资本 | 三支柱明确整合 Bourdieu+Putnam+Ostrom 的社会资本理论 |
| Agent 本体论 | AI 作为"复制的推理 agent"/进化单元/生产要素，**能力容器视角**（fitness=部署频率、算力分配） | AI 作为**社会角色 agent**（role-bearing，可验证 principal 身份） |
| 协议 (P) | 无可部署协作协议；制度规则是抽象的"对齐算子"transformation Tj | 明确的 ASM 通信协议（Paper 2） |
| 量化社会资本 (SC) | 有量化（Price 方程协方差、HHI 概念缺失），但量化的是"适应度/绩效协方差"，非声誉/社会资本 | 量化的社会资本/声誉（基于 Bourdieu/Putnam/Ostrom） |
| 无许可网络 (N) | 假设"良混合的企业种群"、firm-internal 治理；**企业边界内的封闭组织**，非无许可开放网络 | 无许可开放协作网络 |
| 可证伪命题 | 无 P1–P5 式可证伪命题；纯解释性框架，自承缺 operationalisation | 5 条可证伪命题 P1–P5 |
| 验证 | 无实证（4 个定性案例 anecdote） | （Paper 框架定位为可证伪 + 协议可部署） |

## Paper 1 §2 区分段落（~200词）
Harré (2025) is the most direct theory competitor to our three-pillar framework: like us, it explicitly fuses multiple social-science traditions—multi-level selection, Aoki's firm-as-computation, Ostrom's commons design principles, and Acemoglu's inclusive/extractive institutions—rather than applying a single lens, and it even shares our Ostrom anchor and our concern with permissionless, polycentric arrangements. We acknowledge this synthesis as genuinely ambitious and the most sophisticated formal account in the cluster. The decisive differences, however, are three. First, on **theory**: Harré's integrative axis is evolutionary-economic (the Price equation over nested games), and crucially it omits the social-capital tradition of Bourdieu and Putnam that constitutes our second pillar (SC); his "quantification" measures fitness–performance covariances, not verifiable reputation or social capital. Second, on **agent ontology**: AI is modeled as a replicating inferential unit or factor of production—an invocable capability container whose "fitness" is deployment frequency and compute allocation—whereas our agents are social-role agents bearing verifiable principal identity. Third, on **deployability and falsifiability**: Harré offers no deployable collaboration protocol (P), no permissionless open network (N) beyond firm-internal governance, and—by his own admission in the open-research-questions section—no operationalized, falsifiable propositions; the cross-agent covariance terms remain a measurement aspiration. Our framework supplies a concrete protocol (ASM), quantified social capital, a permissionless network, and five falsifiable propositions (P1–P5). Harré thus represents the closest *single-discipline-cluster* synthesis but not a unified P+SC+N framework.

## Action items
- [ ] 在 Paper 1 §2 引用为"最接近的理论综合竞争者"——承认其多理论融合的雄心，再精准区分（缺 Bourdieu/Putnam 社会资本、缺可部署协议、缺无许可网络、缺可证伪命题）。
- [ ] 在 §2 关于"Ostrom 应用于 AI"的段落与 Gupta2025 并列引用（两者都用 Ostrom，但 Harré 是综合而非单一）。
- [ ] 可在 SC 支柱讨论中借用其"对齐算子调制协方差结构"的形式化语言作对照，强调我们量化的是社会资本而非适应度协方差。
- [ ] 注意：其附录 A 的 11 条 AI 设计原则可作为我们 P/N 支柱"制度层面 vs 协议层面"区分的反衬材料。

## Jason's feedback
> （请在此处写入你的feedback）
