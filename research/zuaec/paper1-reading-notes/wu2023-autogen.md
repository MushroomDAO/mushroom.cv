# [Wu et al. 2023] AutoGen: Enabling Next-Gen LLM Applications via Multi-Agent Conversation
**Citation**: Qingyun Wu, Gagan Bansal, Jieyu Zhang, Yiran Wu, Beibin Li, Erkang Zhu, Li Jiang, Xiaoyun Zhang, Shaokun Zhang, Jiale Liu, Ahmed Awadallah, Ryen W. White, Doug Burger, Chi Wang. "AutoGen: Enabling Next-Gen LLM Applications via Multi-Agent Conversation." arXiv:2308.08155v2 [cs.AI], 3 Oct 2023.
**机构**: Microsoft Research; Pennsylvania State University; University of Washington; Xidian University
**arXiv**: https://arxiv.org/abs/2308.08155
**PDF**: papers/wu2023-autogen.pdf
**Cluster**: Multi-agent orchestration frameworks (capability-invocation baseline) → Paper 1 §2 contrast + §5; Paper 2 §2 baseline (conversation programming vs. social protocol)
**Status**: ✅ 全文已分析（2026-05-22）

## Core claim (一句话)
AutoGen is a generic open-source framework that lets *developers* build LLM applications by composing "conversable, customizable" agents whose interactions are specified through a new programming paradigm—conversation programming (computation + control flow)—unifying complex multi-agent workflows as message-passing chats.

## 研究问题
How can we facilitate development of LLM applications spanning broad domains/complexities via a multi-agent approach? Concretely, two design questions: (1) How to design individual agents that are capable, reusable, customizable, effective in multi-agent collaboration? (2) How to develop a straightforward, unified interface accommodating a wide range of conversation patterns (single/multi-turn, static/dynamic, varying human involvement)?

## 方法与主要内容
- **Two core abstractions.**
  1. **Conversable agents** — an entity with a developer-assigned "role" that sends/receives messages, maintains internal context from its message history, and is configured with capabilities backed by LLMs, tools, human input, or combinations. Roles ("code writer", "code executor", "critic", "user proxy") are configuration choices, not earned/social identities.
  2. **Conversation programming** — a paradigm centered on inter-agent conversations with two facets: *computation* (actions an agent takes to compute a reply) and *control flow* (the sequence/conditions of those computations). Both can be programmed via a fusion of natural language + code.
- **Design patterns / mechanisms.** Unified `send`/`receive`/`generate_reply` interfaces; an **auto-reply mechanism** that induces conversation flow without a central control plane (described by the authors as "decentralized, modular"—but this is software modularity, not a permissionless network); registerable custom reply functions; control by fusion of programming + natural language; static and dynamic conversation patterns (two-agent, group chat, hierarchical, joint).
- **Evaluation.** Empirical studies across six application clusters (math, coding/OptiGuide, QA/retrieval-augmented, online decision-making/ALFWorld, conversational chess, dynamic group chat). Reports improved task performance, reduced developer code, reduced manual effort vs. SOTA baselines.
- **Discussion.** Acknowledges it is early-stage; open directions include optimal agent topology/conversation patterns, the automation-vs-human-control balance, and emergent safety challenges as agent count grows.

## 论文未覆盖的范围（我们的差异化基础）
| Dimension | This paper (AutoGen) | 我们的框架 (P/SC/N) |
|---|---|---|
| Agent ontology | Capability container: a configurable LLM/tool/human wrapper that "converses". Identity = developer config. | Role-bearing social agent: persistent identity carrying a credential-bound social role. |
| Roles | Functional labels assigned at design time (planner, critic, executor). Not earned, not portable, not accountable. | Roles as social positions bound to credentials; earned, attestable, portable across the network. |
| Coordination (P) | Conversation programming: message-passing inside one developer's process; control flow set by the developer. | A **collaboration protocol (P)** for multi-party coordination across organizational boundaries—not a single app's chat loop. |
| Social capital (SC) | None. No reputation, trust, history, or quantified standing accrues to an agent across tasks/apps. | **Quantified social capital (SC)** (Bourdieu/Putnam/Ostrom) — reputation/trust accumulated and measurable. |
| Network (N) | Closed: agents live in one developer-controlled program. "Decentralized" = software modularity (auto-reply, no control plane), NOT permissionless entry. | **Permissionless network (N)**: open membership, no central orchestrator gating who participates. |
| Accountability / identity persistence | None across sessions; no cross-app identity, no ZK reputation, no sanction mechanism. | Credential/ZK-reputation binding; identity and accountability persist and travel. |
| Governance | Developer is sole authority; humans optionally in the loop within the app. | Network-level governance; permissionless multi-party participation. |

## Paper 1 区分段落（~150-200词，英文）
AutoGen is the canonical instantiation of the *capability-invocation* paradigm our work seeks to transcend. Its agents are "conversable, customizable" units—wrappers around LLMs, tools, or humans—whose "roles" are configuration choices a single developer assigns at design time, not social positions an agent earns, carries, and is held accountable for. Coordination is "conversation programming": message-passing and control flow scripted within one developer-owned process. While the authors call the auto-reply mechanism "decentralized and modular," this denotes software modularity, not a permissionless network: there is no open membership, no central-authority-free entry, and no identity that persists or travels beyond the host application. Crucially, AutoGen has no notion of social capital—no reputation, trust, or standing accrues to an agent across tasks, and no sanction or accountability mechanism exists. Our framework reframes the agent from a capability container into a role-bearing social actor and supplies the three pillars AutoGen lacks: a multi-party collaboration **protocol (P)** spanning organizational boundaries, **quantified social capital (SC)** grounded in Bourdieu/Putnam/Ostrom, and a **permissionless network (N)** with portable, credential-bound identity.

## Action items
- [ ] Cite in Paper 1 §2 as the defining "conversation programming" / capability-container baseline; quote "conversable, customizable" + "roles assigned by developer".
- [ ] Cite in Paper 1 §5 when contrasting software-modular "decentralization" (auto-reply, no control plane) vs. our permissionless network N.
- [ ] Cite in Paper 2 §2 as the conversation-programming protocol baseline AGAINST which ASM (role/credential binding, ZK reputation, permissionless multi-party) is positioned.
- [ ] Use AutoGen's own "future safety challenges as agents grow" admission to motivate the need for accountability/SC at the network layer.

## Jason's feedback
> （请在此处写入你的feedback）
