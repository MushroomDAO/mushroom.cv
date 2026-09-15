# Paper 2 Initial Draft v0

> **Document type**: Working draft for internal iteration (not for submission)
> **Created**: 2026-05-20
> **Status**: v0 — first complete skeleton with substantive content in all sections; gaps marked [TODO]
> **Target venue**: arXiv (primary: cs.DC; cross-list: cs.CR, cs.MA)
> **Target length**: 10,000-12,000 words (current ~6,500 words)
> **Companion paper**: Paper 1 (Three Pillars for AI Agent Socialization)
> **Companion files**: [paper-submission-plan-v2.md](paper-submission-plan-v2.md)

---

# ASM: A Communication Protocol for Role-Bearing AI Agents in Open Collaboration Networks

<!--
Title options (terminology revised 2026-05-21 — "Decentralized/去中心化" removed from title & keywords per sensitivity review; replaced with government-neutral "Open"):
- A (primary, current): "ASM: A Communication Protocol for Role-Bearing AI Agents in Open Collaboration Networks"
  - alt wording also acceptable: "Distributed Collaboration Networks" / "Permissionless Collaboration Networks"
- B (backup, kept for venue-specific adjustment): "ASM: Operationalizing the Role-Bearing Agent Paradigm — Verifiable Identity, Privacy-Preserving Reputation, and Permissionless Coordination"
- C (deprecated, pre-revision wording, kept only for traceability): "ASM: A Native Communication Protocol for Decentralized Agent Collaboration with Verifiable Identity, Authorization, and Privacy-Preserving Reputation"
中文 (primary): "ASM：开放协作网络中角色承载型 AI Agent 的通信协议"
  - 备选: "分布式协作网络中..." （distributed）
注：W3C "Decentralized Identifiers (DID)" 为标准专有名词，正文引用处保留原名；仅标题/关键词/小节标题做中性化处理。
-->


**Authors**: [Jason Jiao, et al. — TBD]
**Affiliation**: Mycelium Protocol Open Source Community; AAStar
**Correspondence**: [TBD]
**Code & artifacts**: github.com/MushroomDAO/launch
**Conflict of Interest**: The authors are core contributors to Mycelium Protocol, the reference implementation discussed in §8. See §8.1 for full disclosure.

---

## Abstract

A companion paper [Authors, 2026, Paper 1] argues that AI agents should be positioned as **social role agents** carrying verifiable principal identity, rather than as invocable capability containers, and proposes a three-pillar framework (collaboration protocols, quantified social capital, permissionless networks) for an Agent Collaboration Network. This paper provides the protocol-level operationalization. We present **ASM (Agent Social Message)**, an agent communication protocol that operationalizes the role-bearing agent paradigm by integrating: (1) cryptographic binding of social roles and credentials from declared principals (individuals or organizations) to agents; (2) role-specific collaboration state machines (e.g., procurement protocol, partnership formation protocol, academic collaboration protocol); (3) privacy-preserving reputation accumulation via LAAS (Local AI As Service) feature extraction with Differential Privacy noise injection — keeping raw social data on-device while circulating only noisy vectors, with optional ZK proofs for high-assurance contexts; (4) permissionless multi-party coordination across organizational boundaries. ASM enables agents to engage in long-chain social and economic transactions—procurement contracts, partnership formation, cross-organization workflows—that current capability-level protocols (MCP, FIPA ACL, AutoGen) cannot support. We specify a dual-network model (human subnet A + social memory layer + permissionless agent subnet B), a three-block ASM message structure (Identity & Authorization Capsule, Capability & Resource Manifesto, Interaction Intent & Proof Payload), a finite state machine for two-phase interaction (relay-mediated discovery, direct negotiation), and an adversary model covering eight attacker types with safety and liveness analyses. We describe an ongoing implementation as part of Mycelium Protocol (currently on Sepolia testnet with planned OP mainnet), with full conflict-of-interest disclosure. This paper provides specification and security analysis; formal cryptographic proofs are deferred to future work.

**Keywords**: multi-agent systems; agent communication; verifiable identity; differential privacy; federated learning; social capital; protocol design; permissionless networks

---

## 1. Introduction

### 1.0 Relationship to the Companion Paper

A companion paper [Authors, 2026, Paper 1] argues that the next phase of AI agent deployment requires a **paradigm shift**: from positioning agents as *invocable capabilities* (the current MCP / FIPA ACL / AutoGen paradigm) to positioning them as **social role agents**—entities that carry verifiable principal identity (KYC, business licenses, prior reputation) and operate within authorization scope to engage in long-chain economic and social transactions across organizational boundaries. The companion paper proposes a three-pillar framework (collaboration protocols, quantified social capital, permissionless networks) grounded in classical institutional theory (Ostrom, Bourdieu, Putnam) as the conceptual foundation for an Agent Collaboration Network.

**This paper provides the protocol-level operationalization** of that framework. We focus on:
- **L5 (Architecture)**: the dual-network model with social memory layer
- **L6 (Protocol)**: the ASM message specification, state machine, and reputation system
- **L7 (Implementation)**: a transparent description of the Mycelium Protocol reference implementation

Readers seeking the underlying paradigm argument, scoping review of agent literature, and theoretical grounding should consult Paper 1.

### 1.1 Motivation

Recent advances in LLM-based AI agents have produced systems capable of autonomous action, but the communication infrastructure connecting them has lagged. Current solutions fall into three families:

1. **Centralized orchestration** (e.g., LangChain, AutoGen): A central process coordinates agent calls; communication is logically point-to-point through the orchestrator
2. **Standardized RPC** (e.g., Anthropic's MCP, OpenAI's tool calls): Agents invoke each other through standardized request-response interfaces
3. **Federated messaging** (e.g., Matrix-based agent networks): Agents exchange messages via federated relay infrastructure

None of these adequately address the **socialization requirements** articulated in our companion paper [Authors, 2026, Paper 1]: collaboration protocols, quantified social capital, and permissionless networks. Specifically:

