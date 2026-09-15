# Paper 3 工作目录

**Paper 3**：标准 Agent 设计 + ACN 接入工程（Pi 底座工程落地）

## 文档导航

| 文档 | 作用 |
|------|------|
| `paper3-draft-v0.md` | Paper 3 论文初稿（五模块框架 + Tier 评测 + IFI/MAI）|
| `agent-network-architecture.md` | agent 网络架构设计 |
| `01-feature-requirements.md` | **需求清单**：Paper 1/2/3 全部 feature → 工程需求项（优先级 + 里程碑）|
| `02-pi-research.md` | **Pi 调研**：pi-mono 架构实情（5 大扩展钩子 + pi-ai 本地模型）|
| `03-technical-plan.md` | **技术方案**：ACN-Agent on Pi 架构 + feature 映射 + 可行性 + 4+1 里程碑 + 测试 |

## 一句话总结

以 **Pi（pi-mono，TS，54k★，MIT）** 为底座，通过其 5 个扩展钩子（transformContext / convertToLlm / beforeToolCall / afterToolCall / streamFn）+ 自定义消息类型 + AgentTool 集，注入 LAAS 隐私层、ASM 协议、SC 声誉、Nostr relay 网络，落地为 ACN-Agent。不 fork、不对抗框架。

## 下一步

`03-technical-plan.md` §七 列了 6 个待确认项；建议先打通 **M2 最小 demo**（两 agent 跨 relay 完成 ASM 握手）作为 Paper 3 最有力的工程证据。
