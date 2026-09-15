# [Mou et al. 2024] From Individual to Society: A Survey on Social Simulation Driven by Large Language Model-based Agents

**Citation**: Xinyi Mou*, Xuanwen Ding*, Qi He*, Liang Wang*, Jingcong Liang, Xinnong Zhang, Libo Sun, Jiayu Lin, Jie Zhou, Xuanjing Huang, Zhongyu Wei†. "From Individual to Society: A Survey on Social Simulation Driven by Large Language Model-based Agents." arXiv:2412.03563v1 [cs.CL], 4 Dec 2024. (*Equal contribution; †Corresponding author.) Repository: https://github.com/FudanDISC/SocialAgent
**机构**: Fudan University; East China Normal University; Harbin Institute of Technology (Shenzhen); Shanghai Innovation Institute
**arXiv**: https://arxiv.org/abs/2412.03563
**PDF**: papers/individual-to-society-survey2024.pdf
**Cluster**: Scoping-review 锚点综述（LLM-agent 社会模拟全景）。为 Paper 1 §2 提供"individual → scenario → society"三层演进的 related-work 框架与时间线证据；其 society-simulation 的四要素（composition / network / social influence / outcomes）为 Paper 1 SC（社会资本）与 N（网络）支柱提供文献支撑与对照基线。
**Status**: ✅ 全文已分析（2026-05-22）；标题、作者、机构、arXiv id 全部核实一致

## Core claim (一句话)
LLM 凭借 role-playing 带来的"算法保真度（algorithmic fidelity）"可替代人类受试者来模拟社会行为；本综述把该领域系统地划分为三类——Individual / Scenario / Society Simulation——三者呈递进关系（个体细粒度建模 → 大规模社会现象），并逐类梳理架构/关键组件、目标场景分类、评估方法、数据集与跨类趋势。

## 研究问题
传统社会学研究依赖人类参与，昂贵、难规模化且有伦理风险。LLM-driven agents 能否作为人类替身可信地模拟个体响应与社会动态？围绕"个体建模的精度需求"与"多样性/规模需求"两条轴，如何对该快速膨胀的领域做系统分类、并辨明各类模拟的核心构件与评估方式？

## 方法与主要内容
**三层分类法（Fig. 1）**：
- **Individual Simulation**：模拟特定个体或共享人口学特征的群体（Profile / Memory / Planning / Action），聚焦单人特征复制（如人格），不含多 agent 交互。
- **Scenario Simulation**：在集中场景下由具体目标/任务驱动一组 agent 协作（软件开发、QA、论文评审），强调专长 agent 的集体智慧，规模小。
- **Society Simulation**：模拟 agent 社会中更复杂多样的行为以探究真实世界社会动态（既可小范围检验社科理论，也可大规模填充虚拟社区）。源头追溯到 Park et al. generative agents。

**Society Simulation 的四大社会构造要素（§5.1）**：
1. **Composition（构成）**：社会由海量异质（heterogeneity）个体组成——信念、偏好、行为、规范价值、社会结构中的位置各异；建模多样性是捕捉复杂社会动态的前提。
2. **Network（网络）**：用图结构刻画（节点=个体，边=关系），决定信息与影响的扩散方向；区分 offline / online 网络；引入 homophily（同质相吸）原理；大规模时常用真实关系 + 合成关系混合或按同质性连接。
3. **Social Influence（社会影响）**：即社科中的 embeddedness（嵌入性）；分"影响接收方"（同信息因 profile 不同而异，可叠加 cognitive bias、norm reflection）与"影响施加方"——援引 **Pareto 分布 / Matthew Effect**，指出影响力集中于少数已占优势者，故发送者的**身份、地位与声誉**至关重要（opinion leaders 建模、social impression memory、party affiliation）。
4. **Outcomes（结果）**：emergent 群体行为与系统级结果。

**趋势（§7）**：三类各自经历"粗粒度表层特征 → 更细致角色 → 情境驱动"（individual）、"简单 → 多阶段 → 协作场景"（scenario）、"构建初步环境（pre-Jun 2023）→ 特定场景对齐（至 Feb 2024，首次发表激增）→ 规模化 + 多模态"（society）的演进。综述还汇总常用数据集与 benchmark，并以代表作时间线图（Fig. 7）锚定关键节点（Generative Agents、EconAgent、OASIS、WarAgent 等）。

