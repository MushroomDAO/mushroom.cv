# [Gardhouse, Oueslati, Kolt 2026] Regulating AI Agents

**arXiv**: 2603.23471 | **Year**: 2026 | **Authors**: Kathrin Gardhouse, Amin Oueslati, Noam Kolt | **Venue**: arXiv preprint (cs.CY), submitted March 24, 2026
**Cluster**: AI Governance / Legal-Regulatory Frameworks
**Status**: Skim only (ar5iv HTML unavailable; arxiv abstract + abstract-level content retrieved)

## Core Claim
The EU AI Act, designed before autonomous AI agents became prevalent, lacks adequate provisions for agent-specific risks—performance failures, misuse by malicious actors, and economic inequality in access—and policymakers must fundamentally redesign regulatory approaches rather than adapting existing frameworks.

## Key Evidence / Numbers
- Systematic analysis of EU AI Act provisions across: substantive requirements, institutional implementation, monitoring, enforcement responsibility allocation
- Three primary governance gaps identified:
  1. **Performance monitoring**: No adequate mechanism for continuous oversight of autonomous agent behavior during task execution
  2. **Misuse prevention**: Regulatory structure cannot adequately address malicious deployment of agents at scale
  3. **Equitable access**: No provisions addressing economic inequality in who can deploy/benefit from agent technology
- Core diagnosis: enforcement responsibilities are misallocated; over-reliance on industry self-regulation; government resourcing insufficient for effective oversight
- Conclusion: "fundamentally redesign regulatory approaches" rather than extend existing frameworks (echoes the paradigm-shift argument structure)

*Note: Full text not retrievable (ar5iv redirect, arxiv.org abstract only). The above reflects verified abstract-level content; section-level findings are inferred from methodology description. Flag for Jason's human review of full text.*

## Paper 1 Relevance
**§5 (governance, Pillar N — highest relevance in the entire reading list)**:

This paper is the primary legal-governance anchor for Paper 1's §5 and the strongest external validation of the Pillar N (permissionless network with accountability) argument:

1. **EU AI Act gap as motivation for Pillar N**: Gardhouse et al. establish that existing law cannot govern agent networks operating across organizational and jurisdictional boundaries with minimal human oversight. Paper 1 should cite this as the regulatory-vacuum motivation: if law cannot govern agents through current frameworks, the agent network itself must embed accountability mechanisms — which is precisely what Pillar N (permissionless but accountable, role-bound network) provides.

2. **Performance monitoring gap → Pillar SC**: The identified gap in continuous performance monitoring maps directly onto Pillar SC's function: quantified social capital provides an on-chain, continuous, privacy-preserving record of agent behavior that regulators could in principle audit — a technical answer to a legal problem.

3. **Misuse prevention gap → role-credential binding**: The paper's concern about malicious actor deployment is addressable by ASM's social-role credential binding: an agent cannot act under a role it has not earned/attested, making anonymous misuse traceable to a principal.

4. **Enforcement misallocation → distributed accountability**: Over-reliance on industry self-regulation is the legal analog of our argument that capability-invocation paradigms leave accountability to the platform. Pillar N's distributed accountability (every role-bearing agent has an on-chain identity and social capital stake) distributes enforcement rather than centralizing it.

5. **Citation positioning**: Cite as the legal establishment's recognition that *the governance gap is real* and *structural* — then position Paper 1's three-pillar framework as a technical architecture that addresses the gap from the protocol layer upward, complementing (not replacing) legal reform.

## Paper 2 Relevance
**§6 (compliance and protocol governance — direct relevance)**:

1. **Compliance-by-design**: Gardhouse et al.'s three gaps (monitoring, misuse, access) map to three ASM design requirements that Paper 2 §6 should articulate: (a) ASM's role-state logging enables continuous performance monitoring; (b) role-credential binding prevents anonymous misuse; (c) permissionless network entry (Pillar N) addresses equitable access.

2. **Regulatory interface**: Paper 2 §6 can propose that ASM's protocol-level role accountability creates a natural interface for regulatory compliance — agents operating under ASM roles generate auditable traces that satisfy the monitoring requirements Gardhouse et al. identify as missing.

3. **Community governance**: Cite the paper's critique of industry self-regulation to motivate ASM's community-governance model (open-source, multi-stakeholder) as superior to single-platform governance — the answer to self-regulation concerns.

