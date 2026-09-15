# Agentic Peer-to-Peer Networks: From Content Distribution to Capability and Action Sharing
**arXiv**: 2603.03753 | **Year**: 2026 | **Authors**: Taotao Wang, Lizhao You, Jingwen Tong, Chonghe Zhao, Shengli Zhang | **Venue**: arXiv preprint (Shenzhen University, Xiamen University, Guangzhou University)

## Core Claim
Client-Side Autonomous Agents (CSAAs) on edge devices need a fundamentally different P2P architecture than traditional file-sharing networks: capabilities are dynamic, state-dependent, and potentially unsafe (unlike static files), requiring signed soft-state capability descriptors, semantic discovery, and a tiered verification spectrum (reputation → challenge-response → evidence-based attestation).

## Key Evidence / Numbers
- **Four-plane architecture**: Connectivity & Identity / Semantic Discovery / Execution / Trust & Verification
- **Signed Capability Descriptors (CDs)**: soft-state with TTL-based freshness; multi-dimensional QoS + trust vectors
- **Three verification tiers**: Tier 1 = reputation-based; Tier 2 = challenge-response probing (canary tasks); Tier 3 = cryptographic evidence packages (signed receipts, tool traces, attestations)
- **Sybil attack simulation**: Risk-Aware selection with Tier 2 canary probing sustains significantly higher workflow success vs. optimistic baselines
- **Scalability**: discovery latency near-constant from 20 to 200 nodes; overhead grows modestly (soft-state refresh traffic)
- **TTL knee point**: ~15 seconds balances freshness and control-plane overhead under high capability drift
- Two-step workflow (image generation + publishing) showed significant reliability gains with tiered verification
- Three fundamental shifts from classic P2P: static files → dynamic capabilities; deterministic integrity → probabilistic trust; bandwidth waste → privacy/safety risk

## Paper 1 Relevance
- **Role**: N pillar (Permissionless Network) — the closest published architectural blueprint for the N pillar; a peer-reviewed reference for decentralized capability discovery and tiered trust in open agent networks
- **§4/§5 use**: "The N pillar's permissionless architecture aligns with Wang et al.'s (2026) agentic P2P framework, which demonstrates that capability-based P2P networks are technically feasible at scale [cite]; we extend their tiered verification into a role-bearing social capital layer."
- **Differentiation**: Wang et al. focus on *capability sharing* between CSAAs (edge-device agents); our N pillar addresses open role-bearing agent participation in collaboration networks with social accountability (SC). Their verification tiers map onto ASM's challenge-response but lack role-identity binding.
- The 15-second TTL finding for capability freshness has direct implications for ASM protocol design (role assertion validity windows)

## Paper 2 Relevance
**High** — The tiered verification framework and signed Capability Descriptors are the closest existing system to ASM's role-claim + verification mechanism. Cite in Paper 2 §5 (Related Work): ASM provides the *social-role-aware* message protocol that sits above Wang et al.'s connectivity and discovery planes. Key extension: our role claims carry social capital assertions (not just QoS vectors) and are grounded in verifiable social history.

## Verdict
⭐⭐⭐⭐⭐ | Include as core N pillar reference — strongest published architectural work on decentralized agentic networks with tiered verification; directly relevant to both papers. Cite in Paper 1 §4/§5 and Paper 2 §5.

## Jason's feedback

> **2026-05-24**
> 这是一个有益的探索。
>
> **P2P vs Relay 网络**：他们建立的是 P2P network，我们选择 Nostr 这种有 relay 的 network 更好一些，更去中心、更自主。我们选择 relay 的原因是：有了 relay 之后有可靠性，并且 relay 可以提升对 relay 本身的性能要求。P2P 每个节点平等的话，普通客户端更多，无法提出更多要求。但他这个思路是正确的。
>
> **声誉评分**：我们是有的，专门基于 ERC-8004 做的。
>
> **挑战-响应探针**：这个思路不错。但我们是根据协议和协议要求的数据来做相互交互，最终验证的还是人。挑战-响应探针测试的是哪方面的能力，我不知道它在哪个层面。实际上能力在我们整个 Paper 1/Paper 2 中是第一个维度——换句话说，我们认为能力是 OK 的，我们不去确认能力 OK 不 OK，而是确认这个协作 OK 不 OK。比如采购和供货之间，图片处理、信息收集、数据标准化这些底层的原子能力，我们都认为你是 OK 的，不会去考虑你说你做不到。不知道这个论文的能力维度在哪个层面——如果是社会层面的协作的话，是不错的；如果在更底层的话，对我们来说只能了解和借鉴。
>
> **密码学证据包**：这个肯定我们会做相应的，比如密码学签名、KYC、ZK 相关能力。举个例子：我是供货方，但各种原因不想暴露自己的厂家和实际价格。但我可以给你 ZK 凭证——我是合法的制造商，有这样的产品，价格在一个大概的范围内。这样在确定初步意向的时候信息量是足够了。但真正签合同，那肯定要真实的厂家、产品、价格，签订合规的合同。初期协作的话 ZK 就够了。
>
> **能力发现**：这个思路也不错。但我们最终的通信协议还是以 relay 为中心，通过广播和查询的方式——这种方式比较笨，但比较有效、比较可靠。而且现在网络速度和 agent 处理能力是 24 小时的，对人类很复杂的事情——比如询盘全国供应商——对 agent 来说可能一晚上就搞定了。
>
> **分层信任机制**：我们要参考和借鉴。
>
> 总体来说这是一个实验性的论文，很有价值，但实验采取的一些技术属于实验室级别、玩具级别，不是生产级别。但依然可以关注几个关键点是如何用哪些技术实现的，借鉴它的机制和原理。