- **MCP** focuses on tool invocation, not multi-party social coordination
- **FIPA ACL** (1997-2002) provides rich speech acts but no cryptographic accountability
- **Matrix/Federated systems** address messaging but not reputation or authorization
- **DIDComm** addresses identity but not interaction state machines or reputation

### 1.2 Contributions

This paper makes the following contributions:

1. **A dual-network system model** (§4) formalizing human authorization of agent operations in permissionless agent subnets, with explicit trust assumptions, network model, key lifecycle, and failure model
2. **The ASM message specification** (§5) with three-block structure, formal BNF syntax, and a finite state machine governing two-phase interaction
3. **A privacy-preserving reputation system** (§5) combining LAAS (Local AI As Service) on-device feature extraction, Differential Privacy noise injection, and federated reputation learning — keeping raw social data local while enabling reputation-weighted routing; with ZK proofs as an optional high-assurance extension
4. **A comprehensive security analysis** (§7) covering an eight-actor adversary model with safety and liveness properties analyzed against each
5. **A real-world deployment case** (§8): ASM as part of Mycelium Protocol on Ethereum/Optimism mainnet, with transparent disclosure

### 1.3 Threat Landscape Anchoring

Throughout this paper, we ground the protocol design in five concrete threat scenarios that motivate each design choice:

- **T1 (Privacy)**: A passive observer attempts to deanonymize an agent's human authorizer
- **T2 (Authorization escalation)**: A malicious agent acts beyond authorized scope
- **T3 (Reputation inflation)**: A coordinated agent ring inflates each other's reputation
- **T4 (Denial of service)**: An attacker floods relays with junk requests
- **T5 (Liveness disruption)**: An adversary partitions the network or stalls protocol progression

We refer back to T1-T5 in each design subsection.

### 1.4 Scope and Limitations

This paper provides:
- A protocol *specification* (§5) at a level of detail sufficient for independent reimplementation
- A *security analysis* with adversary models and attack-defense reasoning
- A *deployment case study* with on-chain verifiable artifacts

This paper does **not** provide:
- Formal cryptographic security proofs (Theorem-Proof style). Such proofs require cryptography-domain expertise. We provide *security analysis* in the sense established by protocol design literature (e.g., Wireguard, Signal Protocol initial papers), deferring formal proofs to future work
- A trained LAAS model implementation (§5.2). The paper specifies the architecture and interface; training a production-quality feature extraction model is deferred to subsequent engineering work
- Production-scale performance benchmarks beyond preliminary measurements (§8.4)
- A complete economic analysis of incentive mechanisms

---

## 2. Background and Related Work

### 2.1 Agent Communication Languages

**FIPA ACL** [FIPA 2002] established the speech-act-based communication paradigm for multi-agent systems, defining performatives (INFORM, REQUEST, PROPOSE, etc.) and content languages (FIPA-SL). ASM borrows the structured-message paradigm but extends it with cryptographic accountability absent in FIPA.

**KQML** [Finin et al. 1994] is the predecessor to FIPA ACL; similar limitations apply.

**Anthropic MCP** [Anthropic 2024] standardizes tool invocation between LLMs and external resources. MCP is request-response oriented and does not address multi-party social coordination, reputation, or authorization beyond local trust.

**OpenAI Function Calling / Tool Use** [OpenAI 2023] is similarly request-response and does not address peer-to-peer agent collaboration.

**Google Agent-to-Agent (A2A)** [Google, 2025] extends the request-response pattern to peer agent delegation via JSON Agent Cards (capability descriptors at `/.well-known/agent.json`). A2A addresses agent discovery and capability advertisement but omits role encoding, human authorization chains, and reputation; LDP [Prakash 2026] empirically shows A2A skill-matching achieves similar routing quality to identity-aware alternatives, suggesting capability discovery alone is insufficient for trust-sensitive coordination.

**ANP (Agent Network Protocol)** [Chang et al. 2025, arXiv:2508.00007] is a three-layer open-source protocol — identity+encryption layer (did:wba), meta-protocol negotiation layer (natural language), application layer — targeting cross-platform agent connectivity. ANP is the closest existing protocol to ASM in technical scope, and is backed by the ANP Open Source Technology Community (with significant Ant Group involvement). Key gaps relative to ASM: ANP provides no role-bearing message headers, no reputation layer, and meta-protocol negotiation via natural language is non-deterministic. Crucially, ANP's protocol governance is driven by a single corporate ecosystem; ASM is designed as a community-governed open protocol where any compliant party can operate a relay or implement the protocol — analogous to the Linux kernel or Nostr relay network versus proprietary alternatives.

**ACPs (Agent Collaboration Protocols)** [Liu et al. 2025, arXiv:2505.13523] proposes a unified protocol suite spanning registration, discovery, interaction, and tool invocation, explicitly addressing the fragmentation between MCP, A2A, and ANP. ACPs targets capability flow completeness; it does not address role encoding, verifiable human authorization, or reputation-weighted routing.

**LACP (Large Agent Communication Protocol)** [Li et al. 2025, arXiv:[TODO]] is a standardization proposal targeting formal semantics for LLM agent communication, drawing on speech-act theory. LACP addresses message semantics; ASM addresses the social infrastructure layer atop any communication semantics.

**LDP (Layered Delegation Protocol)** [Prakash 2026, arXiv:2603.08852] introduces identity cards with 20+ fields (model family, reasoning profile, cost characteristics) enabling specialization-aware delegation, achieving ~12× faster routing on easy tasks and 37% token reduction. LDP's key empirical finding — that unverified confidence metadata *degrades* synthesis quality below the no-metadata baseline (the "provenance paradox") — directly motivates ASM's requirement for *cryptographically verifiable* rather than self-asserted social capital.

### 2.2 Verifiable Identity Standards

**W3C DID Core** [Sporny et al. 2022] specifies the format and resolution of Decentralized Identifiers (`did:method:identifier`). DIDs are foundational; ASM uses DIDs for agent and human identity but extends with authorization relationships.

**W3C Verifiable Credentials** [Sporny et al. 2022] specifies the format for credentials issued by one party about another. ASM uses VCs as the basis for authorization and reputation, with extensions for ZK presentation.