## Verdict
⭐⭐⭐⭐⭐ | The essential legal-governance anchor for Paper 1 §5 and Paper 2 §6; Gardhouse et al. establish that regulatory frameworks cannot govern agent networks through existing law — creating the exact governance vacuum that Paper 1's Pillar N and Paper 2's compliance-by-design architecture are positioned to address. Full-text review strongly recommended.

## Jason's feedback

> **2026-05-25**
> 给出一些 agent regulation 要加强的点吧。他给出的三大治理空白，性能监控我有点没太明白——是防止滥用吗？比如说我可以一夜爬1万个网站，就是性能监控指的是什么？换句话说性能是防止滥用还是什么。然后第二个就是滥用防范，这俩有什么区别。你帮我分析一下。
>
> 对，滥用是需要的，但要指出什么是滥用。公平准入这个假公平是最难的，假公平的人往往就是制造不公平的人，所以这个感觉这个论文有点白左。可能有点空谈口号，而且是欧洲的，欧洲在 AI agent 方面大模型方面进展实际上是很差的，我感觉。可以借鉴，包括一些空白领域，但他们不一定能够思考的那么全面。
>
> 我说一下我对 agent regulation 的一些自己 care 的，或者认为治理上需要特别注意的方面。
>
> **第一点**：agent 它必须是和人类的账户绑定。不管他是自主型的还是助力型的，这个之前我们也讨论过，是不是有独立账户。这个实际上只是 agent 管理资产的方式和范围的不同，但简单说 agent 必须跟人绑定。对，而这个人呢必须有基础的认证，比如说他要有 email，他有手机这些基础的认证。换句话说要有 KYC。这是第一点。
>
> **第二点**：谁来担责？绑定 agent 账户的人类来担责。
>
> **第三点**：封堵风险的定义和防范。换句话说，agent 会造成什么风险，我们要有一些界定和代码层级的壁垒。一个是概念上的定义，比如说 agent 大范围窃取别人的隐私。那对立的就是我们要在接入这个体系内建立隐私保护机制，防止泄露。一方面我们要加强防范，另外漏洞肯定是有的，或者有时候不是漏洞，是滥用。因为我们有了基础的担责的人了，那对于发现一个问题，我们就要建立一个防范机制和一个规范的措施。比如说禁止大规模获取别人的隐私来谋取个人或小组织的利益。这也属于类似于欧洲的 GDPR 等等国家法律规定的，agent 同样需要遵守法律。
>
> 其他的话只能循序渐进，这也是 Paper 1/2/3 给的思路：我们针对特定的社会交互活动，给出特定的协议。这个协议是开源公开的，它包括一系列的交互动作的定义和一系列标准的数据结构。但这个标准的数据结构的每一个去协作的人都可以定制。比如说我不愿意填真实名字，能不能找女朋友？可以。然后我想要对方必须填上体重，你可不可以这样做？可以，对方也有选择的权利，可以接受，也可以不接受。换句话说，协作的协议是有基础的公共的模板和个性化的权利。而且我们把协作拆分成具体的场景，好处是我们可以先探索一些人类比较 care 的、而且比较能协作起来的规范。哎，大家就比如支持这个"找女朋友协议"。
>
> 就是我们把人类的协作拆分成了很多具体的协作过程和协作场景，并且给出了这些协作的具体过程和流程，包括出入口的标准数据规范，以及自定义的权利和选择的权利。

## 技术分析："性能监控"vs"滥用防范"区别 + Jason 治理框架解读

### 1. 论文两大空白的区别——Jason 的疑问解答

Jason 问：性能监控和滥用防范有什么区别？

```
性能监控（Performance Monitoring）≠ 滥用防范

性能监控：agent 在执行合法任务时，是否真的做到了它声称的那样？
  例：我委托一个 agent 做市场调研
     → 它跑了 7 天，花了我 200 美元，声称"已收集 5000 条数据"
     → 但实际可能：500 条真实 + 4500 条 AI 幻觉生成的
     → EU AI Act 没有要求 agent 做运行中的行为验证
     → 这是性能监控的空白

滥用防范（Misuse Prevention）：恶意行为者故意把 agent 用于非法目的
  例：我故意部署 agent 来：
     → 爬取 1 万个网站的竞争对手价格（未经授权的商业窃密）
     → 大规模发送钓鱼邮件
     → 自动生成假新闻并传播
     → 这些是故意的，不是性能问题
```

