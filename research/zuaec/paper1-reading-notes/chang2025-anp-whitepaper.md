# Agent Network Protocol Technical White Paper
**arXiv**: 2508.00007 | **Year**: 2025 | **Authors**: Gaowei Chang, Eidan Lin, Chengxuan Yuan, Rizhao Cai, Binbin Chen, Xuan Xie, Yin Zhang (ANP Open Source Technology Community) | **Venue**: arXiv / ANP Community

## Core Claim
ANP proposes a three-layer protocol architecture (identity/encryption, meta-protocol negotiation, application) using W3C DID (did:wba method) for cross-platform agent authentication without central authority — replacing human-centered web infrastructure with AI-native machine-readable connections and enabling agents to discover, authenticate, and collaborate across platforms.

## Key Evidence / Numbers
- Three-layer architecture: (1) identity+encryption layer (did:wba, ECDHE), (2) meta-protocol layer (dynamic negotiation via natural language), (3) application layer
- DID method: **did:wba** — web-based DID enabling cross-platform agent identity
- Agent Description Protocol (ADP): JSON-LD metadata for agent capabilities, interfaces, security requirements
- Agent Discovery: active discovery (domain directories) + passive discovery (search services)
- Multi-DID strategy for privacy/anonymity
- Human vs. agent authorization: sensitive operations require explicit human approval
- Minimal information disclosure principle
- Design goal: rapid real-world deployment on existing internet infrastructure

## ASM Comparison (Paper 2 focus)

### 技术层差异（Technical Gap）
- **What it does**: The most direct protocol competitor to ASM — ANP is a full protocol specification with DID identity, capability description, and dynamic meta-protocol negotiation. The survey (2504.16736) identifies ANP as the primary cross-domain inter-agent protocol
- **Gap vs ASM**: (1) **No role-bearing** — ANP's DID identity and ADP capability description do not encode agent role type (Coordinator, Executor, Verifier) that ASM uses for routing decisions; (2) **No reputation mechanism** — ANP enables agents to find and authenticate each other but provides no mechanism for trust scoring based on interaction history; (3) Meta-protocol negotiation via natural language is flexible but non-deterministic — ASM's structured message format is more verifiable; (4) did:wba relies on domain-based web infrastructure, which is still somewhat centralized

### 治理层差异（Governance Gap）— Jason's framing [2026-05-22]

**ANP = 企业主导型协议（Corporate-backed Protocol）**
- 由蚂蚁集团（Ant Group/Alibaba 生态）主导推动，虽代码开源，但协议演进路线由企业控制
- 设计目标：服务商业 agent 市场，企业级部署优先
- 类比：**Windows** — 公司控制标准，即使发布"开放"API

**ASM/Mycelium = 社区治理型开放协议（Community-governed Open Protocol）**
- 以开源方式发布，协议共创由社区驱动（无任何单一企业控股）
- **"在合规形式下的无许可协议社区"**：只要通过国家正常合规渠道，任何人/机构都可以：
  - 建立中继节点（relay）
  - 实现协议
  - 参与治理
- 类比：**Linux / Nostr** — 无许可参与，任何人可运行中继，协议由社区演进
- 国内类比：联盟链中的开放生态，而非单一机构链

**Paper 2 §2 差异化表述（建议引用语）**：
> "ANP [Chang et al. 2025] provides a technically capable protocol for cross-platform agent identity, but operates under corporate-backed governance where protocol evolution is controlled by a single commercial entity. ASM, by contrast, is designed as a community-governed open protocol: any participant — organization or individual — who meets basic compliance requirements can operate a relay, implement the protocol, or contribute to its evolution, analogous to the Linux kernel or Nostr relay network. This governance-layer distinction, not merely technical differences, is the primary differentiator."

- **Paper 2 §2 use**: Primary direct competitor — include in comparison table. Differentiate on BOTH technical layer (role-bearing, reputation) AND governance layer (community vs corporate).

## Paper 1 Relevance
- **§4.1 (N pillar)**: ANP's three-layer architecture is the reference design for the N pillar — cite as the best existing N pillar implementation; Paper 1 argues ASM extends it with P+S pillars integrated
- **§4.2/4.3**: The absence of P+S pillar features in ANP validates Paper 1's argument that a three-pillar framework is needed

## Verdict
⭐⭐⭐⭐⭐ | Most important direct competitor — cite in P2 §2 comparison table as primary foil. ANP has the closest protocol architecture but lacks role + reputation. Also essential for Paper 1 §4. Note: ANP community authors wrote both this and the survey (2504.16736), creating slight conflict of interest in that survey's ANP coverage.

---
## Jason's Feedback

> **2026-05-24**
> 精心设计的网络可能不如自组织涌现的网络，让 agent 更好地协作和发挥能力。蚂蚁集团主导的 agent 连接协议，身份认证一定是通过蚂蚁集团的体系，而不是可匿名无许可的。
>
> 第二个，明显和开源对立的闭源方式带来很多不确定性：每个 agent 的交互数据究竟被做了什么，谁也不知道，带来很大的数据垄断和隐私风险。也包括不能涌现更好智能的风险——因为它不是无许可的、不是自组织的。
>
> 从蚂蚁集团主导这个角度来看，有这么多缺点。当然在具体的技术应用层面——比如身份和加密、自然语言协议、应用协议——是有可以借鉴的。一些具体的应用，他们能给出很好的深入研究和洞察。对于它的视角和站位是天然觉得有缺点的，但一分为二来看，技术可借鉴这一块，希望深入分析：具体应用协议如何定义、有什么好处、技术栈是什么、用什么逻辑构建、自然语言如何形成协议、端到端加密方式如何，记录下来为 paper1/paper2 服务。