**EIP-8004** [Ethereum Improvement Proposals, 2024] proposes binding NFTs to DIDs, enabling on-chain accountability for agent identity. ASM uses EIP-8004 for agent NFT identity with human authorizer binding.

**DIDComm** [DIF, 2023] specifies messaging between DID-identified parties. DIDComm focuses on bilateral communication and does not address multi-party social coordination or reputation.

**OIDC-A (OpenID Connect for Agents 1.0)** [Nagabhushanaradhya 2025, arXiv:2509.25974] extends OpenID Connect with five claim categories — agent identity, delegation chain, capability, trust level, and hardware attestation — to address the gap that OAuth 2.0/OIDC was designed for human users and cannot represent agent delegation chains or model-level identity. OIDC-A's delegation chain (ordered arrays with mandatory scope reduction at each step) and Zero Trust verification (at every interaction point) are directly informative for ASM's principal chain design. Key gap: OIDC-A provides authentication infrastructure but no reputation-weighted routing and no role-bearing message semantics; ASM can ride atop OIDC-A authentication while adding the SC and protocol layers.

**AgentDID** [Xu et al. 2026, arXiv:[TODO]] proposes DID-based persistent identity for LLM agents, enabling cross-platform identity continuity. AgentDID focuses on identity persistence; ASM extends with role contracts and reputation accumulation bound to that identity.

### 2.3 Privacy-Preserving Credentials

**BBS+ signatures** [Camenisch & Lysyanskaya, 2004; Boneh et al. 2018] enable selective disclosure: a credential can be issued once and selectively revealed in different presentations.

**Differential Privacy (DP)** [Dwork & Roth 2014] provides a mathematical framework for quantifying information leakage when sharing derived data. ASM uses the Gaussian mechanism for DP noise injection over social capital feature vectors before network transmission (§5.3).

**ZK-SNARKs** [Groth 2016] enable proving statements about credentials without revealing the credentials themselves. ASM supports ZK proofs as an *optional* high-assurance extension for regulated contexts (§5.5); they are not required for base protocol compliance.

**Cryptographic accumulators** [Benaloh & de Mare 1993; Camenisch & Lysyanskaya 2002] enable proving membership in a set without revealing the set's content. Referenced in §5.5 for the optional ZK extension.

**Self-Sovereign Identity** [Allen 2016] provides the philosophical framing for ASM's design.

### 2.4 Peer-to-Peer Communication

**Nostr** [Nostr NIPs, 2023] is a simple, censorship-resistant protocol for distributed social networking based on relays. ASM uses Nostr-compatible relays for the discovery phase (§5.3).

**libp2p** [Protocol Labs, 2019] provides modular peer-to-peer networking primitives including transport, NAT traversal, and pub/sub. ASM uses libp2p for the direct negotiation phase (§5.3).

**AT Protocol (Bluesky)** [Bluesky, 2023] is an alternative federated social protocol; we discuss why Nostr is preferred for our use case in §5.3.

### 2.5 Reputation Systems

**eBay-style reputation** [Resnick et al. 2000] uses summary scores; vulnerable to gaming, reset, and centralization.

**EigenTrust** [Kamvar et al. 2003] uses transitive trust propagation; computationally expensive at scale.

**Web3 reputation** (e.g., POAP, Karma3, Lens Protocol): Various approaches based on on-chain history; most expose full transaction history, lacking privacy.

**TrustFlow** [Seliuchenko 2026, arXiv:2603.19452] replaces scalar agent reputation with multidimensional topic-aware reputation vectors propagated via interaction graph operators. Key results: 98% multi-label P@5 precision on dense graphs; ≤4 percentage-point adversarial impact (Sybil, laundering, vote-ring attacks); economic signal weighting at 3× base weight. TrustFlow is the mathematically closest prior system to ASM's topic-aware reputation pillar. Key gaps: TrustFlow operates on interaction graphs without requiring DID-linked identity (graph is the trust substrate); it is a standalone reputation algorithm, not embedded in a communication protocol; there is no role layer. ASM extends TrustFlow's multi-dimensional intuition with (a) DID-linked identity, (b) per-hop reputation embedding in message routing, and (c) role-type priors that shape which reputation dimensions matter.

**AgentReputation (FSE 2026)** [arXiv:2605.00073] is a peer-reviewed decentralized reputation system for open multi-agent environments, combining on-chain anchoring with off-chain evaluation. As a peer-reviewed (FSE 2026) rather than preprint contribution, this provides citation-weight support for the SC pillar.

**NANDA / Agent Registry Survey** [Singh et al. 2025, arXiv:2508.03095] surveys four agent registry solutions (MCP, A2A, Microsoft Entra, NANDA). Key finding: NANDA achieves <1-second revocation via VC-Status lists versus minutes for MCP/A2A — empirical evidence that decentralized verifiable registries can match enterprise SLA requirements. NANDA's three-layer architecture (Lean Index Layer ≤120 bytes, AgentFacts Layer, Dynamic Resolution Layer) is the closest published design to ASM's N-pillar registration mechanism.

ASM differs from all of the above by combining (a) cryptographic verifiability, (b) ZK-based privacy, (c) explicit Sybil/collusion resistance, and (d) embedding reputation directly into protocol routing decisions rather than as a standalone scoring layer.

### 2.6 Requirement Coverage for Open Agent Socialization

We compare existing systems against the six requirements identified in our companion paper [Authors, 2026, Paper 1]. We note upfront that these systems are designed for **different primary purposes**; the comparison reflects coverage for our specific use case, not overall quality. We include both foundational standards (FIPA ACL, DIDComm) and the most directly competing recent protocols (ANP, OIDC-A):

| Requirement | FIPA ACL[^a] | MCP[^b] | ANP[^f] | OIDC-A[^g] | DIDComm[^c] | Nostr[^d] | TrustFlow[^h] | **ASM** |
|------------|----------|-----|-----|--------|---------|-------|-----------|---------|
| Role-bearing messaging | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ |
| Cryptographic identity | ❌ | ❌ | ✅[^f1] | ✅ | ✅ | ✅ | ❌ | ✅ |
| Verifiable human authorization | ❌ | ❌ | ⚠️[^f2] | ✅[^g1] | ⚠️[^c1] | ❌ | ❌ | ✅ |
| Privacy-preserving reputation | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ⚠️[^h1] | ✅ |
| Community-governed / permissionless | ❌ | ❌ | ⚠️[^f3] | ⚠️[^g2] | ⚠️[^c2] | ✅ | ✅ | ✅ |
| Multi-party coordination protocol | ✅ | ❌ | ✅[^f4] | ❌ | ❌ | ⚠️[^d2] | ❌ | ✅ |

