# [Ehtesham et al. 2025] A Survey of Agent Interoperability Protocols: Model Context Protocol (MCP), Agent Communication Protocol (ACP), Agent-to-Agent Protocol (A2A), and Agent Network Protocol (ANP)

**Citation**: Abul Ehtesham, Aditi Singh, Gaurav Kumar Gupta, Saket Kumar. "A Survey of Agent Interoperability Protocols: Model Context Protocol (MCP), Agent Communication Protocol (ACP), Agent-to-Agent Protocol (A2A), and Agent Network Protocol (ANP)." arXiv:2505.02279v2 [cs.AI], 23 May 2025. 21 pp.
**机构**: Kent State University; Cleveland State University; Youngstown State University; Northeastern University (Boston)
**arXiv**: https://arxiv.org/abs/2505.02279
**PDF**: papers/ehtesham2025-interop-survey.pdf
**Cluster**: Agent Protocols / Trust — Paper 2 §2 comparison
**Status**: ✅ 全文已分析（2026-05-22）

## Core claim (一句话)
No single agent-interoperability protocol suffices across all deployment contexts; MCP, ACP, A2A, and ANP each target a distinct interoperability tier (tool access → structured messaging → enterprise task delegation → open-internet P2P), and a phased complementary adoption (MCP → ACP → A2A → ANP) is the practical path to scalable agent ecosystems.

## 研究问题
How do the four leading 2024–2025 LLM-agent interoperability protocols (MCP, ACP, A2A, ANP) differ in architecture, discovery, identity/auth, messaging, session, transport, and security, and in what order should organizations adopt them?

## 方法与主要内容 (taxonomy/protocols/trust-model categories covered)
Descriptive comparative survey (no empirical evaluation). Contents:
- **Historical timeline** (Table 2): KQML (1993), MASIF (1998), FIPA-ACL (2000), Web Services/SOAP-WSDL (2002), ESB patterns (2006), RAG (2020), Function Calling/Toolformer/ReAct (2023), MCP/ANP/ACP (2024), A2A (2025). Three eras: Symbolic+SOA foundations → Retrieval/In-model action → Protocol-oriented interoperability.
- **Per-protocol deep dive** (architecture, core components, 4-phase lifecycle Creation/Operation/Update/Termination, and a security threats+mitigations table each — Tables 3–6):
  - **MCP** (Anthropic, Nov 2024): JSON-RPC 2.0 client–server; primitives Tools/Resources/Prompts/Sampling; control models (model/app/user/server-controlled). Centralized-server assumption; prompt-injection / tool-poisoning risks.
  - **A2A** (Google, Apr 2025): peer-to-peer task delegation; Agent Cards at `/.well-known/agent.json`; Task/Message/Artifact; SSE + push notifications; enterprise-trust-boundary scope.
  - **ACP** (IBM/Linux Foundation, Mar 2025): RESTful HTTP, MIME-typed multipart messages, sync+async, brokered registry + offline discovery, integrates RBAC and DIDs; session-aware.
  - **ANP**: decentralized P2P, W3C DIDs (did:wba), JSON-LD/ADP agent descriptions, Meta-Protocol Negotiator, open-internet discovery; mentions `humanAuthorization` for sensitive actions.
- **Comparison matrix (Table 7)** across: Architecture Model, Agent Discovery, Identity & Auth, Message Format, Core Components, Transport Layer, Session Support, Target Scope, Primary Use Case, Strengths, Limitations.
- **Phased adoption roadmap** (§9): Stage 1 MCP → Stage 2 ACP → Stage 3 A2A → Stage 4 ANP (open agent markets).

## 与 ASM 的关系（差异化 + 可借用）
| Dimension | This paper (MCP/ACP/A2A/ANP) | ASM 的定位 |
|---|---|---|
| Identity layer | DID/token/AgentCard identifies the *agent software* | ASM cryptographically binds *declared human/org principals' social roles + credentials* to the agent (accountability anchor) |
| Discovery/profile | Capability-based (Agent Card, Agent Detail, ADP) — what the agent *can do* | Role-bearing profile — what social role the agent *holds on behalf of whom* |
| Collaboration model | Generic task delegation / message exchange | Role-specific collaboration state machines |
| Reputation/trust | Not addressed at protocol level (paper flags this as future work: "trust frameworks for agent collaboration") | Privacy-preserving reputation via ZK proofs over accumulator-managed credentials |
| Network openness | ANP = open P2P but capability-only; A2A/ACP = trusted/enterprise | ASM = permissionless multi-party coordination + role accountability |
| Lifecycle/security | 4-phase lifecycle + per-phase threat tables (signing, DIDs, mTLS) | ASM can reuse the Creation/Operation/Update/Termination lifecycle framing and the spoofing/manifest-signing mitigations |
| Borrowable | Table 7 dimension set; lifecycle structure; did:wba + JSON-LD discovery precedent (ANP) | ASM's §2 table should adopt these dimensions and add: role-credential binding, ZK reputation, human-authorization accountability |

## Paper 2 §2 引用段落 (~150-200词，英文)
Ehtesham et al. (2025) provide the canonical comparative reference for the current generation of agent interoperability protocols, contrasting MCP, ACP, A2A, and ANP across architecture model, discovery, identity/authentication, message format, session support, transport, and security lifecycle. Their analysis confirms that these protocols converge on *capability-based* identity—MCP token-based tool access, A2A capability-bearing Agent Cards, ACP Agent Detail manifests, and ANP did:wba decentralized identifiers with JSON-LD descriptions—and that even the most open of them (ANP) authenticates the *agent as software entity* rather than the social role its principal authorizes. Crucially, the authors explicitly identify "trust frameworks for agent collaboration" as unsolved future work, and no surveyed protocol prescribes ecosystem-level reputation or privacy-preserving accountability. ASM addresses precisely this gap: rather than competing on transport or discovery, it layers (i) cryptographic binding of declared principals' social roles and credentials, (ii) role-specific collaboration state machines, (iii) ZK-based privacy-preserving reputation over accumulator-managed credentials, and (iv) permissionless multi-party coordination with human-authorization accountability—dimensions absent from the Table 7 comparison axes that the survey establishes as the field standard.

## Action items
- [ ] Cite as the primary related-work anchor opening Paper 2 §2 (establishes the capability-invocation baseline ASM departs from)
- [ ] Reuse Table 7's dimension set as the skeleton of the ASM §2 comparison table; add 3 ASM-specific rows: role-credential binding / ZK reputation / human-authorization accountability
- [ ] Cite the phased-adoption framing (§9) when positioning ASM as a complementary trust+role layer rather than a transport replacement
- [ ] Cite the lifecycle + per-phase threat tables (Tables 3–6) when describing ASM's security model
- [ ] Pull KQML/FIPA-ACL/MASIF historical lineage (Table 2) for Paper 1's protocol-evolution narrative (Pillar P)

## Jason's feedback
> （请在此处写入你的feedback）