## ANP 技术借鉴深度分析（Jason 要求，2026-05-24）

### 1. 三层架构的借鉴价值

ANP 最有价值的贡献是**分层设计原则**，每层职责清晰：

```
层 3（应用层）  ←→  具体业务协议（采购、推荐、评审…）
    ↑ 调用
层 2（元协议层）←→  协议协商（"我们用什么协议通信"）
    ↑ 依赖
层 1（身份+加密）←→  did:wba + ECDHE 端对端加密
```

**我们可以借鉴的**：这个三层分离原则可以直接映射到 ASM：
- ASM 层 1 = DID/VC 身份层（已有）
- ASM 层 2 = ASM 消息头（协议协商字段）
- ASM 层 3 = 具体协作协议（采购协议、推荐协议等）

---

### 2. did:wba 身份方案的技术细节

**did:wba（Web-Based Agent DID）**的构建逻辑：
- 基于域名的 DID：`did:wba:company.com:agents:purchasing-001`
- 验证文档放在 `/.well-known/did.json`，任何人可以请求验证
- 优点：不需要区块链，利用现有 Web 基础设施，部署成本低
- 缺点：依赖域名 → 仍然依赖中心化 DNS 体系

**我们的改进**：用 EIP-8004 NFT 身份替代 did:wba，链上存储而非域名，真正去中心化。但 ANP 的 did:wba 对于"快速部署在现有企业 Web 基础设施上"的场景仍有参考价值——ASM 可以支持 did:wba 作为身份接入方式之一（多 DID 策略）。

---

### 3. 自然语言元协议协商——借鉴与风险

**ANP 的做法**：Agent 之间用自然语言协商"接下来用什么协议"：
```
Agent A: "我支持采购协议 v2.1 和推荐协议 v1.0，你支持哪个？"
Agent B: "我支持采购协议 v2.1，我们用这个。"
```

**借鉴价值**：
- 协议发现（Protocol Discovery）的思路是对的——agent 不能假设对方支持什么
- 能力声明（ADP: Agent Description Protocol）用 JSON-LD 格式很实用

**ANP 的问题（我们需要改进的）**：
- 自然语言协商 = 非确定性，不可机器验证
- 攻击者可以用语义歧义进行协议降级攻击
- **ASM 的改进**：用结构化的协议协商字段替代自然语言：
  ```json
  "protocol_capabilities": ["asm:procurement:v2.1", "asm:referral:v1.0"],
  "preferred": "asm:procurement:v2.1"
  ```
  机器可验证，无歧义。

---

### 4. ECDHE 端到端加密方案

**ANP 使用 ECDHE（椭圆曲线 Diffie-Hellman 密钥交换）**：
- 每次 session 生成临时密钥，前向安全（Forward Secrecy）
- 即使长期密钥泄露，历史通信内容也无法解密
- 标准实现：X25519 曲线

**可直接借鉴到 ASM**：ASM 直接采用 ECDHE 作为消息加密方案，无需重新设计，在 Paper 2 §4（协议规范）中引用 ANP 的做法并说明"ASM 与 ANP 在传输加密上使用相同方案（ECDHE/X25519），差异在上层"。

---

### 5. Agent Description Protocol（ADP）的借鉴

**ADP 的内容**（JSON-LD 格式）：
```json
{
  "agentId": "did:wba:company.com:agent-001",
  "capabilities": ["procurement", "contract_review"],
  "supportedProtocols": ["anp:procurement:v1"],
  "securityRequirements": {"encryption": "ECDHE", "auth": "did:wba"},
  "humanApprovalRequired": ["payment > 10000 CNY"]
}
```

**我们的对应**：ASM 的 Capability & Resource Manifesto（消息第二块）吸收了这个思路，但增加了：
- 角色声明（role_type）
- 声誉阈值要求（min_reputation_score）
- 协议合规证明（VC_protocol）

**在 Paper 2 §2 中**：明确说"ASM 的能力描述块扩展自 ANP 的 ADP 设计，增加了角色语义和声誉要求字段"。

---

### 小结：ANP 可直接借鉴的 4 项 + 需要替换的 2 项

| 项目 | 借鉴/替换 | ASM 处理方式 |
|------|---------|------------|
| 三层分层架构 | ✅ 借鉴 | 直接采用，ASM 在各层上扩展 |
| ECDHE 端到端加密 | ✅ 借鉴 | 直接引用，Paper 2 §4 注明 |
| ADP 能力描述格式 | ✅ 借鉴 | 扩展加入角色+声誉字段 |
| 多 DID 隐私策略 | ✅ 借鉴 | ASM 支持匿名化 DID 用于隐私场景 |
| did:wba 身份方案 | ⚠️ 替换 | 改用链上 DID（EIP-8004），更去中心化 |
| 自然语言元协议协商 | ❌ 替换 | 改用结构化 JSON 字段，机器可验证 |
