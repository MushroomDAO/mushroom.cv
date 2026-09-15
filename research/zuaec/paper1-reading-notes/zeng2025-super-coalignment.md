# [Zeng et al. 2025] Super Co-alignment of Human and AI for Sustainable Symbiotic Society
**Citation**: Yi Zeng, Feifei Zhao, Yuwei Wang, Enmeng Lu, Yaodong Yang, Lei Wang, Chao Liu, Yitao Liang, Dongcheng Zhao, Bing Han, Haibo Tong, Yao Liang, Dongqi Liang, Kang Sun, Boyuan Chen, Jinyu Fan. "Super Co-alignment of Human and AI for Sustainable Symbiotic Society." arXiv:2504.17404v5 [cs.AI], 28 Jun 2025. 16 pages, 57 references. Supported by Beijing Major Science and Technology Project No.Z241100001324005.
**机构**: Beijing Key Laboratory of Safe AI and Superalignment; Beijing Institute of AI Safety and Governance; Brain-inspired Cognitive AI Lab, Institute of Automation, Chinese Academy of Sciences (CASIA); University of Chinese Academy of Sciences; Peking University Institute for AI; Long-term AI; Beijing Normal University. (通讯作者 Yi Zeng, yi.zeng@ia.ac.cn)
**arXiv**: https://arxiv.org/abs/2504.17404
**PDF**: papers/zeng2025-super-coalignment.pdf
**Cluster**: Human-AI Co-evolution / Alignment — Paper 1 §1/§4 (+ Paper 2 §6 governance)
**Status**: ✅ 全文已分析（2026-05-22）

## Core claim (一句话)
Unidirectional alignment (imposing fixed human values on ever-more-capable AI) is fundamentally insufficient; values for a "sustainable symbiotic society" must be **co-shaped and co-evolved** by humans and AGI/ASI together ("Super Co-alignment"), achieved by integrating external oversight with intrinsic, self-and-empathy-driven proactive alignment.

## 研究问题
A position/framework paper, not empirical. Central question: how can alignment remain robust when AI surpasses human oversight capacity (superalignment), given that RLHF, scalable oversight, and weak-to-strong generalization all break down or invite deception at the ASI level? The authors reframe this from "how do we keep AI obeying humans" to "how do humans and ASI jointly evolve a shared value system."

## 方法与主要内容
Conceptual framework with a two-pillar roadmap (Figure 1):
1. **External Oversight Superalignment** — (a) *Explainable autonomous alignment*: automated, interpretable value-misalignment detection + automatic correction (AI-assisted red teaming, value-representation interpretation); (b) *Dynamic iterative alignment*: a multi-level, developmentally-staged ethical safeguard system that tracks humanity's evolving values (cites "progress alignment" / ProgressGym, ref [47]).
2. **Intrinsic Proactive Superalignment** — grounded in moral-emergence theory from mammalian/human societies. Three cognitive prerequisites for morality: **Self (self-awareness/self-causal awareness), Theory of Mind (cognitive empathy), and Affective Empathy** (Figure 2). The argument: "knowing good from evil" requires understanding, which requires a sense of Self ("you think, therefore you are" does not yet apply to current AI). Invokes Yangming Wang's four-sentence teaching and Descartes.
3. **Integration & complementarity**: external supervision provides mandatory red lines/correction; intrinsic alignment makes human control *meaningful* by internalizing norms via self-other resonance. Must be instilled **early-stage** (while AI is controllable), "like teaching a child."
4. **Ultimate Super Co-alignment** (§5): at AGI/ASI level, AI will demand its own rights (privacy, dignity, existence); humans must *co-evolve their own values*. Briefly reviews symbiosis principles from Zeng/Lu/Sun (ref [57], AI and Ethics 2025): separate principle sets for humans, for AGI/ASI, and shared co-aligned principles (Mutual Trust, Collaboration, Respect for diversity of intelligence, Promoting Sustainable Symbiosis).

## 论文未覆盖的范围（我们的差异化基础）

| Dimension | This paper (Zeng 2025) | 我们的框架 (P/SC/N) |
|---|---|---|
| 对齐单位 | Human ↔ a single (super)intelligent AI; species-level value co-shaping | **Agent-to-agent** in a multi-agent collaboration *network*; alignment is also peer-to-peer |
| 机制载体 | Internal cognitive mechanisms (Self/ToM/empathy) + external oversight signals | **(P) Collaboration Protocols** — externalized, on-the-wire message semantics & role contracts; alignment as protocol conformance, not internal cognition |
| 信任来源 | Intrinsic moral emergence + interpretable internal value representations | **(SC) Quantified Social Capital** — trust earned/lost via verifiable track record (Bourdieu/Putnam/Ostrom), not assumed from inner empathy |
| 身份 | "Living AI" as a moral subject with rights; no notion of verifiable principal | **Role-bearing agents w/ verifiable principal identity** — agent acts *on behalf of* a named principal; accountability is cryptographic/social, not psychological |
| 准入与治理 | Top-down safeguard frameworks designed by humans; AGI/ASI co-design "later" | **(N) Permissionless Network** — open entry, governance emerges from protocol + social capital, no central designer of safeguards |
| 时间尺度 / 风险 | Existential / AGI-ASI horizon; catastrophic risk framing | Near-term operational agent collaboration; failure mode is coordination/trust failure, not extinction |

## Paper 1 区分段落（~150–200词，英文）
Zeng et al. (2025) advance "Super Co-alignment," arguing that fixed, unidirectional human-value imposition cannot govern AI that surpasses human oversight, and that humans and AGI/ASI must *co-evolve* a shared value system through complementary external oversight and intrinsic, empathy-driven alignment. This grounds our §1 motivation: alignment is bidirectional and dynamic, not a one-way constraint. Yet their locus of alignment is the **internal cognition** of a single (super)intelligent agent — Self, Theory of Mind, affective empathy — and their unit of analysis is the human-species/AI relationship at an existential horizon. Our framework relocates alignment to the **observable, networked layer**: agents are not moral subjects to be endowed with empathy but **role-bearing actors with verifiable principal identity (N-layer entry)** whose trustworthiness is *measured, not assumed*. Where Zeng relies on intrinsic self-other resonance, we externalize coordination into **(P) Collaboration Protocols** and substitute psychological empathy with **(SC) Quantified Social Capital** — a Bourdieu/Putnam/Ostrom-grounded, accumulable trust signal. Their co-evolution is human↔ASI; ours is **agent↔agent within a permissionless collaboration network**. We treat their intrinsic-alignment vision as orthogonal and complementary: a desirable inner disposition, but insufficient without protocol-level accountability and quantified social-capital incentives in open multi-agent settings.

## Action items
- [ ] Cite in Paper 1 §1 (motivation) as the strongest recent statement of *bidirectional / co-evolutionary* alignment — pairs with Shen et al. 2025 (bidirectional HAI alignment).
- [ ] Cite in Paper 1 §4 (human-AI collaboration) to contrast intrinsic-cognition alignment vs our protocol+social-capital externalized alignment.
- [ ] Possible Paper 2 §6 (governance): their symbiosis principles (ref [57], Zeng/Lu/Sun, AI and Ethics 2025) are a governance touchstone — note that ASM substitutes verifiable-identity + social capital for "designed principles."
- [ ] Mine the lit-review backbone: refs [19] weak-to-strong, [39] Constitutional AI, [47] ProgressGym, [46] Hagendorff deception (PNAS) — useful citations for our "capability-container alignment is insufficient" argument.

## Jason's feedback
> （请在此处写入你的feedback）
