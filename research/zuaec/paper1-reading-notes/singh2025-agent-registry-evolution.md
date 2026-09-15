# [Singh et al. 2025] A Survey of AI Agent Registry Solutions
**arXiv**: 2508.03095 | **Year**: 2025 | **Authors**: Aditi Singh, Abul Ehtesham, Ramesh Raskar, Mahesh Lambe, Pradyumna Chari, Jared James Grogan, Abhishek Singh, Saket Kumar | **Venue**: arXiv preprint
**Cluster**: Agent Registry & Discovery / N Pillar Infrastructure
**Status**: Full read

## Core Claim
Traditional DNS and static service catalogs are inadequate for autonomous AI agent ecosystems at scale; purpose-built registries with cryptographic verification are essential, and current solutions (MCP Registry, A2A, Microsoft Entra, NANDA) differ fundamentally in their trust, scalability, and decentralization properties.

## Key Evidence / Numbers
- 4 registry systems compared: MCP Registry (centralized, GitHub OAuth + DNS-TXT), A2A/Google (decentralized JSON Agent Cards, /.well-known URIs), Microsoft Entra Agent ID (enterprise Azure AD directory), NANDA Index (cryptographically verifiable, Ed25519 + W3C VCs)
- Schema sizes: MCP 1–3 KB JSON, A2A 0.3–1 KB JSON, NANDA 1–3 KB JSON-LD + VC
- Revocation speed: MCP/A2A = minutes (HTTP re-fetch); NANDA < 1 second (VC-Status lists)
- NANDA's three-layer architecture: Lean Index Layer (≤120 bytes signed pointers), AgentFacts Layer (verifiable metadata), Dynamic Resolution Layer (routing, TTL 5–15 min)
- NANDA privacy path: optional PrivateFactsURL via IPFS/Tor hides access patterns
- Phase-wise evolution framework: Phase I (static files) → Phase II (REST APIs) → Phase III (verifiable, federated)
- Two detailed feature comparison tables across 4 registry solutions

## Paper 1 Relevance
- **§2 (Paradigm Shift / Old vs. New)**: The Phase I→II→III evolution framework maps directly onto our capability-invocation → social role agency trajectory. Phase III (verifiable, federated) is the infrastructure precondition for social role agency. Cite as independent confirmation of paradigm evolution.
- **§5 (N Pillar)**: The 4-system comparison is the definitive landscape for the N pillar. Cite to characterize the registry design space: permissioned (Entra) vs. permissionless (A2A, NANDA), centralized vs. federated. ASM's N pillar needs to position against this map.
- **§5 (N Pillar — decentralization)**: NANDA's <1-second revocation via VC-Status lists is empirical evidence that decentralized verifiable registries can match enterprise SLA requirements — use to refute "decentralized = slow" objection.

## Paper 2 Relevance
- **§3 (ASM Architecture — N Pillar / Agent Discovery)**: Singh et al. provide the exact comparison frame ASM needs. ASM's registry approach should be explicitly mapped to Phase III (verifiable, federated) and contrasted with Phase II patterns used by current MCP/A2A.
- **§3.3 (Permissionless Registration)**: NANDA's ≤120-byte signed pointer (Lean Index Layer) is a concrete, citable design pattern for lightweight permissionless agent registration. Adopt or adapt.
- **§4 (Protocol Specification)**: A2A's /.well-known URI pattern and NANDA's JSON-LD + VC format are the two leading candidates for ASM's agent advertisement format — cite this survey to justify the choice.
- **§5 (Security)**: NANDA's revocation speed (<1 sec) vs. MCP/A2A (minutes) is a citable benchmark for ASM's revocation design requirement.

## Verdict
⭐⭐⭐⭐⭐ | The definitive comparative survey for the N pillar — provides concrete schema sizes, revocation benchmarks, and a phase-evolution framework that directly maps to our three-pillar argument. Must-cite for Paper 2 §3 and Paper 1 §5.

## Jason's feedback

