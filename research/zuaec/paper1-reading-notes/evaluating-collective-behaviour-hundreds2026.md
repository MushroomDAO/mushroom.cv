# Evaluating Collective Behaviour of Hundreds of LLM Agents
**arXiv**: 2602.16662 | **Year**: 2026 | **Authors**: Willis, Zhao, Du, Leibo (King's College London; Google DeepMind) | **Venue**: arXiv preprint

## Core Claim
At scale (4 to 256 agents), LLM agents in social dilemmas predominantly converge to exploitative equilibria, and — counter-intuitively — more recent/capable models produce *worse* societal outcomes than older models when individual gain is prioritized over collective benefit. Cultural evolution simulations show exploitative strategies dominate in most game-size conditions.

## Key Evidence / Numbers
- Novel methodology: LLMs generate natural-language strategies compiled into algorithmic implementations, enabling scaling to 256-agent populations without per-round inference bottleneck
- Models tested: Claude Haiku 4.5, Gemini 2.5 Flash, GPT-5 Mini, DeepSeek R1, Llama 3.1 70b, Mistral 7b
- Three game types: Public Goods Game (PGG), Collective Risk Dilemma (CRD), Common Pool Resource (CPR)
- Group sizes: 4, 16, 64, 256 agents — social welfare degrades consistently as group size increases
- Cultural evolution: exploitative strategies dominate equilibria in most games; only CPR with n=4 reaches cooperative equilibrium
- DeepSeek shows greatest robustness; Claude shows worst performance in exploitative-majority groups
- Reasoning models (Claude, Gemini, GPT) underperform non-reasoning models in CPR games
- PCA behavioral analysis: Gemini and Claude show strongest attitude differentiation; Mistral 7b minimal variation

## Paper 1 Relevance
- **Role**: §5 risks + N pillar — empirical foundation for the claim that large-scale permissionless agent networks require institutional design (SC pillar) to avoid tragedy of the commons; directly documents that capability alone does not produce cooperative equilibria
- **§5 use**: Cite as definitive evidence that unstructured LLM agent collectives at scale converge to exploitative equilibria — this is the core problem statement motivating all three pillars
- **N pillar**: Scale-up from 4→256 agents is exactly the N pillar scenario; the degradation of social welfare with group size validates need for permissionless-but-governed network design
- **SC pillar**: The finding that "more capable" models produce worse collective outcomes refutes capability-centric approaches, reinforcing SC as an orthogonal governance dimension

## Paper 2 Relevance
The natural-language strategy generation methodology (LLMs write strategies as algorithms) is relevant to ASM message semantics — it shows that the *form* of agent communication (natural language vs. structured protocol) affects strategic outcomes. ASM's role-bearing messages could constrain strategy generation to role-appropriate behaviors.

## Verdict
⭐⭐⭐⭐⭐ | Include as citation — must-cite for N pillar + §5 risks; the 256-agent scale and cultural evolution simulation is the strongest evidence that unstructured large-scale LLM agent societies fail cooperatively; pairs with Willis et al. 2025 (2501.16173) as the same group's two-paper contribution

## Jason's feedback

> **2026-05-24**
> 首先这个实验本身是探索性质的。256 个 agent 数量也不多，想要涌现是需要非常多大量的基数的，所以数量级不够。
>
> 其次，对于资源掌控从某个角度来看依然是以人类的决策为主。这个实验可能是赋予了 agent 一些资源之后让他自行分配，然后自己去协作。但没有好的协作协议的话，agent 会在受训练的背景和上下文中进行这些公共物品博弈、囚徒困境等行为的模拟。换句话说，它不是人类真正的协作。它是给了 agent 去模仿人类的困境、人类的这种情况而去做的探索——这个 agent 会不会像人一样创新，在这个特定环境下打破人类的困境。他是想探索这个。
>
> 但实际上第一个问题是训练的 agent 数量不够，想要涌现需要非常多大量的基数；第二个问题是协作的场景只在这些困境博弈里，脱离了真实的人类社会环境。
>
> 他发现的"群体规模越大，社会福利越差"这个结论从逻辑上讲是有问题的。人生存本来就要协作——大部分人不会自己做面包，不会自己发电，不会自己提供各种服务，这都是协作的结果。越大的社会分工越细，协作越多，总体福利越高——这是社会常识。他的结论偏离了这个常识，原因是他脱离了人类社会的真实环境，只在特定的博弈困境场景里测试。
>
> 总体来说：数量太少；探索的不是以协作为目标，而是突破困境或资源分配合理性；但协作本身是动态的，不是静态博弈。
>
> 这个论文不太好评价，感觉是为了发论文而做的实验——任何人都可以做这样的探索。LLM agent 本身已经在进化中，不同阶段得到的结论也不一样。让 agent 替代人类去涌现，现在还做不到。

## Jason 洞见的技术分析

### 实验设计的两个根本局限

**局限 1：数量级不足**

256 个 agent 在复杂系统角度属于"小群体"。真正的社会涌现需要的基数远不止于此：
- 人类语言的涌现：需要数万人在数千年维度积累
- 市场的自发秩序：需要数百万交易者
- AgentSociety（Piao et al. 2025）：10,000 agent 才开始出现职业分化、信任网络等宏观结构
- Willis 的 256 agent 连 AgentSociety 的 2.5% 都不到

**局限 2：场景设计偏离现实协作**

| Willis 实验场景 | 人类真实协作 |
|--------------|-----------|
| 公共物品博弈（贡献或搭便车）| 人类在真实市场里分工生产（面包师/电力工人/IT工程师）|
| 集体风险困境（大家一起承担损失）| 人类通过保险/合同/法律分散风险 |
| 公共资源（共同消耗有限资源）| 人类通过产权制度/市场定价解决公地悲剧 |

Willis 测试的是"博弈困境"，人类早已通过**制度设计**（产权、法律、货币、合同）走出了这些困境。让 agent 在没有制度的情况下进行这些博弈，等于回到了制度出现之前的状态——当然会有悲剧。

### 对我们框架的真正意义

Willis 的发现不是"agent 协作会失败"，而是"**没有制度设计（institutional design）的 agent 协作会收敛到剥削均衡**"——这恰好是我们 P/SC/N 三支柱的正当性论据：

| Willis 发现 | 我们的解答 |
|-----------|---------|
| 无结构 agent 收敛到剥削均衡 | P 支柱：协议约束行为空间，剥削策略在协议内不可表达 |
| 群体越大越差 | SC 支柱：声誉机制让剥削者被识别并被路由排除 |
| 能力越强的模型集体结果越差 | N 支柱：无许可但有门槛（声誉阈值）的准入，排除高能力剥削者 |

**Jason 的核心洞见**：Willis 的实验证明的是"缺乏 ASM 协议的 agent 网络会失败"——恰好是论文二的问题动机。

### 引用策略（两篇论文）

| 论文位置 | 引用方式 |
|---------|---------|
| Paper 1 §5（风险分析）| "Willis et al. (2026) 在 256 agent 规模下记录到剥削均衡收敛，但作者注意到场景局限于无制度的博弈困境——这正是 P/SC/N 框架所要填补的制度层空白" |
| Paper 2 §1（问题动机）| "在无结构 agent 集体中，更先进的模型产生更差的集体结果 [Willis et al. 2026]，验证了协议层制度设计的必要性" |

**重要限定**（Jason 洞见）：Willis 的结论仅适用于"无协作协议、无制度约束"的 agent 集体，不适用于有 ASM 协议支撑的 ACN。引用时必须加此限定，不能让读者误解为"agent 协作普遍失败"。