## 技术借鉴分析（Jason 要求提取）

### 我们的核心立场差异：能力验证 vs 协作验证

| 维度 | Wang et al. P2P | 我们的 ACN |
|------|----------------|---------|
| **验证对象** | agent 能力是否真实（能不能做到）| agent 协作是否 OK（协作质量和结果）|
| **假设** | 能力声明可能造假，需 challenge-response | 基础原子能力假设 OK；关注协作层信任 |
| **挑战机制** | 金丝雀任务（小任务探针）| 协议数据交互 + 人类最终验证 |
| **信任层** | 能力信任（可以做什么）| 协作信任（做过什么，声誉历史）|

**Jason 的洞见**：能力层在我们框架里是 Given（假设已 OK）——我们解决的是"能力够的 agent 如何高效协作"，而不是"如何验证 agent 能力"。这是一个范畴的根本区别。

### P2P vs Relay 的架构选择分析

| 对比维度 | P2P（Wang et al.）| Relay（我们的 N 支柱）|
|---------|-----------------|-------------------|
| 节点平等性 | 所有节点平等 | Relay 节点有更高要求（可靠性、性能）|
| 可靠性保证 | 依赖节点可用性，不稳定 | Relay 提供中间缓存，可靠性高 |
| 性能要求 | 普通客户端难以满足高要求 | Relay 可以设定和执行性能标准 |
| 去中心程度 | 更去中心 | 相对 P2P 略中心，但比 ANP 去中心得多 |
| 实际可用性 | 实验室可行，生产级别待验证 | Nostr 网络已在生产环境运行 |

**设计理由**（Jason 亲述）：选 relay 是工程上的务实选择——可靠性和可控性优先于极致去中心化。

### ZK 证明的具体使用场景（Jason 给出的最清晰案例）

**场景：外贸采购的分阶段信息披露**

```
阶段 1（初步意向匹配）:
  供应方提供 ZK 证明:
    - "我是合法注册的制造商" ← ZK proof（不暴露营业执照）
    - "我有这类产品（SKU 范围）" ← ZK proof（不暴露具体型号）
    - "我的价格在 X 到 Y 区间" ← ZK range proof（不暴露实际报价）
  → 采购方可以判断：值不值得进一步谈

阶段 2（签订合同）:
  必须提供真实信息:
    - 真实厂家名称 + 营业执照
    - 具体产品型号、规格
    - 实际价格 + 付款条件
  → 合规合同，法律约束
```

这对应 Paper 2 §5.6（ZK 可选扩展）：ZK 不是强制要求，但在"不愿暴露但需要建立初步信任"的高价值场景中是有价值的。

### 可借鉴的技术机制（提取清单）

| 技术点 | 借鉴价值 | 我们的对应设计 |
|--------|---------|-------------|
| **分层验证机制**（Tier 1/2/3）| ✅ 高 | SC 支柱：声誉（Tier 1）→ 协议数据验证（Tier 2）→ VC 密码学证明（Tier 3）|
| **软状态能力描述符**（TTL 刷新）| ✅ 中 | ASM 协议能力字段：`protocol_capabilities`，可加 TTL 机制 |
| **15 秒 TTL 最优点**（能力漂移 vs 控制平面开销）| ✅ 工程参考 | relay 路由表刷新周期的工程参数参考 |
| **语义能力发现**（非精确匹配）| ✅ 中 | relay 的 topic 订阅机制（当前实现较粗粒度，可细化）|
| **Sybil 攻击防御**（Risk-Aware 选择 + 金丝雀任务）| ⚠️ 机制借鉴 | SC 声誉门槛 + 协议数据验证替代金丝雀任务 |
| **P2P 平等节点架构** | ❌ 不采用 | 改用 relay 中心（可靠性优先）|

### Paper 1/2 引用位置

| 论文位置 | 引用方式 |
|---------|---------|
| Paper 1 §4（N 支柱）| "Wang et al. (2026) 的分层验证框架（声誉→挑战响应→密码学证据）为 N 支柱的信任机制提供了参考蓝图；我们在 relay 网络架构上实现了与其 Tier 1/3 对应的机制，以可靠性换取部分去中心性" |
| Paper 2 §5（安全分析）| "分层验证是有效防御 Sybil 攻击的实证机制 [Wang et al. 2026]；ASM 用 SC 声誉门槛替代金丝雀任务，在社会层面实现等价防御" |
