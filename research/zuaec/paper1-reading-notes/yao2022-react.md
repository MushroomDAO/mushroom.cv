# [Yao et al. 2023] ReAct: Synergizing Reasoning and Acting in Language Models

**Citation**: Shunyu Yao, Jeffrey Zhao, Dian Yu, Nan Du, Izhak Shafran, Karthik Narasimhan, Yuan Cao. "ReAct: Synergizing Reasoning and Acting in Language Models." Published as a conference paper at ICLR 2023. arXiv:2210.03629v3 [cs.CL], 10 Mar 2023 (v1 Oct 2022). Project page: https://react-lm.github.io/.
**机构**: Department of Computer Science, Princeton University (Yao, Narasimhan); Google Research, Brain team (Zhao, Yu, Du, Shafran, Cao)
**arXiv**: https://arxiv.org/abs/2210.03629
**PDF**: papers/yao2022-react.pdf
**Cluster**: Old-Paradigm / Capability Invocation — Paper 1 §1/§2 contrast (capability root)
**Status**: ✅ 全文已分析（2026-05-22）

## Core claim (一句话)
Interleaving verbal **reasoning traces** ("Thoughts") with **task-specific actions** in a single LLM prompt creates a synergy — reasoning helps induce/track/update action plans and handle exceptions, while acting lets the model gather external information — that beats reasoning-only (CoT) or acting-only baselines on QA, fact verification, and interactive decision-making.

## 研究问题
Can reasoning (CoT) and acting (action/plan generation), previously studied separately, be **combined synergistically** in a single LLM to improve general task solving, reduce hallucination/error-propagation, and improve interpretability — using only few-shot prompting?

## 方法与主要内容
- **Mechanism (§2)**: Given an agent interacting with an environment (observation o_t, action a_t under policy π), ReAct **augments the action space** to Â = A ∪ L, where L is the space of language. A "thought" â_t ∈ L is a *reasoning action* that does NOT affect the environment (no observation feedback); it only updates the internal context c_{t+1} = (c_t, â_t) to support future reasoning/acting. Thoughts can decompose goals, inject commonsense, extract observation info, track progress, handle exceptions.
- **Setup**: few-shot in-context prompting (1–2 examples), no fine-tuning for main results.
- **Benchmarks**: HotpotQA (multi-hop QA), Fever (fact verification) — both with a simple Wikipedia API (search/lookup/finish); ALFWorld (text game), WebShop (web navigation).
- **Results**: On HotpotQA/Fever, ReAct overcomes CoT's hallucination + error propagation by grounding in retrieved facts; best overall is ReAct+CoT (internal + external knowledge). On ALFWorld/WebShop, 1–2-shot ReAct beats imitation/RL trained on 10^3–10^5 instances by +34% and +10% absolute success. Reasoning+acting also improves interpretability, trustworthiness, diagnosability (humans can separate internal knowledge from external evidence and inspect the trace).

## 论文未覆盖的范围（我们的差异化基础）

| Dimension | This paper (ReAct) | 我们的框架 (P/SC/N) |
|---|---|---|
| Unit of analysis | A **single agent** solving a task by itself; "synergy" is internal (reasoning ↔ acting), not social. | A network of role-bearing agents; synergy is *social/inter-agent*. |
| What is augmented | The agent's **action space** (add a language/thought action) — a pure capability augmentation. | The agent's **social standing & role**, not just its action repertoire. |
| Identity / principal | None. The agent is anonymous, stateless across tasks, accountable to no one; it is a prompt configuration. | Verifiable principal identity; the agent acts *on behalf of* a principal and is accountable. |
| Collaboration | No multi-agent dimension whatsoever; "acting" = calling a Wikipedia API or moving in a game. Tools are passive resources. | **(P) Collaboration Protocols**: agents coordinate as social peers, not just call APIs. |
| Social capital / trust | "Trustworthiness" = human *interpretability* of one trace (can I read the reasoning?), NOT social trust/reputation accumulated over interactions. | **(SC) Quantified Social Capital**: trust as a measurable, accumulated, portable asset. |
| Network | None; closed task environment, no entry/exit, no peers. | **(N) Permissionless Network**: open, no central orchestrator. |

## Paper 1 §2 区分段落（~150-200词，英文）
Yao et al. (2023) introduce ReAct, the seminal and elegantly simple paradigm that interleaves verbal reasoning "thoughts" with task actions inside a single LLM, formalized as augmenting the action space Â = A ∪ L with language actions that update internal context without touching the environment. ReAct is rightly foundational: it demonstrably reduces hallucination, beats reasoning-only and acting-only baselines, and improves human interpretability — and it is the direct ancestor of the tool-use/action loop in nearly every modern agent. We treat it as the **capability root** of the invocation paradigm. Yet ReAct's entire frame is a *single agent augmenting its own problem-solving capability*: "acting" means calling a Wikipedia API or moving in a game, "trustworthiness" means a human can read one reasoning trace, and there is no notion of a verifiable principal, peer agents, accumulated reputation, or an open network. Our framework moves orthogonally — from augmenting a lone agent's capabilities to positioning agents as role-bearing social principals coordinated by (P) Collaboration Protocols, held accountable through (SC) Quantified Social Capital, on an (N) Permissionless Network.

## Action items
- [ ] Cite in §1 as the lineage/root of the capability-invocation loop (reason+act → tool use).
- [ ] Cite in §2 to make the precise contrast: ReAct's "augment the action space" vs our "augment social role/standing"; ReAct's "trustworthiness = trace readability" vs our SC = accumulated social trust.
- [ ] Note the absence of any multi-agent/identity dimension as the clearest single-agent foil to (P) and (N).

## Jason's feedback
> （请在此处写入你的feedback）
