# Voyager: An Open-Ended Embodied Agent with Large Language Models
**arXiv**: 2305.16291 | **Year**: 2023 | **Authors**: Wang, Xie, Jiang, Mandlekar, Xiao, Zhu, Fan, Anandkumar | **Venue**: arXiv preprint (NVIDIA / Caltech / UT Austin / Stanford / UW Madison)

## Core Claim
The first LLM-powered embodied lifelong learning agent — Voyager — continuously explores Minecraft without human intervention by combining three components: an automatic curriculum (GPT-4 proposes progressively harder tasks), an expanding skill library (verified code behaviors stored in a vector database), and an iterative prompting mechanism (environment feedback → self-verification → refinement), achieving open-ended skill accumulation far beyond prior state-of-the-art.

## Key Evidence / Numbers
- **3.3×** more unique items discovered than prior SOTA
- Tech tree mastery: wooden tools **15.3×** faster, stone tools **8.5×** faster, iron tools **6.4×** faster; only method to unlock **diamond tier**
- Map traversal: **2.3×** longer distances across diverse terrain
- Within **160 prompting iterations**: 63 unique items discovered (vs. minimal progress from ReAct, Reflexion, AutoGPT)
- Zero-shot generalization: successfully solves novel tasks in new worlds while all baselines fail entirely
- Skill library: code-based, indexed by text embeddings for semantic retrieval; skills are compositional and reusable
- Up to **4 iterative refinement rounds** per task with environment feedback and GPT-4 critic verification

## Paper 1 Relevance
- **Role**: Old paradigm contrast — exemplifies the "skill library / capability accumulation" paradigm at its best; Voyager's skill library is a canonical capability artifact: private, single-agent, performance-optimized, with no social dimension
- **§2 use**: Cite in §2.2 (self-evolving / open-ended skill accumulation sub-cluster): "Voyager [citation] demonstrates that an agent can build an ever-expanding library of reusable skills through open-ended exploration — yet the library is private capability infrastructure; it encodes no social role, carries no reputation signal, and is inaccessible to other agents in a permissionless network"
- **Pillar**: Framework contrast (the skill library is a capability repository, not a social institution — no P, no SC, no N)

## Paper 2 Relevance
N/A — Paper 1 only. Voyager's "iterative prompting" is between a single agent and its environment, not a communication protocol between role-bearing agents.

## Verdict
⭐⭐⭐⭐ | Include as direct citation — the Minecraft results (3.3× items, diamond-tier achievement) are vivid and memorable; Voyager is a well-known paper and citing it concretely illustrates the capability-accumulation paradigm that Paper 1 argues is insufficient for open collaboration networks.

*Note: Full text retrieved from ar5iv HTML.*

## Jason's feedback
> （请在此处写入你的feedback）
