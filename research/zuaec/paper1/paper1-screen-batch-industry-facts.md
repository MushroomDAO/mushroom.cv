# Industry Facts & Development Speed — Candidate Batch

> Created: 2026-05-22 | Agent: industry-facts search
> Purpose: Evidence of AI agent development speed and maturity for Paper 1 §1 motivation + §4 context
> Total candidates: 28 entries across 4 categories

---

## Category A: Major Lab Research Papers

| ID | Title | Org/Authors | Year | Source (URL/arXiv) | ⭐ | Key Fact for Citation |
|----|-------|-------------|------|-------------------|----|-----------------------|
| A1 | Trustworthy Agents in Practice | Anthropic | 2025 | https://www.anthropic.com/research/trustworthy-agents | ⭐⭐⭐⭐⭐ | Anthropic frames Claude Code and Claude Cowork as "agents" that write/execute code, manage files, and complete multi-app tasks — marks pivot from LLM to autonomous agent paradigm |
| A2 | The 2025 AI Agent Index: Documenting Technical and Safety Features of Deployed Agentic AI Systems | MIT/HAI (multiple authors) | 2025 | https://arxiv.org/abs/2602.17753 | ⭐⭐⭐⭐⭐ | Documents 30 state-of-the-art deployed agents; finds most developers share little info about safety/evaluation — establishes baseline of agent ecosystem in 2025 |
| A3 | Co-Scientist: A multi-agent AI partner to accelerate research | Google DeepMind | 2026 | https://deepmind.google/blog/co-scientist-a-multi-agent-ai-partner-to-accelerate-research/ | ⭐⭐⭐⭐⭐ | Production multi-agent system (Generation + Proximity + Reflection agents); graduated to Nature paper May 2026 — concrete proof of role-differentiated agent collaboration in science |
| A4 | ARE: Scaling up Agent Environments and Evaluations | Meta AI | 2025 | https://arxiv.org/abs/2509.17158 | ⭐⭐⭐⭐ | Meta's platform for scalable agent env creation; includes Gaia2 benchmark; bridges model development and real-world deployment at scale |
| A5 | HyperAgents: Self-Improving Multi-Agent Systems | Meta AI | 2025 | https://ai.meta.com/research/publications/hyperagents/ | ⭐⭐⭐⭐ | DGM-H system improves across coding, paper review, robotics reward design, math grading — evidence of cross-domain self-improving agents |
| A6 | Toward Training Superintelligent Software Agents through Self-Play SWE-RL | arXiv | 2025 | https://arxiv.org/abs/2512.18552 | ⭐⭐⭐⭐ | Self-play RL paradigm for software agents; requires only sandboxed repos and no human-labeled data; signals direction toward autonomous agent capability development |
| A7 | Punctuated Equilibria in Artificial Intelligence | arXiv | 2026 | https://arxiv.org/pdf/2603.14664 | ⭐⭐⭐⭐ | Argues agentic systems (Claude Code, OpenClaw) emerged in early 2026 as "niche constructors" reshaping codebases and deploying skills to robots — framing agents as societal actors |
| A8 | The Orchestration of Multi-Agent Systems: Architectures, Protocols, and Enterprise Adoption | Adimulam, Gupta, Kumar | 2026 | https://arxiv.org/abs/2601.13671 | ⭐⭐⭐⭐⭐ | Comprehensive survey of MCP + Agent2Agent (A2A) protocols; documents enterprise deployment patterns — directly relevant to Paper 2 protocol framing |

---

## Category B: Benchmarks & Performance Data

