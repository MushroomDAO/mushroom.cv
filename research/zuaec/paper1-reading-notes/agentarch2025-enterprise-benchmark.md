# [AgentArch 2025] AgentArch: A Comprehensive Benchmark to Evaluate Agent Architectures in Enterprise
**arXiv**: 2509.10769 | **Year**: 2025 | **Authors**: (see paper) | **Venue**: arXiv cs.AI
**Cluster**: Evaluation / Enterprise Benchmarking
**Status**: Skim only (abstract + key results; ar5iv redirect to arxiv.org/abs)

## Core Claim
Enterprise multi-agent systems exhibit significant model-specific architectural preferences that invalidate the "one-size-fits-all" paradigm: 18 distinct agentic configurations across state-of-the-art LLMs reveal that optimal architecture depends on the model, with complex enterprise tasks achieving only 35.3% maximum success rate, exposing fundamental gaps in current agentic AI for production deployment.

## Key Evidence / Numbers
- 18 distinct agentic configurations evaluated across multiple state-of-the-art LLMs
- Maximum performance on complex enterprise tasks: 35.3% success rate
- Maximum performance on simpler enterprise tasks: 70.8% success rate
- Four architectural dimensions varied: orchestration strategy, agent prompt implementation (ReAct vs. function calling), memory architecture, thinking tool integration
- Key finding: model-specific architectural preferences — different LLMs perform optimally with different architectural designs
- Challenge addressed: understanding "how different design dimensions interact within complex multi-agent systems" — prior work studied components in isolation

## Paper 1 Relevance
**§5 (Evaluation / Empirical Claims)**: AgentArch complements ARE (2509.17158) by providing the enterprise-specific performance baseline. The 35.3% ceiling on complex tasks is a strong empirical anchor for Paper 1's argument that current capability-invocation architectures are production-inadequate. The model-specific architectural preference finding supports our claim that fixed capability registries (current paradigm) are brittle — a permissionless network with social capital-driven routing would dynamically match tasks to architecturally compatible agents rather than assuming universal architecture works for all. Cite in §5 alongside ARE as converging evidence that current MAS architectures fail in realistic deployment conditions.

## Paper 2 Relevance
The four-dimension architecture space (orchestration, prompt style, memory, thinking tools) maps onto ASM design choices: orchestration ↔ routing protocol, memory ↔ agent state persistence, prompt implementation ↔ message format. The enterprise benchmark failure modes (35.3% on complex tasks) motivate ASM's role-based message routing: if complex task success requires careful architectural matching, then the protocol layer must carry enough semantic information (role, capability claims, reputation) to enable that matching at runtime.

## Verdict
⭐⭐⭐ | Useful enterprise-grounding benchmark; the 35.3% ceiling and model-specific preference finding are citable numbers, but the abstract-only access limits depth of engagement. Worth citing in §5 as a convergent data point alongside ARE and scaling-agent-systems.

## Jason's feedback
> （请在此处写入你的feedback）