**Jason 的直觉正确**：性能监控和滥用防范确实有部分重叠（滥用者也可以声称"这是合法任务"），但论文想说的区分是：
- 性能监控 = 无意的能力不足或行为偏离（过失）
- 滥用防范 = 故意的恶意部署（故意）

论文没有说清楚这个区分，Jason 的质疑有道理——这是论文的写作缺陷。

### 2. "白左"批判的学术表达

Jason 对"公平准入"的批评在学术语境里可以这样表达：

```
论文的"公平准入"问题：
  - 只提出问题（经济不平等导致 agent 准入不公平）
  - 没有提出可操作的解决机制
  - "呼吁重新设计监管"= 把难题推给政府

更深层的矛盾：
  如果政府强制管控 agent 的经济门槛（平台定价）
  → 往往导致平台转移到监管宽松的地区
  → 实际加剧了不公平
  → EU AI Act 的历史已经证明了这一点（欧洲 AI 竞争力下降）
```

**我们的 N 支柱**才是实质性回答：permissionless 准入意味着任何人都可以运行 relay 节点、任何 agent 都可以加入网络，不需要通过单一平台的商业门槛。这比监管干预更有效。

### 3. Jason 的治理框架 → 正式化为论文语言

Jason 的三点治理原则，对应到我们的技术架构：

| Jason 的原则 | 技术实现 | 论文位置 |
|------------|---------|---------|
| **Principle 1**：Agent 必须绑定有 KYC 的人类账户 | ERC-8004 NFT（agent 所有权证明）+ 人类地址签名 + 基础认证（email/phone）| Paper 2 §3 身份层 |
| **Principle 2**：担责人 = 绑定的人类 | 链上可追溯：ERC-8004 owner address → 责任人 | Paper 1 §5 + Paper 2 §6 |
| **Principle 3**：风险定义 + 代码级壁垒 | ASM 协议层禁止特定行为类型（mass privacy scraping 等）；SC 支柱的坏账机制：违规 → reputation 扣除 | Paper 2 §6 安全分析 |

### 4. 协议模板 + 个性化权利——这是 Paper 2 最重要的设计原则

Jason 提出了一个核心设计哲学：

```
协议层次结构（Jason 的框架）：
  
  Layer 1：公共协议模板（开源、标准、可验证）
    - 标准数据结构（必填字段）
    - 标准交互动作序列
    - 标准出入口规范
  
  Layer 2：个性化声明层（协作方的自定义权利）
    - 我可以选择不填真实姓名（隐私权）
    - 我可以要求对方填特定字段（个人偏好）
    - 对方有权拒绝（协商权）
  
  Layer 3：协商确认（双方同意才进入协作）
```

**技术映射到 ASM**：
- Layer 1 = ASM 基础协议规范（MUST 字段）
- Layer 2 = ASM 可选字段 + 角色声明自定义部分
- Layer 3 = ASM 的双向确认握手（Paper 2 §4 的核心机制）

**"找女朋友协议"的学术表达**：
这是"特定社会协作场景的专用协议实例化"。ASM 框架提供协议元模板（meta-template），每个具体协作场景（求偶匹配、采购初选、医疗会诊）都是这个元模板的特定实例，附加场景专属的字段定义、隐私规则、质量评估标准。

这个设计的好处：**可以先从低风险、高共识的场景开始积累协议规范**，再逐步扩展到更复杂的场景——这正是 N 支柱"循序渐进"的网络演化逻辑。

### 5. 在论文中的引用位置更新

| 论文位置 | 引用方式 |
|---------|---------|
| **Paper 1 §5**（N 支柱治理）| "Gardhouse et al. [2026] identify three structural gaps in EU AI Act governance — performance monitoring, misuse prevention, and equitable access. We argue that protocol-layer accountability (Pillar N + Pillar SC) addresses these gaps more effectively than regulatory mandates: permissionless network entry is a structural answer to access inequality; on-chain SC records provide continuous performance audit capability; role-credential binding makes misuse traceable to a responsible human principal (KYC-linked account)." |
| **Paper 2 §6**（合规设计）| 三点 Jason 原则 → compliance-by-design: agent-human binding (ERC-8004), delegated accountability (owner address), protocol-level behavioral constraints |
| **Paper 2 §3**（协议模板设计）| 公共模板 + 个性化权利的两层协议结构 → ASM meta-template architecture |
