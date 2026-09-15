# 参赛项目概念 — Agent协作网络

> **版本**：v0.1（2026-05-20，初稿）
> **状态**：设计中，持续迭代
> **用途**：ZUAEC 8th 参赛核心材料，同时作为 public-goods 分支 Agent 设计的背景框架

---

## 一句话定义

**用区块链基础设施 + AI Agent 构建一个可定义协作协议的去中心化 Agent 协作网络，让任何人和组织都能低成本接入和使用 AI Agent 完成复杂任务。**

---

## 核心问题

普通人和中小组织面临的 AI 使用困境：

| 问题 | 现状 |
|------|------|
| Agent 工具孤岛 | 各工具互不相通，无法协同 |
| 数据和行为不可信 | AI 结果无法验证，易被篡改 |
| 成本和门槛高 | 需要技术能力和资金才能使用 |
| 协作无法自动结算 | Agent 之间的服务交换缺乏信任机制 |

---

## 解决方案：三层架构

```
┌─────────────────────────────────────────────────────────┐
│  应用层（Agent 工具）                                      │
│  微信客服 / 研究助手 / 图片精灵 / 合同雷达 / 财务速记 ...     │
├─────────────────────────────────────────────────────────┤
│  协作协议层（Collaboration Protocol）                      │
│  可定义的协作流程 + Agent 角色注册 + 任务路由 + 结果验证      │
├─────────────────────────────────────────────────────────┤
│  区块链基础层（Mycelium Protocol）                         │
│  AirAccount（无 Gas）+ SuperPaymaster + Registry + GToken │
└─────────────────────────────────────────────────────────┘
```

---

## 核心概念：可定义协作协议

### 什么是协作协议

一个 **协作协议（Collaboration Protocol）** 定义：
- **参与 Agent**：谁来完成哪个环节
- **数据流**：上一个 Agent 的输出如何传给下一个
- **触发条件**：什么情况下启动哪个 Agent
- **结算规则**：服务完成后如何链上结算（GToken / aPNTs）
- **验证机制**：结果如何被链上验证或仲裁

### 协作协议示例

**示例1：电商客服 → 售后 → 退款全自动流程**
```yaml
protocol: ecommerce-cs-flow
agents:
  - role: customer_service      # 微信客服 Agent
    trigger: user_message
    output: intent_classified
  - role: order_query           # 订单查询工具
    trigger: intent == "query_order"
    input: order_id from user
    output: order_status
  - role: refund_processor      # 退款处理 Agent
    trigger: intent == "refund" AND order_status == "eligible"
    output: refund_ticket
settlement:
  currency: GToken
  per_successful_refund: 0.1 GT
```

**示例2：研究报告全自动生成**
```yaml
protocol: research-report-flow
agents:
  - role: document_reader       # 研究助手 Agent
    input: [pdf_files]
    output: structured_summary
  - role: web_searcher          # 联网检索 Agent
    trigger: summary.needs_update == true
    output: additional_sources
  - role: report_writer         # 写作 Agent
    input: [summary, sources]
    output: draft_report
  - role: fact_checker          # 核查 Agent
    input: draft_report
    output: verified_report
settlement:
  currency: aPNTs
  per_report: 50 aPNTs
```

---

## 与 Mycelium Protocol 的关系

```
Mycelium Protocol
    └─ 提供区块链底座
         ├─ Registry.sol → 注册 Agent 角色（KMS / DVT / ENDUSER 等）
         ├─ GToken → Agent 协作的票据和结算单位
         ├─ AirAccount → 用户无需持有 ETH，Gasless 体验
         └─ SuperPaymaster → 赞助 Agent 之间的链上操作

Agent协作网络
    └─ 在 Mycelium 基础层之上
         ├─ 定义协作协议（YAML/JSON 配置）
         ├─ Agent 注册到 Registry（角色 + 抵押）
         ├─ 按协议执行任务
         └─ 链上自动结算
```

---

## 差异化竞争优势

| 维度 | 我们 | OpenAI / 通用 AI 平台 |
|------|------|---------------------|
| 数据主权 | 用户本地，不强制上云 | 数据上传云端 |
| 行为可验证 | 链上记录，可审计 | 黑盒 |
| 成本 | 开源自部署，接近¥0 | SaaS 订阅，月费昂贵 |
| 协作结算 | Agent 之间自动链上结算 | 无原生结算机制 |
| 角色权限 | Registry 合约管理，去中心化 | 平台中心化控制 |

---

## 应用场景（首批）

参考 `docs/public-goods/` 系列设计文档：

| Agent | 目标用户 | 技术栈 |
|-------|---------|--------|
| 微信客服 Agent | 中小商家 | RAG + 工具调用 + 微信 Webhook |
| 研究助手 Agent | 研究生 / 顾问 | PDF解析 + 向量库 + LLM |
| 图片精灵 Agent | 电商卖家 / 创作者 | SDXL/Flux 本地部署 |
| 合同雷达 Agent | 自由职业者 / 中小企业 | 法律规则库 + LLM 分析 |
| 会议秘书 Agent | 创业团队 | Whisper + LLM 摘要 |

---

## 待深化的设计问题

> 这里记录尚未想清楚、需要持续思考的部分

1. **协作协议的标准化**：YAML 配置还是 Solidity 合约定义？两种方式的权衡？
2. **Agent 注册的准入门槛**：任何人可以注册 Agent 吗？还是需要 GToken 抵押？
3. **结果验证机制**：如何链上证明 Agent 的输出是真实可信的？ZK Proof？
4. **跨 Agent 数据隐私**：Agent 之间传递的数据如何加密？用户数据泄露风险？
5. **激励机制设计**：提供好 Agent 的人如何获得持续收益？
6. **恶意 Agent 惩罚**：注册了但输出垃圾的 Agent 如何惩罚？Slash 机制？

---

## 版本历史

| 版本 | 日期 | 变更 |
|------|------|------|
| v0.1 | 2026-05-20 | 初稿，基于 Jason 口述整理 |
