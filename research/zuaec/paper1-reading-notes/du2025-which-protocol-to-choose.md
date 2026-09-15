# Which LLM Multi-Agent Protocol to Choose?
**arXiv**: 2510.17149 | **Year**: 2025 | **Authors**: Hongyi Du, Jiaqi Su, Jisen Li, Lijie Ding, Yingxuan Yang, Peixuan Han, Xiangru Tang, Kunlun Zhu, Jiaxuan You | **Venue**: Under review at ICLR 2026

## Core Claim
Protocol choice significantly influences multi-agent system behavior — task completion times vary up to 36.5% across protocols (A2A, ACP, ANP, Agora). ProtocolBench provides systematic evaluation across task success, latency, overhead, and robustness; ProtocolRouter achieves up to 18.1% recovery time improvement by dynamically selecting protocols at runtime.

## Key Evidence / Numbers
- Completion time variation: **up to 36.5%** across protocols in streaming scenarios
- Mean latency difference: **3.48 seconds** between best/worst protocols
- ProtocolRouter improvement: **up to 18.1% recovery time** over single-protocol baselines
- Protocols compared: A2A, ACP (Agent Communication Protocol), ANP, Agora
- Evaluation dimensions: task success rate, end-to-end latency, message/byte overhead, robustness under failures
- Benchmarks: GAIA, Fail-Storm Recovery
- ICLR 2026 under review (high-quality venue signal)

## ASM Comparison (Paper 2 focus)
- **What it does**: Provides the first rigorous empirical benchmark comparing existing inter-agent protocols — ProtocolBench is the evaluation framework Paper 2 should position ASM against
- **Gap vs ASM**: ProtocolBench evaluates A2A/ACP/ANP/Agora but none of these protocols carry role-bearing identity or reputation-weighted routing; ASM would be a new entry point for the benchmark. The 36.5% variation shows protocol choice matters — a role+reputation-aware protocol like ASM should reduce variance in trust-sensitive scenarios
- **Paper 2 §2 use**: Direct citation for comparison table — reference ProtocolBench metrics as the evaluation standard; position ASM in the "inter-agent protocol" category alongside A2A/ANP/Agora and note the additional trust+role dimensions it adds. ProtocolRouter's adaptive selection validates ASM's motivation for smarter routing

## Paper 1 Relevance
- **§4.1 (N pillar)**: ProtocolBench's empirical finding that protocol choice matters by up to 36.5% validates Paper 1's claim that the N pillar requires careful protocol design, not just any standard

## Verdict
⭐⭐⭐⭐⭐ | Essential P2 §2 citation — the benchmark paper for protocol comparison. ICLR 2026 venue gives it authority. ASM's comparison table should reference ProtocolBench dimensions. Cite in P1 §4.1 for empirical evidence that protocol choice has significant performance consequences.

---
*Jason's feedback*: [待填]
