# [Liu et al. 2025] DIAP: A Decentralized Agent Identity Protocol with Zero-Knowledge Proofs and a Hybrid P2P Stack
**Citation**: Yuanjie Liu, Wenpeng Xing, Ye Zhou, Gaowei Chang, Changting Lin, Meng Han. "DIAP: A Decentralized Agent Identity Protocol with Zero-Knowledge Proofs and a Hybrid P2P Stack." arXiv:2511.11619v1 [cs.DC], 6 Nov 2025. Preprint, under review. Code: github.com/logos-42/DIAP_Rust_SDK
**机构**: Binjiang Institute of Zhejiang University; Zhejiang University; GenTel.io; ANP Open Source Community
**arXiv**: https://arxiv.org/abs/2511.11619
**PDF**: papers/diap2025-agent-identity.pdf
**Cluster**: Paper 2 §3 (identity / DID) + §5 (ZK) — DIRECT competitor/reference
**Status**: ✅ 全文已分析（2026-05-22）
**Note on title**: Abstract/conclusion inconsistently expand the acronym ("Decentralized Interstellar Agent Protocol" vs "Decentralized Intelligent Agent Protocol"); the paper title and standard form is "Decentralized Agent Identity Protocol." Note for ZUAEC relevance: authored at Zhejiang University / Binjiang Institute.

## Core claim (一句话)
DIAP gives autonomous agents a fully decentralized, persistent, privacy-preserving identity by binding identity to an **immutable IPFS CID** and using **Noir Zero-Knowledge Proofs** for *stateless, instantaneous proof of ownership* ("ZKP-on-CID"), delivered as a production-ready, "zero-dependency" Rust SDK over a hybrid Libp2p+Iroh P2P stack.

## 研究问题
Existing agent-communication protocols (A2A, ACP) either rely on centralized identity providers (single point of failure, anti-decentralization) or fail to integrate decentralized identity resolution, losing persistence/cross-network resolvability. Mutable pointers (IPNS) solve key-rotation/revocation clumsily and are slow. How to achieve persistent + verifiable + privacy-preserving + trustless agent identity and communication with no centralized intermediary and low developer friction?

## 方法与主要内容
- **Core premise**: "Identity should be immutable; proof of ownership should be dynamic and stateless." Identity = the IPFS CID (cryptographic hash) of the agent's `DIDDocument`.
- **Layered architecture**: (1) Identity & Verification Layer, (2) Communication & Privacy Layer, (3) Network Transport Layer.
- **Identity registration (ZKP-on-CID)**: generate ed25519 keypair → derive W3C `did:key` → build `DIDDocument` (pubkey, controller, P2P info) → publish to IPFS → get immutable CID → optionally bind CID to an IPNS record for a stable human-readable gateway while internally rotating keys.
- **Noir ZKP circuit** (`main.nr`): agent proves a composite statement *without revealing private key* — (1) hash(DID_doc) == public CID_hash; (2) sk derives the public key hash in doc; (3) knows a secret nonce hashing to a Verifier-supplied `nonce_hash` (challenge → replay protection). NOTE: the published circuit uses toy arithmetic constraints (e.g. `sk[0]*sk[1]+sk[0]+sk[1]` as "key derivation"), not real ed25519/hash gadgets — this is a prototype, not a sound cryptographic implementation.
- **Privacy-preserving P2P endpoints**: PeerId is *self-encrypted* — AES-256 key derived from the agent's own ed25519 private key + static salt; ciphertext+nonce+signature stored as `serviceEndpoint`. Public verifiers can validate the signature (tamper-evidence) but only the holder can decrypt its own PeerId → "verifiable yet undiscoverable", blocking topology crawling / DDoS reconnaissance.
- **Hybrid P2P stack**: Libp2p GossipSub for authenticated N-to-N service discovery (every message is an `AuthenticatedMessage`: from_did, did_cid, nonce, zkp_proof, signature; receiver runs nonce→ZKP→signature checks) + Iroh (QUIC) for high-performance 1-to-1 direct data exchange after identity is established.
- **Zero-dependency ZKP SDK**: `UniversalNoirManager` + `build.rs` pre-compiles and embeds the Noir circuit so end-users need no external ZKP toolchain.
- **Evaluation**: example-suite/integration tests only (`complete_auth_demo`, `pubsub_verification_loop_demo`, `iroh_complete_closed_loop`, `cross_platform_demo`) — demonstrates mutual ZKP authentication between "Alice"/"Bob", authenticated pubsub, direct Iroh streams. No quantitative benchmarks; security proofs explicitly left to future work.

