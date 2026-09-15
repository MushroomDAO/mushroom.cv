# [Wang, Gong, Sun, Xu et al. 2026] Multi-Agent Systems: From Classical Paradigms to Large Foundation Model-Enabled Futures

**arXiv**: 2604.18133 | **Year**: 2026 | **Authors**: Zixiang Wang, Mengjia Gong, Qiyu Sun, Jing Xu, Shuai Mao, Xin Jin, Qing-Long Han, Yang Tang | **Venue**: arXiv preprint
**Cluster**: MAS Survey / Historical Framing — Classical to LLM-Enabled
**Status**: Full read

## Core Claim
Classical MAS (CMAS) and LLM-based MAS (LMAS) are complementary rather than competing paradigms: LMASs lift coordination from low-level state exchange to semantic-level reasoning and zero-shot generalization, but the field requires a co-evolutionary framework integrating classical control guarantees with LFM-based planning.

## Key Evidence / Numbers
- **MACNET scaling discovery**: System performance grows *logistically* with agent count; collaborative emergence occurs *earlier* than predicted by traditional neural scaling laws
- **OASIS simulation**: Scales to **1 million agents**, revealing diverse social dynamics at population scale
- **SocioVerse pool**: Built on a **10 million user pool** for predictive social simulations
- Survey covers four analytical dimensions for CMAS: perception (cooperative fusion), communication (topology/frequency/content), decision-making (model/learning-based), control (consensus/formation)
- LMAS covers: role definition (manual vs. task-adaptive), perception hierarchy (semantic → situational → cognitive), planning, memory (short-/long-term), execution
- Interaction paradigms: Cooperative (shared goals), Competitive (debate frameworks), Hybrid (dynamic switching)
- Six open challenges: co-evolution, multimodality scaling, causality-enhanced reasoning, device-edge-cloud deployment, embodied intelligence, ethics/safety alignment
- Key distinction: CMASs use "predefined system models, handcrafted rules, or task-specific policies" while LMASs enable "semantic-level perception and language-based interaction"

## Paper 1 Relevance
**§2 (historical framing and old-paradigm contrast — highest relevance for this paper)**:

This survey is the single most valuable reference for Paper 1's §2 historical narrative. It provides:

1. **Authoritative taxonomy of the classical paradigm**: CMAS coordination via explicit state models, consensus/formation control, MARL — the "low-level state exchange" world. This is precisely the "capability invocation" paradigm Paper 1 argues from. Cite as the canonical survey establishing what the old paradigm is before Paper 1 defines the new one.

2. **Clean paradigm-shift language**: The paper's own framing — "from rule- and model-centric coordination toward cognitively empowered, knowledge-driven collaboration" — is almost exactly Paper 1's argument, but stops short of the social-role-agency claim. Paper 1 goes further: LLM-based coordination is still capability-level; the next shift is to *social role agency* with accountability and social capital.

3. **Scaling evidence**: MACNET's logistic scaling (emergence earlier than neural scaling) and OASIS's 1M-agent simulations provide empirical grounding for the claim that agent networks are reaching social-system scale — motivating Pillar N (permissionless network infrastructure).

4. **"Complementarity" framing**: The survey's conclusion that CMAS and LMAS are complementary (not replacement) parallels Paper 1's claim that our three-pillar framework does not replace existing agent protocols but *layers* social infrastructure on top.

5. **Six open challenges**: Ethics/safety alignment and the device-edge-cloud deployment challenge map onto Paper 1's governance discussion (§5, Pillar N); causality-enhanced reasoning maps onto Pillar SC (attribution of credit requires causal tracing).

**Differentiation point**: This survey culminates with "co-evolutionary CMAS+LMAS frameworks" as the frontier. Paper 1 identifies a further gap: even co-evolutionary LMASs lack persistent social identity, earned roles, and quantified social capital. The paradigm shift Paper 1 argues is therefore *beyond* what this survey sees as the frontier — positioning Paper 1 as extending the best available framing.

## Paper 2 Relevance
**§2 (related work, protocol comparison)**: The survey's taxonomy of CMAS communication (topology, frequency, content dimensions) and LMAS interaction mechanisms (collaborative architecture, task orchestration, communication) provides the comparison axes against which ASM's role-bearing protocol can be positioned. Specifically: no surveyed protocol in either paradigm addresses *social role binding* at the protocol level — ASM fills this gap.

The competitive vs. cooperative vs. hybrid interaction paradigm classification is directly usable in ASM §2 to characterize what types of agent interactions the protocol is designed to support.

## Verdict
⭐⭐⭐⭐ | The essential historical-framing reference for Paper 1 §2; provides authoritative taxonomy of the classical paradigm Paper 1 departs from, plus scaling evidence and the paradigm-shift language that Paper 1 needs to extend one step further toward social role agency.

## Jason's feedback
> （请在此处写入你的feedback）
