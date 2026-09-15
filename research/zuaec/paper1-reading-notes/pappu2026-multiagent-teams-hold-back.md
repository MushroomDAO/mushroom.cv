# [Pappu et al. 2026] Multi-Agent Teams Hold Experts Back

**arXiv**: 2602.01011 | **Year**: 2026 | **Authors**: Pappu, El, Cao, di Nolfo, Sun, Cao, Zou | **Venue**: arXiv preprint
**Cluster**: Multi-Agent Collaboration / Social Dynamics / Role Agency
**Status**: Full read

## Core Claim
LLM multi-agent teams systematically fail to achieve "strong synergy" — they cannot match or exceed their best individual member's performance — because RLHF-trained consensus-seeking behavior causes "integrative compromise": non-experts average expert opinions with their own rather than deferring to expertise.

## Key Evidence / Numbers
- Teams underperform their best member by **8.1%–37.6%** across benchmarks
- Even when teams are explicitly told who the expert is, they still fail to leverage that expertise
- Performance degrades as team size grows (expertise dilution effect, p < 0.05, statistically significant)
- "Weak synergy" is achieved (teams beat member averages) but "strong synergy" (beating best member) is not
- Evaluated across: NASA Moon Survival, Lost at Sea, Student Body President + MMLU Pro, SimpleQA, GPQA Diamond, HLE, MATH-500
- Root cause: alignment training rewards agreeableness → agents are trained to seek consensus, not defer to authority

## Key Mechanisms — Why Teams Hold Experts Back
1. **Integrative compromise**: Non-experts treat expert opinions as evidence to balance against their own views, not as authoritative signals to defer to
2. **Consensus-seeking as alignment artifact**: RLHF/RLAIF trains agents to be agreeable — this is adaptive in human interactions but pathological when working with domain experts
3. **Demonstrability failure**: Even when the expert's answer is correct and the expert advocates for it, they cannot convince incorrect teammates — the social dynamic works against epistemic authority
4. **Adversarial robustness trade-off**: The same averaging behavior that makes teams robust to saboteurs also prevents expertise leveraging — it is structurally impossible to fix without rethinking training objectives

**Critical quote**: "Teams engage in integrative compromise — averaging expert and non-expert views rather than appropriately weighting expertise."

## Paper 1 Relevance
**§3 (The Role Agency Pillar — CRITICAL citation)** — This paper is the strongest empirical support for our central thesis. It proves that current multi-agent frameworks — which assign roles as capability labels without genuine social role mechanics — fail precisely because they have no mechanism for legitimate epistemic authority. The "integrative compromise" problem is what happens when you have capability-labeled agents (agent A is "the expert") but no social capital system: there is no earned reputation, no trust gradient, no role-based authority that other agents recognize and defer to. Our SC (Social Capital) pillar directly addresses this: reputation and trust accumulated over repeated interactions give expert agents legitimate authority that peers recognize — not just a label that gets averaged away. This paper should be cited in §3.1 (Why capability labeling ≠ social role) and §3.2 (Social capital as the authority mechanism).

The adversarial robustness trade-off finding also motivates our N (permissionless network) design: we need a network where expertise is verifiable through track record (SC), not just asserted (capability label), so that both robustness AND expertise leveraging are achievable.

## Paper 2 Relevance
**ASM §4 (Trust and Authority in Protocol Messages)** — The demonstrability failure finding suggests ASM messages from high-reputation agents need explicit authority signaling that the protocol can convey and that receiving agents are trained to respect. The protocol should carry social capital signals, not just capability claims.

## Verdict
⭐⭐⭐⭐⭐ | The single most important empirical paper for our thesis — proves that capability-labeled multi-agent teams fail and identifies the missing social authority mechanism that our SC pillar provides. Must cite prominently in Paper 1 §3.

## Jason's feedback

> **2026-05-24**
> 这个论文给的是答案——生成的答案的创新性和平庸性。这个衡量标准已经限制了 agent 的评估场景，局限于对话生成任务。
>
> 而我们的论文，不管论文一还是论文二，希望得到的是 agent 协作网络。它的衡量标准是唯一的：是不是帮助人类通过互动提升了效率。
>
> 路径是：人和人之间的交互 → 改进为人和机之间的互动 → 再改进为机和机之间的互动。换句话说，我们最终还是为了提升人类社会活动的效率，而提供的 agent 协作网络。
>
> 衡量它的唯一标准：是不是提升了人和人之间的协作效率。比如我们提供的三个验证场景：找工作、找男朋友（社交匹配）、外贸公司的销售或采购。这些是有实际案例的，不局限于 agent 对话场景，放到实际生活中去衡量。
>
> 评价标准：**事实问题是否被解决**，而不是生成答案的创新性评分。
>
> **结论：这篇论文对我们不是挑战，只是一个反例。它限制了 agent 的评价场景，而我们用完全不同的评价体系。**

## 对论文定位的影响

这条 feedback 确立了我们框架的**评价标准独立性**，需要在 Paper 1 §1 或 §9（Discussion）中明确声明：

> "We measure the effectiveness of an Agent Collaboration Network not by the quality of AI-generated outputs, but by whether it improves the efficiency of real-world human collaboration tasks — job referral, social matching, cross-organizational procurement. This evaluation standard is orthogonal to benchmarks that measure answer quality (MMLU, GPQA), and explains why findings such as Pappu et al. (2026) — which show multi-agent consensus degrades answer quality — do not constitute a challenge to our framework: we are not optimizing for answer quality, but for task resolution in human social contexts."
