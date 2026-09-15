# [Song, Cimpeanu, Shen & Han 2026] Evolution of Fairness in Hybrid Populations with Specialised AI Agents

**Citation**: Zhao Song, Theodor Cimpeanu, Chen Shen, The Anh Han (2026). *Evolution of fairness in hybrid populations with specialised AI agents.* Philosophical Transactions of the Royal Society A (submitted). arXiv:2602.18498v1 [cs.MA], 15 Feb 2026.
**机构**: Teesside University (UK, Song & Han); University of Stirling (UK, Cimpeanu); Faculty of Engineering Sciences, Kyushu University (Japan, Shen). Corresponding: The Anh Han (t.han@tees.ac.uk). Funded by EPSRC EP/Y00857X/1.
**arXiv**: https://arxiv.org/abs/2602.18498
**PDF**: papers/song2026-fairness-hybrid.pdf
**Cluster**: Human-AI Hybrid Collaboration — Paper 1 §4 (+ P/SC)
**Status**: ✅ 全文已分析（2026-05-22）

## Core claim (一句话)
In an asymmetric (bipartite) Ultimatum Game over hybrid human-AI populations, the *role* an AI is locked into matters more than its prosociality: AI placed in the norm-enforcing receiver position drives population-wide fairness far more effectively than AI placed in the norm-modelling proposer position, and a strategy-aware "Discriminatory" AI proposer that conditions offers on predicted receiver thresholds beats both, sustaining mutual fairness with far fewer agents under strong selection.

## 研究问题
How do role-specialised AI agents — fixed into either proposer or receiver positions — influence the evolution of human fairness norms in hybrid populations where humans and AI interact across asymmetric social roles (employer-employee, provider-client, regulator-regulated)? Specifically: does an AI that *models* fairness (generous proposer) differ in efficacy from one that *enforces* it (strict receiver)? Can they act synergistically? Most prior UG work assumes role symmetry; this paper breaks that assumption.

## 方法与主要内容
- **Model**: One-shot Ultimatum Game on a finite, well-mixed *bipartite* population — separate proposer and receiver populations, each a mix of humans + pre-programmed AI. Proposers choose high (h=0.5) or low (l=0.1) offer; receivers set high or low acceptance threshold.
- **Dynamics**: Humans update strategies via social learning (Moran process with Fermi pairwise-comparison rule, selection intensity β). AI agents are fixed (do not learn). Small-mutation limit → Markov chain over four monomorphic states (HH, HL, LH, LL); stationary distribution = long-term fairness measure.
- **Three AI designs**:
  1. *Samaritan AI proposer* — unconditionally offers fair h.
  2. *Samaritan AI receiver* — unconditionally sets high threshold h (norm-enforcer).
  3. *Discriminatory AI proposer* — predicts each receiver's threshold (idealised theory-of-mind / intention recognition / reputation), offers h only to high-threshold receivers, l otherwise.
- **Key results**:
  - Samaritan AI *receivers* induce full fairness in BOTH populations; Samaritan AI *proposers* at best fix proposers and collapse under strong selection. Mechanism: receivers exploit disadvantageous inequity aversion (Fehr-Schmidt).
  - Under strong selection (β=100), ~58 AI receivers needed; AI proposers alone ineffective. Combining types is synergistic: boundary follows M_P + M_R = 58 (total agent count is what matters).
  - Discriminatory AI proposer outperforms both Samaritan types — only ~8 agents needed at β=100 — by sanctioning low-threshold receivers via reduced offers. More cost-effective but more sensitive to payoff structure (works best when unfairness easily punishable, fair offers not too costly).
  - HH (mutual fairness) robust across ~88% of parameter space for Samaritan, ~50% for Discriminatory.
- **Limitations/future** (their own): well-mixed only (no networks); fixed (non-learning) AI — flags RL/LLM agents as future; assumes perfect receiver-strategy recognition; ignores institutional/welfare COST of deploying AI agents.

## 论文未覆盖的范围（我们的差异化基础）

| Dimension | This paper (Song et al. 2026) | 我们的框架 (P/SC/N) |
|---|---|---|
| What is modelled | Evolutionary *dynamics* of fairness given exogenous AI strategies | The *infrastructure* (protocol, social capital, network) that makes role-bearing behavior possible & incentive-shaping |
| AI agent nature | Hard-coded fixed strategy ("Samaritan"/"Discriminatory"); no identity, no memory across games | Role-bearing agent with verifiable identity, persistent reputation, accountable presence on a network |
| Reputation | Mentioned only as an idealised input ("AI can use reputation scores") — not built | Pillar SC: quantified social capital as a first-class, earned, network-native primitive |
| Role assignment | Exogenous, researcher-imposed (locked proposer/receiver) | Roles emerge from and are bound to agent identity + accumulated standing on permissionless network N |
| Network structure | Explicitly well-mixed; "structured populations a vital next step" | Pillar N: permissionless network IS the structured substrate they defer to future work |
| Cost of deployment | Flagged as overlooked open problem (institutional cost vs welfare) | P/SC make the cost legible: reputation-staking & protocol rules internalise the enforcement cost |
| Mechanism of fairness | Sanctioning via reduced offers / threshold enforcement | Same insight (enforcement > modelling) realised as protocol-level commitments + reputational consequences |

## Paper 1 区分段落（~150-200词，英文）
Song, Cimpeanu, Shen and Han (2026) provide the strongest available formal argument for why *role* — not mere prosociality — governs whether AI agents shift human cooperation equilibria: their bipartite Ultimatum Game shows that AI in the norm-*enforcing* receiver position, or a strategy-aware "Discriminatory" proposer, drives population-wide fairness far more effectively and cheaply than unconditional generosity. This directly motivates our §4 claim that the position and accountability of an agent, not its capability alone, determine collaborative outcomes. Crucially, however, their AI agents are *exogenous abstractions*: hard-coded strategies with no identity, no persistent reputation, set into roles by the modeller, interacting only in well-mixed populations. They explicitly defer structured networks, learning agents, reputation, and the institutional *cost* of enforcement to future work. Those deferred pieces are precisely our three pillars. We do not re-derive the evolutionary dynamics; we supply the missing substrate: a collaboration protocol (P) that encodes enforceable role commitments, quantified social capital (SC) that turns their idealised "reputation score" into an earned, network-native primitive, and a permissionless network (N) that *is* the structured topology and accountable role-assignment mechanism their model assumes away. Their dynamics describe the incentive landscape; P/SC/N build it.

## Action items
- [ ] Cite in §4 (machine-machine + human-AI collaboration) as formal evidence that enforcement-position agents beat modelling-position agents → supports framing role-bearing > capability-container.
- [ ] Cite in Pillar SC motivation: they treat reputation/intention-recognition as an idealised black-box input — our SC operationalises it.
- [ ] Cite in Pillar N motivation: "well-mixed only; structured networks a vital next step" is an explicit gap our permissionless network addresses.
- [ ] Use their "institutional cost vs social welfare" open problem (Han et al. 2026, Phys Life Rev) to argue P/SC internalise enforcement cost.
- [ ] Note their future-work call for "RL/LLM learning-driven agents" — bridges to our role-bearing learning agents (avoid overclaiming: they are game-theoretic, we are protocol-architectural).

## Jason's feedback
> （请在此处写入你的feedback）
