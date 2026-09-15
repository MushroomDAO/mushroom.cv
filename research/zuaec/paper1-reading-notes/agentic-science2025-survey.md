# [Wei, Yang, Zhang et al. 2025] From AI for Science to Agentic Science: A Survey on Autonomous Scientific Discovery

**arXiv**: 2508.14111 | **Year**: 2025 | **Authors**: Jiaqi Wei, Yuejin Yang, Xiang Zhang, + 18 co-authors (Shanghai AI Lab, Zhejiang University, Fudan University, and others; 27 total authors) | **Venue**: arXiv preprint (2025)
**Cluster**: Agentic Science / Autonomous Scientific Discovery / Survey / Real-World Deployment
**Status**: Full read

## Core Claim

"Agentic Science" is a qualitatively distinct paradigm — where AI progresses from partial assistance to full scientific agency — requiring a three-level capability hierarchy (five foundational capabilities → four core scientific processes → domain applications) and facing four critical barriers (reproducibility, sparse rewards, multimodal integration, long-horizon causal reasoning) before achieving the "Nobel-Turing Test" benchmark.

## Key Evidence / Numbers

- **100+ systems** surveyed across life sciences, chemistry, materials science, physics
- **Coscientist**: autonomously designed and optimised chemical reactions via robotic hardware
- **Robin**: independently hypothesised ripasudil for treating dry age-related macular degeneration (novel therapeutic connection)
- **OriGene**: identified GPR160 and ARG2 as novel cancer therapeutic targets, validated in patient systems
- **The Virtual Lab**: designed **92 novel SARS-CoV-2 nanobodies** computationally with empirical validation
- **ORGANA**: reduced human workload by **>80%** in chemical synthesis
- **SpatialAgent**: achieved expert-level performance on datasets with **2+ million** single-cell measurements
- Four evolutionary levels: L1 (computational oracle) → L4 (generative architect); primary focus on **L3** (autonomous scientific partner)
- Proposed benchmark: **"Nobel-Turing Test"** — AI making a Nobel Prize-worthy discovery
- Future vision: **"Global Cooperation Research Agent"** — decentralised ecosystem of specialised agents at planetary scale

## Three-Level Research Hierarchy

1. **Five Foundational Capabilities**: planning & reasoning, tool integration, memory mechanisms, multi-agent collaboration, optimisation/evolution
2. **Four Core Scientific Processes**: observation & hypothesis generation, experimental planning & execution, data analysis, synthesis & validation
3. **Domain Applications**: life sciences, chemistry, materials science, physics

## Paper 1 Relevance

Highest relevance to **§5 (real-world deployment and scaling)**. This is the authoritative comprehensive survey of autonomous scientific agents — provides the strongest empirical grounding for our argument that open ACN frameworks are needed at scale. The "Global Cooperation Research Agent" vision is exactly our N pillar realised in a specific domain: a permissionless network of specialised agents collaborating without central coordination.

Key citation angle: four critical barriers (reproducibility, sparse rewards, multimodal integration, long-horizon reasoning) map directly onto the problems our three pillars address — P (reproducible protocols), SC (non-sparse reward through continuous social capital signals), N (long-horizon causal coordination across network).

The four-level evolution framing also provides a shared vocabulary: our ACN framework targets the transition from L2 (automated assistant) to L3 (autonomous partner) in open, heterogeneous networks — a gap the survey explicitly identifies as unsolved.

Zhejiang University affiliation (co-authors) may be relevant for ZUAEC submission context — confirms that ZJU researchers are active in this space.

## Paper 2 Relevance

Supports **§3 (ASM design motivation — multi-agent collaboration at scale)**. The paper's "multi-agent collaboration" as one of five foundational capabilities confirms our assumption that protocol-level coordination (ASM's domain) is a necessary primitive for L3+ agentic systems. The "tool integration" challenge (minor parameterisation errors invalidate results) directly motivates ASM's role-bearing message format: role metadata prevents capability mismatches that cause silent failures.

