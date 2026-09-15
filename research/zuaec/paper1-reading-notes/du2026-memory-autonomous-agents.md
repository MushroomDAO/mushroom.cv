# Memory for Autonomous LLM Agents: Mechanisms, Evaluation, and Emerging Frontiers
**arXiv**: 2603.07670 | **Year**: 2026 | **Authors**: Pengfei Du | **Venue**: Advanced Intelligent Systems (targeted preprint; Hong Kong Research Institute of Technology)

## Core Claim
Memory transforms a stateless text generator into a genuinely adaptive agent through a write–manage–read loop formalized within a POMDP framework; however, even the 2026 frontier reveals that near-perfect passive recall does not translate to agentic decision quality (40–60% on multi-session agentic tasks vs. near-100% on recall benchmarks), and multi-agent shared memory governance has no current strong solutions.

## Key Evidence / Numbers
- MemoryArena benchmark: near-perfect passive recall (LoCoMo) → 40–60% on multi-session agentic tasks requiring memory-driven decisions
- Long-context (200k tokens) consistently underperforms purpose-built memory systems on selective retrieval tasks
- Only MemoryAgentBench explicitly tests selective forgetting
- Five mechanism families: context-resident compression, retrieval-augmented stores, reflective self-improvement, hierarchical virtual context (MemGPT-style), policy-learned management (RL)
- Three-dimensional taxonomy: temporal scope (working/episodic/semantic/procedural), representational substrate (text/vectors/structured DB/executable), control policy (heuristic/prompted/RL-learned)
- Key finding: "multi-agent systems: no current strong solutions for shared memory governance"
- Production gaps: write-path noise accumulation, staleness/contradiction handling, privacy/deletion compliance, observability deficits

## Paper 1 Relevance
- **Role**: 2026 frontier evidence that individual-agent memory is unsolved for multi-agent contexts, directly motivating SC as the inter-agent relational layer
- **§2 use**: §2 Related Work — cite as the most recent (2026) survey confirming that shared memory governance in MAS remains an open problem; SC pillar is proposed as one answer
- **§3 use**: §3.3 (SC pillar) — "no current strong solutions for shared memory governance" is a quotable gap statement; SC externalizes cross-agent relational state as quantified social capital rather than trying to solve distributed memory at the storage level
- **Pillar**: SC (Social Capital) — the "recall ≠ agentic utility" finding supports the argument that what agents need is not just individual memory but socially-contextualized decision signals (reputation, role history)

## Paper 2 Relevance
Lightly relevant — the POMDP formalization of memory write–manage–read could inform ASM's role of carrying social state in message envelopes (the message carries what the receiving agent "needs to remember" about the sender). Light mention possible in ASM §3 design rationale.

## Verdict
⭐⭐⭐ | Background context — the "no solutions for shared memory governance" quote is the most valuable; the rest establishes individual-agent memory landscape as contrast material

## Jason's Feedback
[待填]
