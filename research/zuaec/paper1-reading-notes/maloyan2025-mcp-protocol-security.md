# Breaking the Protocol: Security Analysis of the Model Context Protocol Specification and Prompt Injection Vulnerabilities in Tool-Integrated LLM Agents
**arXiv**: 2601.17549 | **Year**: 2025 | **Authors**: Narek Maloyan, Dmitry Namiot | **Venue**: arXiv preprint

## Core Claim
The first systematic security analysis of MCP v1.0 identifies three fundamental protocol-level vulnerabilities (capability attestation absence, sampling without origin authentication, implicit trust propagation) that cannot be fixed through implementation hardening — they require protocol-level redesign. AttestMCP reduces attack success rate from 52.8% to 12.4%.

## Key Evidence / Numbers
- Overall MCP attack success rate amplification: **+26.4%** vs non-MCP baseline
- Cross-server propagation amplification: **+41.6%**
- Tool response manipulation amplification: **+23.7%**
- Sampling-based injection success rate: **67.2%**
- AttestMCP reduction: **52.8% → 12.4%** ASR (76.5% reduction)
- AttestMCP latency overhead: **8.3ms median** per message
- Cross-server attack reduction: **85.8%**
- Three LLM backends tested: Claude-3.5-Sonnet, GPT-4o, Llama-3.1-70B
- Five MCP server implementations, 2–5 concurrent servers
- 847 test scenarios via ProtoAmp framework
- Three architectural vulnerabilities: (1) no capability attestation, (2) sampling without origin auth, (3) implicit trust propagation

## ASM Comparison (Paper 2 focus)
- **What it does**: Provides the most rigorous quantitative analysis of MCP's security failures + AttestMCP as a protocol extension adding capability attestation and message authentication — directly prototypes what ASM's security layer needs to provide
- **Gap vs ASM**: AttestMCP is a bolt-on extension to MCP, not a new protocol. ASM is designed from the ground up with attestation and identity. The three vulnerabilities AttestMCP patches are not present in ASM's architecture: (1) ASM has DID-based capability attestation by design, (2) ASM messages carry authenticated origin headers, (3) ASM has role-isolated trust domains preventing cross-role propagation
- **Paper 2 §1 and §5 use**: Companion to Radosevich (2504.03767) — together they provide both attack evidence and quantification. Cite the three vulnerability types as the protocol-design requirements ASM satisfies. Reference AttestMCP's 8.3ms overhead as the acceptable latency ceiling for ASM's security layer

## Paper 1 Relevance
- **§5 (security risks)**: The three MCP vulnerabilities provide the concrete threat taxonomy for Paper 1's protocol security section — most precise characterization of the design-level risks
- **§4.1 (N pillar)**: The implicit trust propagation problem (multi-server cascade attacks) is directly addressed by ASM's role-isolated routing

## Verdict
⭐⭐⭐⭐⭐ | Essential pair with Radosevich (2504.03767) — together these two papers provide the strongest motivation for ASM. This paper adds quantified attack amplification (26.4%) and AttestMCP's overhead baseline (8.3ms). Cite in P2 §1, §5; P1 §5.

---
*Jason's feedback*: [待填]