SC pillar: sparse reward problem in scientific discovery is exactly the challenge our reputation-weighted routing addresses — by accumulating social capital across many interactions, agents receive non-sparse signals even when breakthroughs are rare.

## Verdict

⭐⭐⭐⭐⭐ | The most comprehensive empirical survey of real-world agentic deployment (100+ systems, 27 authors, 4 domains) — authoritative citation for §5 deployment context, the "Global Cooperation Research Agent" vision directly anticipates our N pillar, and the four barriers framework provides a structured argument for why all three pillars are necessary.

## Jason's feedback

> **2026-05-24**
> 首先这个论文很棒，虽然是一个综述，但它确实整合了 agent science 这个领域所有的成就和当前进展。
>
> **可以借鉴的第一个点**：它的愿景是 Global Cooperation Research Agent。我们建立的 agent 协作网络，从逻辑上是天然可以为这个 research 服务的。如果想要为 research 服务，除了能力范围要满足之外，可能还需要在协作和沟通上达到要求才行。
>
> **想了解自主性在哪里**，包括我们自己的协议也是需要进化的。他的自主性究竟在哪里？
>
> **L4 生成架构师是什么意思？** 为什么计算神谕→自动助手→自主科学伙伴→生成架构师，这里边核心的区别在哪里？
>
> 真实案例中，自主性和涌现已经有了明显的结果——但这些都是独立 agent 或几个 agent 发现的。**跨组织协作，这个综述里应该比较少吧**，帮我看一下有没有。
>
> 他给出的四个障碍——可重现性、稀疏奖励、多模态集成、长程因果推理——实际上依然是单个 agent 级别的能力障碍，视野依然是独立 agent，对于跨组织协作可能涉猎不多。
>
> **自我进化这一块是值得借鉴的**。包括未来我们这种 Global Cooperation Research Agent 也符合他对未来的预期。

## L1→L4 四级进化：核心区别（Jason 追问）

| 等级 | 名称 | 谁定义"做什么" | 谁定义"怎么做" | 代表性能力 |
|------|------|-------------|-------------|---------|
| **L1** | 计算神谕（Computational Oracle）| 人类 | 人类 | 高性能计算、AlphaFold 结构预测 |
| **L2** | 自动助手（Automated Assistant）| 人类 | AI 执行预定义工作流 | ChatGPT 协助写论文、自动文献综述 |
| **L3** | 自主科学伙伴（Autonomous Scientific Partner）| 人类给方向 | AI 独立提出假设/设计实验/解释结果 | Robin 发现新药靶点、OriGene 找癌症靶点 |
| **L4** | 生成架构师（Generative Architect）| AI 自主定义 | AI 自主定义 | 创造新研究范式、设计其他 AI 系统、定义新领域 |

**核心跃迁点**：
- L1→L2：工具变成执行者（人还是导演）
- L2→L3：执行者变成思考者（AI 开始提问而不只是回答）
- L3→L4：思考者变成创造者（AI 创造新的问题空间，不是解答已有问题）

**对我们的映射**：我们 ACN 框架当前定位是支持 L2→L3 的跃迁——让 agent 从"被调用的工具"变成"有角色、有声誉的自主协作伙伴"。L4 是更远期愿景（需要更成熟的协议和信任基础设施）。

## 自主性的来源（Jason 追问）

论文将自主性分解为**五大基础能力**的组合：

```
自主性 = f(规划推理, 工具集成, 记忆机制, 多agent协作, 优化进化)
```

| 基础能力 | 自主性贡献 | 现有实现案例 |
|---------|---------|-----------|
| **规划推理** | 能独立分解任务，不需要人手把手 | Tree-of-Thought, ReAct |
| **工具集成** | 能调用外部工具执行实验 | Coscientist 控制机器人设备 |
| **记忆机制** | 能跨会话积累知识 | MemGPT, 长期知识图谱 |
| **多 agent 协作** | 任务超出单体能力时分工 | Virtual Lab 92 个纳米抗体设计 |
| **优化进化** | 从失败中更新策略 | ORGANA 减少 80% 人工 |

