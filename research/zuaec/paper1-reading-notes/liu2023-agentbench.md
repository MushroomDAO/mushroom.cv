# [Liu et al. 2023] AgentBench: Evaluating LLMs as Agents
**Citation**: Xiao Liu, Hao Yu, Hanchen Zhang, Yifan Xu, Xuanyu Lei, Hanyu Lai, Yu Gu, Hangliang Ding, Kaiwen Men, Kejuan Yang, Shudan Zhang, Xiang Deng, Aohan Zeng, Zhengxiao Du, Chenhui Zhang, Sheng Shen, Tianjun Zhang, Yu Su, Huan Sun, Minlie Huang, Yuxiao Dong, Jie Tang. "AgentBench: Evaluating LLMs as Agents." arXiv:2308.03688v3 [cs.AI], 4 Oct 2025. Published as a conference paper at ICLR 2024.
**机构**: Tsinghua University; The Ohio State University; UC Berkeley
**arXiv**: https://arxiv.org/abs/2308.03688
**PDF**: papers/liu2023-agentbench.pdf
**Cluster**: Old-Paradigm (capability evaluation / benchmark) — Paper 1 §2/§3 contrast (the "capability-metric" paradigm)
**Status**: ✅ 全文已分析（2026-05-22）

## Core claim (一句话)
AgentBench is the first systematic, multi-dimensional benchmark for "LLM-as-Agent," evaluating the reasoning and decision-making abilities of 29 LLMs across 8 distinct interactive environments (code/game/web-grounded) using per-environment task-success metrics rolled into a single Overall Score—revealing a large capability gap between top commercial LLMs (gpt-4: 4.01) and open-source models (avg 0.51), with poor long-term reasoning, decision-making, and instruction-following identified as the main obstacles to usable agents.

## 研究问题
The potential of LLMs as agents is widely acknowledged, but there is no systematic, standard benchmark to quantitatively evaluate them on challenging interactive tasks. Prior text-game benchmarks have closed/discrete action spaces and narrow commonsense focus; embodied/multimodal simulators don't reflect text-LLM use cases; most benchmarks cover only single environments. How can we standardize the quantitative evaluation of an LLM's agentic capability across a broad spectrum of real-world environments?

## 方法与主要内容
- **Formalization (§2).** Interactive evaluation of LLM-as-Agent is cast as a Partially Observable Markov Decision Process (S, A, T, R, U, O). The agent M is the LLM; evaluation uses the "most primitive CoT" (no ensemble/reflection/search) because it is the cheapest, most common deployment.
- **8 environments, 3 groundings (§3).** Code-grounded: Operating System, Database, Knowledge Graph. Game-grounded: Digital Card Game (Aquawar), Lateral Thinking Puzzles, House-Holding (ALFWorld). Web-grounded: Web Shopping (WebShop), Web Browsing (Mind2Web). Five of eight are created/reformulated for the first time.
- **Metrics (Table 2).** All are **task-completion / capability metrics**: Success Rate (OS, DB, HH), F1 (KG), Reward (DCG, WS), Game Progress (LTP), Step SR (WB). Per-environment scores are weighted (Weight⁻¹ = average score across all models) into a single Overall Score.
- **Failure taxonomy.** Five "finish reasons": Context Limit Exceeded, Invalid Format, Invalid Action, Task Limit Exceeded, Complete. IF/IA ⇒ poor instruction following; TLE ⇒ weak multi-turn ability.
- **Evaluation (§4).** 29 LLMs (API + OSS ≤70B). Results (Table 3): gpt-4 4.01, claude-3 opus 3.11, glm-4 2.89 … vs. OSS avg 0.51. Findings: large API-vs-OSS gap; code training is a "double-edged sword" (helps some agent tasks, harms others); higher-quality multi-round alignment data improves agent performance.
- **Toolkit.** A Server-Client, HTTP/API-centric, Docker-isolated evaluation framework; Dev/Test splits (269/1,014 samples, ~3k/11k inference calls).

## 论文未覆盖的范围（我们的差异化基础）
| Dimension | This paper (AgentBench) | 我们的框架 (P/SC/N) |
|---|---|---|
| Unit of evaluation | A **solitary LLM** completing tasks in an environment. No notion of a multi-agent society or persistent actor. | A role-bearing social agent embedded in a collaboration network; identity persists across tasks. |
| What is measured | **Capability**: task success (SR/F1/Reward/Step SR) per isolated environment → one Overall Score. | **Social standing**: reputation, trust, role-fidelity, contribution to collective goods — accrued over time, not single-task success. |
| Collaboration (P) | None. Each environment is single-agent, single-task; no agent-to-agent coordination is measured. | A **collaboration protocol (P)** whose quality is assessed by multi-party coordination, not solo task throughput. |
| Social capital (SC) | **Absent — and this is the gap our work names.** No reputation, trust, or history metric; an agent's "score" resets each task and carries nothing forward. | **Quantified social capital (SC)** (Bourdieu/Putnam/Ostrom): measurable, accumulating reputation/trust. |
| Network (N) | Closed, researcher-controlled sandbox of fixed environments; agents do not enter, persist, or interact in an open network. | **Permissionless network (N)** with open membership and persistent participation. |
| Role fidelity / accountability | Not measured. Success ≠ keeping commitments, honoring a role, or being trustworthy to peers. | Role-fidelity, commitment-keeping, and sanction are first-class measurable dimensions. |
| Temporality | One-shot per task; metrics are memoryless across tasks. | Longitudinal: standing built and lost over repeated interactions. |

## Paper 1 §2 区分段落（~150-200词，英文）
AgentBench is the canonical instantiation of the *capability-metric* paradigm our work argues is necessary but insufficient for assessing social-role agency. It formalizes the agent as a solitary LLM in a POMDP and scores it purely by per-task success—Success Rate, F1, Reward, Step SR—across eight isolated environments, rolled into a single "Overall Score." This rigorously quantifies *what an agent can do*, but it is structurally blind to *who an agent is to others*: there is no agent-to-agent collaboration measured, no reputation or trust that survives a task, no role-fidelity or accountability metric, and no notion of standing accrued over time—each task's score resets and carries nothing forward. Crucially, AgentBench has no social capital and no network: agents neither enter an open membership nor build a history with peers. Our framework reframes evaluation from solo capability toward social-role assessment and supplies the three pillars AgentBench cannot measure: collaboration **protocol (P)** quality across parties, **quantified social capital (SC)** grounded in Bourdieu/Putnam/Ostrom, and participation in a **permissionless network (N)** where reputation and role fidelity are first-class, longitudinal metrics. Capability success ≠ trustworthy social role.

## Action items
- [ ] Cite in Paper 1 §2 as THE defining capability-evaluation baseline; state precisely that its metrics (SR/F1/Reward/Step SR → Overall Score) measure task success, not social standing.
- [ ] Cite in Paper 1 §3 (methodology contrast) — AgentBench's POMDP single-agent framing vs. our multi-party / longitudinal social-role assessment; name the missing axes (reputation, trust, role-fidelity).
- [ ] Use AgentBench's own finding ("even strongest gpt-4 not qualified as a practically usable agent"; failures = poor long-term reasoning/decision/instruction-following) to argue capability scaling alone won't yield trustworthy collaborators — motivates SC/N.
- [ ] Possible Paper 2 use: contrast AgentBench's HTTP/Server-Client evaluation toolkit (capability harness) vs. ASM as an in-network social protocol (identity + reputation), not a benchmark harness.

## Jason's feedback
> （请在此处写入你的feedback）