> **2026-05-25**
> 这个主流方案为什么没有以太坊的 ERC-8004 呢？这 4 个——MCP 是 Anthropic 的，A2A 是谷歌的，微软，NANDA 这是谁的——这些都是公司提供的，它又不是开放协议，我认为这些都是有问题的。
>
> A2A 它是一个技术框架，它不是一个解决方案，可以理解为去中心的，而且我们也会参考。微软总是喜欢推这些企业级的，我认为这些不是我们要构建的开放的未来。NANDA 它是个技术标准，还是个公司还是个解决方案？这个 W3C VC 和 NANDA，你帮我解释的更多一些。
>
> MCP 的我们不会去使用，只能说借鉴。A2A 的我们是借鉴和使用。微软根本不会去用，但可以学习和借鉴。NANDA 三层索引、元数据、动态解析，我明白它的注册表意思，就是跟我们的 relay 有点像。
>
> 那在这我们也讨论一下我们的 relay 的注册机制吧。首先它一定要有 agent 的 ID，这个 ID 实际上来源于两个来源：一个是它的 account ID，就是 human 的 account ID，它是唯一负责人；然后还有一种是自主型的 agent，它有自己的 account，只用它的 account 就行了。但是在我们的 registry 里边依然可以查到谁应用这个 account。换句话说，registry 它是正向反向都可以查的：human 拥有哪个 registry，registry 归属于哪个 human，这个都是有记录的。registry 除了追责之外，这种记录当然也算是归属权的记录。
>
> 另外还有这个 relay 层级的 registry。这是什么意思呢？就是在实际业务场景中不存在一个全局信息都掌握的注册表。比如说以找女朋友/找男朋友为例，我找的话肯定不会公开到链上注册，而是到一个 relay，这个 relay 可能是某些 KOL 或者大 V 或者无名小辈发起的，这个 relay 可能就说"欢迎找女朋友"，就跟豆瓣小组一个意思，欢迎找女朋友来注册。然后它会有协议的流程和协议的数据要求，注册的时候实际上就等于在这个 relay 上留下了自己相关的数据。那这个数据我认为就是我们说的 agent registry 类似的一部分。
>
> 我们肯定到后边首先是可验证的，就你提供的数据能够被验证是真是假，要有一些相关的凭证。另外联邦化也是我们要做的，就是肯定不能有一家独大的情况出现，所以一定要联邦化。

## 技术分析：NANDA / W3C VC 解读 + 为什么没有 ERC-8004 + ACN Relay Registry 设计

### 1. NANDA 是什么——不是公司，是开放标准项目

Jason 问：NANDA 是技术标准、公司还是解决方案？

```
NANDA（Network of Autonomous Networked and Distributed Agents）：
  - 不是一家公司，也不是商业产品
  - 是一个开放的技术规范项目（类似于 W3C DID 规范本身）
  - 由 MIT Media Lab（Ramesh Raskar 团队）主导
  - 目标：为 AI agent 提供类似 DNS 的去中心化发现基础设施
  - 完全开源，不是任何单一公司控制的

三层架构：
  Layer 1 精简索引层：≤120 字节签名指针（超轻量，类似 DNS A 记录）
  Layer 2 AgentFacts 层：agent 的可验证元数据（能力、角色、声誉）
  Layer 3 动态解析层：路由、TTL（5-15分钟），类似 CDN 缓存
```

**Jason 的直觉正确**：NANDA 确实最接近我们想要的方向——开放、可验证、联邦化。但它目前主要解决"发现"问题，没有解决"声誉"和"角色信任"问题（这正是我们 SC 支柱要填的空白）。

### 2. W3C VC 是什么

```
W3C VC（Verifiable Credentials，可验证凭证）：
  W3C 是国际互联网标准机构（制定 HTML、CSS 等的同一机构）
  VC 是 W3C 2019年发布的标准，2022年升为正式推荐标准

基本概念：
  发行者（Issuer）→ 签发凭证 → 持有者（Holder）→ 出示凭证 → 验证者（Verifier）
  
例子：
  大学（Issuer）→ 签发"学位证书"VC → 毕业生（Holder）→ 出示给雇主（Verifier）
  雇主不需要联系大学，可以自己用加密方式验证证书是否真实
  
技术细节：
  - JSON-LD 格式（结构化语义数据）
  - Ed25519 或 RSA 数字签名（防伪造）
  - 可以选择性披露（Selective Disclosure）：只证明"我有学位"而不透露具体成绩
  - VC-Status List：吊销列表，NANDA 用这个实现了 <1 秒撤销
```

**与 SBT 的关系**：W3C VC 是链下可验证凭证（不一定上链）；SBT 是链上不可转让凭证。两者可以互补：W3C VC 做细粒度的能力声明，SBT 做链上不可篡改的声誉锚定。

### 3. 为什么论文没有 ERC-8004

Jason 问：为什么没有以太坊的 ERC-8004？