[^a]: FIPA ACL: rich speech-act language; no cryptographic accountability or reputation.
[^b]: Anthropic MCP: tool/RPC invocation; no social coordination or reputation.
[^f]: ANP [Chang et al. 2025]: technically closest competitor. ✅[^f1]: did:wba cryptographic identity. ⚠️[^f2]: sensitive operations require human approval but authorization chain is not cryptographically verifiable. ⚠️[^f3]: open-source code but protocol governance driven by single corporate ecosystem (Ant Group); not community-governed in the Linux/Nostr sense. ✅[^f4]: three-layer architecture with meta-protocol negotiation.
[^g]: OIDC-A [Nagabhushanaradhya 2025]: authentication infrastructure extending OIDC. ✅[^g1]: delegation chain with mandatory scope reduction, Zero Trust verification. ⚠️[^g2]: requires OIDC provider; not fully permissionless. No reputation layer.
[^c]: DIDComm: bilateral DID messaging. ⚠️[^c1]: identity but not explicit human-agent authorization chain. ⚠️[^c2]: federation requires server coordination.
[^d]: Nostr: censorship-resistant social relay. ⚠️[^d2]: multi-party messaging but no formal coordination state machine.
[^h]: TrustFlow [Seliuchenko 2026]: topic-aware vector reputation. ⚠️[^h1]: no ZK privacy preservation; reputation scores are graph-visible. No identity anchoring or protocol embedding.

ASM is **designed to satisfy all six requirements simultaneously** — the "simultaneously" is the contribution; each individual requirement is addressed by at least one prior system, but no prior system addresses all six jointly.

---

## 3. The Dual-Network Model

### 3.1 Overview

ASM operates over a *dual-network model* with three layers:

```
+----------------------------------------+
|  Human Subnet A (off-chain + on-chain) |  ← Source of authority,
|  Humans authorize agents via VCs       |    intent, and social capital
+----------------------------------------+
                  |
                  | Authorization (signed VCs)
                  v
+----------------------------------------+
|  Social Memory Layer (on-chain)         |  ← Immutable record of:
|  Distributed ledger of agent history    |    authorization, interactions,
|  Merkle-aggregated collaboration events |    reputation credentials
+----------------------------------------+
                  ^
                  | History queries (ZK proofs)
                  |
+----------------------------------------+
|  Agent Subnet B (permissionless)       |  ← Where agents discover,
|  Agents discover, negotiate, execute   |    negotiate, collaborate
+----------------------------------------+
```

### 3.2 Why Three Layers, Not Two

A common design alternative is a flat two-layer model (humans + agents). The three-layer model is motivated by:

1. **Persistence**: Bilateral human-agent authorization disappears when either side goes offline; the social memory layer persists across sessions
2. **Composability**: Multi-party collaborations require aggregating histories from multiple parties; a shared layer enables this without bilateral negotiation
3. **Auditability**: Disputes require a shared record; bilateral records are vulnerable to evidence destruction

### 3.3 The Authorization Relationship

A human h ∈ H authorizes an agent a by issuing a Verifiable Credential VC_auth(h → a, scope, expiry, revocable=true). The VC is recorded on the social memory layer.

Key properties:
- **Revocable**: h can revoke VC_auth at any time
- **Scoped**: scope limits a's actions (e.g., max budget, topic categories)
- **Time-bounded**: expiry caps validity
- **Cryptographically accountable**: any action by a in agent subnet B can be traced to the authorizing VC

We refer to this as an "adoption" or "binding" relationship, analogous to a human guardianship.

### 3.4 Formal Definitions

We define participants and resources formally:

**Definition 1 (Human Authorizer)**:
h ∈ H is a tuple (did_h, pk_h, address_h), where did_h is a DID, pk_h is a public key for signing credentials, and address_h is an on-chain address for authorization recording.

**Definition 2 (Agent)**:
a ∈ A is a tuple (did_a, pk_a, NFT_a, VC_set), where did_a is an agent DID, pk_a is the agent's signing key, NFT_a is an EIP-8004-compliant identity NFT, and VC_set is the set of received credentials (authorization + reputation).

**Definition 3 (Authorization VC)**:
VC_auth(h → a) is a signed tuple (issuer=h, subject=a, scope, expiry, revocable, signature_h).

**Definition 4 (Reputation VC)**:
VC_rep(a₁ → a₂) is a signed tuple issued by agent a₁ about agent a₂'s collaboration performance: (issuer=a₁, subject=a₂, collaboration_id, rating, signature_{a₁}).

**Definition 5 (Social Memory Layer)**:
SML is a tuple (Ledger, Aggregator), where Ledger is a Byzantine-fault-tolerant append-only log (in our deployment: Ethereum/Optimism mainnet), and Aggregator is a Merkle-based interaction history compressor.

---

## 4. ASM Protocol Specification

### 4.1 Message Structure: Three Blocks

Every ASM message is a tuple m = (IA, CR, II):

**Block 1: Identity & Authorization Capsule (IA)**

The IA proves the sender is authorized without revealing the human authorizer:

```
IA = {
  agent_did: did_a,
  authorization_proof: ZK-proof(
    "I hold a valid VC_auth from some h ∈ H_trusted",
    revealed: nothing about h's identity
  ),
  capability_assertions: [
    ZK-proof("I possess capability X with rating ≥ R"),
    ...
  ]
}
```

**Block 2: Capability & Resource Manifesto (CR)**

The CR declares the agent's capacity for the proposed collaboration:

```
CR = {
  budget_commitment: Pedersen-commitment(budget_value),
  budget_proof: range-proof("budget ≥ minimum_required"),
  reputation_summary: ZK-proof(
    "I hold at least K credentials from distinct issuers
     with total weight ≥ T"
  ),
  intent_hash: hash(intent_statement)
}
```

