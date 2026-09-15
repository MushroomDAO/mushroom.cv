# [Deng, Da, Pan et al. 2025] SWE-Bench Pro: Can AI Agents Solve Long-Horizon Software Engineering Tasks?

**arXiv**: 2509.16941 | **Year**: 2025 | **Authors**: Xiang Deng, Jeff Da, Edwin Pan, Yannis Yiming He, Charles Ide, + 17 additional contributors (Scale AI) | **Venue**: arXiv preprint
**Cluster**: Agent Capability Benchmarking / Real-World Performance Evidence
**Status**: Full read

## Core Claim
Frontier AI agents resolve fewer than 25% of enterprise-grade software engineering problems, exposing a dramatic benchmark-reality gap (>70% on SWE-Bench Verified vs. <25% on SWE-Bench Pro) that reveals genuine capability limits rather than benchmark saturation.

## Key Evidence / Numbers
- **Public set performance**: GPT-5: **23.3%**, Claude Opus 4.1: **22.7%** resolution rate
- **Commercial set performance**: Claude Opus 4.1: **17.8%**, GPT-5: **14.9%** (harder, proprietary codebases)
- **Prior benchmark (SWE-Bench Verified)**: frontier models achieve **>70% Pass@1** — a >50 percentage-point gap
- **Dataset size**: 1,865 total problems (731 public, 276 commercial, 858 held-out)
- **Average patch complexity**: **107.4 lines of code** across **4.1 files** (long-horizon, multi-file)
- Python/Go repositories show higher resolve rates; JavaScript/TypeScript more variable
- Evaluation: SWE-Agent scaffold with **200-turn limit**, Docker-based containerized environments
- Failure mode analysis via GPT-5-as-judge: larger models fail primarily on semantic correctness and multi-file coordination; smaller models on tool-use and context management
- Contamination resistance strategy: GPL-licensed repos + commercial codebases from early-stage startups

## Paper 1 Relevance
**§5 (capability benchmarks and Pillar SC motivation — high relevance)**:

SWE-Bench Pro provides the most rigorous available evidence for Paper 1's argument that *raw task capability is insufficient* and that social coordination infrastructure is necessary:

1. **The capability ceiling argument**: Even frontier models (GPT-5, Claude Opus 4.1) fail on 75%+ of enterprise-grade tasks. This is not a training-data problem — it is a *long-horizon coordination* problem. Multi-file coordination failures (the primary failure mode for large models) are exactly the problem Pillar P (collaboration protocols) and Pillar SC (social capital as a trust signal for delegation) are designed to address.

2. **The benchmark-saturation crisis**: The >70% vs. <25% gap between SWE-Bench Verified and SWE-Bench Pro demonstrates that existing benchmarks measure capability at the wrong level of abstraction. Paper 1's paradigm-shift argument is strengthened: even if we solve the capability problem, agents operating without social roles and accountability still cannot be trusted with long-horizon enterprise work.

3. **Governance angle**: The commercial codebase tier (17.8% resolution) illustrates that real-world agentic deployment in enterprise contexts requires not just capability but accountability and auditability — which maps onto Pillar N (permissionless but accountable network) and Paper 1's §5 governance discussion.

4. **Failure mode taxonomy**: The distinction between large-model failures (semantic correctness, multi-file coordination) and small-model failures (tool-use, context management) suggests that *coordination*, not raw model capability, is the binding constraint at the frontier. This directly motivates Pillar P.

5. **Citation value**: The 23.3%/22.7% public-set numbers are highly citable as concrete evidence that "state-of-the-art agents cannot yet autonomously handle real-world software engineering tasks" (Paper 1 §5 opening).

## Paper 2 Relevance
Minor relevance. SWE-Bench Pro's multi-file, multi-turn evaluation protocol (200-turn limit, Docker environments, explicit requirements) implicitly describes the kind of long-horizon collaboration scenario ASM's role-bearing state machines need to support. The benchmark's three-tier dataset structure (public/held-out/commercial) could serve as a model for ASM's protocol validation test suite design in §7.

## Verdict
⭐⭐⭐⭐ | Essential empirical evidence for Paper 1 §5; the benchmark-reality gap numbers (>70% → <25%) are among the most citable in the agentic AI literature for demonstrating that capability benchmarks alone do not capture real-world agent performance, motivating the social infrastructure layer the three-pillar framework provides.

## Jason's feedback
> （请在此处写入你的feedback）