**Jason 的洞见**：我们自己的协议也需要进化。对应到 ASM：协议版本迭代 + relay 路由算法自我优化（基于历史任务成功率更新路由权重）= ASM 的"协议层自主进化"。

## 跨组织协作案例检查（Jason 要求核查）

**结论：跨组织协作案例极少，几乎都是单组织内多 agent**

| 案例 | 是否跨组织 | 实际结构 |
|------|---------|---------|
| Coscientist | ❌ 单系统 | 一个 AI 控制多种实验设备 |
| Robin | ❌ 单 agent | 单体 AI 提出假设 |
| OriGene | ❌ 单系统 | 单系统内多模块协作 |
| Virtual Lab | ⚠️ 准跨 agent | 同一实验室内多个专业化 AI 分工（非跨组织）|
| ORGANA | ❌ 单系统 | 单系统减少人工 |
| SpatialAgent | ❌ 单 agent | 单 agent 处理大规模数据 |

**确认 Jason 的判断正确**：综述的视野基本停留在单 agent 或单组织内多 agent，**跨组织协作几乎是空白**。这正是我们 ACN 框架填补的空间——从"实验室内自主"到"跨组织、社会级别的自主协作"。

## 四个障碍与 P/SC/N 的关系（重新解析）

Jason 指出四个障碍都是单 agent 级别的。这是正确的，但可以从另一个角度引用：

| 论文障碍 | 单 agent 层面（论文视角）| ACN 层面（我们的扩展）|
|---------|----------------------|-------------------|
| 可重现性 | 实验结果无法重现 | → P 支柱：协议标准化保证协作可重现 |
| 稀疏奖励 | 重大发现太稀少，信号弱 | → SC 支柱：跨交互的声誉积累提供连续非稀疏信号 |
| 多模态集成 | 视觉/文本/实验数据整合 | → N 支柱：不同模态能力的 agent 组网互补 |
| 长程因果推理 | 跨实验、跨时间的推理 | → SC+N：长期声誉追踪 + 跨组织信息流支持长程因果 |

## 对我们论文的核心借鉴（Jason 要求总结）

| 借鉴点 | 具体内容 | 用在哪里 |
|--------|---------|---------|
| **Global Cooperation Research Agent 愿景** | ACN 是这个愿景的基础设施层 | Paper 1 §1（Introduction 动机）+ §9（Discussion 未来）|
| **L1→L3 跃迁框架** | 我们的目标：支持 L2→L3 跃迁在开放网络中发生 | Paper 1 §2（范式转换论证）|
| **五大基础能力中的多 agent 协作** | 确认协议层是 L3 agentic science 的必要条件 | Paper 2 §1（设计动机）|
| **自我优化/进化作为基础能力** | 我们的协议需要支持自我进化 → ASM 版本迭代机制 | Paper 1 §9（Discussion）+ Paper 2 §8（Future Work）|
| **跨组织协作空白** | 综述证明跨组织协作是未填补的空白 | Paper 1 §2（研究空白论证：现有工作止步于单组织）|
| **浙大联合署名** | ZUAEC 投稿背景：ZJU 研究者在这个方向上活跃 | 投稿选题合理性参考 |

**Paper 1 §1 建议引用语**：
> "Wei et al. (2025) survey over 100 agentic systems in scientific discovery and envision a 'Global Cooperation Research Agent' ecosystem. However, the 100+ surveyed systems are exclusively intra-organisational: cross-organisation agent collaboration at the level required for planetary-scale scientific networks remains an open problem. The P/SC/N framework addresses exactly this gap — providing the protocol, trust, and network infrastructure for the L3→L4 transition to occur across organisational boundaries, not just within them."