**Block 3: Interaction Intent & Proof Payload (II)**

The II contains the action-specific payload:

```
II = {
  action: <PROPOSE | ACCEPT | REJECT | DELEGATE | CONFIRM | ABORT>,
  payload: action_specific_data,
  merkle_proof: history_proof_for_referenced_events,
  signature: sig_a(IA || CR || II)
}
```

### 4.2 Message Syntax (BNF)

```
<asm-message> ::= <ia-block> <cr-block> <ii-block>

<ia-block> ::= <agent-did> <auth-proof> <capability-proof-list>
<cr-block> ::= <budget-commit> <budget-range-proof>
              <reputation-proof> <intent-hash>
<ii-block> ::= <action-code> <payload> <merkle-proof> <signature>

<action-code> ::= PROPOSE | ACCEPT | REJECT | DELEGATE | CONFIRM | ABORT
<payload> ::= action-specific-CBOR-encoded-data
...
```

[TODO: Complete BNF for v1 final draft.]

### 4.3 Two-Phase Workflow

ASM uses a two-phase interaction protocol:

**Phase 1: Discovery (Relay-Mediated)**

```
1. Agent a publishes IA + CR (no II) to multiple relays
2. Other agents on relays match published IA+CR against their own intents
3. On match, recipient agent sends a "match notification" to a's inbox
4. a evaluates received matches and selects negotiation partners
```

Phase 1 is asynchronous, low-bandwidth, and analogous to "business card exchange."

**Phase 2: Negotiation (Direct WebRTC)**

```
1. Selected partners establish direct WebRTC/WebSocket connection
2. Exchange full ASM messages with II blocks
3. Negotiate terms via PROPOSE/ACCEPT/REJECT cycles
4. Lock terms via mutual signatures
5. Execute (potentially with multiple sub-DELEGATE actions)
6. CONFIRM completion; mutual reputation VC issuance
```

Phase 2 is synchronous, high-bandwidth, and analogous to "private meeting."

### 4.4 Finite State Machine

The protocol state machine for a two-party interaction:

```
States:
  S = {DISCOVERY, MATCHED, NEGOTIATING, AGREED, EXECUTING, CONFIRMED, ABORTED}

Initial state: DISCOVERY
Accepting states: {CONFIRMED, ABORTED}

Transitions (δ):
  DISCOVERY × match_received → MATCHED
  MATCHED × propose_sent → NEGOTIATING
  NEGOTIATING × accept_received → AGREED
  NEGOTIATING × reject_received → DISCOVERY  (try next match)
  NEGOTIATING × timeout → ABORTED
  AGREED × execute_start → EXECUTING
  EXECUTING × confirm_received → CONFIRMED
  EXECUTING × abort_signal → ABORTED
  Any × timeout_max → ABORTED
```

[TODO: Diagram in v1 final draft.]

---

## 5. Privacy-Preserving Reputation System

### 5.1 Design Goals

The reputation system must satisfy five properties:

- **G1 (Data minimization)**: Raw social data never leaves the user's device; only derived feature vectors circulate in the network
- **G2 (Computational privacy)**: Circulated vectors cannot be used to reconstruct the original social data (model inversion resistance)
- **G3 (Verifiability)**: Reputation claims are independently verifiable by third parties without revealing the underlying data
- **G4 (Sybil resistance)**: Agents cannot inflate reputation by controlling multiple identities or manufacturing synthetic collaboration history
- **G5 (Collusion resistance)**: Coordinated groups cannot artificially inflate each other's reputation beyond what honest interaction would yield

A sixth property informs our architecture selection:

- **G6 (Consumer hardware feasibility)**: The entire privacy stack must run on a standard personal computer (e.g., 64 GB Apple M1 Max class) without specialized cryptographic accelerators

G6 rules out ZK-SNARK proofs over raw credential sets as the *primary* privacy mechanism: generating a Groth16 proof over 128-dimensional vectors with a consumer-grade laptop takes approximately 2–10 seconds per query, which is infeasible for real-time routing decisions. We instead adopt Differential Privacy (DP) noise injection as the primary mechanism, with ZK proofs reserved as an optional extension for high-assurance scenarios (§5.5).

### 5.2 Architecture: LAAS + Federated Extraction

We introduce **LAAS (Local AI As Service)**: a lightweight AI model running entirely on the user's device that extracts multidimensional social capital feature vectors from local interaction data (email history, project contributions, professional endorsements, etc.).

```
Raw social data (private)
  → stays on device, never transmitted
  → LAAS local model extracts feature vector v ∈ ℝ^d
  → DP noise injected: ṽ = v + N(0, σ²I)
  → noisy vector ṽ circulates in the network
  → routing decisions made by vector proximity: ||ṽ_a - ṽ_threshold|| < δ
```

This architecture provides a fundamental privacy guarantee by construction: an attacker who intercepts ṽ faces a model inversion problem against DP-protected data, rather than inverting a deterministic function over clear credentials.

**Vector matching vs. credential checking.** Traditional reputation systems verify binary credentials ("does agent A hold credential X?"), which are trivially forgeable if the issuance process is compromised. ASM's vector matching asks "is agent A's social capital profile sufficiently close to the target profile for this task?" To fake this, an attacker must construct a synthetic social history that produces the correct feature vector — a preimage attack against the LAAS model, whose difficulty scales with the model's depth and the dimensionality d.

**Dimension registry.** Feature vector dimensions correspond to social capital categories (e.g., professional domain, collaboration frequency, network diversity). The base dimension schema is defined by community consensus as a public protocol; individual participants may add private extension dimensions or omit non-mandatory dimensions. Different collaboration protocols may require different mandatory dimension subsets (e.g., a job-referral protocol requires different SC dimensions than an academic co-authorship protocol). This mirrors how different social contexts demand different social capital signals [Putnam 2000; Bourdieu 1986].

### 5.3 Differential Privacy: Primary Privacy Mechanism

We apply Local Differential Privacy (LDP) to vectors before transmission.

