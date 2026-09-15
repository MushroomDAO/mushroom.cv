# [Fleming et al. 2025] A Layered Protocol Architecture for the Internet of Agents

**Citation**: Charles Fleming, Luca Muscariello, Vijoy Pandey, Ramana Kompella (Cisco Research). "A Layered Protocol Architecture for the Internet of Agents." arXiv:2511.19699v3 [cs.NI], 20 Jan 2026 (v1 originally Nov 2025).
**机构**: Cisco Research (USA / France)
**arXiv**: https://arxiv.org/abs/2511.19699
**PDF**: papers/fleming2025-layered-protocol-architecture.pdf
**Cluster**: Agent Protocols / Architecture — Paper 2 §2 (comparison) / §6 (threat model, semantic-layer attacks)
**Status**: ✅ 全文已分析（2026-05-22）

## Core claim (一句话)
Current agent protocols (MCP, A2A, FIPA-ACL) standardize the *syntax* of messages but cannot enforce *semantic agreement*, so the authors propose two new OSI-style layers above HTTP/2/3 — an Agent Communication Layer (L8) for message envelopes/performatives/interaction patterns and an Agent Semantic Layer (L9) for context discovery, semantic grounding/validation, and population-scale coordination/consensus.

## 研究问题
How should the network protocol stack evolve to support reliable, scalable multi-agent collaboration ("Internet of Agents"), given that OSI/TCP/IP were built for data delivery between hosts and current agent protocols only solve syntactic interoperability while leaving semantic meaning unmanaged at the application layer?

## 方法与主要内容
This is a position/architecture paper (no experiments). Key contents:

**Diagnosis of the gap.** Two failure modes of syntax-only protocols: (1) *Syntax without semantic context* (e.g. "switch" is parseable but ambiguous); (2) *Semantic underspecification* (e.g. "Book a ticket to New York" parses but lacks airport/date/class). These force expensive non-deterministic LLM clarification loops. FIPA-ACL had an `:ontology` slot but provided no protocol-level mechanism to *negotiate/align* ontologies; A2A/MCP/NLIP are lighter (JSON over HTTP/2) but still leave grounding to the developer.

**Two new layers (the architecture):**
- **L8 — Agent Communication Layer** (the "how"): unifies A2A/MCP/NLIP/FIPA-ACL into one syntactic layer with 3 components — (1) Message Structure / envelope (sender, receiver, msg ID, performative); (2) Performatives / speech acts in three registries: Transactional (REQUEST, AGREE, REFUSE, INFORM), Negotiation (PROPOSE, ACCEPT, REJECT, COUNTER_PROPOSE), Information (QUERY, SUBSCRIBE, PUBLISH); (3) Interaction Patterns — request-reply, publish-subscribe, aggregation (N:1), collaboration groups (N:N).
- **L9 — Agent Semantic Layer** (the "what" + collective state): the novel contribution. A 4-phase SL protocol: (1) **Context Discovery & Negotiation** (a "semantic handshake": SL-HELLO → SL-SELECT → SL-LOCK, locking a versioned URN like `urn:contexts:travel:v2.1`); (2) **Semantic Grounding** (bind data to formal Shared Context definitions in JSON Schema / RDF-OWL / Protobuf / even shared embedding spaces); (3) **Semantic Validation/Disambiguation**; (4) **Coordination & Consensus** ("Ripple Effect" — voting / threshold signatures / state replication so a quorum commits to the same shared state). Recognizes HTTP/2/3 as the L7 Application Transport (FRAMES + STREAMS = "narrow waist").

**Security section (§5) — directly relevant to ASM §6.** Introduces *semantic-layer* attack vectors that complement (not replace) TLS/MLS: (a) **Semantic Injection** (L9 equivalent of prompt injection — schema-valid payload carrying malicious instructions); (b) **Context Poisoning / Spoofing** (compromised registry swaps `sender_id`/`receiver_id` in a payment context); (c) **Semantic DoS** (flood with schema-valid but LLM-expensive ambiguous queries — exhausts inference budget, not bandwidth); (d) **Semantic Downgrade Attack** (MITM strips a fixed context version from SL-HELLO to force a vulnerable older one, analogous to TLS downgrade). Defenses: Authenticated Contexts (cryptographically signed, version-pinned, validated against trusted Schema Authorities), Semantic Firewalls (concept-level authorization + rate limiting), Confidentiality of Capability (encrypt SL-HELLO so capability advertisements leak no business intelligence), and a federated **Schema Authority (SA)** trust/governance model (centralized SAs for public contexts, self-signed for private, federation/mutual recognition across boundaries — mirrors TLS CA / SAML/OIDC).

