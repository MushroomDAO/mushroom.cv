# DEBATE: A Large-Scale Benchmark for Role-Playing LLM Agents in Multi-Agent, Long-Form Debates
**arXiv**: 2510.25110 | **Year**: 2025 | **Authors**: Chuang et al. | **Venue**: arXiv preprint

## Core Claim
DEBATE is the first empirical benchmark measuring how authentically multi-agent LLM systems simulate realistic group opinion dynamics in structured debates, revealing systematic gaps between LLM and human social behavior.

## Key Evidence / Numbers
- Dataset: 29,417 messages, 2,792 U.S. participants, 797 groups, 107 topics
- LLM agents show stronger opinion convergence than humans: SD reduction in tweet stance t(30)=-2.27, p=.03 for LLMs vs. t(30)=0.02, p=.98 for humans
- LLMs regress to mean more: r=-0.53 vs. human r=-0.42 for tweet stance
- GPT-4o-mini best semantic alignment (similarity: 0.49); SFT improved surface metrics only
- On-topic utterance rates: humans 58–66%, LLMs 54–92% (simulation-mode dependent)

## Paper 1 Relevance
- **Role**: §4 social dynamics — empirical evidence that role-playing LLM agents deviate from human social dynamics in structured interaction
- **§4 use**: Supports the need for explicit social role structures (not just prompted personas) to achieve authentic collaborative behavior; DEBATE's gaps motivate the S pillar (Social Role Agency)
- Strong methodological rigor — 29k-message human dataset provides credible comparison baseline

## Paper 2 Relevance
Indirect — opinion convergence dynamics relevant to §5 risk analysis (conformity/manipulation risks in open agent networks).

## Verdict
⭐⭐⭐⭐ | Include — strong empirical grounding for §4, directly motivates S pillar argument; benchmark paper with real human data

## Jason's feedback
[ ]