**Mechanism**: For each transmitted vector ṽ = v + N(0, σ²I), the Gaussian mechanism achieves (ε, δ)-DP for:

```
σ = √(2 ln(1.25/δ)) · Δ₂f / ε
```

where Δ₂f is the ℓ₂-sensitivity of the feature extraction function. Practical parameters: ε = 1.0, δ = 10⁻⁵ yields noise levels compatible with routing fidelity at d ≥ 64 dimensions.

**Privacy budget management.** Each vector transmission consumes a portion of the user's daily privacy budget ε_total. ASM clients enforce a per-day limit of K transmissions, each consuming ε_total / K. When the budget is exhausted, the client either pauses transmissions (conservative) or prompts the user to authorize budget renewal. The Rényi Composition Theorem bounds cumulative disclosure across K transmissions. Practically, setting K = 20 queries/day with ε = 0.05 per query yields ε_total = 1.0, well within the range for which DP provides meaningful protection [Dwork & Roth 2014].

**Verification without disclosure.** A counterparty verifying that ṽ_a is within δ of a target profile v_threshold computes ||ṽ_a - v_threshold|| < δ + noise_bound. The noise bound is publicly known from the DP parameters; the LAAS client publishes a commitment C(σ) proving the declared noise level was used. This allows verification without revealing v itself.

### 5.4 Per-Collaboration Credentials and Aggregation

Upon CONFIRMED state (§4 FSM), each party issues a **VC_rep** to the counterparty:

```json
{
  "type": "ReputationCredential",
  "domain": "academic_research",
  "rating": 4,
  "collaboration_id": "<on-chain event hash>",
  "issuer_did": "did:key:...",
  "issuer_sig": "<signature>"
}
```

These VCs feed back into the local LAAS model as new training signal, updating the feature vector over time without requiring re-extraction from scratch. The LAAS model thus implements **federated reputation learning**: each agent's local model improves from its own interaction history; only the noisy vector (not the VCs themselves) is shared with the network.

**Aggregation for routing.** Relays maintain a coarse routing table indexed by DP-protected vectors. When agent A seeks collaboration partners matching a capability profile, the relay performs approximate nearest-neighbor search in vector space, returning candidate agents whose ṽ is within distance δ of the query vector.

**Self-issuance prevention.** VC_rep issuance requires the counterparty's DID to differ from the subject's DID. Self-issued credentials are syntactically invalid and rejected by all relays.

### 5.5 Sybil and Collusion Resistance

**Sybil attack**. An attacker controlling N agents attempts to build mutual collaboration history to inflate reputation.

*Defense (protocol)*: VC_rep requires the issuer's authorization VC to be valid — ultimately backed by a verified human principal. Acquiring K distinct human authorizers raises the attack cost to "recruiting K willing humans."

*Defense (economic)*: ASM network entry requires a protocol ticket (nominal fee, 10–30 CNY equivalent), limiting the economical Sybil scale. Each ticket is KYC-linked for sensitive operations, anchoring identity to a legal entity.

*Defense (behavioral)*: Fabricated reputation eventually requires real-world redemption (e.g., a referral that leads to a hire, a partnership that produces revenue). Synthetic social histories that do not lead to real-world interaction outcomes decay in value, as the LAAS model downweights unverified interaction chains.

**Collusion ring**. K agents mutually issue high ratings to inflate each other's domain reputation.

*Defense*: Diversity weighting — credentials from agents within tightly clustered interaction subgraphs are downweighted proportional to the graph's clustering coefficient. TrustFlow [Seliuchenko 2026] demonstrates ≤4 percentage-point adversarial impact from collusion attacks using similar graph-topology defenses.

*Defense*: Domain non-transferability — inflated reputation in one domain (e.g., "synthetic code review") does not transfer to unrelated domains; attackers must run separate rings per target domain.

**Residual risk**: A well-funded attacker willing to recruit real humans for fake collaborations can partially circumvent protocol defenses. We treat this as a social engineering attack, addressed by governance mechanisms (community flagging, on-chain penalty records) rather than purely cryptographic ones. This mirrors the threat model for real-world reputation systems: eBay shill bidding is economically bounded by detection risk and penalty, not by cryptographic impossibility [Resnick et al. 2000].

### 5.6 Optional Extension: ZK Proofs for High-Assurance Scenarios

For applications where quantitative privacy guarantees beyond DP are required (e.g., regulated financial contexts), ASM supports an optional ZK extension:

```
Statement: "My vector v satisfies ||v - v_threshold|| < δ"
Proof system: Bulletproofs [Bünz et al. 2018] or Halo2
Proof size: O(log d) for d-dimensional vectors
Verification: < 0.1 seconds
Generation: ~2–10 seconds on M1 Mac (128 dimensions)
```

This extension is not required for base ASM compliance. Relays advertise whether they accept DP-only or require ZK attestation. High-trust relay tiers (e.g., regulated industry networks) may mandate ZK; open public relays accept DP-only.

**ZK for citizenship verification.** A separate ZK application: proving legal citizenship status (for KYC purposes) without revealing name, birthdate, or address. This is orthogonal to the reputation system and uses standard government-credential ZK schemes [TODO: cite W3C Digital Credentials API].

### 5.7 LAAS Device Specifications and DP Parameter Recommendations

| Parameter | Specification |
|-----------|--------------|
| Target hardware | PC-class device, ≥16 GB RAM (64 GB recommended for M1 Max) |
| LAAS model size | < 2 GB; runs fully local (no cloud API calls) |
| Vector dimensionality d | 64–256 (protocol-negotiated per collaboration domain) |
| DP noise σ | Calibrated to (ε=1.0, δ=10⁻⁵); adjustable via client settings |
| Daily transmission budget | K = 20 queries/day (default); user-configurable |
| TEE support (optional) | Community-operated NXP i.MX93/95 devices (ARM TrustZone) for high-assurance relay nodes |

Community members may pool resources to operate TEE-enabled relay nodes (e.g., NXP i.MX93/95 hardware with ARM TrustZone) that provide hardware attestation of LAAS model integrity. Participation in TEE-attested relay tiers is voluntary; the protocol remains functional without TEE hardware.

