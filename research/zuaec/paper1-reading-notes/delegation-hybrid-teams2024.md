# Optimizing Delegation in Collaborative Human-AI Hybrid Teams
**arXiv**: 2402.05605 | **Year**: 2024 | **Authors**: Andrew Fuchs, G.K.M. Tobin | **Venue**: ACM Transactions on Autonomous and Adaptive Systems (TAAS)

## Core Claim
An RL-trained manager agent operating via an Intervening MDP (IMDP) can dynamically delegate control authority among hybrid human-AI team members, improving task performance by up to ~187% over solo agents while minimizing intervention frequency.

## Key Evidence / Numbers
- Up to **~187% performance gain** over best solo agent in balanced human-AI teams
- Framework tested in simulated driving at four-way intersections under perception-degradation scenarios (fog, night, color blindness, distraction)
- Manager uses Soft Actor-Critic (SAC) with prioritized experience replay; learns purely from sparse observations at intervention points
- Baseline random manager shows high variance, confirming the RL learning contribution
- Sequential control: at any time only one team member holds control authority (no concurrent delegation)

## Paper 1 Relevance
- **Role**: P pillar (Collaboration Protocol) — empirical grounding for dynamic role assignment in human-AI teams; also supports Paper 1 §4 (human-in-the-loop hybrid systems)
- **§4 use**: Cite as an engineering instantiation of the role-assignment problem — the IMDP framework operationalizes what the P pillar addresses abstractly: who does what, when, and under what authority structure
- **Distinction**: Fuchs & Tobin solve delegation *within* a closed team via RL; our framework addresses open permissionless networks where role assignment must work without prior team configuration and with social accountability mechanisms (SC)
- Supports the claim that role/authority assignment is a first-class design problem, not an afterthought

## Paper 2 Relevance
Marginal. The IMDP manager communicates control-transfer decisions but does not define an open communication protocol for role-bearing agents. The delegation signal in ASM (role claim + authority scope) maps conceptually onto the control-authority delegation studied here, but the paper does not speak to message format or identity verification.

## Verdict
⭐⭐⭐ | Background — cite in §4 to motivate dynamic role assignment in hybrid teams; not a direct competitor to our social-embedding framework (closed RL team vs. open social network).

## Jason's feedback
> （请在此处写入你的feedback）
