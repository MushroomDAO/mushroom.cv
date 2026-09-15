# [Yuan et al. 2026] Beyond Message Passing: A Semantic View of Agent Communication Protocols

**Citation**: Dun Yuan, Fuyuan Lyu (co-first), Ye Yuan, Weixu Zhang, Bowei He, Jiayi Geng, Linfeng Du, Zipeng Sun, Yankai Chen, Changjiang Han, Jikun Kang, Xi Chen, Haolun Wu, Xue Liu. 2026. *Beyond Message Passing: A Semantic View of Agent Communication Protocols*. arXiv:2604.02369v3 [cs.NI], 13 Apr 2026. (Survey, ~34pp)
**机构**: (作者群以 McGill / 北邮 等华人作者为主；论文未在首页逐一标注 affiliation——bibliography 中标 [TODO: verify institutions])
**arXiv**: https://arxiv.org/abs/2604.02369
**PDF**: papers/semantic-view-protocols2026.pdf
**Cluster**: Protocol Semantics — Paper 2 §2/§5
**Status**: ✅ 全文已分析（2026-05-22）

## Core claim (一句话)
受人类沟通理论启发，把 agent 通信协议拆为**三层：communication / syntactic / semantic**；系统分析 18 个协议后发现严重**失衡**——传输与语法层日趋成熟，但 **semantic 层（澄清、上下文对齐、验证）协议级支持极弱**，导致语义责任被"外推"到 prompt / wrapper / 编排逻辑，形成隐性互操作与维护**技术债**。

## 研究问题
当前 agent 通信协议（MCP、A2A、ACP 等）能可靠传输并解析消息，但**无法保证两个 agent 对同一请求做相同解释**（"successful message exchange ≠ successful meaning alignment"）。如何用一个统一框架评估协议的"完整性"，并暴露其语义缺口？

## 方法与主要内容
**人类沟通三层映射**（Shannon-Weaver / Grice 合作原则 / Clark common ground / Sperber-Wilson relevance theory）：
1. **Communication Layer**（"能否可靠收发信号？"）：传输、排序、交付保证、安全、流式。
2. **Syntactic Layer**（"是否说同一种语言？"）：schema（JSON/RPC/事件）、工具/能力、生命周期、错误。transport-agnostic typed message contract。
3. **Semantic Layer**（"我们指的是同一件事吗？"）：intent 对齐、歧义消解、验证、共享上下文。子能力：intended outcome（机器可检查的前/后置条件 + 证据）、alignment（schema/词汇/身份跨命名空间映射，可审计 rule id）、**verification**（把计划与结果变成"checked commitments"，输出须逻辑跟随输入或有引用证据，"interactive claims may require justification or machine-checkable proofs"）、meaning-aware security（intent 白名单、provenance、capability scopes 抗 prompt injection）。

**18 协议分析（§4，表格 ✓/△/×）**：跨 9 列（Transport/Stream/Security | Schema/Lifecycle/Error | Clarify/Context/Verify）评分。关键发现：
- MCP：semantic 三列全 ×；A2A：是少数 Clarify=✓ 的协议；Agora：Clarify/Context/Verify 全 ✓（靠协商收敛成 hashed Protocol Document）；多数协议 semantic 列为 × 或 △。
- ANP/LMOS：用 JSON-LD + DID 承载跨域可解析语义；Coral：DID-backed 身份 + 链上声誉/escrow；LOKA：身份+加密投票+可审计共识；AITP：把 intent 转成 typed payload（表单/attestation/支付）。

**技术债（§5）三类**：
- **生态碎片化债**（5.1）：多协议并存 → 定制集成成本、重复/锁定、治理不确定性（"interoperability debt"）。
- **通信层债**（5.2）：会话管理不足（假设同步、短会话，无法建模长时异步 / 部分失败 / 交错 handoff——引 MPST 多方会话类型文献）、错误管理不足（HTTP 状态码无法表达"策略性拒绝/无法理解 performative"等认知层失败）、**消息结构不足**（字段定义不严、versioning/扩展性差）。
- **语法/语义层债**（5.3）：Data Model Debt（弱类型 JSON 无 IDL）、Schema Drift Debt、**Performative Ambiguity Debt**（LLM 随机性导致 performative 误分类→无效状态转换/死锁）、Ontological Grounding Debt（缺共享本体→domain misalignment）、Contextual Coherence/Drift Debt（协议不强制跨 agent 上下文同步）。