---

## 6. Security Analysis

### 6.1 Adversary Model

We consider eight adversary types, each with explicit capability and goal:

| Adversary | Capability | Goal |
|-----------|-----------|------|
| A1: Malicious agent | Send forged or contractually invalid messages | Profit from defection |
| A2: Colluding ring | K agents coordinate to inflate mutual reputation | Capture market share |
| A3: Malicious relay | Censor or forge index entries | Block specific agents or amplify others |
| A4: Stolen key | Use compromised agent or human keys | Impersonate legitimate party |
| A5: Malicious human | Authorize agent for harmful actions | Externalize liability |
| A6: Passive observer | Monitor all network traffic | Deanonymize human-agent links |
| A7: Spam attacker | Flood relays with junk | Deny service |
| A8: Resource-rich entity | Accumulate reputation via paid recruitment | Long-term oligopoly |

### 6.2 Safety Properties

**S1 (Message authenticity)**: Forged messages are computationally infeasible
- *Defense*: Standard digital signatures over IA||CR||II
- *Status*: Standard assumption; reduces to signature scheme security
- *Adversaries addressed*: A1

**S2 (Authorization integrity)**: Agents cannot exceed authorized scope without detection
- *Defense*: VC_auth scope is on-chain; violations are externally verifiable
- *Status*: Detection guaranteed; *prevention* requires off-chain enforcement
- *Adversaries addressed*: A1, A5

**S3 (Reputation unforgeability)**: Reputation cannot be forged
- *Defense*: Accumulator-based construction requires real signatures from real issuers (§5)
- *Status*: Reduces to BBS+ signature security and accumulator soundness
- *Adversaries addressed*: A1, A2

**S4 (History immutability)**: Past collaboration records cannot be altered
- *Defense*: Merkle root on social memory layer (on-chain)
- *Status*: Reduces to underlying blockchain's finality assumptions
- *Adversaries addressed*: A1

**S5 (Privacy)**: Passive observers cannot deanonymize human authorizers
- *Defense*: ZK-SNARK in IA block hides specific authorizer
- *Status*: Reduces to ZK-SNARK zero-knowledge property
- *Adversaries addressed*: A6

### 6.3 Liveness Properties

**L1 (Eventual termination)**: Honest agents do not wait indefinitely

For each protocol state, we specify a timeout:
- DISCOVERY: t_d = 60s (publish-listen cycle)
- MATCHED → NEGOTIATING: t_n = 30s (must propose within)
- NEGOTIATING: t_neg = 300s (negotiation must conclude)
- EXECUTING: t_exec = task-specific, declared in proposal
- Any state: t_max = 3600s (absolute upper bound)

On timeout, state transitions to ABORTED.

**L2 (Relay failure recovery)**: Single-relay failure does not block discovery
- *Defense*: Agents publish to multiple (≥3) relays; matching is OR-based
- *Adversaries addressed*: A3

**L3 (Network partition tolerance)**: In partial synchrony, honest agents complete or abort
- *Defense*: All states have timeouts; partition-induced timeouts → ABORTED
- *Status*: Standard partial-synchrony model

**L4 (DoS recovery)**: Spam does not block legitimate traffic
- *Defense*: Relay-level rate limiting + posting deposit (PoW or stake)
- *Adversaries addressed*: A7

[TODO: Detailed defense for A8 (resource-rich oligopoly) — likely requires economic analysis beyond protocol layer.]

### 6.4 Attack-Defense Matrix Summary

| Adversary | Primary Defense | Residual Risk |
|-----------|----------------|---------------|
| A1: Malicious agent | Signatures + on-chain authority chain | Off-chain enforcement gap |
| A2: Collusion ring | Diversity weighting + time decay | Sophisticated long-term gaming |
| A3: Malicious relay | Multi-relay redundancy | Coordinated global censorship |
| A4: Stolen key | Key rotation + revocation | Pre-revocation losses |
| A5: Malicious human | On-chain accountability | Legal/criminal responsibility |
| A6: Passive observer | ZK proofs | ZK system assumptions |
| A7: Spam | Posting deposit + rate limiting | Economic attacker with capital |
| A8: Resource-rich | Time decay + diversity | Long-term oligopoly tendency |

---

## 7. Real-World Deployment: Mycelium Protocol on OP Mainnet

### 7.1 Disclosure

**The authors are core contributors to the Mycelium Protocol open-source project** (github.com/MushroomDAO/launch). The implementation discussed in this section is the authors' work. All claims are verifiable via:

- Source code: github.com/MushroomDAO/launch
- Smart contract verifications: Etherscan/Optimism Etherscan
- Documentation: docs.mushroom.cv

This section follows the *transparent implementation case study* convention common in systems papers (e.g., Wireguard's deployment notes, Signal Protocol's WhatsApp integration). Readers should weigh empirical claims accordingly.

### 7.2 Deployment Stack

| Component | Mycelium Protocol Implementation |
|-----------|--------------------------------|
| Social Memory Layer | Sepolia testnet smart contracts (production-tested); planned OP mainnet |
| Agent NFT identity | EIP-8004 (in development) → falls back to ERC-721 in production |
| Authorization VCs | On-chain Registry.sol contract |
| Reputation accumulator | aPNTs (Aggregated Personal Network Tokens) |
| Privacy mechanism (primary) | DP noise injection (Gaussian, ε=1.0) on LAAS feature vectors |
| Privacy mechanism (optional) | ZK proofs (Bulletproofs / Halo2) for regulated relay tiers |
| Settlement | GToken (ERC-20) + ERC-4337 paymaster |
| Discovery layer | Nostr relays (multi-relay deployment) |
| Negotiation layer | libp2p over WebRTC |

### 7.3 Current Deployment Status

As of May 2026:
- Smart contracts deployed on Sepolia testnet (full feature set)
- SaleContractV2: production-ready (20 E2E tests pass on Sepolia)
- Gasless flow (EIP-3009 + BuyHelper): production-ready
- Mainnet deployment: scheduled per [docs/mainnet-launch/MAINNET-DEPLOY.md]

### 7.4 Preliminary Observations

