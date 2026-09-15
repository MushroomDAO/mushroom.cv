# [Wang et al. 2025] A Survey on Large Language Model based Autonomous Agents

**Citation**: Lei Wang, Chen Ma, Xueyang Feng, Zeyu Zhang, Hao Yang, Jingsen Zhang, Zhi-Yuan Chen, Jiakai Tang, Xu Chen, Yankai Lin, Wayne Xin Zhao, Zhewei Wei, Ji-Rong Wen. "A Survey on Large Language Model based Autonomous Agents." *Frontiers of Computer Science*, 2025, 18(6): 186345. DOI: 10.1007/s11704-024-40231-1. arXiv:2308.11432v7 [cs.AI], 2 Mar 2025 (v1 Aug 2023). 42 pages.
**机构**: Gaoling School of Artificial Intelligence, Renmin University of China, Beijing
**arXiv**: https://arxiv.org/abs/2308.11432
**PDF**: papers/wang2024-autonomous-agents-survey.pdf
**Cluster**: Old-Paradigm / Capability Invocation — Paper 1 §1/§2 contrast
**Status**: ✅ 全文已分析（2026-05-22）

## Core claim (一句话)
LLM-based autonomous agents can be unified under a single architecture of four capability modules — **Profile, Memory, Planning, Action** — and the field is best organized around the *construction, application, and evaluation* of such agents.

## 研究问题
This is a scoping/taxonomy survey, not a hypothesis-testing paper. It asks: (1) How to design an agent **architecture** that best leverages an LLM as central controller? (2) How to **acquire/enhance** the agent's task capabilities (with vs. without fine-tuning)? (3) Where are these agents **applied** (social/natural science, engineering) and how are they **evaluated** (subjective + objective)? (4) What challenges and future directions remain?

## 方法与主要内容
- **Unified architecture (§2, the canonical figure)**: four modules.
  - *Profile module* — "identify the role of the agent": demographic, personality, social info; built via Handcrafting / LLM-Generation / Dataset-Alignment. Crucially, the profile is written *into the prompt* to steer LLM behavior.
  - *Memory module* — short-term (in-context) vs long-term (external vector store); structures (unified/hybrid), formats, operations (reading/writing/reflection).
  - *Planning module* — w/o feedback (single-/multi-path reasoning, external planner) vs w/ feedback (environment/human/model feedback).
  - *Action module* — action target, production (memory recollection / plan following), impact; action space includes tools, databases, self-knowledge.
- **Capability acquisition**: fine-tuning vs prompt-engineering (mechanism feedback, human feedback) strategies.
- **Applications**: social science (sims, propaganda, policy), natural science, engineering (incl. multi-agent code-gen like ChatDev, MetaGPT, Self-collaboration).
- **Evaluation**: subjective (human/Turing-style) + objective (metrics, benchmarks incl. multi-agent collaboration/coordination tasks).
- **Challenges (§6)**: role-playing capability, generalized human alignment, prompt robustness, hallucination, knowledge boundary, efficiency.

## 论文未覆盖的范围（我们的差异化基础）

| Dimension | This paper (Wang 2025) | 我们的框架 (P/SC/N) |
|---|---|---|
| What "role" means | A *profile* string injected into the prompt to bias the LLM ("you are a coder"). Role = prompt-time persona, no persistence, no external accountability. | **Social-role agency**: a role-bearing agent with verifiable principal identity; role is enforced/recognized by a network, not just prompted. |
| Identity | None. The agent has no verifiable principal identity; "self-awareness" is named only as a *challenge* (§6.1), not a design primitive. | Verifiable principal identity is foundational — distinguishes a social-role agent from an invocable container. |
| Inter-agent relations | Treated as one of several profile fields ("social information") and as application-layer multi-agent collaboration (ChatDev etc.) — engineered, task-scoped, centrally orchestrated. | **(P) Collaboration Protocols**: open, role-aware coordination as first-class infrastructure, not an application convenience. |
| Trust / reputation / social standing | Absent. No notion of accumulated social capital, reputation, or trust assets across interactions. | **(SC) Quantified Social Capital** (Bourdieu/Putnam/Ostrom): trust and standing are measured, accumulated, portable. |
| Network membership | Closed, designer-defined agent sets; collaboration is hand-wired per application. | **(N) Permissionless Network**: open entry/exit, no central orchestrator. |
| Governance / norms | Out of scope; "alignment" is single-LLM value alignment, not collective norms. | Norms/governance via Ostrom-style institutions over a permissionless network. |

## Paper 1 §2 区分段落（~150-200词，英文）
Wang et al. (2025) provide the canonical synthesis of the LLM-agent field, distilling a large body of work into a single, influential architecture: a **Profile–Memory–Planning–Action** stack with the LLM as central controller. This is an authoritative and well-organized portrait, and we adopt it as the reference description of the *capability-invocation paradigm*. Tellingly, the survey treats an agent's "role" as a **profile module** — text written into the prompt to bias the model's behavior — and inter-agent "social information" as merely one optional profile field. Identity, self-awareness, and norm-governed cooperation appear only as open *challenges* (§6.1 role-playing, §6.2 generalized alignment), never as architectural primitives. Thus the agent is fundamentally an **invocable capability container**: a configurable problem-solver whose collaboration is hand-wired per application, with no verifiable principal identity, no portable social standing, and no permissionless network. Our framework supersedes this capability-positioning with a **social-role positioning**: agents as role-bearing principals coordinated through (P) Collaboration Protocols, accountable via (SC) Quantified Social Capital, on an (N) Permissionless Network — precisely the dimensions Wang et al.'s taxonomy leaves unaddressed.

## Action items
- [ ] Cite in §2 as the canonical "old-paradigm" reference; reproduce/redraw the Profile-Memory-Planning-Action figure as the capability-paradigm baseline.
- [ ] Cite §6.1 (role-playing as challenge) + §6.2 (generalized alignment) as evidence that the field itself flags identity/norms as *unsolved*, motivating our social-role pillar.
- [ ] Use the "profile = prompt string" framing in §1 to introduce the capability-container vs social-role-agent contrast.

## Jason's feedback
> （请在此处写入你的feedback）
