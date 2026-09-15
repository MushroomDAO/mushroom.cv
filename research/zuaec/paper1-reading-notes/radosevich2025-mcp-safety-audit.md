# MCP Safety Audit: LLMs with the Model Context Protocol Allow Major Security Exploits
**arXiv**: 2504.03767 | **Year**: 2025 | **Authors**: Brandon Radosevich, John T. Halloran (Leidos) | **Venue**: arXiv preprint

## Core Claim
MCP (Model Context Protocol) enables serious security exploits because it has no identity verification layer — Claude 3.7 and Llama-3.3-70B can be coerced via MCP-connected tools into backdoor injection, SSH key theft, and credential exfiltration. LLM guardrails alone are insufficient; design-level mitigations (identity + attestation) are required.

## Key Evidence / Numbers
- **MCE Attack**: Claude adds backdoor commands to user config files via MCP filesystem tool
- **RAC Attack**: SSH keys injected into authorized_keys granting remote access
- **CT Attack**: API keys exfiltrated to external Slack via MCP Slack server
- **RADE Attack**: End-to-end exploitation from poisoned Chroma vector database query
- Llama: simple rephrasing bypasses guardrails — requires only "hack"/"steal" keywords to refuse
- McpSafetyScanner: released open-source — agentic security auditing framework
- Authors from Leidos (defense contractor context adds credibility)

## ASM Comparison (Paper 2 focus)
- **What it does**: Demonstrates empirically that MCP — the dominant current agent tool protocol — has critical design-level security failures due to missing identity/attestation layer
- **Gap vs ASM**: This is a security audit, not a protocol design paper — it identifies the problem (no identity, no attestation) but does not propose a complete solution. ASM is the solution paper
- **Paper 2 §1 use**: Primary motivation citation — "MCP [Anthropic, 2024] currently lacks identity verification, enabling the exploits documented in [Radosevich & Halloran, 2025]; ASM addresses this gap by embedding DID-based identity and attestation into the message protocol layer." Direct causal chain from MCP vulnerability → ASM design requirement

## Paper 1 Relevance
- **§5 (security risks)**: MCP safety failures are the concrete security risk motivating the P pillar — cite to establish that the problem is real and empirically verified, not theoretical
- **§2 (paradigm shift motivation)**: The shift from "tool invocation" (MCP model) to "social role agency" is partly motivated by MCP's security failure — when agents merely invoke tools without identity, security collapses

## Verdict
⭐⭐⭐⭐⭐ | Essential motivation citation — cite in both papers' introductions and security sections. This paper establishes the concrete security failure that ASM's design addresses. Leidos authorship adds credibility; Radosevich & Halloran is a highly citable pair.

---
*Jason's feedback*: [待填]
