# Towards Adaptive, Scalable, and Robust Coordination of LLM Agents: A Dynamic Ad-Hoc Networking Perspective
**arXiv**: 2602.08009 | **Year**: 2026 | **Authors**: Rui Li, Zeyu Zhang, Xiaohe Bo, Quanyu Dai, Chaozhuo Li, Feng Wen, Xu Chen | **Venue**: ICML 2026

## Core Claim
RAPS reframes LLM agent coordination as a dynamic ad-hoc networking problem, using a decentralized publish-subscribe protocol with intent-based routing and Bayesian reputation evaluation — achieving 90.0% average accuracy across five benchmarks and maintaining 83.0% under 2:3 adversarial agent ratio.

## Key Evidence / Numbers
- MMLU: **88.2%** (vs 86.3% best baseline, +1.9%)
- GSM8K: **95.4%** (vs 94.1%, +1.3%)
- HumanEval: **91.5%** (vs 91.0%, +0.5%)
- Average: **90.0%** vs 88.0% best baseline (+2.0%)
- Robustness: **83.0%** accuracy at 2:3 truthful/adversarial ratio (baselines: 19.6%–49.7%)
- Scalability: stable with growing agent populations; no training overhead (competitors: 2+ hrs for 20 agents)
- Bayesian reputation: Beta-Bernoulli model, first-hand + witness ratings with deviation test
- Pub-sub: Publishers → Brokers (content-based routing) → Subscribers (intent declarers)

## ASM Comparison (Paper 2 focus)
- **What it does**: Decentralized pub-sub coordination with intent-based routing and Bayesian peer reputation — the closest networking-layer analogy to ASM's N+S pillars
- **Gap vs ASM**: (1) No persistent identity — agents participate without DID anchoring, so reputation is session-scoped; (2) No role-bearing — the pub-sub routing is based on semantic intent not assigned roles; (3) No verifiable credentials — trust is computed locally by each agent's watchdog, not verifiable by third parties; (4) Permissionless in practice but not by design
- **Paper 2 §4 use**: Cite RAPS as the best networking-layer precedent for intent-based routing; differentiate ASM's addition of persistent identity (DID) and verifiable role credentials that enable cross-session trust accumulation

## Paper 1 Relevance
- **§4.1 (N pillar — network)**: RAPS's pub-sub with intent-based routing is a strong empirical example of the N pillar in action; cite as evidence for decentralized coordination effectiveness
- **§4.3 (S pillar)**: Bayesian reputation with adversarial robustness is key evidence for reputation mechanisms in open networks

## Verdict
⭐⭐⭐⭐⭐ | High priority — ICML paper with strongest empirical results for dynamic agent coordination; cite in both papers. P1 §4.1/4.3, P2 §4. The key differentiator for ASM is identity-anchored reputation vs RAPS's anonymous Bayesian scoring.

---
*Jason's feedback*: [待填]
