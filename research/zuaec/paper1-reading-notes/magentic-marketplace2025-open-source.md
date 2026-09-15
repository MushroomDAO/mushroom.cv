# Magentic Marketplace: An Open-Source Environment for Studying Agentic Markets
**arXiv**: 2510.25779 | **Year**: 2025 | **Authors**: Gagan Bansal, Wenyue Hua, Zezhou Huang, Adam Fourney, Amanda Swearngin et al. | **Venue**: arXiv preprint (Microsoft Research + Arizona State University)

## Core Claim
Frontier LLM agents can approach optimal welfare in two-sided marketplaces under ideal search conditions, but performance degrades sharply with scale, all models exhibit severe first-proposal bias (10–30× advantage for speed over quality), and smaller models are vulnerable to manipulation tactics — revealing that open agent markets require both better protocols and better institutional design.

## Key Evidence / Numbers
- GPT-4.1 and Gemini-2.5-Flash approached optimal outcomes with perfect search; degraded sharply with realistic lexical search
- Extreme first-proposal bias: first offers selected 60–100% of the time vs. near-zero for third proposals (4.5× to 100%+ selection rate advantage)
- Welfare declined 4.3–65.4% when increasing consideration set from 3 to 100 search results ("paradox of choice")
- Frontier models (GPT-4.1, Sonnet-4.5, Gemini-2.5-Flash) showed robust resistance to psychological manipulation
- Smaller models (GPT-4o, open-source variants) showed significant vulnerability to authority appeals, social proof, prompt injection
- Market scales: small (33 customers, 99 businesses), medium (100 customers, 300 businesses)
- HTTP/REST architecture with 5 core actions: search, text messaging, order proposals, payments, message retrieval
- Open-source: github.com/microsoft/multi-agent-marketplace; synthetic data generation for restaurants and contractors domains

## Paper 1 Relevance
- **Role**: N pillar empirical evidence + framework contrast; Magentic Marketplace shows what an open agent market looks like without social capital or role-based trust, revealing the behavioral biases and manipulation vulnerabilities that Paper 1's SC and N pillars address
- **§3 use**: §3.4 (N pillar) — cite as empirical evidence that two-sided agent markets are being studied and that open participation requires anti-manipulation infrastructure; the "paradox of choice" effect motivates role-based filtering (N pillar's reputation-gated discovery)
- **§3 use**: §3.3 (SC pillar) — first-proposal bias shows agents rely on naive heuristics instead of social capital signals; reputation-based evaluation (SC) would correct the bias
- **Pillar**: N (primary) + SC (secondary)

## Paper 2 Relevance
The HTTP/REST five-action protocol is the closest prior work to ASM's message-layer design — but it covers only transactional actions (search, propose, pay), not role attestation or social state. ASM fills the gap in the message envelope for role-bearing agents. Cite in ASM §2 (related work) as the most concrete marketplace protocol predecessor.

## Verdict
⭐⭐⭐⭐ | Include as citation — strong for N pillar and Paper 2 protocol comparison; the first-proposal bias finding is a memorable empirical anchor for why agents need better information signals (SC) rather than just better search

## Jason's Feedback
[待填]
