# [Chen et al. 2025] Static Sandboxes Are Inadequate

**Citation**: Chen, J., Badshah, S., Yu, X., & Han, S. (2025). Static Sandboxes Are Inadequate: Modeling Societal Complexity Requires Open-Ended Co-Evolution in LLM-Based Multi-Agent Simulations. *arXiv:2510.13982v3* [cs.MA], 21 Oct 2025
**机构**: Faculty of Computer Science, Dalhousie University; Meta, Vancouver
**arXiv**: https://arxiv.org/abs/2510.13982
**PDF**: papers/chen2025-2510.13982-static-sandboxes.pdf
**Cluster**: Multi-Agent Architecture / Social Simulation — Paper 1 §2 & §4 支撑文献
**Status**: ✅ 全文已分析（2026-05-21）

---

## Core claim (一句话)
当前LLM多智能体仿真被困于静态沙盒（预定义任务、刚性评估、封闭循环），根本无法捕捉真实社会的复杂性；必须转向开放式协同演化（open-ended co-evolution）范式，让 agent 与环境相互塑造、持续创新。

---

## 研究问题
LLM驱动的多智能体仿真如何从静态任务优化转向开放式、协同演化的社会复杂系统建模？需要什么架构原则和评估框架？

---

## 三支柱分类法（核心贡献）

| 支柱 | 内容 | 代表系统 |
|------|------|---------|
| 1. Dynamic Scenario Evolution | agent 持续探索变化环境，生成新任务，迭代发展技能 | VOYAGER, OpenWebVoyager |
| 2. Agent–Environment Co-evolution | agent 与环境互相塑造，产生涌现社会结构、规范、制度 | TwinMarket, GABSS |
| 3. Generative Agent Architectures | LLM驱动agent具备记忆/感知/自反思，模拟类人认知过程 | Generative Agents (Park 2023), Lyfe Agents |

**关键立场**："不可预测性不是需要控制的缺陷，而是需要拥抱的特性"；提出从"适应行为"到"**适应本体**"（adaptive ontology）的范式跃迁——agent 发明新的行为类别，而非仅优化既有类别。

---

## 主要论点（position paper，无实验数据）

1. 现有仿真框架（AgentBench, AgentSims等）仍受限于预设任务空间和刚性评估标准
2. LLM"失败模式"（幻觉、记忆漂移、价值错位）实为静态假设与动态需求不匹配的信号
3. 短期循环（感知→推理→执行→通信→反馈）+ 长期角色演化架构（图2）
4. 评估新维度：探索容量、适应学习、涌现创新、社会稳定对齐、记忆一致性（香农熵等）
5. 未来十年预测：开放式协同演化仿真将取代静态 benchmark 成为自适应 AI 主流测试床

---

## 论文未覆盖的范围（我们的差异化基础）

| 维度 | Chen et al. 2025 | 我们的框架 |
|------|-----------------|----------|
| 研究性质 | 立场论文（position paper）+ 综述，无实验 | 理论框架 + 协议规范 + Mycelium 实证部署 |
| 角色稳定性 | 强调"角色流动性"（role fluidity），角色可任意漂移 | ✅ 持久社会角色（role-bearing agent）作为第一类实体，角色是 SC 计算基础 |
| 协议规范 | ❌ 无具体通信协议，仅"通信作为社会转型媒介"的设计原则 | ✅ ASM 协议（消息结构+角色约束+信任路由）|
| 社会资本量化 | 未建模（仅"涌现规范"的定性描述）| ✅ Bourdieu 社会资本量化为可计算 SC 变量 |
| 网络拓扑 | 未涉及参与约束或网络结构 | ✅ 无许可网络 N——开放参与 + DIDComm 身份锚定 |
| 评估实践化 | 概念性维度提议，无操作化路径 | ✅ 五个可证伪命题 P1–P5，可通过部署数据验证 |
| 可证伪性 | ❌ 无形式化命题 | ✅ 演绎性命题体系 |

---

## Paper 1 §2 区分段落（~200词）

> Chen et al. (2025) mount a timely and well-reasoned critique of the static sandbox paradigm in LLM-based multi-agent research, demonstrating that predefined task metrics, rigid benchmarks, and closed-loop interaction patterns fundamentally cannot model real-world societal complexity. Their three-pillar taxonomy—dynamic scenario evolution, agent–environment co-evolution, and generative agent architectures—usefully frames the design space for open-ended simulation, and their concept of "adaptive ontology," in which agents invent new categories of interaction rather than merely refining existing ones, resonates directly with our argument that capability-invocation framings are insufficient for genuine agent collaboration. Our work shares Chen et al.'s rejection of static role assignment and their intuition that norm emergence and persistent social identity are first-class concerns. However, their contribution remains a position and review paper without a formal theoretical foundation, empirical validation, or deployable protocol specification. The three pillars articulate desiderata rather than mechanisms: they do not specify how agents should carry persistent social roles across interaction contexts, how social capital should be quantified to make trust economically meaningful, or what network topology enables open participation without coordination bottlenecks. Our three-pillar framework directly operationalizes what Chen et al. call for: collaboration protocols (P) provide the formal interaction rules, quantified social capital (SC) makes the reputation dynamics they identify computationally tractable, and permissionless network topology (N) instantiates the open-ended co-evolutionary environment they envision but do not architect.

---

## Action items
- [x] §2区分段落已草拟
- [x] 比较表已完成
- [ ] Paper 1 §2：引用 Chen et al. 2025 支持"静态能力调用范式不足以模拟社会复杂性"的论点
- [ ] Paper 1 §4（未来工作）：可引用 Chen et al. 评估框架作为比较基准
- [ ] Phase 2 写作时将上述段落插入 Paper 1 §2

---

## Jason's feedback
> （请在此处写入你的feedback）
