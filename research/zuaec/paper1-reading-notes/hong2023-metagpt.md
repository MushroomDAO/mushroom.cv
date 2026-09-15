# [Hong et al. 2023] MetaGPT: Meta Programming for a Multi-Agent Collaborative Framework
**Citation**: Sirui Hong, Mingchen Zhuge, Jiaqi Chen, Xiawu Zheng, Yuheng Cheng, Ceyao Zhang, Jinlin Wang, Zili Wang, Steven Ka Shing Yau, Zijuan Lin, Liyang Zhou, Chenyu Ran, Lingfeng Xiao, Chenglin Wu, Jürgen Schmidhuber. "MetaGPT: Meta Programming for a Multi-Agent Collaborative Framework." arXiv:2308.00352v7 [cs.AI], 1 Nov 2024. Published as a conference paper at ICLR 2024.
**机构**: DeepWisdom; AI Initiative, King Abdullah University of Science and Technology (KAUST); Xiamen University; The Chinese University of Hong Kong, Shenzhen; Nanjing University; University of Pennsylvania; UC Berkeley; The Swiss AI Lab IDSIA/USI/SUPSI
**arXiv**: https://arxiv.org/abs/2308.00352
**PDF**: papers/hong2023-metagpt.pdf
**Cluster**: Old-Paradigm (multi-agent collaboration framework) — Paper 1 §2/§3 contrast; Paper 2 §2 baseline (structured communication protocol)
**Status**: ✅ 全文已分析（2026-05-22）

## Core claim (一句话)
MetaGPT is a meta-programming framework that injects human-team Standardized Operating Procedures (SOPs) into LLM-based multi-agent collaboration—encoding SOPs into prompt sequences, assigning specialized roles (Product Manager, Architect, Project Manager, Engineer, QA Engineer) along an "assembly line," and forcing structured (document/diagram) outputs—to reduce cascading hallucinations and achieve SOTA on software-engineering code generation.

## 研究问题
Existing LLM multi-agent systems handle simple dialogue but break down on complex tasks because naively chaining LLMs causes logic inconsistencies and cascading hallucinations (e.g., agents producing "idle chatter" rather than coherent deliverables). How can human-developed SOPs—which decompose tasks, define member responsibilities, and standardize intermediate outputs—be encoded into multi-agent LLM workflows to make collaboration coherent, accurate, and robust?

## 方法与主要内容
- **Specialization of roles (§3.1).** Five roles are *defined by the framework designer*. Each agent is given a profile = {name, profile, goal, constraints} plus initialized context and skills (e.g., PM can web-search; Engineer can execute code). All agents follow ReAct-style behavior and monitor a shared message pool.
- **Workflow across agents.** A fixed sequential SOP: user requirement → PM writes PRD (user stories, requirement pool) → Architect produces system design (file lists, data structures, interface defs) → Project Manager distributes tasks → Engineer implements → QA Engineer writes tests. Output is a complete software artifact.
- **Communication protocol (§3.2).** (1) **Structured communication interfaces** — each role has a fixed schema/format; agents communicate via documents and diagrams (not free dialogue) to avoid "telephone-game" distortion. (2) **Publish-subscribe mechanism** — a global shared message pool; agents publish structured messages and subscribe to information relevant to their role profile, activating an action only once all prerequisite dependencies arrive.
- **Iterative programming with executable feedback (§3.3).** Engineer writes + runs unit tests, reads results, and self-debugs (up to 3 retries) using execution/debugging memory.
- **Evaluation.** HumanEval (Pass@1 85.9%), MBPP (Pass@1 87.7%) — SOTA; plus a self-built SoftwareDev benchmark (70 tasks). Beats ChatDev on executability (3.75/4), runtime, code statistics, productivity (124.3 vs 248.9 tokens/line), and human-revision cost (0.83 vs 2.5). Ablation: adding roles beyond a lone Engineer improves executability and reduces revisions. Executable feedback adds +4.2%/+5.4% Pass@1.
- **Outlook (Appendix A).** Discusses (early-stage) self-improvement: agents recursively rewrite their *constraint prompts* from prior-project feedback stored in long-term memory — but only constraints in role specialization, not the communication interfaces. Also sketches "multi-agent economies" / AgentStore where agents list priced services and users subscribe and pay per usage (NLSOM "Economy of Minds" credit assignment). Note: this is a within-platform marketplace, not a permissionless network or earned social capital.

