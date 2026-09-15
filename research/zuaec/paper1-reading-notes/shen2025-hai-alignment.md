# [Shen, Knearem et al. 2026] Human-AI Interaction Alignment: Designing, Evaluating, and Evolving Value-Centered AI For Reciprocal Human-AI Futures
**Citation**: Hua Shen, Tiffany Knearem, Divy Thakkar, Pat Pataranutaporn, Anoop Sinha, Yike Shi, Jenny Liang, Lama Ahmad, Tanu Mitra, Brad A. Myers, Yang Li. "Human-AI Interaction Alignment: Designing, Evaluating, and Evolving Value-Centered AI For Reciprocal Human-AI Futures." CHI EA '26 (Extended Abstracts, CHI Conference on Human Factors in Computing Systems), Apr 13–17 2026, Barcelona. arXiv:2512.21551v1 [cs.HC], 25 Dec 2025. 6 pages. DOI 10.1145/3772363.3778710. CC-BY 4.0.
**机构**: NYU Shanghai; MBZUAI; Google; MIT Media Lab; Google (Paradigms of Intelligence); CMU + NYU; CMU; OpenAI; University of Washington; Google DeepMind.
**arXiv**: https://arxiv.org/abs/2512.21551
**PDF**: papers/shen2025-hai-alignment.pdf
**Cluster**: Human-AI Co-evolution / Alignment — Paper 1 §1/§4 (+ Paper 2 §6 governance)
**Status**: ✅ 全文已分析（2026-05-22）

## ⚠️ 文献类型警示
**这是一份 CHI 2026 Workshop 提案/组织文件（BiAlign 第二届），不是经验性或理论性研究论文。** 6 页正文主要是：workshop 目标(G.1–G.4)、四大主题、组织者简历、议程(Table 1)、Call for Participation。其学术贡献是**议程设定（agenda-setting）**而非新方法/新实证结果。引用时应作为**"bidirectional human-AI alignment 研究社区与范式"的代表性文献**，真正的理论锚点是其引用的 **Shen et al. 2024 系统综述 (arXiv:2406.09264, ref [23])** 与 **ValueCompass (arXiv:2409.09586, ref [25])**。建议把这两篇列入待检索清单。

## Core claim (一句话)
Alignment must move beyond unidirectional models (only adapting AI to human values) to **bidirectional human-AI alignment**: a dynamic, reciprocal process where humans and AI co-adapt through interaction, evaluation, and value-centered design — and the HCI community must be at the table to operationalize human/societal values.

## 研究问题
As a workshop proposal, it poses an *agenda* rather than answering a research question. Framing questions across four themes: (1) which human/societal values should guide reciprocal alignment and how to translate them into design/technical processes; (2) what interaction/design mechanisms let humans steer, critique, co-create with AI while retaining agency; (3) how to evaluate bidirectional alignment technically AND socially (trust, collective well-being, economic impact); (4) how alignment goals co-evolve as humans and AI mutually adapt over time.

## 方法与主要内容
- **Paradigm statement**: traditional alignment is static/one-way and inadequate as AI permeates daily decision-making; feedback loops influence both AI behavior and human responses → need continuous reciprocal mutual adaptation (cites Shen et al. 2024 systematic review, ref [23]).
- **Four themes**: Value-Centered Alignment Objectives (pluralistic values, value-sensitive design); Developing Interfaces/Interactions for Alignment (interactive alignment, participatory design, human agency); Evaluating Alignment & Societal Impacts (trust, responsible AI); **Dynamic Co-Evolution of Human-AI Futures** (adaptability, resilience, lifelong learning, co-evolution).
- **Community evidence**: builds on ICLR 2025 BiAlign Workshop (100+ submissions), CHI 2025 BiAlign SIG (100+ participants), 250+ Slack community.
- **Logistics**: 180-min workshop, two keynotes (Lama Ahmad/OpenAI; Elizabeth Churchill/MBZUAI), lightning talks, concept mapping, on-the-spot paper writing.

## 论文未覆盖的范围（我们的差异化基础）

| Dimension | This paper (Shen 2026 workshop) | 我们的框架 (P/SC/N) |
|---|---|---|
| 对齐关系 | **Human ↔ AI** dyad; co-adaptation between people and AI systems | **Agent ↔ agent** in a multi-agent network; human is the *principal behind* an agent, not the direct counterpart |
| 学科方法 | HCI / interface design / participatory & value-sensitive design; human-in-the-loop steering | **Protocol engineering + social/economic mechanism design**; alignment as on-the-wire conformance + incentives, minimal human-in-the-loop |
| 价值如何落地 | "Operationalize abstract values" via design principles & UX | **(SC) Quantified Social Capital** — values/trust become a *measurable, accumulable* on-network quantity (Bourdieu/Putnam/Ostrom) |
| 身份与问责 | Implicit (a user interacts with an AI); no verifiable identity layer | **Role-bearing agents w/ verifiable principal identity**; accountability is structural |
| 网络 / 准入 | Closed dyadic / workshop framing; no network-entry concept | **(N) Permissionless Network** — open entry, decentralized collaboration |
| 输出形式 | Research agenda + community building (no protocol/spec) | **(P) Concrete collaboration protocol (ASM)** — an actual communication spec |

## Paper 1 区分段落（~150–200词，English）
Shen, Knearem et al. (2026) crystallize the HCI community's call for **bidirectional human-AI alignment** — treating alignment as a continuous, reciprocal co-adaptation between humans and AI rather than a one-way fitting of AI to fixed human values, and pressing to *operationalize* abstract values (fairness, agency, responsibility) through value-centered design. This directly supports our §1/§4 premise that alignment is dynamic and value-laden, and their "Dynamic Co-Evolution of Human-AI Futures" theme resonates with our co-evolutionary stance. However, their unit of analysis is the **human-AI dyad** and their toolkit is **HCI/interface/participatory design**, keeping a human continuously in the loop to steer a single AI. Our framework operates one level out: the principals recede *behind* their agents, and alignment plays out **agent-to-agent across a permissionless network (N)**. We replace UX-mediated steering with **(P) explicit collaboration protocols** and replace "operationalizing values through design" with **(SC) Quantified Social Capital** — making trust a measurable, accumulable network quantity grounded in Bourdieu/Putnam/Ostrom rather than an interface affordance. Crucially, this is a *workshop agenda*, not a method; we cite it to locate our work within the bidirectional-alignment turn while showing that a multi-agent, identity-bearing, protocol-and-social-capital substrate is the missing layer their human-centered framing leaves open.

## Action items
- [ ] Cite in Paper 1 §1/§4 as the representative **HCI-side statement of bidirectional alignment**; pair with Zeng et al. 2025 (AI-safety side) to show the cross-disciplinary convergence toward co-evolutionary alignment.
- [ ] **Retrieve the real theory anchors** it points to: Shen et al. 2024 "Towards Bidirectional Human-AI Alignment: A Systematic Review" (arXiv:2406.09264) and Shen et al. 2024 "ValueCompass" (arXiv:2409.09586) — these are the citable substance; add to lit-review screen.
- [ ] Note for honesty: do NOT cite this as if it contained new methods/results — flag it internally as a workshop proposal so /ars-citation-check does not over-claim.
- [ ] Possible Paper 2 §6: the "operationalize values / evaluate alignment socially" theme motivates ASM's social-capital quantification as a concrete answer to their open evaluation question.

## Jason's feedback
> （请在此处写入你的feedback）
