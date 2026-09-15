# Agent Name Service (ANS): A Proof-of-Concept Trust Layer for Secure AI Agent Discovery, Identity, and Governance in Kubernetes
**arXiv**: 2604.26997 | **Year**: 2025 | **Authors**: Mittal & De La Cruz | **Venue**: arXiv preprint (journal submission in progress)

## Core Claim
ANS provides a DNS-analogous naming and discovery system for AI agents built on DID + VC + OPA, demonstrating in a Kubernetes PoC that the four gaps in current deployments — uniform discovery, cryptographic authentication, capability proofs, and policy enforcement — can be closed with sub-15ms latency at 1000+ registrations/minute.

## Key Evidence / Numbers
- Agent discovery latency: **12ms mean**
- Capability verification latency: **78ms mean**
- Registration throughput: **1,000+ agents/minute**
- Deployment: 3-node cluster, 50 concurrent agents, 100% scripted scenario success
- Traditional deployment: 2–3 days → ANS: 30 minutes
- ZKP for capability attestation (prove capability without exposing secrets)
- OPA (Open Policy Agent) for declarative policy enforcement

## ASM Comparison (Paper 2 focus)
- **What it does**: DNS-like naming + DID/VC identity + ZKP capability attestation + OPA policy — the most complete discovery+identity layer found in this batch
- **Gap vs ASM**: Kubernetes-native (infrastructure-layer, not application-layer); focuses on discovery and authentication but no role encoding in the naming scheme; no reputation scoring — an agent discovered via ANS has capability proof but no trust history. Also infrastructure-oriented (CRDs, admission controllers) not message-protocol-oriented
- **Paper 2 §4 use**: Cite as the closest "infrastructure-level" precursor to ASM's N pillar (network discovery + identity). ASM's innovation is embedding role and reputation into the message routing layer rather than the infrastructure layer

## Paper 1 Relevance
- **§4.1 (N pillar — network)**: ANS shows a clean separation of naming/discovery from execution — the N pillar design in Paper 1 should note this decomposition
- **§4.2 (P pillar)**: ZKP capability attestation without secret exposure is a useful primitive to reference

## Verdict
⭐⭐⭐⭐ | Include as P2 citation — key precursor to ASM's identity+discovery design; differentiate on role layer and reputation. Also cite in Paper 1 §4 as N+P pillar evidence.

---
*Jason's feedback*: [待填]
