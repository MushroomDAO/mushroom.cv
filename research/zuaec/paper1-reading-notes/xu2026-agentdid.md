# AgentDID: Trustless Identity Authentication for AI Agents
**arXiv**: 2604.25189 | **Year**: 2025 | **Authors**: Minghui Xu, Xiaoyu Liu, Yihao Guo, Chunchi Liu, Yue Zhang, Xiuzhen Cheng | **Venue**: arXiv preprint

## Core Claim
AgentDID is the first dynamic state verification framework for AI agents in decentralized environments — combining static DID/VC identity with runtime challenge-response probes (readiness, context consistency) to authenticate agents not just by who they are but whether they are currently operational and in the expected state.

## Key Evidence / Numbers
- Scalability: **3.25 TPS** at 50v50 concurrent agent pairs
- End-to-end latency: **~13.5 seconds**
- DID registration time: **15.37 seconds** on Ethereum Sepolia
- Cost: **<$1 USD** per DID registration
- Storage overhead: **1.23 KB** average per VC
- Context hashing: linear scaling, millisecond-level even at 40MB contexts
- Three VC credential types: provenance credentials, capability credentials, compliance credentials
- Runtime checks: readiness probes (standardized tasks) + context consistency (hash-based state verification)

## ASM Comparison (Paper 2 focus)
- **What it does**: Extends static DID/VC with dynamic runtime verification — agents prove they are currently available and in the right state, not just that they were issued a credential at some point
- **Gap vs ASM**: (1) No role encoding in the VC schema — three credential types (provenance/capability/compliance) do not include role type; (2) 13.5-second latency and 3.25 TPS are too slow for real-time agentic workflows — ASM likely needs sub-second authentication; (3) No reputation mechanism; (4) The dynamic verification is per-session (readiness at interaction time), not cumulative (reputation over time)
- **Paper 2 §3 use**: Cite as the closest existing work on dynamic agent identity verification; differentiate ASM on: (a) role encoding in credential schema, (b) need for faster verification (<1s for routing decisions), (c) reputation accumulation across interactions rather than just session-time readiness

## Paper 1 Relevance
- **§4.2 (P pillar)**: AgentDID's three-credential-type schema (provenance, capability, compliance) is a useful reference for what agent credentials should include; the P pillar should note that role is a fourth credential type that enables social agency

## Verdict
⭐⭐⭐⭐ | Good P2 §3 citation for dynamic identity verification — the runtime challenge-response idea is novel and directly relevant. Differentiate on latency (13.5s is slow), role encoding, and reputation. Also cite in Paper 1 §4.2.

---
*Jason's feedback*: [待填]