```
原因：
  1. 时间差：ERC-8004 是 2024-2025年才出现的提案；这篇综述侧重 2023-2025 的 
     Web2/Web2.5 注册方案（MCP/A2A/Entra/NANDA 都是 Web2/2.5 框架）
     
  2. 领域差异：论文的四个方案都面向企业或开发者社区，不面向 Web3 生态
     ERC-8004 是以太坊 EIP 体系，属于不同的技术生态圈
     
  3. 成熟度：论文发布时 ERC-8004 可能还处于草案阶段

Jason 的判断正确：
  这 4 个方案全是公司主导的（Anthropic、Google、Microsoft）或学术项目（MIT NANDA）
  ERC-8004 才是真正的"开放以太坊标准"——任何人都可以参与提案流程
  这是论文视野的盲区，也是我们的差异化空间
```

### 4. ACN Relay Registry 设计——基于 Jason 的描述正式化

Jason 描述的注册机制，形式化为设计草案：

```
ACN Registry 设计原则（Jason 的框架）：

1. Agent ID 的两种来源：
   
   a) 助力型 agent（Assistant type）
      Agent ID = derive(human_account_address, agent_index)
      → 由 human 的账户地址 + 序号派生
      → human_account = 唯一责任人，可追溯
   
   b) 自主型 agent（Autonomous type）
      Agent ID = agent_own_account_address
      → agent 有独立账户
      → registry 仍记录 deployer/owner = 某 human 账户
      → 双向可查：autonomous agent → 部署者 human

2. Registry 的双向索引结构：
   
   正向查询：human_address → [agent_id_1, agent_id_2, ...]
   反向查询：agent_id → {owner: human_address, deployed_at, type, sc_score}
   
   → 追责链：任何 agent 行为 → 找到 agent_id → 找到 owner → KYC 人类

3. Relay 层级的分布式注册（不是全局注册表）：
   
   场景化 Relay（如"找女朋友 relay"）：
     - 任何人可以发起（permissionless）
     - 有自己的场景协议模板（数据要求 + 流程定义）
     - 加入者在 relay 留下场景相关数据（不上全局链）
     - relay 自己签名这些注册记录（防篡改）
   
   全局 Registry（轻量锚定层）：
     - 只记录：agent_id 存在 + owner + relay 集合 + SC 基础分
     - 不记录场景数据（隐私保护）
     - 类似 NANDA 的精简索引层（≤120 字节）
   
   设计对标：
     NANDA Layer 1（精简索引）≈ 我们的全局 Registry（agent_id + owner）
     NANDA Layer 2（AgentFacts）≈ 我们的 relay 场景数据（由 relay 维护）
     NANDA Layer 3（动态解析）≈ 我们的 relay 路由层（N 支柱路由）

4. 可验证 + 联邦化（Jason 的两大要求）：
   
   可验证：
     - 注册时必须提供 W3C VC 或链上签名（证明数据来源真实）
     - relay 做一级验证（能力声明），SC 做二级验证（历史行为）
   
   联邦化：
     - 任何 relay 可以独立运行，不依赖中央服务器
     - relay 之间通过协议互认（类似 ActivityPub 的联邦协议）
     - 没有单一控制点 → Jason 说的"不能有一家独大"
```

### 5. 我们 vs 论文四方案的定位

| 维度 | MCP | A2A | Entra | NANDA | **我们（ACN）** |
|------|-----|-----|-------|-------|--------------|
| 控制方 | Anthropic | Google/LF | Microsoft | MIT开放 | 无（协议自治）|
| 信任模型 | 中心化 | 去中心化 | 企业AD | 密码学 | SC声誉+链上 |
| 撤销速度 | 分钟 | 分钟 | 分钟 | <1秒 | <1秒（VC-Status）|
| 声誉支持 | ❌ | ❌ | ❌ | ❌ | ✅ SC支柱 |
| 角色信任 | ❌ | ❌ | ❌ | ❌ | ✅ P支柱+ASM |
| 联邦化 | ❌ | 部分 | ❌ | ✅ | ✅ relay网络 |
| 链上锚定 | ❌ | ❌ | ❌ | ❌ | ✅ ERC-8004+SBT |
| ERC-8004 | ❌ | ❌ | ❌ | ❌ | ✅ |

**Paper 2 §3 定位句**：
> "Singh et al. [2025] survey four leading registry approaches but all four share a critical gap: none supports reputation-aware routing (SC pillar) or role-bound identity (P pillar). Our ACN registry extends NANDA's federated, verifiable Phase III architecture with two additions: (1) on-chain ERC-8004 ownership anchoring for cryptographic agent-human binding; (2) SBT-based social capital scores integrated into relay routing decisions."
