# Why Do Multi-Agent LLM Systems Fail?
**arXiv**: 2503.13657 | **Year**: 2025 | **Authors**: Cemri, Pan, Yang, Agrawal, Chopra, Tiwari, Keutzer, Parameswaran, Klein, Ramchandran, Zaharia, Gonzalez, Stoica et al. | **Venue**: arXiv preprint

## Core Claim
Multi-agent LLM systems fail primarily due to organizational dysfunction among agents — not individual LLM limitations — as captured in the MASFT taxonomy of 14 failure modes across 3 categories; simple prompt engineering and architectural tweaks are insufficient, requiring structural redesigns informed by organizational theory.

## Key Evidence / Numbers
- 150+ tasks analyzed with 6 expert annotators, Cohen's Kappa = 0.88 (high inter-rater reliability)
- ChatDev achieves only 25% correctness on benchmarks, significantly below single-agent baselines
- Improved prompting + topology redesign yielded only 14% performance gain — indicating fundamental systemic limits
- **MASFT taxonomy — 14 failure modes across 3 categories**:
  - FC1 Specification & System Design (5 modes): task spec violations, role spec disobedience, step repetition, conversation history loss, unaware of termination
  - FC2 Inter-Agent Misalignment (6 modes): conversation reset, failure to request clarification, task derailment, information withholding, ignored peer input, reasoning-action mismatch
  - FC3 Task Verification & Termination (3 modes): premature termination, absent/incomplete verification, incorrect verification
- Failure distribution is balanced — no single category dominates; failure patterns vary by system architecture
- Identifies parallels with High-Reliability Organization (HRO) principles

## Paper 1 Relevance
- **Role**: KEY empirical evidence for why social structure is needed; the 14 failure modes are the negative case that Paper 1's Three Pillars address
- **§4/§5 use**: §4 (Problem Analysis) — cite MASFT as the empirical taxonomy showing what goes wrong when agents lack social roles (FC1: role disobedience), social capital (FC2: information withholding, ignored peer input), and accountable network structure (FC3: verification failures)
- **§3 use**: §3 (Three Pillars rationale) — "failures correlate with HRO violations" directly supports the sociological grounding of Paper 1's framework; SC pillar addresses FC2 failures; P pillar addresses FC1; N pillar (accountability) addresses FC3
- **Pillar**: P/SC/N — all three pillars respond to specific failure modes in MASFT

## Paper 2 Relevance
FC2 failures (information withholding, ignored peer input, reasoning-action mismatch) are exactly what ASM's role-bearing message envelope is designed to mitigate — role attestation + reputation context give receiving agents signal to evaluate and reject or escalate inputs. Cite in ASM §1 (motivation) and §4 (design rationale).

## Verdict
⭐⭐⭐⭐⭐ | Include as citation — HIGHEST PRIORITY for Paper 1; the 14-failure-mode taxonomy is the empirical anchor for all three pillars; also strong for Paper 2 motivation

## Jason's Feedback

> **2026-05-24**
> 这个论文比较符合我们需要引用的范围。他通过论文分析出了 14 类常规问题。我们要针对这些问题——规范失败、通信失败及其细节，通信失败主要原因是什么、如何造成——作为校验我们协议规范设计和系统设计的框架。不管是协议规范设计还是系统设计，都需要借鉴，甚至使用这些规范来校正和检验我们的设计，是否在这些方面上有改进、有提升、有创新。这是重点关照和借鉴的论文。

## MAST 14 类失败 → P/SC/N 对照表（论文使用版）

| # | MAST 失败类型 | 描述 | P 支柱回应 | SC 支柱回应 | N 支柱回应 |
|---|-------------|------|-----------|------------|-----------|
| **FC1 规范与系统设计失败** |
| 1 | Task spec violation | agent 不遵守任务规格 | ASM role contract 强制声明角色边界 | — | — |
| 2 | Role spec disobedience | agent 越权操作 | ASM VC 绑定角色，relay 验证 | SC 低的 agent 路由降权 | — |
| 3 | Step repetition | 重复执行已完成步骤 | FSM 状态机跟踪 CONFIRMED 状态 | — | — |
| 4 | Conversation history loss | 跨轮次上下文丢失 | ASM 消息带 collaboration_id 链接 | — | relay 持久化历史 |
| 5 | Unaware of termination | 不知道任务已结束 | FSM 明确 TERMINATED 状态广播 | — | — |
| **FC2 Agent 间失准失败** |
| 6 | Conversation reset | 对话被意外重置 | ASM session 标识符持久化 | — | relay 端状态存储 |
| 7 | Failure to request clarification | 歧义不澄清直接执行 | ASM CLARIFY performative | — | — |
| 8 | Task derailment | 任务偏离原始目标 | role contract 中 scope 字段限定 | SC 历史记录偏离行为 | — |
| 9 | Information withholding | agent 隐瞒关键信息 | ASM rationale field 强制披露推理 | **SC 核心**：隐瞒行为降低信用积累 | — |
| 10 | Ignored peer input | 忽略对等 agent 的输入 | 协议强制确认 ACK | SC 加权路由：高声誉 agent 输入权重更高 | — |
| 11 | Reasoning-action mismatch | 说一套做一套 | ASM intent + proof payload 两字段必须一致 | SC 记录不一致行为，降信用 | — |
| **FC3 任务验证与终止失败** |
| 12 | Premature termination | 任务未完成就结束 | FSM CONFIRMED 需双方签名 | — | relay 仲裁 |
| 13 | Absent/incomplete verification | 没有验证步骤 | 协议强制 verification phase | — | relay 作为第三方验证节点 |
| 14 | Incorrect verification | 验证标准错误 | role contract 中预定义验证标准 | SC：历史错误验证记录 | — |

**结论**：P/SC/N 三支柱对 14 类失败模式的覆盖率 = 14/14。其中：
- P 支柱（协议）直接响应：1、2、3、4、5、6、7、8、11、12、13、14（12 类）
- SC 支柱（社会资本）直接响应：2、9、10、11、14（5 类，最关键是 FC2 信息类失败）
- N 支柱（网络）直接响应：4、6、12、13（4 类，主要是跨节点状态和仲裁）

**在 Paper 1 §5（结构性空缺）中使用**：以 MASFT 14 类失败为诊断框架，逐类说明现有系统（MCP/A2A/AutoGen）无法解决，P/SC/N 框架逐类回应。