## 论文未覆盖的范围（我们的差异化基础）

| 维度 | This paper (Mou et al. survey) | 我们的框架（P/SC/N） |
|------|-------------------------------|---------------------|
| 研究目的 | **描述/解释**已有社会模拟工作，目标是"用 agent 复现/预测人类社会现象"（社科研究工具） | **规范性构建**：设计真实部署的开放协作网络，agent 是承载可验证委托人身份的生产性社会角色，而非人类受试者的替身 |
| 角色性质 | 角色 = profile + role-playing 人格（算法保真度的素材），服务于模拟可信度 | 社会角色 = 承载**可验证委托人身份**、跨会话持久、可问责的 role-bearing agent |
| 社会资本 (SC) | 声誉/身份/地位仅作为 social influence 的**描述性输入**（opinion leaders、Pareto/Matthew Effect 的事后刻画），不是可累积、可转移、可激励的内生机制 | **量化社会资本（SC）**（Bourdieu/Putnam/Ostrom）作为可累积、可转移、影响准入与协作权重的内生状态变量；本综述虽列举 network/influence 却未将其统一为一个可证伪的资本理论 |
| 网络 (N) | network 作为信息扩散的**图结构建模对象**（offline/online、homophily），用于复现传播动态；无开放准入/无许可机制 | **无许可网络（N）**：任意 role-bearing agent 凭可验证身份无许可加入/退出开放协作网络 |
| 理论整合 | 分散援引社科概念（heterogeneity、embeddedness、homophily、Matthew Effect），逐场景借用，未提出统一框架 | 将 P/SC/N 整合为**首个统一、可证伪的三支柱框架** |

## Paper 1 §2 区分段落（~200词）
Mou et al. (2024) is the most comprehensive scoping anchor for LLM-agent social simulation, taxonomizing the field into a progression from Individual to Scenario to Society Simulation, and — crucially for us — distilling four society-construction elements: composition (heterogeneity), network (graph structure, homophily), social influence (embeddedness, with reputation/identity/status mattering via the Pareto/Matthew Effect), and outcomes. This makes the survey an ideal SC/N anchor: it documents that prior work already gestures at social capital and network structure. However, the survey's purpose is descriptive — to help researchers *replicate and predict* human social phenomena, treating agents as human substitutes whose value is "algorithmic fidelity." Its agents are personas seeded for simulation realism, not role-bearing agents with verifiable principal identity, and reputation appears only as a descriptive input to influence, never as an accumulable, transferable, incentive-bearing capital. Our framework departs normatively rather than descriptively. (P) protocol-level role declarations and credentials, (SC) Quantified Social Capital grounded in Bourdieu/Putnam/Ostrom as endogenous state, and (N) a permissionless open network unify what the survey catalogues as scattered, scenario-specific borrowings (heterogeneity, embeddedness, homophily, Matthew Effect) into the first unified, falsifiable three-pillar framework for *deployable* agent collaboration, not social-science emulation.

## Action items
- [ ] Paper 1 §2：用本综述的 individual→scenario→society 三层分类与时间线（Fig. 7）作为 scoping-review 的领域版图骨架，定位我们的工作在"society"层但属规范性构建而非描述性模拟。
- [ ] Paper 1 SC 论证：引用 §5.1.3 的 Pareto/Matthew Effect 与"sender 的 identity/status/reputation 至关重要"作为社会资本存在性的文献支撑，同时指出综述未将其形式化为可累积/可转移资本（我们的差异）。
- [ ] Paper 1 N 论证：引用 §5.1.2 network（offline/online、homophily）说明现有工作把网络当作传播建模对象，缺乏无许可开放准入机制。
- [ ] Paper 1/2 §2：以"agent = 人类替身/算法保真度"（§1）对比"agent = 可验证社会角色代理"，强化范式转移叙事。
- [ ] 可作为 related-work 的引文枢纽，顺藤摸瓜补充其引用的 OASIS、EconAgent、WarAgent、CRSEC 等 society-simulation 代表作。

## Jason's feedback
> （请在此处写入你的feedback）
