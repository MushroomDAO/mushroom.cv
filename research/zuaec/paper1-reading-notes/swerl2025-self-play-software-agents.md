# [SWE-RL 2025] Toward Training Superintelligent Software Agents through Self-Play SWE-RL
**arXiv**: 2512.18552 | **Year**: 2025 | **Authors**: [Multi-author team — affiliations not retrieved] | **Venue**: Preprint
**Cluster**: Capability Trajectory & Training Methods
**Status**: Abstract + key results read (ar5iv fatal error; arxiv.org abstract retrieved)

## Core Claim
Self-play SWE-RL (SSR) is a training paradigm for superintelligent software agents that requires only sandboxed code repositories with no human-labeled issues or tests; a single LLM agent trained via RL in self-play (simultaneously injecting and repairing bugs) achieves +10.4 points on SWE-Bench Verified and consistently outperforms human-data baselines.

## Key Evidence / Numbers
- **+10.4 percentage points** improvement on **SWE-Bench Verified** over human-data baseline
- **+7.8 percentage points** improvement on **SWE-Bench Pro** over human-data baseline
- Both improvements maintained "consistently over the entire training trajectory" — not one-shot gains
- Training data requirements: only **sandboxed code repositories** with source code + installed dependencies — NO human-labeled issues, NO curated tests
- Bug specification format: **test patches** (formal), NOT natural language descriptions — enables self-play loop
- Evaluation gap: SSR is evaluated on **natural language issues** even though trained on test-patch format — demonstrates genuine generalization
- Training paradigm: single LLM agent in self-play loop (injector + repairer roles alternating)
- Complexity curriculum: bug difficulty increases iteratively during training

## Paper 1 Relevance
**§1 (Motivation — capability trajectory)**: SWE-RL demonstrates that agent capabilities are self-amplifying — agents can now improve themselves without human curation. The +10.4 point gain is significant because it compounds on already high SWE-Bench baselines (see Apollo Research's 87% SOTA forecast). Together, these papers show:
1. Current SOTA is rapidly approaching human coding performance
2. The training paradigm is shifting to self-play/RL — capability growth rate may accelerate beyond linear forecasts

**§1 (urgency argument)**: Self-amplifying capability growth ("no human curation needed") means the window for establishing collaboration norms and protocols is narrowing — infrastructure (Three Pillars) must be built now before agents operate at scales where human oversight becomes impractical.

**§4 (SC Pillar)**: SSR's bug-inject/repair loop means agents are accumulating behavioral histories with verifiable outcomes. This is precisely the kind of action-traceable record that quantified Social Capital (SC) would leverage — reputation derived from verifiable task performance, not self-report.

## Paper 2 Relevance
Self-play trained agents generating test patches aligns with ASM's role-bearing model — the "bug injector" and "bug repairer" are distinct functional roles that benefit from a protocol distinguishing role identity from model identity.

## Verdict
⭐⭐⭐⭐ | Strong capability trajectory evidence showing self-amplifying improvement (+10.4 SWE-Bench Verified); most important use is in §1 to argue that capability growth is accelerating beyond human-curation limits, making the Three Pillars infrastructure framework urgent.

## Jason's feedback
> （请在此处写入你的feedback）