**选型决策树（§6）**：单租户工具调用→MCP；多步例程→agents.json；组织内编排→ACP-AGNTCY/IBM；跨组织发现委托→A2A，需可验证身份+可携带语义→ANP/LMOS；重复交互→Agora；**跨信任边界 typed 交易/attestation/支付→AITP，需 escrow+声誉→Coral（DID+链上声誉）**；治理/伦理共识→LOKA。原则："选择能减少 session/schema/meaning drift 的最小协议"。

**结论（§7）**："semantic gap"是当前 MAS 技术债的首要驱动；协议错误地假设"传输成功 = 理解一致"。

## 与 ASM 的关系（差异化 + 可借用）

| 维度 | This paper (Semantic View) | ASM 的定位 |
|------|------|------|
| 性质 | **survey / 评估框架**（描述性，不提新协议）| 一个**具体新协议**（规范性） |
| 分层 | communication / syntactic / **semantic** 三层 | ASM 的 role-credential + intent-proof message block 正好落在其 **semantic 层**（intent 验证 + meaning-aware security） |
| 角色/身份 | 仅 ANP/LMOS/Coral 用 DID；多数协议无 first-class 角色 | **密码学角色/凭证绑定 + role-specific 状态机**——直接补其指出的"协议级角色/身份缺口" |
| 验证 | 把 "machine-checkable proofs / proof-carrying" 列为 semantic 层应有却普遍缺失的能力 | **intent-proof message block + ZK 声誉** = 该缺失能力的具体实现 |
| 状态机 | 批评现有协议会话模型假设同步短会话（session management debt）| ASM 的 **role-specific state machines** 可论证为对 §5.2.1 session debt 的回应 |
| 消息结构 | §5.2.3 批评消息结构字段定义不严、无 versioning | ASM 严格定义的 role-credential + intent-proof message block 直接对标此债 |
| 隐私 | meaning-aware security 谈 provenance/capability scope，但**未涉及 ZK 隐私声誉** | ASM 的 ZK over accumulators 在其框架内是未覆盖的语义安全增强 |

**可借用（这是 Paper 2 §2 的理想理论支架）**：(1) 直接采用其**三层框架**给 ASM 定位——"ASM 把语义责任从 prompt/wrapper 收回到协议层"；(2) 用其 9 列能力表把 ASM 与 MCP/A2A/ANP/Coral 同台对比，论证 ASM 在 Clarify/Context/Verify + 角色/隐私维度的优势；(3) 引用其 **Performative Ambiguity Debt / Ontological Grounding Debt / session management debt** 作为 ASM 要解决的具名问题；(4) Coral（DID + 链上声誉 + escrow）是 §6.5 中与 ASM 最近的竞品——ASM 用 ZK 声誉 vs Coral 的链上（公开）声誉是关键差异点。

## Paper 2 引用段落（~190词，英文）
Yuan et al. [2026] survey 18 agent communication protocols through a human-inspired three-layer taxonomy—communication, syntactic, and semantic—and show a structural imbalance: contemporary protocols (MCP, A2A, ACP) mature rapidly at transport and schema levels yet provide "limited protocol-level mechanisms for clarification, context alignment, and verification," forcing semantic responsibilities into prompts and ad-hoc wrappers and accruing "semantic technical debt." They name several debts directly relevant to multi-party coordination—*performative ambiguity*, *ontological grounding*, *contextual coherence*, and *session-management* debt—and observe that only a minority of protocols treat identity as first-class (ANP/LMOS via DIDs, Coral via DID-backed on-chain reputation). ASM positions itself squarely in this under-served semantic layer: cryptographic role/credential binding makes roles a protocol primitive rather than a prompt convention; role-specific state machines address the session-management debt of synchronous, short-lived lifecycle models; and intent-proof message blocks operationalize the "machine-checkable proofs" the survey identifies as missing. Crucially, where the closest comparator, Coral, exposes reputation on-chain, ASM employs zero-knowledge, accumulator-based reputation—delivering verifiable trust over a permissionless network without disclosing the underlying interaction history, an extension of meaning-aware security the survey's framework does not cover.

## Action items
- [ ] Paper 2 §2（背景/框架）：采用 Yuan et al. 三层 taxonomy 作为定位 ASM 的理论支架，明确 ASM 工作在 semantic 层
- [ ] Paper 2 §2/§5：用其 9 列能力表与 MCP/A2A/ANP/**Coral** 同台对比 ASM
- [ ] Paper 2 §5（差异化）：用上面段落，特别强调 vs Coral（公开链上声誉）→ ASM ZK 声誉差异
- [ ] 引用具名技术债（performative ambiguity / ontological grounding / session management）作为 ASM 解决的问题清单
- [ ] [TODO: verify] 补全作者 affiliation（首页未逐一标注）

## Jason's feedback
> （请在此处写入你的feedback）
