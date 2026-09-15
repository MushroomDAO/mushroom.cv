# Tool Learning with Large Language Models: A Survey
**arXiv**: 2405.17935 | **Year**: 2024 | **Authors**: Qu, Dai, Wei, Cai, Wang, Yin, Xu, Wen | **Venue**: arXiv preprint (Renmin University / Baidu / CAS)

## Core Claim
Tool learning — augmenting LLMs with external tools via APIs — can be systematically organized into four workflow stages (task planning, tool selection, tool calling, response generation) and two paradigms (one-step vs. iterative), providing a unified framework for extending LLM capabilities beyond their intrinsic limits across diverse domains.

## Key Evidence / Numbers
- Reviews approximately **100 papers** across the tool learning field
- Catalogs **26 benchmarks** spanning general and specialized evaluation
- ToolBench2: **16,464 tools** with **126,486 instances** (largest dataset in the field)
- Seven major research challenges identified: high latency, lack of rigorous metrics, limited tool accessibility, safety/robustness vulnerabilities, fragmented approaches, absence of real-world benchmarks, underexplored multi-modal learning
- Six benefit categories: knowledge acquisition, expertise enhancement, automation/efficiency, interaction enhancement, interpretability/trust, robustness/adaptability
- Epigraph: "Sharp tools make good work" — *The Analects: Wei Ling Gong*

## Paper 1 Relevance
- **Role**: Old paradigm scoping — the comprehensive survey of the capability-invocation paradigm; its four-stage workflow (plan → select → call → respond) is purely about task-level capability extension with no social structure
- **§2 use**: Cite in §2.1 alongside Toolformer as the survey-level evidence for how thoroughly the field has developed capability invocation while leaving social coordination unaddressed: "Qu et al. [citation] survey ~100 papers and catalog 26 benchmarks, confirming that tool learning's four-stage workflow addresses task-level capability extension but contains no stage for social role negotiation, trust establishment, or permissionless network entry"
- **Pillar**: Framework contrast (the four-stage pipeline is a capability pipeline, not a social one — no P, no SC, no N)

## Paper 2 Relevance
N/A — Paper 1 only. "Tool calling" in this survey refers to API invocation for task performance; it does not address role-bearing communication protocols between agents.

## Verdict
⭐⭐⭐ | Use as background context — cite once in §2.1 as the comprehensive survey of the old paradigm; the 100-paper scope and 26-benchmark catalog give quantitative weight to the claim that capability invocation is a mature, well-mapped paradigm that nonetheless misses the social layer.

*Note: Full text retrieved from ar5iv HTML.*

## Jason's feedback
> （请在此处写入你的feedback）