| ID | Title | Org/Authors | Year | Source | ⭐ | Key Metric |
|----|-------|-------------|------|--------|----|-----------| 
| B1 | SWE-bench Verified Leaderboard (live) | Princeton / Scale AI | 2025–2026 | https://benchlm.ai/benchmarks/sweVerified / https://epoch.ai/benchmarks/swe-bench-verified | ⭐⭐⭐⭐⭐ | As of May 2026: Claude Mythos Preview leads at **93.9%**; Claude Opus 4.7 at 87.6%; GPT-5.3 Codex at 85% — from 1.96% (Claude 2, 2023); 47 models evaluated |
| B2 | SWE-Bench Pro: Can AI Agents Solve Long-Horizon Software Engineering Tasks? | Scale AI | 2025 | https://arxiv.org/abs/2509.16941 | ⭐⭐⭐⭐ | On harder SWE-Bench Pro, best agents reach only 23.3% (public set) — exposes gap between standard benchmark saturation and real-world complexity |
| B3 | Forecasting Frontier Language Model Agent Capabilities | Pimpale, Højmark, Scheurer, Hobbhahn (Apollo Research) | 2025 | https://arxiv.org/abs/2502.15850 | ⭐⭐⭐⭐⭐ | Predicts: by early 2026, non-specialized agents reach 54% on SWE-Bench; SOTA agents reach **87%** — quantitative capability trajectory with forecasting methodology |
| B4 | Stanford AI Index 2026 — Chapter 2: Technical Performance | Stanford HAI | 2026 | https://hai.stanford.edu/assets/files/ai_index_report_2026_chapter_2_technical.pdf | ⭐⭐⭐⭐⭐ | AI agents achieved 12% → **66.3%** jump on OSWorld (real computer tasks); within 6 points of 72.35% human baseline — most dramatic capability jump tracked across years |
| B5 | ARC-AGI-3: A New Challenge for Frontier Agentic Intelligence | arXiv | 2026 | https://arxiv.org/abs/2603.24621 | ⭐⭐⭐⭐ | Interactive video game benchmark requiring agents to explore novel environments, infer goals, plan — humans 100%, frontier AI <1% as of March 2026; marks next frontier |
| B6 | GAIA: A Benchmark for General AI Assistants (and 2025 leaderboard results) | Meta / HuggingFace | 2023–2025 | https://huggingface.co/gaia-benchmark | ⭐⭐⭐⭐ | H2O.ai reached **75% accuracy** (grade C) — first to cross that threshold, ahead of OpenAI Deep Research; benchmark tracks general-purpose assistant maturity |
| B7 | Towards a Science of Scaling Agent Systems | arXiv | 2025 | https://arxiv.org/abs/2512.08296 | ⭐⭐⭐⭐ | Introduces quantitative scaling principles for agent systems — performance varies with coordination, model capability, and system/task factors; v2 updated April 2026 |
| B8 | WebArena Progress 2025: 14.41% → 61.7% | IBM / multiple | 2025 | (cited in: https://simmering.dev/blog/agent-benchmarks/) | ⭐⭐⭐ | WebArena baseline 14.41% → IBM CUGA 61.7% by early 2025; driven by Planner-Executor-Memory architectures — shows architectural maturation driving benchmark gains |
| B9 | The 2025 AI Agent Index (AI Agent Taxonomy + Safety Survey) | arXiv (also arxiv:2502.01635) | 2025 | https://arxiv.org/abs/2502.01635 | ⭐⭐⭐⭐ | Earlier index documenting agent ecosystem — companion to 2602.17753; captures 2025 baseline diversity of deployed agent types |
| B10 | GitHub Copilot Developer Productivity Data | GitHub / Microsoft | 2025 | https://github.blog/news-insights/company-news/pick-your-agent-use-claude-and-codex-on-agent-hq/ | ⭐⭐⭐⭐ | Developers using Copilot report **55% more productive** at code writing; **75% higher job satisfaction** — largest real-world deployment evidence for coding agents |

---

## Category C: Industry / Investment Reports

| ID | Title | Org | Year | URL | ⭐ | Key Finding |
|----|-------|-----|------|-----|----|-----------| 
| C1 | The State of AI in 2025: Agents, Innovation, and Transformation | McKinsey & Company | Nov 2025 | https://www.mckinsey.com/capabilities/quantumblack/our-insights/the-state-of-ai | ⭐⭐⭐⭐⭐ | **88%** of orgs use AI in at least one function; **23%** scaling agentic AI; **39%** experimenting; only **5.5%** are "high performers" (>5% EBIT impact) — definitive adoption baseline |
| C2 | PwC AI Agent Survey 2025 | PwC | May 2025 | https://www.pwc.com/us/en/tech-effect/ai-analytics/ai-agent-survey.html | ⭐⭐⭐⭐⭐ | **79%** of companies already adopting AI agents; **66%** report measurable productivity gains; **75%** agree agents will reshape workplace "more than the internet did"; **88%** plan to increase AI budgets |
| C3 | Gartner Predicts: 40% of Enterprise Apps Will Feature AI Agents by 2026 | Gartner | Aug 2025 | https://www.gartner.com/en/newsroom/press-releases/2025-08-26-gartner-predicts-40-percent-of-enterprise-apps-will-feature-task-specific-ai-agents-by-2026-up-from-less-than-5-percent-in-2025 | ⭐⭐⭐⭐⭐ | **<5% → 40%** enterprise app integration in one year (2025→2026); agentic AI projected at $450B revenue by 2035 (from 2% in 2025) |
| C4 | Gartner 2026 Hype Cycle for Agentic AI | Gartner | 2026 | https://www.gartner.com/en/articles/hype-cycle-for-agentic-ai | ⭐⭐⭐⭐ | Governance, security, cost profiles emerging alongside core capabilities — signals enterprise adoption depends on social/structural frameworks not just raw capabilities |
| C5 | Stanford AI Index 2026 (Full Report) | Stanford HAI | 2026 | https://hai.stanford.edu/ai-index/2026-ai-index-report | ⭐⭐⭐⭐⭐ | **89% of enterprise AI agent projects never reach production**; avg $150K–$800K spent per failed project; GenAI in at least one function at **70%** of orgs; adoption surged to **88%** but <10% fully scaled in any single function |
| C6 | State of AI 2025 (stateof.ai annual report) | Nathan Benaich / Air Street Capital | 2025 | https://www.stateof.ai/ | ⭐⭐⭐⭐ | "2025 was turning point where AI stopped being helper and became task-owning agent"; **44%** of US businesses now pay for AI tools (up from 5% in 2023); avg contracts reached $530K |
| C7 | State of AI: An Empirical 100 Trillion Token Study | a16z (Andreessen Horowitz) | 2025 | https://a16z.com/state-of-ai/ | ⭐⭐⭐⭐ | OpenRouter grew from ~10T to **100+ trillion tokens/year** as of mid-2025; fastest-growing behavior is "agentic inference" (extended sequences, not single prompts); 5M+ developers, 300+ models from 60+ providers |
| C8 | Epoch AI: Training Compute Costs Doubling Every 8 Months | Epoch AI | 2025 | https://epoch.ai/data-insights/cost-trend-large-scale | ⭐⭐⭐⭐ | Training compute for largest models grows **4-5× annually** since 2010; by 2030 frontier training clusters >$100B and consuming multiple GW of power — scale context for why coordination matters |

---

## Category D: arXiv Preprints on Scaling / Deployment

| ID | Title | Authors | Year | arXiv | ⭐ | Paper 1/2 Use |
|----|-------|---------|------|-------|----|----|
| D1 | Beyond Scaling: Agents Are Heading to the Edge | (multiple) | 2026 | https://arxiv.org/html/2605.18535v1 | ⭐⭐⭐⭐ | Small models (WideSeek-R1-4B) now match 671B DeepSeek-R1 on personal-agent workloads — agents not limited to frontier compute; democratization argument for Paper 1 §4 |
| D2 | AI Agents vs. Agentic AI: A Conceptual Taxonomy | (multiple) | 2025 | https://arxiv.org/html/2505.10468v1 | ⭐⭐⭐⭐ | Systematic taxonomy distinguishing agent types — useful for Paper 1 §2 definitional scaffolding for "role-bearing agents" vs. capability invocation |
| D3 | A Survey on Evaluation of LLM-based Agents | (multiple) | 2025 | https://arxiv.org/html/2503.16416v2 | ⭐⭐⭐⭐ | Comprehensive survey of 50+ benchmarks for agentic AI evaluation as of Oct 2025 — establishes evaluation landscape and maturity signals for Paper 1 §4 |
| D4 | AgentArch: A Comprehensive Benchmark to Evaluate Agent Architectures in Enterprise | (multiple) | 2025 | https://arxiv.org/html/2509.10769v1 | ⭐⭐⭐ | Enterprise-specific benchmark for agent architectures; addresses real-world deployment constraints not captured by academic benchmarks |
| D5 | Open Challenges in Multi-Agent Security: Towards Secure Systems of Interacting AI Agents | (multiple) | 2025 | https://arxiv.org/html/2505.02077v2 | ⭐⭐⭐⭐ | Documents security challenges unique to multi-agent interaction (trust, delegation, prompt injection at scale) — supports Paper 2 motivation for structured identity/role protocols |
| D6 | Distinguishing Autonomous AI Agents from Collaborative Agentic Systems | (multiple) | 2025 | https://arxiv.org/html/2506.01438v1 | ⭐⭐⭐⭐ | Framework distinguishing individual autonomous agents from collaborative agentic systems — conceptual foundation for Paper 1 three-pillar framing |
| D7 | More AI Agents Isn't Always Better (Google Research + MIT) | Google Research, MIT | 2025 | https://the-decoder.com/more-ai-agents-isnt-always-better-new-google-and-mit-study-finds/ | ⭐⭐⭐⭐⭐ | 180 controlled experiments: multi-agent systems showed **81% boost to 70% drop** in performance depending on task — empirical evidence that coordination structure (not just scale) determines outcomes; directly motivates need for social/role frameworks |

---

## Key Facts Summary (for Paper 1 §1 opening)

These statistics can anchor the motivation section — ordered from capability evidence to adoption gap to coordination need:

1. **Benchmark acceleration**: SWE-bench Verified scores rose from 1.96% (Claude 2, 2023) to 93.9% (Claude Mythos Preview, May 2026) in under 3 years — the fastest-ever capability trajectory on a complex software task benchmark.

2. **Computer use breakthrough**: Stanford AI Index 2026 reports AI agents jumped from 12% to 66.3% on OSWorld (real OS tasks), landing within 6 points of the 72.35% human baseline.

3. **Enterprise adoption surge**: McKinsey (Nov 2025) — 88% of organizations now use AI in at least one function; 62% are experimenting with or scaling AI agents. Yet only 5.5% are high performers seeing >5% EBIT impact.

4. **Production deployment gap**: Stanford AI Index 2026 finds 89% of enterprise AI agent projects never reach production, despite $150K–$800K investments per project — the failure is organizational and structural, not technical.

5. **Coordination determines outcomes**: Google Research + MIT (180 experiments) find multi-agent systems produce an 81% boost or 70% drop in performance depending solely on coordination structure — raw agent capability is insufficient; social organization matters.

6. **Deployment explosion**: Gartner (Aug 2025) predicts <5% → 40% of enterprise apps featuring AI agents within a single year (2025→2026), with 33% of enterprise software to include agentic AI by 2028.

7. **Token volume signal**: a16z's 100-trillion-token study shows "agentic inference" (extended multi-step sequences) is the fastest-growing inference pattern as of mid-2025, displacing single-prompt interactions.

8. **Compute scaling**: Epoch AI documents training compute growing 4-5× annually since 2010, with frontier model clusters projected to exceed $100B by 2030 — structural pressure driving specialization and collaboration over monolithic models.

9. **Safety/transparency deficit**: The 2025 AI Agent Index (MIT, arXiv:2602.17753) documents 30 deployed agents and finds most developers share little information about safety, evaluations, or societal impact — institutional void that social frameworks must fill.

10. **Role-specialized multi-agent in production**: Google DeepMind's Co-Scientist (Nature, May 2026) deploys purpose-built role-differentiated agents (Generation + Proximity + Reflection) for scientific hypothesis generation — existence proof for the Paper 1 three-pillar thesis.

---

## Notes for Jason

- **Highest priority to verify**: B1 (SWE-bench leaderboard live data, check date-stamped snapshot), C3 (Gartner % figures, behind paywall), C5 (Stanford 89% failure stat — confirm exact methodology).
- **Non-paywalled, directly citable**: A2 (arXiv:2602.17753), B3 (arXiv:2502.15850), B7 (arXiv:2512.08296), A8 (arXiv:2601.13671), D5, D6, D7.
- **Industry reports (cite as grey literature)**: C1 (McKinsey), C2 (PwC), C3 (Gartner), C6 (stateof.ai), C7 (a16z) — use "Industry Report" citation style with access date.
- **Paper 2 most relevant**: A8 (MCP + A2A protocols survey), D5 (multi-agent security), A3 (Co-Scientist role differentiation).
- **Paper 1 §1 most relevant**: C1, C2, C3, C5, D7 (the "coordination matters" empirical finding is the strongest argument for why social frameworks are needed beyond raw capability).