## 与 ASM 的关系（差异化 + 可借用之处）

| Dimension | This paper (L8/L9 IoA stack) | ASM — what ASM adds |
|---|---|---|
| Layering / scope | Generic 2-layer extension above HTTP/2/3; *semantic interoperability* (shared meaning of task terms) is the core problem | ASM operates at the collaboration-protocol layer but its problem is *social-role agency*, not term disambiguation; ASM's 3-block message structure can be read as an L8-style envelope carrying role/credential blocks |
| Identity binding | Authenticated Contexts = signed *schema*; agent identity handled by L7 (OAuth/TLS) — no notion of a *social role* bound to a principal | ASM **cryptographically binds social roles/credentials from declared principals to agents** — a binding L8/L9 has no concept of |
| Reputation | None; trust = signed contexts + Schema Authorities | ASM adds **privacy-preserving reputation via ZK proofs over accumulator-managed credentials** |
| Coordination | L9 "Ripple Effect" consensus = converge on shared *semantic state*; assumes cooperative population | ASM uses **role-specific collaboration FSMs** + **permissionless multi-party coordination** with an explicit 8-attacker adversary model |
| Trust governance | Federated Schema Authorities (CA-like, partly centralized) | ASM's permissionless / dual-network model avoids a central SA; this is a key contrast to surface |
| Threat model | 4 *semantic-layer* attacks (injection, context poisoning, semantic DoS, semantic downgrade) | ASM should **adopt** semantic downgrade + context poisoning into its §6 adversary model; ASM's role-binding directly defends against the "capability spoofing" risk this paper leaves open |

**可借用之处 (ASM should cite/adopt):** (1) The L8/L9 separation gives ASM a clean way to *position* itself — ASM can state it sits at/above L8 and adds a "social/identity layer" orthogonal to L9's semantic layer. (2) The **semantic downgrade attack** and **context/registry poisoning** are concrete new adversary entries for ASM §6. (3) The **Schema Authority federation model** is the centralized-trust foil against which ASM's permissionless reputation/ZK design should be contrasted. (4) The speech-act performative registry (Transactional/Negotiation/Information) is a vocabulary ASM's FSM transitions can reuse/cite.

## Paper 2 区分/引用段落（~180 词，英文）
Fleming et al. (2025, Cisco Research) argue that today's agent protocols — MCP, A2A, FIPA-ACL, NLIP — standardize only the *syntactic* envelope of messages and cannot enforce shared *meaning*, and they propose a two-layer extension to the OSI/IoA stack: an Agent Communication Layer (L8) consolidating message structure, speech-act performatives, and interaction patterns, and a novel Agent Semantic Layer (L9) that negotiates and cryptographically authenticates a versioned "Shared Context" and provides population-scale consensus. In Paper 2's §2 comparison this work is the **architecture/layering** reference point: it shows that the protocol community's frontier is *semantic* interoperability, whereas ASM targets an orthogonal and unaddressed axis — *social-role agency*, i.e. cryptographically binding declared-principal credentials and roles to agents, privacy-preserving reputation via ZK over accumulators, and permissionless multi-party coordination. We position ASM's 3-block message structure as an L8-compatible envelope that additionally carries a role-credential block L8/L9 lack. For §6, Fleming et al.'s four *semantic-layer* threats — semantic injection, context/registry poisoning, semantic DoS, and the **semantic downgrade attack** — should be incorporated as adversary inputs, and ASM's role binding is presented as the defense against the *capability/identity spoofing* gap their federated Schema-Authority model leaves open in permissionless settings.

## Action items
- [ ] §2 comparison table: add row "Layered IoA stack (L8/L9, Fleming 2025)" — axis = semantic interoperability vs. ASM's social-role agency; note ASM 3-block ≈ L8 envelope + role-credential block.
- [ ] §6 adversary model: import *semantic downgrade* and *context/registry poisoning* as named attacker capabilities; map to ASM's 8-attacker taxonomy.
- [ ] §6/related: cite federated Schema Authority as the centralized-trust foil to ASM's permissionless ZK reputation.
- [ ] Optionally cite the speech-act performative registry when defining ASM FSM transition labels.

## Jason's feedback
> （请在此处写入你的feedback）
