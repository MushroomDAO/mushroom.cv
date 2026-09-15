# [Fang, Peng, Zhang et al. 2025] A Comprehensive Survey of Self-Evolving AI Agents: A New Paradigm Bridging Foundation Models and Lifelong Agentic Systems
**Citation**: Jinyuan Fang, Yanwen Peng, Xi Zhang, Yingxu Wang, Xinhao Yi, Guibin Zhang, Yi Xu, Bin Wu, Siwei Liu, Zihao Li, Zhaochun Ren, Nikos Aletras, Xi Wang, Han Zhou, Zaiqiao Meng. "A Comprehensive Survey of Self-Evolving AI Agents: A New Paradigm Bridging Foundation Models and Lifelong Agentic Systems." arXiv:2508.07407v2 [cs.AI], 31 Aug 2025. 55 pages.
**机构**: University of Glasgow; University of Sheffield; Mohamed bin Zayed University of AI; National University of Singapore; University of Cambridge; University College London; University of Aberdeen; Leiden University.
**arXiv**: https://arxiv.org/abs/2508.07407
**PDF**: papers/self-evolving-agents-survey2025.pdf
**Cluster**: Unified-but-non-social frameworks (Paper 1 §1/§2 — the "unified framework" foil)
**Status**: ✅ 全文已分析（2026-05-22）

## Core claim (一句话)
Agent systems remain static after deployment; the field's progress can be unified under a single feedback-loop framework (System Inputs → Agent System → Environment → Optimisers) that abstracts how agents *self-improve their own components* (LLM, prompts, memory, tools, workflows, inter-agent communication) toward lifelong, autonomous adaptation.

## 研究问题
How can the heterogeneous body of "agent evolution/optimisation" techniques be organised into a single conceptual structure, and what is the trajectory from static foundation models to lifelong self-evolving multi-agent systems? It surveys techniques per-component, per-domain (biomedicine, programming, finance), plus evaluation/safety/ethics.

## 方法与主要内容
- A **unified conceptual framework** abstracting the *feedback loop* of self-evolution into four components: **System Inputs, Agent System, Environment, Optimisers** (§3).
- A paradigm progression: MOP (Model Offline Pretraining) → MOA (Model Online Adaptation) → MAO (Multi-Agent Orchestration) → **MASE (Multi-Agent Self-Evolving)** (Table 1), each adding a tighter interaction/feedback channel.
- "Three Laws of Self-Evolving AI Agents" (Asimov-inspired): I. Endure (safety adaptation), II. Excel (performance preservation), III. Evolve (autonomous evolution) — explicitly hierarchical, safety-first.
- A taxonomy of optimisation across single-agent (reasoning, prompt, memory, tool), multi-agent (workflow topology, inter-agent communication), and domain-specific settings (§4–6); §5 covers optimising *communication mechanisms* but purely as a coordination/performance lever, not as social structure.
- Dedicated evaluation, safety, ethics discussion (§7–8). Positions itself against concurrent Gao et al. (2025b) "what/when/how to evolve" taxonomy as more integrative.

## 论文未覆盖的范围（我们的差异化基础）
| Dimension | This paper (Fang et al. 2025) | 我们的框架 (P/SC/N) |
|---|---|---|
| What "unifies" the field | A feedback loop for **self-improvement of capability** (the agent optimises its own internal components) | A **social-embedding** structure: collaboration **Protocol (P)**, quantified **Social Capital (SC)**, permissionless **Network (N)** |
| Object of optimisation | Internal components (LLM/prompt/memory/tool/workflow) so the agent performs tasks better | The agent's *position and standing* among other agents — role, reputation, accountability |
| Multi-agent view | Agents as collaborating **capability containers**; communication optimised for task coordination | Agents as **role-bearing social actors**; communication carries verifiable role/identity claims |
| Theoretical grounding | Engineering/ML (RL, optimisation, Asimov "laws" as safety heuristics) | Social science: Bourdieu/Putnam/Ostrom on social capital, institutional theory |
| Falsifiability target | Performance/adaptation metrics over time | **Falsifiable social predictions** (does verified social capital change cooperation outcomes in a permissionless net?) |
| Membership/entry | Closed, manually configured populations that then self-tune | **Permissionless** entry with social mechanisms governing trust |

## Paper 1 §2 区分段落（~180 词，英文）
Fang et al. (2025) exemplify the most ambitious *unified* framing of contemporary agent research: they abstract the entire field into a single feedback loop — System Inputs, Agent System, Environment, and Optimisers — and a paradigm ladder from offline pretraining to multi-agent self-evolution. We share their conviction that the field needs one integrative lens rather than a patchwork of point techniques. The decisive difference is *what the unification is about*. Their loop unifies **self-improvement of capability**: how an agent optimises its own LLM, prompts, memory, tools, and workflows to perform tasks better over time. Even their treatment of inter-agent communication is a coordination lever for task performance, and their guiding "Three Laws" are engineering safety heuristics. Our three-pillar framework instead unifies **social embedding**: a collaboration Protocol (P), quantified Social Capital (SC) drawing on Bourdieu, Putnam and Ostrom, and a permissionless Network (N). Where their agents are self-optimising capability containers, ours are role-bearing social actors whose standing, accountability, and trust are verifiable — yielding falsifiable *social* predictions rather than performance curves.

## Action items
- [ ] Cite in §1 as the canonical "self-evolution / capability-loop" paradigm that motivates the capability-vs-social-role contrast.
- [ ] Cite in §2 as the strongest example of a **unified-but-non-social** framework; use the framework-level contrast (their loop = self-improvement; ours = social embedding).
- [ ] Borrow their MOP→MOA→MAO→MASE ladder as a rhetorical setup: our shift is orthogonal (capability axis) vs. our social axis, not a further rung on theirs.
- [ ] Optionally reference their §5 (inter-agent communication optimisation) to sharpen that prior work treats communication as coordination, not social-role signalling.

## Jason's feedback
> （请在此处写入你的feedback）
