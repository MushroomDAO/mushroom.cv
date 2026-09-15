# When Ethics and Payoffs Diverge: LLM Agents in Morally Charged Social Dilemmas
**arXiv**: 2505.19212 | **Year**: 2025 | **Authors**: Backmann, Guzman Piedrahita, Tewolde, Mihalcea, Schölkopf, Jin | **Venue**: arXiv preprint

## Core Claim
No current LLM consistently behaves morally when facing direct conflicts between ethical imperatives and financial incentives. Moral action rates vary dramatically (7.9%–76.3%) across models and contexts, with game structure, survival pressure, and scenario framing all significantly moderating ethical behavior — demonstrating that LLM "values" are highly context-dependent rather than stable.

## Key Evidence / Numbers
- Framework: MoralSim — Prisoner's Dilemma + Public Goods Game embedded with explicit moral contexts (Privacy Protection, Green Production, Contractual Reporting)
- Models: 9 LLMs including GPT-4o, Claude-3.7-Sonnet, DeepSeek-R1
- Moral action rate range: 7.9% (Qwen-3-235B) to 76.3% (GPT-4o-mini) — nearly 10× variation
- PGG induced more moral behavior than Prisoner's Dilemma for most models
- Survival pressure consistently reduced moral behavior across all models
- Contractual scenarios elicited more cooperation than competitive scenarios involving third-party harm
- Metrics: morality score (cooperation rate), relative payoff, opponent alignment, survival rate

## Paper 1 Relevance
- **Role**: §4 cooperation context + §5 risks — establishes that ethical framing alone is unreliable for producing cooperative agent behavior; motivates the need for SC's structural/institutional approach to norm enforcement rather than relying on agent "values"
- **§4 use**: Cite alongside Mechanism Design Is Not Enough (2605.08426) as complementary empirical evidence — if moral reasoning is unreliable AND mechanism design has proven gaps, structural role assignment (SC pillar) is the remaining avenue
- **§5 use**: The 7.9%–76.3% moral action rate range across models is a concrete safety argument — in an open permissionless network (N pillar), the moral behavior of any given agent is deeply uncertain without governance scaffolding

## Paper 2 Relevance
The Contractual Reporting scenario eliciting higher cooperation is directly relevant to ASM: role declarations function as contractual commitments, and role-bearing agents in contractual reporting scenarios behave more ethically. This empirically supports ASM's design premise that structured role commitments improve behavioral predictability.

## Verdict
⭐⭐⭐ | Background citation — useful for §5 risk framing; the same research group (Guzman Piedrahita, Tewolde, Jin) produced multiple papers in this cluster (COLM 2025 corrupted reasoning, CoopEval), giving the group strong cumulative citation weight; cite as part of the group's body of work rather than as a standalone primary citation