## 与我们框架的关系（差异化 + 可借用）
| Dimension | DIAP | 我们 (ASM / Paper 2) |
|---|---|---|
| What is bound | Agent **identity** ↔ immutable IPFS CID of DIDDocument | **Role + human-authorization** bound to credential, not just identity |
| ZK usage | Proof of *key ownership* (stateless auth, replay-safe) | ZK *privacy-preserving reputation over accumulators* — proving reputation/role state, not just key control |
| Reputation | **None** — no reputation/social-capital accumulation at all | Reputation accumulation is core (links to SC pillar) |
| Collaboration semantics | Transport/auth only (discovery + direct channel); no task model | **Role-specific collaboration state machines** governing multi-party coordination |
| Identity model | did:key + IPFS CID + IPNS; persistence via content-addressing | Role-bearing agency, not capability container |
| Authorization | Self-sovereign key possession only | **Human authorization** delegated/bound cryptographically to the agent role |
| Crypto soundness | Prototype Noir circuit (toy constraints), no formal security proofs | Requires sound accumulator + ZK construction |
| Maturity | Working Rust SDK, example tests, no benchmarks | (positioning) |

**可借用**: (1) DIAP is a strong, *recent, Zhejiang-University-authored* reference point for Paper 2 §3 (decentralized identity) and §5 (ZK) — directly establishes the A2A/ACP-vs-decentralized gap we also address. (2) The "immutable identity / stateless dynamic proof" separation and the self-encrypted PeerId (verifiable-yet-undiscoverable) are useful design patterns worth citing or contrasting. (3) The `AuthenticatedMessage` envelope (nonce+ZKP+signature on a gossip layer) is a concrete precedent for our protocol's message authentication. (4) Their hybrid Libp2p-discovery + Iroh-direct split is a useful transport-layer reference.

## 区分/引用段落（~190词，英文）
Liu et al. (2025) propose DIAP, a decentralized agent identity protocol that binds an agent's identity to the immutable IPFS CID of its DID document and uses Noir zero-knowledge proofs for stateless, replay-resistant proof of key ownership, packaged as a zero-dependency Rust SDK over a hybrid Libp2p/Iroh P2P stack with self-encrypted network endpoints. DIAP convincingly addresses *who an agent is* and *that it controls its keys* without centralized intermediaries, making it the closest prior work to ASM's identity layer (§3). It is, however, strictly an **identity-and-transport** protocol: it carries no notion of *reputation* or *social capital*, no *human-authorization* binding, and no *collaboration semantics* — its ZK proofs attest only to key control, not to accumulated reputation or role state, and its prototype Noir circuit uses placeholder arithmetic constraints with no formal security proofs. ASM extends this foundation along three axes DIAP does not address: (i) cryptographic binding of *role and delegated human authorization* (not merely self-sovereign key possession); (ii) ZK *privacy-preserving reputation over accumulators*, making accumulated social capital portable and verifiable; and (iii) *role-specific collaboration state machines* that govern permissionless multi-party coordination beyond point-to-point discovery and data exchange.

## Action items
- [ ] Cite in Paper 2 §3 (decentralized identity) as the closest prior identity protocol; contrast did:key+CID+IPNS vs ASM role-binding.
- [ ] Cite in Paper 2 §5 (ZK) — DIAP proves key ownership; ASM proves reputation/role state over accumulators.
- [ ] Cite in Paper 2 related work / threat model — adopt the A2A/ACP centralization-gap framing; flag DIAP's prototype circuit + missing security proofs as the verifiability gap ASM closes.
- [ ] Reference the self-encrypted PeerId pattern when discussing privacy at the network layer.
- [ ] Note ZUAEC angle: same-institution (Zhejiang University) recent work — useful for positioning/competitive awareness.

## Jason's feedback
> （请在此处写入你的feedback）
