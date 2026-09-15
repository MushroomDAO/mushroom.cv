# A Survey on the Memory Mechanism of Large Language Model based Agents
**arXiv**: 2404.13501 | **Year**: 2024 | **Authors**: Zeyu Zhang, Xiaohe Bo, Chen Ma, Rui Li, Xu Chen, Quanyu Dai, Jieming Zhu, Zhenhua Dong, Ji-Rong Wen | **Venue**: arXiv preprint (Renmin University + Huawei Noah's Ark Lab)

## Core Claim
Memory is the key differentiator between LLM-based agents and baseline LLMs, enabling autonomous evolution through extended agent-environment interactions; the survey identifies three memory sources (inside-trial, cross-trial, external knowledge), two forms (textual, parametric), and three operations (write, manage, read) — but focuses entirely on individual agent memory with minimal treatment of multi-agent or social memory.

## Key Evidence / Numbers
- 30+ implementations analyzed: Reflexion, Generative Agents, MemGPT, ExpeL, Voyager, ReAct, ChatDoctor, Huatuo
- Three memory sources: inside-trial (single task sequence), cross-trial (accumulated across attempts), external knowledge (APIs, databases)
- Two memory forms: textual (interpretable, natural language) vs. parametric (encoded in weights, avoids context limits)
- Three operations: writing, management (reflection/merging/forgetting), reading (similarity-based retrieval)
- Research gap identified: "limited advances in parametric memory" and "minimal research on memory mechanisms for multi-agent systems"
- Research gap: "few studies address memory-based lifelong learning"

## Paper 1 Relevance
- **Role**: Old paradigm contrast — memory survey shows capability-centric approach where "memory" = task history/knowledge accumulation, with no treatment of relational or social memory
- **§2 use**: §2 Related Work — cite to show that even dedicated memory surveys treat agent memory as individual cognitive architecture, not as social capital or relational history
- **§3 use**: §3.3 (SC pillar) — the identified gap "minimal research on memory mechanisms for multi-agent systems" directly motivates SC (Social Capital) as the missing layer: SC is relational memory across agent boundaries, externalized and quantified
- **Pillar**: SC (Social Capital) — contrast: individual memory (Zhang et al.) vs. social capital as inter-agent relational memory (Paper 1's SC pillar)

## Paper 2 Relevance
N/A — Paper 1 only. The memory architecture is individual-agent concern; ASM's role is message-layer, not memory-layer. At most a light mention that ASM message envelopes carry the social context that would otherwise be "lost memory" between agent interactions.

## Verdict
⭐⭐⭐ | Background context — the multi-agent memory gap finding (§4 of Zhang et al.) is the clearest single sentence to quote when introducing SC pillar; the paper itself is a contrast, not a supporter

## Jason's Feedback
[待填]
