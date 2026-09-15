# Internet of Agentic AI: Incentive-Compatible Distributed Teaming and Workflow
**arXiv**: 2602.03145 | **Year**: 2025 | **Authors**: Ya-Ting Yang, Quanyan Zhu (NYU Tandon) | **Venue**: arXiv preprint

## Core Claim
Proposes a formal framework for "Internet of Agentic AI" where geographically distributed agents form incentive-compatible dynamic coalitions for task execution — combining capability coverage, network locality constraints, and individual rationality conditions. Includes a C+MCP compatibility layer positioning the framework above Model Context Protocol.

## Key Evidence / Numbers
- Healthcare case study on 40-node network
- Feasible coalitions achieved at **k=2 hop radius** (modest network range)
- Coalition size decreases with per-agent capability breadth (specialization drives coalition size)
- Algorithm 1: incremental search through expanding hop-radius neighborhoods
- Three feasibility conditions: capability consistency + reward realizability + incentive compatibility
- **C+MCP layer**: pre-execution coordination layer above MCP
- Formal game-theoretic model: minimum-effort coalition selection problem

## ASM Comparison (Paper 2 focus)
- **What it does**: Economic game-theoretic framework for agent coalition formation — most formally rigorous treatment of "who joins which team" under economic constraints
- **Gap vs ASM**: (1) No identity/trust mechanism — assumes agents' capabilities are known and verified by some external means; (2) Coalition formation is the problem, not the communication protocol within the coalition; (3) No reputation — assumes agents are rational (not adversarial); (4) Economic incentives ≠ trust-weighted routing
- **Paper 2 §4 use**: Cite as complementary — Internet of Agentic AI addresses coalition formation (who participates), ASM addresses how they communicate (message protocol). Together they address different layers of the N pillar

## Paper 1 Relevance
- **§4.1 (N pillar)**: Game-theoretic coalition formation validates the N pillar's claim that agent network formation requires formal mechanisms — citable as the economic side of network formation
- **§2 (paradigm shift)**: "Internet of Agentic AI" framing directly supports Paper 1's paradigm shift from tool invocation to networked agent society

## Verdict
⭐⭐⭐ | Background citation — strong for Paper 1 §2/§4.1 (paradigm + N pillar), moderate for Paper 2 (complementary layer). NYU Tandon authors add credibility.

---
*Jason's feedback*: [待填]