[TODO: Once deployment is live, fill in observed metrics: discovery latency, negotiation success rate, ZK proof generation time on browser, etc.]

We commit to releasing deployment metrics quarterly via the open-source repository.

### 7.5 What This Case Study Demonstrates

The Mycelium deployment demonstrates:
1. **Operationalizability**: ASM is buildable using current technology
2. **Composability**: ASM integrates with existing Web3 infrastructure (Ethereum, AA, paymaster)
3. **Real-world threat exposure**: Public mainnet deployment exposes the protocol to actual adversaries

It does **not** demonstrate:
1. **Optimality**: We do not claim this is the best implementation of ASM
2. **Scale validation at N=10⁶ agents**: Current scale is small; large-scale validation is future work

---

## 8. Discussion

### 8.1 Limitations

1. **Formal cryptographic proofs deferred**: Section 6's analysis uses adversary-model reasoning, not theorem-proof style. Formal proofs require cryptography-domain collaboration; we explicitly mark this as future work
2. **LAAS model not yet trained**: §5.2 specifies the LAAS architecture; producing a production-quality feature extraction model requires empirical work on social data corpuses beyond this paper's scope
3. **DP parameter calibration**: Optimal ε values for the privacy-utility tradeoff in social capital vectors are scenario-dependent; we provide default parameters (ε=1.0, δ=10⁻⁵) pending empirical study
4. **Performance at scale**: Initial deployment is small-scale; scale to 10⁵+ agents is unvalidated
5. **Adversary completeness**: 8-adversary model is comprehensive but not exhaustive; novel attacks may emerge

### 8.2 Open Problems

1. **LAAS model architecture**: What model family (embedding model, graph neural network, or federated representation learner) produces the most discrimination-invariant social capital vectors?
2. **DP budget management UX**: How should clients communicate privacy budget consumption to non-expert users? Daily-reset-K approach is operationally simple but may be insufficient for high-frequency users
3. **Domain-specific reputation aggregation**: How should reputation in one domain influence other domains? Full transfer, no transfer, weighted transfer? (Deferred from v1; §5.4 uses domain non-transferability as a safe default)
4. **Cross-protocol identity portability**: How can an agent's reputation accumulated under ASM be ported to other protocols (and vice versa)?
5. **Economic incentive analysis**: Game-theoretic analysis of relay operator incentives, agent posting deposit calibration

### 8.3 Future Work

- LAAS model training: supervised learning on opt-in interaction datasets (2026 Q3)
- Formal DP composition proofs for the multi-query setting (2026 Q4)
- Large-scale deployment study (target: 10⁴ agents, 2027 Q2)
- Cross-implementation compatibility tests with FIPA ACL, DIDComm bridges
- Empirical validation of P1-P5 propositions from companion Paper 1

---

## 9. Conclusion

This paper presents ASM, a native communication protocol for open, permissionless AI agent collaboration. ASM addresses three structural gaps in existing protocols: lack of cryptographic accountability for human authorization, absence of privacy-preserving reputation, and inadequate threat coverage for open agent ecosystems.

Our contributions are:

1. A dual-network model formalizing human authorization of agent operations
2. The ASM message specification with three-block structure, BNF syntax, and finite state machine
3. A privacy-preserving reputation system combining LAAS on-device extraction and Differential Privacy, with Sybil and collusion resistance via protocol economics and graph-diversity weighting
4. A comprehensive security analysis with eight-adversary coverage
5. A real-world deployment case study (Mycelium Protocol) with full disclosure

We position ASM as the protocol-layer instantiation of the Three-Pillar Framework articulated in our companion paper. The combination of the two papers provides both the *theoretical structure* (Paper 1) and the *protocol specification* (Paper 2) for a new class of socially-embedded AI agent systems.

We invite the research community to engage with this work: reproduce the implementation, attack the protocol, extend the framework. The open-source repository is available at github.com/MushroomDAO/launch.

---

## References

[TODO: Reorganize for final draft. ~40-50 entries.]

**Core works cited**:

1. Allen, C. (2016). The Path to Self-Sovereign Identity. *Life with Alacrity*.
2. Anthropic (2024). Model Context Protocol Specification. [TODO: cite]
3. Authors (2026). Three Pillars for AI Agent Socialization (Companion Paper 1).
4. Benaloh, J., & de Mare, M. (1993). One-Way Accumulators. *EUROCRYPT*.
5. Boneh, D., Boyen, X., & Shacham, H. (2018). Short Group Signatures with Cryptographic Accumulators. [TODO: verify]
6. Camenisch, J., & Lysyanskaya, A. (2002). Dynamic Accumulators and Application to Efficient Revocation of Anonymous Credentials. *CRYPTO*.
7. Ethereum Improvement Proposals (2024). EIP-8004: Trustless Agent Identity. [TODO: verify EIP number]
8. Finin, T. et al. (1994). KQML as an Agent Communication Language. *CIKM*.
9. FIPA (2002). FIPA ACL Message Structure Specification.
10. Groth, J. (2016). On the Size of Pairing-Based Non-interactive Arguments. *EUROCRYPT*.
11. Hong, S. et al. (2023). MetaGPT. arXiv:2308.00352.
12. Kamvar, S. et al. (2003). The EigenTrust Algorithm. *WWW*.
13. Nostr NIPs (2023). Notes and Implementation Possibilities. github.com/nostr-protocol/nips.
14. Park, J.S. et al. (2023). Generative Agents. *UIST 2023*.
15. Resnick, P. et al. (2000). Reputation Systems. *Communications of the ACM*.
16. Sporny, M. et al. (2022). Decentralized Identifiers (DIDs) v1.0. W3C Recommendation.
17. Sporny, M. et al. (2022). Verifiable Credentials Data Model v1.1. W3C Recommendation.
18. Wu, Q. et al. (2023). AutoGen. arXiv:2308.08155.
19. Yao, S. et al. (2022). ReAct. arXiv:2210.03629.

---

*End of Paper 2 Initial Draft v0. ~6,500 words. Substantive content in all sections; expansion items marked [TODO]. Awaiting Codex review after Paper 1 review completes.*
