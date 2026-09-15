# A Survey of AI Agent Protocols
**arXiv**: 2504.16736 | **Year**: 2025 | **Authors**: Yingxuan Yang, Huacan Chai, Yuanyi Song, et al. (Shanghai Jiao Tong University + ANP Community) | **Venue**: arXiv preprint

## Core Claim
The first comprehensive survey of AI agent protocols, providing a two-dimensional classification framework (context-oriented vs. inter-agent × general-purpose vs. domain-specific) and evaluating protocols across seven dimensions (efficiency, scalability, security, reliability, extensibility, operability, interoperability) — concluding that a unified protocol would enable a "connected network of intelligence."

## Key Evidence / Numbers
- Two-dimensional classification: context-oriented (MCP, agents.json) vs. inter-agent (ANP, A2A, AITP, AConP, AComP, Agora)
- Seven evaluation dimensions with qualitative comparative analysis
- Protocol evolution demonstrated: MCP v1 → HTTP streaming + auth support
- Four protocols applied to identical trip-planning scenario:
  - MCP: centralized simplicity, lacks flexibility
  - A2A: direct inter-agent, reduces bottlenecks
  - ANP: structured cross-domain via JSON-LD + DIDs
  - Agora: natural language → protocol specification
- Three evolutionary phases: static → evolvable → ecosystem thinking → distributed intelligence infrastructure
- LOKA: decentralized identity + ethical consensus; PXP: human-agent prediction-explanation

## ASM Comparison (Paper 2 focus)
- **What it does**: Provides the definitional taxonomy and comparison framework for the entire protocol landscape — the reference survey for protocol papers
- **Gap vs ASM**: The survey covers existing protocols; ASM fills the gap it identifies: none of the surveyed protocols combine role-bearing identity (DID-encoded role) + reputation-weighted routing + permissionless participation. ANP is closest but lacks role encoding and reputation. A2A is enterprise-gated. MCP lacks identity entirely
- **Paper 2 §2 use**: Primary taxonomy reference — use the context-oriented vs. inter-agent distinction in ASM's related work; position ASM as a new inter-agent protocol with DID+role+reputation that the survey's gap analysis calls for. Cite the "protocol choice would create distributed intelligence infrastructure" framing as motivation

## Paper 1 Relevance
- **§2 (background)**: Citation for the protocol landscape overview — establishes that many protocols exist but none address the social role paradigm Paper 1 argues for
- **§4.1 (N pillar)**: The survey's taxonomy of inter-agent protocols provides the landscape from which N pillar design choices can be justified

## Verdict
⭐⭐⭐⭐⭐ | Essential reference — cite in both papers. Primary taxonomy source for Paper 2 §2; Paper 1's N pillar background. ANP Community co-authorship means the survey is partly self-serving for ANP, worth noting when differentiating ASM from ANP.

---
*Jason's feedback*: [待填]
