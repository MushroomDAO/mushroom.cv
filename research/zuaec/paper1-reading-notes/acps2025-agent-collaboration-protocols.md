# [Liu et al. 2025] ACPs: Agent Collaboration Protocols for the Internet of Agents

**Citation**: Liu, Yu, Chen et al. (2025). ACPs: Agent Collaboration Protocols for the Internet of Agents. *arXiv:2505.13523*
**arXiv**: https://arxiv.org/abs/2505.13523
**Cluster**: Protocol / Architecture — Paper 2 Related Work
**Status**: Skim only（高优先级全文阅读）

## Core claim (一句话)
提出涵盖注册、发现、交互与工具调用的综合协议套件ACPs，解决MCP/A2A/ANP各自割裂、场景局限的问题。

## Key findings (摘要层级)
1. 针对MCP（服务器-客户端工具调用）、A2A（Google的Agent间协作）、ANP（去中心化网络）的碎片化问题
2. 提供统一的注册→发现→交互→工具调用完整流程
3. 2025年5月发表（与ASM同期，是直接竞争者）

## Relation to our framework (ASM Paper 2)
- **Paper 2 §2 比较表**：ACPs是ASM最直接的竞争方案，必须在比较表中有一行专门比较
- **ASM的差异化**：ACPs关注"能力调用流程"，ASM关注"社会角色与授权绑定" — 这是核心差异
- **关键问题**：ACPs是否支持verifiable human-authorization？是否支持privacy-preserving reputation？若不支持→ ASM的三个"simultaneously"仍然成立

## Action items
- [ ] **高优先级全文阅读**：确认ACPs的设计目标列表，与ASM的6维度比较表对位
- [ ] 重点看ACPs是否有"人类授权绑定"机制（如有则需调整比较表）
- [ ] 提取ACPs的协议状态机设计，与ASM的三区块对比
