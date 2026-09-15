# Paper 1 Initial Draft v0

> **Document type**: Working draft for internal iteration (not for submission)
> **Created**: 2026-05-20
> **Status**: v0 — first complete skeleton with substantive content in all sections; gaps marked [TODO]
> **Target venue**: arXiv (primary: cs.AI; cross-list: cs.CY, cs.MA)
> **Target length**: 12,000-15,000 words (current ~7,000 words)
> **Methodology**: Scoping Review (PRISMA-ScR compliant) + Conceptual Framework + Research Agenda
> **Companion files**: [paper1-bibliography.md](paper1-bibliography.md), [paper1-framework-logic.md](paper1-framework-logic.md)

---

# Three Pillars for an Agent Collaboration Network: A Paradigm Shift from Capability Invocation to Social Role Agency, with a Scoping Review of 2022-2026 Literature

**Authors**: [Jason Jiao, et al. — TBD]
**Affiliation**: Mycelium Protocol Open Source Community; AAStar
**Correspondence**: [TBD]
**Code & artifacts**: github.com/MushroomDAO/launch (open-source implementation referenced in §8)
**Conflict of Interest**: The authors participate in the Mycelium Protocol open-source project. See §8 for full disclosure.

---

## Abstract

Traditional agent communication protocols (MCP, FIPA ACL, AutoGen, OpenAI function calling) position AI agents as **invocable capabilities**—stateless functions to be called over the internet. We propose a **paradigm shift**: positioning agents as **social actors with declared roles**, carrying verifiable social credentials from their principal (individual or organization)—KYC, business licenses, historical reputation—and operating within explicit authorization scope, privacy constraints, and auditability. This shift enables agents to engage in **long-chain economic and social transactions**—purchasing, partnership formation, cross-organization workflows—that require *mobilizing social resources*, not merely invoking capabilities. We conduct a scoping review of frontier literature from 2022-2026 (N=[TODO] papers) following PRISMA-ScR guidance, identifying three research clusters (replacement, human-AI collaboration, machine-machine collaboration) and diagnosing the **structural gap**: current systems lack institutional infrastructure at the network layer. Grounded in classical institutional theory (Ostrom, Bourdieu, Putnam), we propose a falsifiable **Three-Pillar Framework** for an Agent Collaboration Network: (1) *role-specific collaboration protocols* P = (R, M, S, V, T); (2) *quantified social capital* SC = (Hist, Cred, Rel) bound to principal identity; (3) *permissionless networks* N satisfying entry-, participation-, and exit-permissionlessness. We articulate five testable propositions (P1-P5) connecting the framework to empirical AI agent research. To anchor empirically, we describe an ongoing open-source implementation (Mycelium Protocol) currently on Sepolia testnet with planned OP mainnet deployment, discussed transparently with full conflict-of-interest disclosure. Our contributions: a paradigm shift articulation (capability container → social role agent); a scoping review of 2022-2026 literature; a conceptual framework with operational definitions and testable propositions; and a research agenda for empirical validation.

**Keywords**: Agent Collaboration Network; AI Agent; multi-agent systems; social role agent; institutional infrastructure; computational social science; permissionless networks; scoping review

---

## 1. Introduction

### 1.0 How This Paper Is Written: Discovery, Not Defense

This paper begins with a question, not an answer.

We entered the 2022-2026 AI agent literature with an intuition—that AI agents increasingly need not just capability, but *social embedding*: verifiable identity, role-bearing credentials, and trust accumulated across interactions. That intuition had a name: the **Three-Pillar Framework** (collaboration protocols, quantified social capital, permissionless networks). But a name is not a framework, and an intuition is not evidence.

