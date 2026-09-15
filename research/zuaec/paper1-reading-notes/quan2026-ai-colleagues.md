# [Quan et al. 2026] Towards AI as Colleagues: Multi-Agent System Improves Structured Ideation Processes
**Citation**: Kexin Quan, Dina Albassam, Mengke Wu, Zijian Ding, Jessie Chin. "Towards AI as Colleagues: Multi-Agent System Improves Structured Ideation Processes." In Proc. CHI '26, Apr 13–17 2026, Barcelona, Spain. ACM. arXiv:2510.23904v2 [cs.HC], 31 Jan 2026. https://doi.org/10.1145/3772318.3790375
**机构**: University of Illinois Urbana-Champaign (Information Sciences / CS); University of Maryland College Park (College of Information)
**arXiv**: https://arxiv.org/abs/2510.23904
**PDF**: papers/quan2026-ai-colleagues.pdf
**Cluster**: HCI / human–AI collaboration (social-role SUPPORT from the HCI side) → Paper 1 §1 (motivation) + §4 (social-role thesis support)
**Status**: ✅ 全文已分析（2026-05-22）

> **Title note**: Final/exact title is **"Towards AI as Colleagues: Multi-Agent System Improves Structured Ideation Processes."** The word "Professional" is NOT in the title. The system is named **MultiColleagues**.

## Core claim (一句话)
A within-subjects HCI study (N=20) shows that a multi-agent conversational system (MultiColleagues) whose role-differentiated AI personas converse with each other and proactively involve the user makes AI feel less like a *tool* and more like a *colleague*—yielding stronger perceived social presence, higher perceived idea quality/novelty, and more engagement than a single-agent baseline.

## 研究问题
- RQ1: How do role-taking patterns and perceptions of social presence shape collaborative atmosphere and user engagement?
- RQ2: How does exposure to multiple AI-colleague perspectives influence ideation processes and perceived outcome quality/novelty?
- RQ3: How do system design features support or constrain users during creative ideation?

## 方法与主要内容
- **System: MultiColleagues.** Multi-agent conversational system for co-ideation. Role-differentiated personas (e.g., User Researcher, System Architect, Market Analyst) plus a **Facilitator** ("facilitator-in-chief" = the human user). Three design goals: (1) support divergent↔convergent shifts (Explore/Focus modes), (2) engage diverse viewpoints, (3) preserve human oversight. Features: dynamic turn selection, persona personalities, structured message threading, word limits, thinking-mode controls.
- **Study.** Within-subjects, 20 participants (mostly students / early-career), single ~10-min session, compared MultiColleagues vs. a state-of-the-art single-agent baseline ("AI as tool" model). LLM-based judge used for idea originality.
- **Results.** MultiColleagues → stronger team-like feeling and social presence; nearly 2× utterances, longer sessions, more words; higher perceived outcome quality and novelty; more time per idea; stronger perceived control / adaptive thinking-mode support. Cost: occasional conversational drift from agent autonomy.
- **Design implications (6).** Framed explicitly as the transition "**From AI as Tools to AI as Colleagues**" — toward "proactive, accountable, and socially embedded colleagues." Includes proactive colleagues, moving from occupational role-play to domain-expert teamwork, calibrated trust, and—critically—the call to "establish ethical frameworks that safeguard **accountability** while enabling AI to act as trusted partners." Notes risk of "moral crumple zones" where responsibility becomes diffused and no actor is accountable.
- **Positioning vs. our baselines.** Explicitly cites AutoGen [121] and CAMEL [64] as multi-agent frameworks that "operationalize LLMs as differentiated collaborators" but evaluate mostly on benchmarks rather than interactive use.

## 论文未覆盖的范围（我们的差异化基础）
| Dimension | This paper (MultiColleagues) | 我们的框架 (P/SC/N) |
|---|---|---|
| What "colleague" means | A *perceived* social experience—measured subjectively (social presence, team feeling) in a 10-min lab session. | A *structurally enforced* social role—identity + role bound to credentials, persisting and accountable beyond any single session. |
| Roles / personas | Prompt-instantiated personas (all from one LLM), differentiated by occupation; ephemeral, app-local. | Credential-bound, earned, portable roles attestable across the network. |
| Accountability | Named as an OPEN PROBLEM ("moral crumple zones", needs "ethical frameworks"); no mechanism provided. | Concrete mechanism: credential/ZK-reputation binding makes agents identifiable, sanctionable, accountable. |
| Coordination (P) | A facilitator UI inside one closed application; human is "facilitator-in-chief". | A multi-party **collaboration protocol (P)** across organizational boundaries, no single host app. |
| Social capital (SC) | Social presence is *felt*, not *quantified or accrued*; no reputation persists. | **Quantified social capital (SC)** (Bourdieu/Putnam/Ostrom) — measurable, accumulating reputation/trust. |
| Network (N) | Closed lab prototype; fixed pool of ~9 personas from the same model; user picks from a menu. | **Permissionless network (N)**: open entry of independent role-bearing agents. |
| Persistence | Single short session; explicitly flagged as limitation (no long-term, no large/persistent teams). | Persistent cross-task identity and standing. |

## Paper 1 区分段落（~150-200词，英文）
Quan et al. provide strong *empirical, HCI-side* support for our central thesis: that there is genuine value in treating AI agents as social colleagues rather than as capability containers. Their within-subjects study shows that when role-differentiated agents converse and proactively involve the user, people experience stronger social presence, richer engagement, and higher perceived idea quality—evidence that the "social role" framing is not merely rhetorical. Yet their contribution is *phenomenological, not infrastructural*: "colleague-ness" is a subjective experience elicited in a ten-minute single-application lab session, produced by prompt-instantiated personas (all from one model) that hold no persistent identity, accrue no reputation, and travel to no other context. Tellingly, the authors themselves flag accountability as an unsolved problem—warning of "moral crumple zones" and calling for ethical frameworks—without supplying any mechanism. Our framework converts their *felt* colleague experience into a *structural* one by adding the three pillars they lack: a multi-party collaboration **protocol (P)**, **quantified social capital (SC)** grounded in Bourdieu/Putnam/Ostrom, and a **permissionless network (N)** with credential/ZK-bound, accountable identity.

## Action items
- [ ] Cite in Paper 1 §1 as motivation: HCI evidence that the "AI as colleague" (social-role) framing measurably improves collaboration → validates our paradigm shift.
- [ ] Cite in Paper 1 §4 as SUPPORT, then sharpen the gap: they show colleague-ness is *felt*; we make it *structural* (P/SC/N). Quote "From AI as Tools to AI as Colleagues" and "proactive, accountable, and socially embedded."
- [ ] Use their own accountability gap ("moral crumple zones", "establish ethical frameworks") as the explicit hook for SC + credential/ZK accountability.
- [ ] Note their limitations (single short session, one model, small fixed team) as the empirical opening our persistence + permissionless-network design fills.

## Jason's feedback
> （请在此处写入你的feedback）