## 论文未覆盖的范围（我们的差异化基础）
| Dimension | This paper (MetaGPT) | 我们的框架 (P/SC/N) |
|---|---|---|
| Agent ontology | Capability container with a more sophisticated wrapper: a role = {name, profile, goal, constraints} + an SOP slot on an assembly line. | Role-bearing social agent: persistent identity carrying a credential-bound social role. |
| Roles | **SOP roles assigned at design time** by the framework author (PM/Architect/Engineer/QA). Fixed, non-portable, non-earned. An agent IS its SOP slot; remove the slot and the "role" vanishes. | Roles as social positions **earned** and attested via credentials; portable and accountable across the network. |
| Coordination (P) | Fixed sequential SOP workflow + structured-document handovers + pub/sub message pool — coordination is hardcoded into the framework by one designer. | A **collaboration protocol (P)** for open multi-party coordination across organizational boundaries, not a designer-fixed pipeline. |
| Social capital (SC) | None. No reputation, trust, or standing accrues to an agent across projects. The self-improvement loop adjusts private constraint prompts, not any shared social ledger. | **Quantified social capital (SC)** (Bourdieu/Putnam/Ostrom) — reputation/trust accumulated and measurable. |
| Network (N) | Closed simulated "software company" inside one process. AgentStore/EOM is a within-platform priced marketplace, NOT permissionless entry. | **Permissionless network (N)**: open membership, no central designer gating who participates or what role they hold. |
| Identity persistence / accountability | None across companies/projects; no cross-platform identity, no reputation, no sanction. Memory is project-local. | Credential/ZK-reputation binding; identity and accountability persist and travel. |
| Governance | Framework designer is sole authority; SOP is fixed (paper notes real teamwork SOPs "change dynamically" — left as future work). | Network-level governance; permissionless multi-party participation with dynamic role negotiation. |

## Paper 1 §2 区分段落（~150-200词，英文）
MetaGPT represents the most sophisticated form of the *role-as-configuration* paradigm: rather than a generic chat loop, it encodes human Standardized Operating Procedures (SOPs) into a fixed assembly-line workflow, assigning each agent a structured profile (name, goal, constraints) and a slot—Product Manager, Architect, Engineer, QA—on the production line. This is a marked advance over CAMEL's two-role dialogue, yet the role remains *design-time assigned by the framework author*: the agent simply *is* its SOP slot. There is no persistent identity that survives across companies, no reputation or trust that accrues from past performance, and no sanction mechanism—the self-improvement loop (Appendix A) only rewrites an agent's private constraint prompts, never a shared social ledger. Even the AgentStore "economy of minds" is a within-platform priced marketplace, not permissionless membership. Our framework reframes the agent from an SOP-bound capability container into a role-bearing social actor and supplies the three pillars MetaGPT lacks: a cross-boundary collaboration **protocol (P)** (vs. one designer's fixed pipeline), **quantified social capital (SC)** grounded in Bourdieu/Putnam/Ostrom, and a **permissionless network (N)** with portable, credential-bound, earned social roles. SOP role ≠ earned social role.

## Action items
- [ ] Cite in Paper 1 §2 as the canonical SOP-driven framework; make precise that an SOP role is design-time assigned and non-portable (contrast with CAMEL: more structure, same paradigm).
- [ ] Cite in Paper 1 §3 (methodology contrast) for the structured-communication-interface + pub/sub message-pool design — frame as protocol-as-software vs. our social collaboration protocol P.
- [ ] Cite in Paper 2 §2 as a structured-communication protocol baseline (schema + shared message pool, no identity/reputation layer) against which ASM is positioned.
- [ ] Use MetaGPT's own admission that real teamwork SOPs "change dynamically" (Appendix A.2) and that self-improvement only edits private constraints — to motivate the need for network-level, earned, dynamic social roles.

## Jason's feedback
> （请在此处写入你的feedback）