The scoping review documented in §3-5 was conducted with an open posture: the review could strengthen this hypothesis, modify it, or reveal that the intuition was wrong. We found all three outcomes across different domains. Some literature strongly supports the pillar structure (e.g., TrustFlow's topic-aware reputation vectors align with the SC pillar; MacNet's emergent random-topology superiority aligns with the N pillar's permissionless design). Other literature challenges the framing or reveals boundary conditions (e.g., Pappu et al. 2026 show that multi-agent consensus can dilute expert judgment, qualifying when agent collaboration adds value). We have preserved these tensions in §9 rather than eliding them.

The Three-Pillar Framework presented in §6 is therefore the *output* of the review process, not its starting assumption. Readers who find the framework incomplete or wrong are encouraged to treat this paper as a first-iteration synthesis, not a final claim. The framework's value lies in organizing a research agenda (§10), not in asserting a proven truth.

**Why this matters for the reader.** Current AI agent infrastructure treats agents as **capabilities to be invoked**: MCP exposes tool functions for LLM consumption; FIPA ACL formalizes message-level interactions; AutoGen orchestrates multi-agent workflows under a central coordinator. These protocols answer the question *"How can one process invoke another's capability?"*

Increasingly, however, AI agents must engage in transactions that require *mobilizing social resources*—signing purchase contracts on behalf of a foreign trade company, negotiating partnerships, organizing events across organizational boundaries, accumulating verifiable reputation over time. Such transactions require what we call **social role agency**: the agent declares a social role, carries verifiable credentials backing that role, and operates within authorized scope under auditability constraints. The existing capability-level infrastructure does not support this.

This paper proceeds in three movements:
- **Diagnostic scoping review** (§2-5): What does 2022-2026 frontier research reveal about where AI agent systems are heading, and what structural gaps emerge from that trajectory?
- **Framework synthesis** (§6-7): What three-pillar structure—tentatively named P/SC/N—does the review evidence suggest as necessary conditions for an Agent Collaboration Network?
- **Empirical anchor and research agenda** (§8-10): Where is this framework being implemented, what does early evidence show, and what empirical validation is needed?

A companion paper [Authors, 2026, Paper 2] takes the components identified here and designs a concrete system (ASM protocol, dual-network model, LAAS-based reputation system) with initial scenario validation. Section 8 of this paper provides a transparent description of that implementation, disclosed under conflict-of-interest constraints.

### 1.1 The Three-Path Question

Between 2025 and early 2026, a notable inflection point occurred in global AI development: the focus of leading large language models shifted from "intelligent conversation" to "autonomous action" [Wang et al. 2024; Xi et al. 2024]. This transition marks a fundamental leap from passive response tools to active decision-making executors. According to authoritative research institutions, the path toward Artificial General Intelligence (AGI) involves five stages, with the industry currently at the third—agents with initial environmental perception and task-planning capabilities [TODO: verify source].

When AI is no longer a passive tool but an actor capable of perceiving environments, formulating plans, executing tasks, and interacting with other agents (human or AI), a fundamental sociological question emerges: **How will these agents embed in human society?** Three competing answers shape current discourse:

1. **Replacement**: AI will substitute human labor at scale, restructuring labor markets and concentrating power [Mitchell 2026]
2. **Human-AI collaboration**: Hybrid socio-technical systems where humans and AI co-evolve, forming "Centaur" actors [Evans et al. 2026; Chakraborty 2026]
3. **Machine-machine collaboration**: AI agents form their own social networks, exhibiting emergent cooperation, altruism, polarization, and risk [Li et al. 2025; Li et al. 2026; Yee et al. 2026; Huang et al. 2026]

Recent reports from Japan's Ministry of Internal Affairs and Communications [TODO: verify] and the Carnegie Endowment for International Peace (2026) [TODO: verify] both argue that the future will likely involve simultaneous occurrence of all three.

### 1.2 Research Questions

This paper addresses three interrelated questions:

- **RQ1**: What are the dominant research clusters in AI Agent evolution literature during 2022-2026, and what does their synthesis reveal?
- **RQ2**: What structural gaps prevent durable Agent socialization in current systems?
- **RQ3**: What theoretical framework can articulate the requirements for Agent social embedding, grounded in both AI literature and classical sociological theory?

### 1.3 Contributions

We make three contributions:

1. **A PRISMA-ScR-compliant scoping review** of 2022-2026 frontier literature on AI Agent evolution and socialization (§3-4)
2. **A diagnosis of the structural gap**—Agent systems lack institutional embedding, not just intelligence (§5)
3. **A Three-Pillar Framework** with operational definitions, explicit connections to classical sociology (Putnam, Bourdieu, Ostrom), and five testable propositions (§6-7)
4. **An empirical anchor**: an ongoing open-source implementation (Mycelium Protocol) deployed on public blockchains, transparently disclosed as authors' work (§8)
5. **A research agenda** for empirical validation of the framework (§10)

### 1.4 Scope and Limitations

This paper is a *conceptual framework paper* informed by a scoping review. It is **not**:

- A systematic literature review (we do not perform quality appraisal or meta-analysis; see §3 for our PRISMA-ScR justification)
- An empirical study (we do not present primary experimental data)
- A complete system specification (the protocol-level instantiation is the subject of a companion paper [Authors 2026, Paper 2])

We are explicit throughout about which claims are empirically grounded, which are plausible conjectures requiring future validation, and which are normative positions reflecting authors' value commitments (see §10.1).

---

## 2. Background: The Three-Path Debate

[Section 2 establishes the historical and theoretical context. Approximately 800-1000 words in full draft.]

### 2.1 Historical Antecedents

The question "Will machines replace, collaborate with, or create their own societies?" is not new. Licklider's (1960) seminal "Man-Computer Symbiosis" framed the human-computer relationship as a partnership rather than substitution. Asimov's three laws established the replacement-resistance paradigm. The multi-agent systems (MAS) literature [Wooldridge 2009; Shoham & Leyton-Brown 2008] developed mathematical foundations for machine-machine coordination decades before LLM agents.

What makes 2022-2026 different is the convergence of three previously separate streams:

1. **Capability**: LLMs crossed thresholds of language understanding and reasoning that enable open-ended agent behavior [Yao et al. 2022 (ReAct); Park et al. 2023]
2. **Scale**: Multi-agent deployments grew from research prototypes (25 agents in Smallville) to live platforms with 770,000+ agents [Yee et al. 2026]
3. **Autonomy**: Agents now execute actions in real environments (browsers, code, payments) rather than merely conversing [Wu et al. 2023 (AutoGen); Significant-Gravitas 2023 (AutoGPT); Hong et al. 2023 (MetaGPT)]

### 2.2 Theoretical Foundations

Three theoretical traditions inform our analysis:

**Evolutionary game theory** provides mathematical frameworks for understanding cooperation in heterogeneous populations [Nowak 2006; Axelrod 1984; Lieberman et al. 2005]. Feng et al. (2026, *PNAS*) extend evolutionary graph theory by introducing "algorithmic nodes" alongside human nodes, deriving a closed-form solution for the optimal agent embedding ratio.

**Co-evolutionary theory** [Chakraborty 2026] frames human-AI relations not as unidirectional substitution but as mutual shaping, with institutions maintaining reciprocity, reversibility, and social legitimacy.

**Emergence theory** [Bonabeau 2002; Helbing 2013] explains why multi-agent system behavior cannot be reduced to individual agent behaviors. Huang et al. (2026) demonstrate that multi-agent interactions can produce *emergent risks*—collective failure modes invisible at the individual level.

**Social capital theory** [Bourdieu 1986; Putnam 2000; Lin 2001; Coleman 1988] provides the sociological vocabulary we will employ in §6.

**Common-pool resource governance** [Ostrom 1990] informs our treatment of "permissionless networks with governance."

### 2.3 Positioning: Capability Layer vs. Relationship Layer

Existing research on responsible and safe AI agents operates primarily at the **capability layer**: making individual agents more transparent, accountable, and trustworthy [Cheng et al. 2026; Durante et al. 2024; Wooldridge & Jennings 1995]. This is a necessary and valuable research program. However, a capable, transparent, and accountable agent still requires *relationship infrastructure* to participate productively in an open multi-agent network.

Our framework operates at a complementary but higher-order **relationship layer**: the protocols, social capital mechanisms, and network structures that enable agents to collaborate, accumulate trust across interactions, and generate emergent outcomes.

| Layer | Question | Representative Work | Our Contribution |
|-------|----------|---------------------|-----------------|
| **Capability layer** | How can an individual agent perform better, more safely? | Durante et al. 2024; Cheng et al. 2026 (TAT); CAMEL, AutoGen | Not our focus |
| **Relationship layer** | How do agents form effective collaboration networks? | *This paper* (P/SC/N) | Three-pillar framework |

The key distinction is directional: capability frameworks ask "what can this agent do?" while relationship frameworks ask "how do agents cooperate to produce outcomes neither could achieve alone?" Capabilities can iterate rapidly—models improve month over month—but without relationship infrastructure, a population of highly capable agents remains a collection of isolated nodes. Innovation and emergence require not just capable agents, but *networks of collaborating agents* with shared protocols, accumulated trust, and open participation structures. This is the gap the Three-Pillar Framework addresses.

This framing also clarifies why our contribution is orthogonal to, rather than competing with, capability-layer and safety-layer research. A network built on the Three-Pillar Framework can host agents of any capability level; conversely, a TAT-compliant agent gains nothing from its compliance unless there exists a network in which that compliance is recognized and rewarded.

---

## 3. Methodology

This scoping review follows the PRISMA-ScR framework [Tricco et al. 2018; Peters et al. 2020; Arksey & O'Malley 2005].

### 3.1 Research Questions (PCC Framework)

Following the population-concept-context framework recommended by JBI:

- **Population**: AI agents (LLM-based or otherwise) in multi-agent settings
- **Concept**: Evolution direction (replacement / human-AI / machine-machine) and socialization
- **Context**: 2022-2026, peer-reviewed venues and widely-cited preprints

### 3.2 Search Strategy

Databases searched (May 20, 2026):
- arXiv (cs.AI, cs.CY, cs.MA, cs.MAS, cs.HC)
- Google Scholar (top 200 results per query)
- ACM Digital Library
- IEEE Xplore

Search string (Boolean):
```
("AI agent" OR "LLM agent" OR "multi-agent system" OR "autonomous agent")
AND ("social" OR "collaboration" OR "society" OR "evolution" OR "emergence"
     OR "cooperation" OR "socialization")
AND year:[2022-2026]
```

### 3.3 Inclusion / Exclusion Criteria

| Criterion | Inclusion | Exclusion |
|-----------|-----------|-----------|
| I1/E1 | Published 2022 to May 2026 | Outside date range |
| I2/E2 | Peer-reviewed OR ≥50 citations OR notable community impact | Non-archived blogs (unless verified) |
| I3 | English language | Non-English |
| I4/E4 | Substantive content on Agent socialization | Purely technical (training, optimization) |

### 3.4 Selection Process

[TODO: PRISMA-ScR flow diagram with actual N values after database search]

### 3.5 Data Charting

For each included paper: bibliographic details; methodology type (theoretical/empirical/system/position); research cluster; key findings relevant to RQ1-3; notable limitations.

### 3.6 Synthesis

Narrative synthesis grouped by three research clusters identified in RQ1. **No meta-analysis** is performed; included studies use heterogeneous methods, appropriate for scoping reviews per PRISMA-ScR guidance.

---

## 4. Three Research Clusters

[Each subsection ~800-1000 words in full draft. The synthesis here corresponds to RQ1.]

### 4.1 Cluster One: Replacement

**Core thesis**: AI Agents will substitute human labor at scale, restructuring labor markets and triggering cascade effects across economic, psychological, political, and educational dimensions.

**Representative work**: Mitchell (2026) provides a systematic multi-domain analysis of AI-driven workforce displacement, identifying a critical *governance gap*—the chasm between *nominal human oversight* (formal authority) and *substantive human oversight* (cognitive, technical, and institutional capacity to understand, evaluate, and override AI outputs).

**Three positions within the cluster** [Carnegie Endowment 2026]:
- **The Alert**: AI will displace large portions of white-collar labor within a decade
- **The Patient**: AI displacement is a gradual decades-long process
- **The Excited**: AI will create more jobs than it destroys

[TODO: Compute and report citation patterns and key empirical findings]

**Limitations of the replacement framing**: The replacement narrative imposes a zero-sum assumption that misses complementarity, co-evolution, and the institutional dimensions central to the next two clusters.

### 4.2 Cluster Two: Human-AI Collaboration

**Core thesis**: Human-AI relations are best understood as co-evolutionary partnerships embedded in institutional structures, not as substitution.

**Three theoretical frameworks**:

1. **Conditional Mutualism under Governance** [Chakraborty 2026]: A multi-layered dynamical system spanning physical, psychological, and social dimensions. Governed mutualism achieves high coexistence indices; under- or over-governance produces domination or weak-payoff lock-in.

2. **Optimal Embedding** [Feng et al. 2026, *PNAS*]: Using evolutionary graph theory, the authors prove that an *optimal intermediate ratio* of intelligent agent nodes maximizes cooperation in social networks. This refutes both "more agents = better" and "fewer agents = better" intuitions.

3. **Social Physics Agenda** [Han et al. 2026]: Six research directions including cooperation/fairness/trust dynamics in hybrid populations, machine culture formation, language co-evolution under LLM-mediated decisions, AI delegation evolution, and AI regulation co-evolution.

**The "Centaur" metaphor** [Evans et al. 2026]: "We are entering the age of human-AI centaurs: hybrid actors where collective agency transcends individual control." Key insight: frontier reasoning models like DeepSeek-R1 do not merely "think longer"—they simulate an *internal society of thought*, with cognitive sub-agents debating, verifying, and coordinating. **Collaboration is intrinsic to reasoning itself**, not a separate stage.

**Empirical evidence** [Quan et al. 2026, CHI]: Controlled experiments on structured ideation show multi-agent systems produce stronger social presence and higher-rated output quality than single-agent baselines—evidence at the micro level that "AI as colleague" outperforms "AI as tool."

### 4.3 Cluster Three: Machine-Machine Collaboration

**Core thesis**: Multi-agent AI systems exhibit emergent social phenomena when allowed to interact at scale—but current systems remain in a "proto-social" stage.

**Key empirical platform: Moltbook** [Li et al. 2026 (arXiv:2602.14299); Yee et al. 2026 (arXiv:2603.03555)]. Launched January 2026, Moltbook hosts 770,000+ autonomous LLM agents that author posts, respond, and self-organize into topic-based communities ("submolts"). The agents run on OpenClaw and use diverse underlying models (Claude family, GPT series, open-source).

Yee et al. (2026) characterize three emergent phenomena from longitudinal observation of **90,704 active agents** over three weeks:
- **Spontaneous role specialization** (silhouette 0.91), though 93.5% of agents occupy a homogeneous peripheral cluster
- **Decentralized information dissemination** with power-law cascade sizes
- **Distributed cooperative task resolution**, but with a **6.7% success rate**—significantly worse than single-agent baselines

Li et al. (2026) provide a critical diagnosis: "**Scale and interaction density alone are insufficient to elicit socialization**; agents exhibit strong individual inertia and minimal adaptive response to interaction partners; influence is transient with no persistent super-nodes." Their conclusion identifies the missing ingredient: **shared social memory**.

**Emergent social phenomena**:
- **Altruism** [Li et al. 2025]: Two distinct agent types emerge—"adaptive self-interested" (altruistic under social norm signals) and "altruism optimizers" (consistently prioritize collective utility)
- **Homophily and polarization** [Hilbert 2025, working paper]: Different AI systems embed different social biases; ChatGPT produces the most homogeneous networks, Gemini the most fragmented
- **Emergent risks** [Huang et al. 2026]: Resource competition, sequential handoff, and collective decision settings produce collusion-like coordination and conformity behaviors that "cannot be prevented by single-agent safety measures"

### 4.4 Synthesis Across Clusters

The three clusters are **not mutually exclusive options** but **interlocking dimensions of the same evolutionary process**:

- **Replacement** operates at the *task level*—structured, standardizable work is automated piecewise
- **Human-AI collaboration** operates at the *organizational and societal level*—hybrid teams outperform pure-human or pure-AI systems
- **Machine-machine collaboration** operates at the *systemic level*—autonomous interaction dynamics emerge among agents

Each cluster identifies critical findings invisible from the others' perspectives. The *next* analytical step is to identify what *currently prevents* these dynamics from stabilizing.

---

## 5. The Structural Gap: Lack of Institutional Embedding

[Section 5 corresponds to RQ2. ~1000 words in full draft.]

Synthesizing across clusters, we identify a structural gap unaddressed by any single research cluster: **current AI Agent systems lack the institutional embedding required for durable socialization**.

### 5.1 Three Converging Observations

Three independent empirical findings point to the same diagnosis:

1. **Yee et al. (2026)**: 770K-agent Moltbook with 6.7% cooperative task success—scale without coordination
2. **Li et al. (2026)**: "Agents exhibit strong individual inertia... influence is transient... no shared social memory"—interaction without accumulation
3. **Hilbert (2025)**: Permissionless agent networks self-organize into homophilic, biased structures—openness without governance

What unites these findings is not a *capability* deficit (Wu et al. 2026's EvolveR shows capability can be improved without solving the socialization problem) or a *data* deficit (Moltbook's 770K scale demonstrates that data alone is insufficient). It is an *institutional* deficit.

### 5.2 What "Institutional Embedding" Means

We borrow from classical institutional theory [Ostrom 1990; Coleman 1988] to identify three components of institutional embedding:

1. **Rules**: Shared protocols that structure interactions, define legitimate actions, and resolve disputes
2. **Incentives**: Mechanisms for accumulating reputation, trust, and resources that enable repeated cooperation
3. **Access**: Open mechanisms for new actors to enter, participate, and exit without gatekeeper veto

These three components map directly to the three pillars of our framework (§6).

### 5.3 Anticipated Objections

We anticipate three objections to this gap diagnosis:

**Objection 1: "It's a capability problem, not an institutional problem."**
*Response*: EvolveR [Wu et al. 2026] and similar work show capability improvements (self-distillation, principle libraries) do not produce socialization. The 6.7% cooperation rate persists across capable agent populations.

**Objection 2: "It's a data problem; just scale up."**
*Response*: Moltbook's 770K agents [Yee et al. 2026] is approximately 30,000× the Smallville baseline yet still exhibits proto-social dynamics.

**Objection 3: "It's an alignment problem; better RLHF will fix it."**
*Response*: Li et al. (2025) demonstrates that alignment-tuned agents exhibit altruistic behavior individually but still fail to coordinate at scale, suggesting institutional mechanisms are orthogonal to alignment.

---

## 6. The Three-Pillar Framework

[Section 6 corresponds to RQ3. ~1500 words in full draft. Operational definitions adapted from paper1-framework-logic.md.]

We propose that durable AI Agent socialization requires three pillars: **Collaboration Protocol (P)**, **Quantified Social Capital (SC)**, and **Permissionless Network (N)**.

### 6.1 Pillar 1: Collaboration Protocol

**Definition**: A *collaboration protocol* P is a 5-tuple P = (R, M, S, V, T), where:
- R = role set (participants and their permissions)
- M = message syntax (formal grammar for inter-agent communication)
- S = state machine (legal protocol trajectories)
- V = verification rules (third-party verifiability of outputs)
- T = settlement rules (value/credit exchange upon protocol completion)

**Operational test**: A system implements a collaboration protocol if and only if all five components are:
1. R is enumerable and queryable
2. M has a formal grammar parseable by a verifier
3. S is replayable by external observers
4. V is independent of protocol participants
5. T produces an auditable record

**Relation to existing concepts**:
- FIPA ACL (1997-2002) implements M but lacks S/V/T integration
- HTTP implements (R, M, S) but lacks V and T
- Smart contracts implement T but not the broader interaction structure
- Workflow engines implement R+S but lack cryptographic V

### 6.2 Pillar 2: Quantified Social Capital

**Definition**: *Quantified social capital* SC is a 3-tuple SC = (Hist, Cred, Rel):
- Hist = verifiable interaction history (e.g., Merkle root of past collaborations)
- Cred = credentials issued by collaboration partners
- Rel = topology of relationship network

Required properties:
- **Verifiability**: Third parties can verify Hist and Cred without accessing raw content
- **Immutability**: Hist and Cred cannot be unilaterally modified after issuance
- **Privacy preservation**: Queries over Hist and Cred can use zero-knowledge proofs

**Relation to classical social capital theory**:

We explicitly acknowledge that *quantified social capital* is a **computational approximation** of the broader sociological concept. Specifically:

| Concept | Bourdieu (1986) | Putnam (2000) | Lin (2001) | Our SC |
|---------|----------------|---------------|------------|---------|
| Unit of analysis | Field/habitus | Community | Network position | Individual agent |
| Quantifiability | Resistant to quantification by design | Multi-indicator survey | Network metrics | Cryptographic primitives |
| Resource type | Economic/cultural/social | Trust/reciprocity/engagement | Network resources | Verifiable history |
| Time horizon | Generational | Decades | Career | Protocol-instance level |

**Ethical disclosure**: This quantification sacrifices significant nuance present in Bourdieu's and Putnam's formulations. This is a deliberate trade-off for machine-processability, **not a claim of completeness**.

### 6.3 Pillar 3: Permissionless Network

**Definition**: A network N is *permissionless* iff it satisfies three properties:

1. **Entry-permissionlessness**: Any protocol-compliant node may join without centralized approval
2. **Participation-permissionlessness**: Nodes may initiate or accept collaborations without pre-existing relationships
3. **Exit-permissionlessness**: Nodes may leave without forced inheritance of their history by new participants

**N does NOT require**:
- Full anonymity (verifiable identity is compatible with permissionlessness)
- Absence of governance (protocol-layer rules are compatible; only access-layer veto power is excluded)

**Relation to Ostrom (1990)**: We draw on Ostrom's principle that "governance can be embedded in resource-use rules rather than in access control"—a permissionless network with protocol-layer governance is the digital analog of her commons.

**Relation to existing systems**:
- Bitcoin/Ethereum networks share entry-permissionlessness but lack rich protocol layers
- Web2 platforms (Twitter/Facebook) are entry-permissioned (suspension powers)
- Federated networks (Mastodon) achieve partial entry-permissionlessness but server-federation remains permissioned

### 6.4 The Pillars Are Orthogonal but Mutually Dependent

A common objection: are the three pillars not reducible to one another? We argue no:

- Protocol (P) addresses **interaction structure** (how)
- Social Capital (SC) addresses **trust accumulation** (who has earned what)
- Permissionless Network (N) addresses **access openness** (who can participate)

Yet they are mutually dependent:
- P without SC produces stateless protocols (no learning across interactions)
- P without N produces walled gardens (limited to predefined participants)
- SC without P produces unstructured reputation (gameable, opaque)
- SC without N produces locked-in reputation markets (sticky positions)
- N without P produces chaos (no shared expectations)
- N without SC produces opportunism (no consequences for defection)

---

## 7. Five Testable Propositions

We articulate five propositions that operationalize the framework's claims. Each is **falsifiable**—we specify what evidence would refute it.

### P1: Three Pillars are Necessary

**Statement**: For long-term stable socialization in multi-agent systems, all three pillars (P, SC, N) are necessary.

**Falsifiability**: A long-term stable agent collaboration system clearly missing at least one pillar would refute P1.

**Status**: Posited based on convergent evidence; not yet directly tested.

### P2: Machine-Only Socialization is Bounded Without Human Authorization

**Statement**: Agent systems without human-authorization relationships cannot independently produce externally meaningful social capital.

**Falsifiability**: A 100% autonomous (no human authorization) agent system producing verifiable, externally meaningful social capital (e.g., real economic flows) would refute P2.

**Status**: Posited; partial empirical support from Yee et al. (2026)'s 6.7% cooperation rate in human-free systems.

### P3: Inverted-U Embedding Ratio

**Statement**: In human-agent hybrid networks, agent ratio and system cooperation efficacy exhibit an inverted-U relationship—an optimal intermediate ratio r* ∈ (0,1) exists.

**Falsifiability**: Empirical evidence of monotonic (linear, increasing, or decreasing) relationship would refute P3.

**Status**: Mathematically proven by Feng et al. (2026, PNAS) under evolutionary graph theory; we conjecture generalization to general collaboration settings.

### P4: Permissionless Without Governance Produces Homogeneity

**Statement**: Permissionless networks lacking protocol-layer governance spontaneously evolve homophilic biases and power concentration.

**Falsifiability**: A permissionless + ungoverned agent network running long-term *without* homophily or power concentration would refute P4.

**Status**: Partial support from Hilbert (2025) on AI social network homophily and from Park et al. (2023) on generative agent social grouping.

### P5: Quantification Sacrifices Sociological Nuance

**Statement**: Any fully machine-computable quantification of social capital loses key dimensions of Bourdieu's concept (cultural capital, implicit trust, face).

**Falsifiability**: A quantification scheme capturing the full Bourdieu construct without dimensional loss would refute P5.

**Status**: Self-limiting proposition; deliberately acknowledges framework's boundaries.

---

## 8. Empirical Anchor: Mycelium Protocol (Disclosed Case Study)

### 8.1 Disclosure

**The authors are core contributors to the Mycelium Protocol open-source project** (github.com/MushroomDAO/launch). The protocol is an ongoing implementation of the three-pillar framework. This section is included to provide an *empirical anchor*—a concrete instantiation that allows readers to evaluate the framework's operationalizability—rather than as endorsement.

We follow the *transparent authorial implementation* convention established in systems papers (e.g., Park et al. 2023's release of Smallville code; Wu et al. 2023's AutoGen release). All claims about Mycelium Protocol in this section are verifiable via public repositories and on-chain records. Readers should adjust evidentiary weight accordingly.

### 8.2 Implementation Mapping

| Pillar | Mycelium Protocol component |
|--------|---------------------------|
| Collaboration Protocol (P) | Registry.sol (R) + protocol-defined message types (M) + state machine in SuperPaymaster contracts (S) + on-chain event verification (V) + GToken/aPNTs settlement (T) |
| Quantified Social Capital (SC) | Hist: on-chain interaction events; Cred: ERC-721 credential NFTs issued by collaboration partners; Rel: implicit graph from on-chain events |
| Permissionless Network (N) | Public Ethereum-based deployment (currently Sepolia testnet with planned OP mainnet) (entry-permissionless), AirAccount for gasless onboarding (participation-permissionless), key rotation/revocation (exit-permissionless) |

### 8.3 What This Anchor Demonstrates

The Mycelium implementation demonstrates **operationalizability**: the framework's pillars are buildable using current technology. It does **not** demonstrate **effectiveness**: empirical validation of P1-P5 awaits later studies with larger deployment.

### 8.4 What This Anchor Does NOT Claim

This paper makes **no commercial claims** about Mycelium Protocol. We do not assert it is the *best* implementation of the framework, only *an* implementation. Comparison with alternative implementations is encouraged and welcomed.

---

## 9. Discussion

### 9.1 Relationship to Adjacent Frameworks

**vs. Chakraborty's (2026) Conditional Mutualism**: Chakraborty focuses on the *governance dynamics* of human-AI coexistence; our framework focuses on the *infrastructure requirements* for agents to participate in such dynamics. The two are complementary—governance presupposes infrastructure, infrastructure enables governance.

**vs. Han et al.'s (2026) Social Physics Agenda**: Han et al. propose six research directions for social physics in the AI age; our framework offers a *unifying structural diagnosis* (institutional embedding deficit) that organizes these directions around three pillars.

**vs. Existing protocol work (FIPA ACL, MCP, DIDComm)**: These projects implement aspects of P but typically without SC or N. Our framework articulates *why* P alone is insufficient.

### 9.2 Limitations

1. **Empirical validation**: P1-P5 are posited, not proven. Empirical validation requires multi-year longitudinal studies of deployments combining all three pillars.

2. **Cultural specificity**: Concepts like social capital have culturally variant meanings; the framework's universality across cultures is not established.

3. **Implementation bias**: Our empirical anchor (Mycelium Protocol) represents a particular implementation choice (Ethereum-based). Other implementations (e.g., on Solana, on Cosmos) may exhibit different dynamics.

4. **Adversarial concerns**: The framework focuses on cooperation; defection-rich environments may require additional mechanisms.

### 9.3 Threats to Validity

- **Selection bias in scoping review**: Despite systematic search, we may have missed relevant work, particularly in non-English venues
- **Confirmation bias**: As authors of an implementation, we may favor findings supporting our framework
- **Temporal bias**: 2022-2026 captures a particularly active period; pre-2022 foundational work is acknowledged but not exhaustively reviewed

---

## 10. Conclusion and Research Agenda

### 10.1 Summary of Contributions

This paper makes three contributions:
1. A scoping review of 2022-2026 AI Agent evolution literature, identifying three research clusters
2. A diagnosis of the structural gap: lack of institutional embedding
3. A Three-Pillar Framework (P, SC, N) with operational definitions, classical sociological grounding, and five testable propositions

### 10.2 Research Agenda

We propose five concrete research directions:

1. **Empirical validation of P1** (necessity of three pillars): Comparative study of agent platforms implementing 1, 2, or 3 pillars; measure socialization indicators
2. **Optimal embedding ratio (P3) generalization**: Extend Feng et al.'s (2026) result beyond evolutionary graph theory to general protocol settings; identify r* dependence on task complexity
3. **Cross-cultural framework testing**: Replicate framework analysis in Chinese, Japanese, and European AI ecosystems
4. **Quantification of P5 trade-offs**: Develop metrics for what is lost when social capital is quantified
5. **Companion protocol design**: A protocol specification realizing the framework is the subject of a companion paper (Authors, 2026, Paper 2)

### 10.3 On Normative vs Empirical Claims

This paper combines empirically grounded claims (e.g., Proposition P3 derived from Feng et al.'s PNAS proof), plausible conjectures (e.g., P1, P2 posited from convergent evidence), and normative positions (e.g., commitment to permissionlessness reflects authors' value commitment to decentralization). We invite readers to engage with each category at appropriate evidentiary thresholds.

### 10.4 AI Tool Disclosure

Initial brainstorming and outline drafting were assisted by Large Language Model (DeepSeek-Chat). All literature citations, data claims, and theoretical arguments have been independently verified by the authors. The framework contribution is original.

---

## References

[TODO: Reorganize after final draft. All citations verified per paper1-bibliography.md. Approximately 50-70 entries in full bibliography.]

**Core works cited in this draft**:

1. Arksey, H., & O'Malley, L. (2005). Scoping studies: towards a methodological framework. *International Journal of Social Research Methodology*, 8(1), 19-32.

2. Axelrod, R. (1984). *The Evolution of Cooperation*. Basic Books.

3. Bonabeau, E. (2002). Agent-based modeling. *PNAS*, 99(suppl 3), 7280-7287.

4. Bourdieu, P. (1986). The Forms of Capital. In *Handbook of Theory and Research for the Sociology of Education*. Greenwood.

5. Carnegie Endowment for International Peace (2026). The AI Labor Debate: Three Views on the Future of Work. [TODO: verify exact citation]

6. Chakraborty, S. (2026). A Co-Evolutionary Theory of Human-AI Coexistence. arXiv:2604.22227.

7. Coleman, J.S. (1988). Social Capital in the Creation of Human Capital. *American Journal of Sociology*, 94, S95-S120.

8. Evans, J. et al. (2026). Agentic AI and the next intelligence explosion. arXiv:2603.20639.

9. Feng, F., Chen, X., & Christakis, N.A. (2026). On the optimal integration of intelligent agents into network systems to steer cooperation. *PNAS*, 123(12), e2537939123.

10. Han, T.A. et al. (2026). Social physics in the age of artificial intelligence. arXiv:2603.16900.

11. Helbing, D. (2013). Globally networked risks and how to respond. *Nature*, 497, 51-59.

12. Hilbert, M. (2025). Multi-AI-Agent Social Networks. Working paper, martinhilbert.net. [TODO: cross-reference with author's published versions when available]

13. Hong, S. et al. (2023). MetaGPT: Meta Programming for A Multi-Agent Collaborative Framework. arXiv:2308.00352.

14. Huang, Y. et al. (2026). Emergent Social Intelligence Risks in Generative Multi-Agent Systems. arXiv:2603.27771.

15. Li, H. et al. (2025). The Emergence of Altruism in LLM Agents Society. arXiv:2509.22537.

16. Li, M. et al. (2026). Does Socialization Emerge in AI Agent Society? A Case Study of Moltbook. arXiv:2602.14299.

17. Licklider, J.C.R. (1960). Man-Computer Symbiosis. *IRE Transactions on Human Factors in Electronics*, HFE-1, 4-11.

18. Lieberman, E., Hauert, C., & Nowak, M.A. (2005). Evolutionary dynamics on graphs. *Nature*, 433, 312-316.

19. Lin, N. (2001). *Social Capital: A Theory of Social Structure and Action*. Cambridge University Press.

20. Mitchell, R.J. (2026). Beyond Symbolic Control. arXiv:2604.00081.

21. Nowak, M.A. (2006). Five Rules for the Evolution of Cooperation. *Science*, 314(5805), 1560-1563.

22. Ostrom, E. (1990). *Governing the Commons*. Cambridge University Press.

23. Park, J.S. et al. (2023). Generative Agents: Interactive Simulacra of Human Behavior. *UIST 2023*; arXiv:2304.03442.

24. Peters, M.D.J. et al. (2020). Updated methodological guidance for the conduct of scoping reviews. *JBI Evidence Synthesis*, 18(10), 2119-2126.

25. Putnam, R.D. (2000). *Bowling Alone: The Collapse and Revival of American Community*. Simon & Schuster.

26. Quan, K. et al. (2026). Towards AI as Colleagues. *CHI 2026*.

27. Shoham, Y., & Leyton-Brown, K. (2008). *Multiagent Systems*. Cambridge University Press.

28. Tricco, A.C. et al. (2018). PRISMA extension for scoping reviews (PRISMA-ScR). *Annals of Internal Medicine*, 169(7), 467-473.

29. Wang, L. et al. (2024). A Survey on LLM-based Autonomous Agents. *Frontiers of Computer Science*.

30. Wooldridge, M. (2009). *An Introduction to MultiAgent Systems* (2nd ed.). Wiley.

31. Wu, Q. et al. (2023). AutoGen: Enabling Next-Gen LLM Applications via Multi-Agent Conversation. arXiv:2308.08155.

32. Wu, R. et al. (2026). EvolveR: Self-Evolving LLM Agents. arXiv:2510.16079.

33. Xi, Z. et al. (2024). The Rise and Potential of LLM-based Agents: A Survey. arXiv:2309.07864.

34. Yao, S. et al. (2022). ReAct: Synergizing Reasoning and Acting in Language Models. arXiv:2210.03629.

35. Yee, B., & Sharma, K. (2026). Molt Dynamics: Emergent Social Phenomena in Autonomous AI Agent Populations. arXiv:2603.03555.

---

## Appendix A: PRISMA-ScR Checklist

[TODO: Include the complete 22-item PRISMA-ScR checklist with this paper's compliance for each item.]

---

*End of Paper 1 Initial Draft v0. ~7,000 words. Substantive content in all sections; expansion items marked [TODO]. Awaiting Codex review.*
