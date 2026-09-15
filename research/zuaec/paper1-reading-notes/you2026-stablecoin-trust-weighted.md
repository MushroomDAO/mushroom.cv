# Stablecoin Design with Adversarial-Robust Multi-Agent Systems via Trust-Weighted Signal Aggregation
**arXiv**: 2601.22168 | **Year**: 2026 | **Authors**: Shengwei You, Aditya Joshi, Andrey Kuehlkamp, Jarek Nabrzyski (University of Notre Dame) | **Venue**: arXiv preprint

## Core Claim
Multi-agent simulations of stablecoin reserve management can be made adversarially robust by scoring agents on behavioral consistency (sentiment alignment, profit rationality, coordination suspicion, destabilization signals) and using trust-weighted aggregation of their signals — without requiring persistent identities, achieving 72% adversarial detection and 57% reduction in attack success.

## Key Evidence / Numbers
- Peak peg deviation: **3.2%** (MVF-Composer) vs 7.4% (SAS baseline) — **57% reduction**
- Recovery time: **14 steps** vs 44 steps — **3.1× faster**
- Bad debt events: **2.1** vs 5.4 — 61% reduction
- Liquidity retention: **92.9%** vs 84.8% (+8.1pp)
- Adversarial detection: **72%** without persistent identities
- Trust score formula: logistic function over 4 behavioral features (sentiment alignment, profit rationality, coordination suspicion, destabilization correlation)
- Risk-weighted aggregation with stress-augmented covariance blending using quadratic blend α(r)=r²

## ASM Comparison (Paper 2 focus)
- **What it does**: Behavior-based trust scoring without persistent identities — agents are evaluated by what they do, not who they are, enabling anonymous participation with adversarial filtering
- **Gap vs ASM**: (1) No DID-linked identity — trust is purely behavioral, so reputation cannot persist across sessions or be ported to other networks; (2) Domain-specific (financial signals) — the 4 behavioral features are stablecoin-specific, not generalizable to arbitrary agent tasks; (3) No role encoding; (4) The "no persistent identity" choice is explicit but limits the trust accumulation ASM enables
- **Paper 2 §5 use**: Cite as evidence that behavior-based trust scoring works in adversarial multi-agent settings; contrast with ASM's DID-linked reputation that enables persistent trust accumulation — ASM's approach sacrifices anonymity for richer trust history

## Paper 1 Relevance
- **§4.3 (S pillar)**: Strong empirical evidence for trust-weighted aggregation in adversarial agent ecosystems; validates the S pillar's claim that reputation mechanisms can filter malicious participants
- **§5 (security)**: 72% adversarial detection without identity anchoring — shows the detection rate is lower without identity persistence, which motivates ASM's DID-linked approach

## Verdict
⭐⭐⭐ | Background citation — useful for S pillar (Paper 1 §4.3) and ASM security motivation. Domain-specific application limits direct relevance; interesting as a contrast case for identity-free vs. identity-anchored reputation.

---
*Jason's feedback*: [待填]
