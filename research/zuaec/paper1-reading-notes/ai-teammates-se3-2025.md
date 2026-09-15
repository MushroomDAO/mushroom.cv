# [Li, Zhang, Hassan 2025] The Rise of AI Teammates in SE 3.0: How Autonomous Coding Agents Are Reshaping Software Engineering

**arXiv**: 2507.15003 | **Year**: 2025 | **Authors**: Hao Li, Haoxiang Zhang, Ahmed E. Hassan (Queen's University) | **Venue**: arXiv preprint
**Cluster**: Human-AI Teaming / Real-World Agent Deployment
**Status**: Full read

## Core Claim
Autonomous coding agents have crossed from prototype to production reality—456K+ real-world PRs empirically prove it—but a persistent benchmark-reality gap reveals systematic capability shortfalls in complex tasks that require new SE methodologies and governance frameworks.

## Key Evidence / Numbers
- **Dataset**: AIDev — 456,535 PRs from 5 autonomous agents (OpenAI Codex, Devin, GitHub Copilot, Cursor, Claude Code) across 61,453 GitHub repositories
- OpenAI Codex PR acceptance rate: **64%** vs. 79% human baseline (a systemic shortfall, not an outlier)
- GitHub Copilot median resolution time: **12.8 minutes** vs. human multi-day cycles
- Accepted agentic PRs reviewed **10× faster** than human PRs (binary reviewer decision pattern)
- Only **9.1%** of Codex code changes affect cyclomatic complexity vs. **23.3%** for humans (agents optimize throughput, not depth)
- Documentation PR acceptance: **88.6%** for OpenAI Codex (agent strength area)
- One repository saw 164 agentic PRs in 3 days vs. 176 human PRs over 3 years
- Bot reviewers in **20.1%** of agentic PRs vs. 10% of human PRs; GitHub Copilot shows **37.4%** hybrid human-bot reviews
- SE paradigm evolution: SE 1.0 (hand-coded) → SE 1.5 (autocomplete) → SE 2.0 (LLM-assisted) → SE 3.0 (agentic, end-to-end)

## Paper 1 Relevance
**§5 (human-AI teaming, real-world evidence for Pillar N)**: This paper provides the strongest available empirical grounding for the claim that agents are *already* operating as social actors in human teams, not hypothetical future entities. The 10× faster review cycles and 64% acceptance rate quantify the real-world performance gap that motivates Pillar SC (social capital as a trust signal). The SE 3.0 framing aligns directly with Paper 1's paradigm-shift argument: SE is moving from tool invocation to agentic collaboration, mirroring our capability-invocation → social-role-agency shift.

Key angles:
- **§2 (old paradigm contrast)**: The paper documents that agents in SE 3.0 still operate primarily as capability-invokers (task-level tool use), not as role-bearing social actors with persistent identity or reputation across repositories/organizations — exactly the gap our three-pillar framework addresses.
- **§5 (governance)**: Nine research directions proposed by the authors (dynamic review triage, authorship attribution, long-term quality evaluation) all presuppose stable, accountable agent identity — i.e., they implicitly need Pillar SC and Pillar N without naming them.
- The inconsistent authorship attribution finding (Codex has none; Claude Code adds "Co-Authored-By") is a concrete illustration of the identity accountability gap our framework targets.

## Paper 2 Relevance
**§6 (compliance and accountability)**: The finding that provider-aligned review loops (GitHub Copilot reviewed by copilot-pull-request-reviewer) enable efficiency but "risk internal bias" is a governance concern that ASM's role-credential binding and permissionless network (Pillar N) directly address. The AIDev dataset also implicitly calls for a protocol layer that can assert *which social role* an agent is acting under (developer? reviewer? orchestrator?) — the missing layer ASM supplies.

## Verdict
⭐⭐⭐ | Excellent empirical foundation for Paper 1 §5; the AIDev numbers are citable as real-world evidence that agents operate at scale in human teams but lack the social-capital and identity infrastructure the three-pillar framework provides.

## Jason's feedback
> （请在此处写入你的feedback）
