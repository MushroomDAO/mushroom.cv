# On the Resilience of Multi-Agent Systems with Malicious Agents
**arXiv**: 2408.00989 | **Year**: 2024 | **Authors**: Jen-tse Huang, Jiaxu Zhou, Tailin Jin, Xuhui Zhou, Zixi Chen, Wenxuan Wang, Youliang Yuan, Maarten Sap, Michael R. Lyu | **Venue**: arXiv preprint (CUHK, Tsinghua, CMU, PKU)

## Core Claim
Multi-agent LLM systems are systematically vulnerable to malicious/faulty agents injecting corrupted outputs; hierarchical architectures are most resilient (23.6% performance drop) while linear pipelines are weakest (49.8% drop), and lightweight verification agents ("Inspector" / "Challenger") can partially but not fully restore performance.

## Key Evidence / Numbers
- **Hierarchical** architecture: 23.6% performance drop under attack
- **Flat** architecture: 46.4% performance drop
- **Linear** architecture: 49.8% performance drop (worst)
- **Code generation** most vulnerable: 39.6% overall performance decline
- Subjective tasks (text evaluation) most robust
- Higher erroneous *message frequency* (Pm) more damaging than higher per-message error density (Pe)
- **Semantic errors** cause more harm than syntactic errors
- Two attack methods: AutoTransform (stealthy profile modification) and AutoInject (message interception)
- Six evaluated systems: MetaGPT, Self-collaboration, CAMEL, SPP, MAD, AgentVerse
- "Inspector" (message verification agent) and "Challenger" (peer-review protocol) both improve resilience but do not achieve full recovery

## Paper 1 Relevance
- **Role**: N pillar (Permissionless Network) + SC pillar — provides the empirical threat-model motivating role verification and social capital as trust mechanisms; supports §5 (failure modes, robustness requirements)
- **§5 use**: "Without role verification and accountability mechanisms, open agent networks face systematic degradation: Huang et al. (2024) demonstrate that even state-of-the-art multi-agent systems suffer 24–50% performance drops under malicious agent injection [cite]. Our SC pillar and the ASM role-verification handshake directly address this gap."
- **Architecture insight**: Hierarchical structures are more resilient — supports Paper 1's argument that social role hierarchy (not flat peer invocation) provides natural resilience through authority scoping

## Paper 2 Relevance
**High** — The "Inspector" and "Challenger" defensive agents in this paper map onto ASM's role-verification challenge-response mechanism. Cite in Paper 2 §4 (threat model / protocol motivation): ASM provides the *message-level protocol* for conducting the verification that Huang et al. identify as necessary but do not specify.

## Verdict
⭐⭐⭐⭐ | Include — strong empirical motivation for our P + SC + N framework; provides concrete threat numbers (23–50% degradation) and validates the need for role verification. Cite in both papers.

## Jason's feedback
> （请在此处写入你的feedback）
