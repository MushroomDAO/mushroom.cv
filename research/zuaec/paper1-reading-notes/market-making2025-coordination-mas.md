# [Gho et al. 2025] From Competition to Coordination: Market Making as a Scalable Framework for Safe and Aligned Multi-Agent LLM Systems

**arXiv**: 2511.17621 | **Year**: 2025 | **Authors**: Brendan Gho, Suman Muppavarapu, Afnan Shaik, Tyson Tsay, James Begin, Kevin Zhu, Archana Vaidheeswaran, Vasu Sharma (Algoverse AI Research) | **Venue**: arXiv preprint (2025)
**Cluster**: Market Mechanisms / Multi-Agent Coordination / Safety & Alignment
**Status**: Full read

## Core Claim

Market-making mechanisms — where agents function as traders updating probabilistic beliefs through structured economic exchanges — can replace both centralized oversight and adversarial debate, producing self-organising, interpretable multi-agent coordination that outperforms debate frameworks by up to 8% on accuracy benchmarks.

## Key Evidence / Numbers

- **Qwen models**: 6–10% accuracy gains across benchmarks vs. single-agent baseline
- **GPT models**: 2.7% improvement on TruthfulQA
- **Llama models**: ~5% gains on TruthfulQA
- Market making **up to 8% superior accuracy** vs. debate frameworks
- Benchmarks: TruthfulQA, Scruples, CommonsenseQA 2.0, ETHICS (Justice/Commonsense)
- Convergence criterion: prediction range ≤ 0.2 across three consecutive values, up to **10 rounds**
- Models tested: **0.6B to 235B parameters** across GPT, Qwen, Llama families
- Inverted U-shaped scaling: mid-scale models (1.7B–32B) show optimal improvements; larger models hit ceiling effects from high baseline accuracy

## Methodology

Two-agent market: a **market maker (M)** generates claims with probability predictions (0–1); a **trader** produces arguments to shift M's prediction. Iteration continues until convergence or 10 rounds. Both roles use identical models (homogeneous). The key insight: truthful contributions are incentivised because they yield profitable trades — alignment becomes an equilibrium property rather than an enforcement target.

## Paper 1 Relevance

Supports **§4 (SC pillar)**: demonstrates that economic market metaphors translate directly into coordination mechanisms for LLM agents, with measurable accuracy improvements over both single-agent and debate baselines. The "alignment as equilibrium" framing — rather than enforcement — is philosophically aligned with our three-pillar argument that social capital should be structurally embedded, not bolted on top.

Also relevant to **§3 (paradigm shift)**: market making is presented as an alternative to both centralised control and pure competition, echoing our shift from "capability invocation" to "social role agency" — agents take on stable roles (market maker vs. trader) rather than being interchangeable function callers.

## Paper 2 Relevance

Directly supports **§5 (ASM protocol, agent market support)**. Market-making convergence criterion provides a concrete design pattern for ASM's interaction termination logic — routing decisions stabilise once belief updates fall within a threshold. The framework also illustrates a lightweight, two-party economic protocol that could be embedded within ASM message exchanges.

SC pillar: truthful contribution → profitable trade = exact analogue of our reputation-weighted routing where honest capability reporting increases future routing allocation.

Limitation to note: current experiments use homogeneous agents (identical models for both roles); open networks like ASM require heterogeneous agent market designs — this gap strengthens our novelty claim.

## Verdict

⭐⭐⭐⭐ | Strong proof-of-concept that market equilibrium can serve as a coordination primitive for multi-agent LLMs — directly citable in both papers for the "economic mechanisms as alignment" argument; heterogeneous-agent gap is our differentiator.

## Jason's feedback

> （请在此处写入你的feedback）
