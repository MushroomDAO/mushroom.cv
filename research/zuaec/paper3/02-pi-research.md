# Pi（pi-mono）框架调研发现

> **用途**：Paper 3 工程底座调研。Pi 是我们选定的 ACN-Agent 底座框架。本文档记录 Pi 的架构实情（基于直接阅读源码 + README + pi.dev 文档，2026-05-26）。
> **仓库**：`github.com/badlogic/pi-mono`（npm scope `@earendil-works`）| 网站 `pi.dev` | 文档 `pi.dev/docs/latest`
> **规模**：54.4k stars | TypeScript | MIT | 驱动 OpenClaw（3 个月 25 万 stars）

---

## 一、为什么是 Pi（设计哲学）

Pi 是**极简主义** agent harness：核心编码 agent 只有 4 个工具（read/write/edit/bash）+ <1000 token 系统提示。它不是一个"全家桶框架"，而是一组**可组合的薄层库**：

| 包 | 作用 |
|----|------|
| `@earendil-works/pi-ai` | 统一多 provider LLM API（含本地模型）|
| `@earendil-works/pi-agent-core` | agent 运行时：工具调用 + 状态管理 + 事件流 |
| `@earendil-works/pi-coding-agent` | 交互式编码 agent CLI（自扩展）|
| `@earendil-works/pi-tui` | 终端 UI 库 |

**对我们的关键意义**：Pi 提供了**恰好够用的扩展钩子**，而不强加架构。我们要的 LAAS、ASM、声誉、relay 全部可以通过 Pi 的钩子注入，而不需要 fork 或对抗框架。

---

## 二、pi-agent-core 架构（核心）

### 2.1 Agent 类

```typescript
import { Agent } from "@earendil-works/pi-agent-core";
import { getModel } from "@earendil-works/pi-ai";

const agent = new Agent({
  initialState: {
    systemPrompt: "...",
    model: getModel("anthropic", "claude-sonnet-4-20250514"),
    thinkingLevel: "medium",
    tools: [...],
    messages: [...],
  },
  convertToLlm: (messages) => messages.filter(...),   // 必需（有自定义消息时）
  transformContext: async (messages, signal) => ...,  // 可选（剪枝/压缩/注入）
  streamFn: customStream,                              // 可选（自定义传输）
  sessionId: "session-123",
  getApiKey: async (provider) => refreshToken(),
  toolExecution: "parallel",                           // 或 "sequential"
  beforeToolCall: async ({ toolCall, args, context }) => {...},  // 可阻断
  afterToolCall: async ({ toolCall, result, isError, context }) => {...},
});
```

### 2.2 五个关键扩展钩子（这是我们整个方案的支点）

| 钩子 | 作用 | 我们用它做什么 |
|------|------|-------------|
| **`convertToLlm`** | 把 `AgentMessage[]` 转成 LLM 能理解的 `Message[]`，过滤掉 UI/控制消息 | **ASM 协议消息作为自定义消息类型**，在这里被过滤——LLM 看不到 ASM 控制头，只看到协作内容 |
| **`transformContext`** | 在 convertToLlm 之前预处理消息（剪枝/压缩/注入外部上下文）| **LAAS 特征提取 + DP 噪声注入 + 记忆召回** 的插入点（数据在进 LLM 前处理）|
| **`beforeToolCall`** | 工具参数验证后、执行前运行，**可阻断执行** | **安全分层 Layer 0-4 的强制点 + 权限模型**：阻止会泄露原始数据的工具调用 |
| **`afterToolCall`** | 工具执行后、结果发出前运行 | 审计标记、声誉更新触发、terminate 控制 |
| **`streamFn`** | 替换默认 LLM 流式调用（用于代理后端）| **路由到本地模型（隐私）或经 Nostr relay 传输** |

### 2.3 自定义消息类型（ASM 的落地机制）

Pi 用**声明合并（declaration merging）**让 `AgentMessage` 可扩展：

```typescript
declare module "@earendil-works/pi-agent-core" {
  interface CustomAgentMessages {
    asm_role_declaration: { role: "asm_role_declaration"; ... };
    asm_reputation_assertion: { role: "asm_reputation_assertion"; ... };
    asm_verification_challenge: { role: "asm_verification_challenge"; ... };
  }
}
```

→ **ASM 协议消息可以成为一等公民的 AgentMessage**，在 agent 内部流转、持久化、审计，但通过 `convertToLlm` 决定哪些进 LLM、哪些只用于协议层。**这正是 M5 社会通信模块的天然落地点。**

### 2.4 AgentTool 接口（TypeBox 类型化）

```typescript
import { Type } from "@earendil-works/pi-ai";  // TypeBox 从 pi-ai 重导出

const tool: AgentTool = {
  name: "erc8004_register",
  label: "Register ERC-8004 Identity",
  description: "...",
  parameters: Type.Object({ ... }),   // TypeBox schema，自动验证
  executionMode: "sequential",        // 可选，覆盖全局
  execute: async (toolCallId, params, signal, onUpdate) => {
    // 失败时 throw（被 agent 捕获为 isError:true，反馈给 LLM 重试）
    onUpdate?.({ content: [...], details: {} });  // 可选流式进度
    return { content: [...], details: {...}, terminate?: true };
  },
};
```

→ **viem（web3）、nostr-tools（relay）、Crawl4AI（数据获取）、MCP 工具** 全部作为 AgentTool 接入。

### 2.5 其他关键能力

- **事件流**：`agent.subscribe(event => ...)`——`agent_start/turn_start/message_*/tool_execution_*/turn_end/agent_end`。→ **审计与可追溯（AUD.1）的天然来源**
- **Steering / Follow-up**：`agent.steer(msg)`（运行中打断）/ `agent.followUp(msg)`（排队后续）→ **Human-in-the-Loop**
- **低层 API**：`agentLoop()` / `agentLoopContinue()`（async generator）→ 完全控制
- **代理模式**：`streamProxy` 让浏览器 agent 经后端代理 → relay 中继参考
- **状态**：`agent.state`（systemPrompt/model/tools/messages/isStreaming/pendingToolCalls）
- **控制**：`agent.abort()` / `agent.waitForIdle()` / `agent.reset()`

---

## 三、pi-ai 架构（LLM 层）

### 3.1 统一多 provider API

`getModel(provider, modelId)`——全类型化，支持：
OpenAI / Azure / **DeepSeek**（一等公民，对应我们 DeepSeek V3.2 计划）/ Anthropic / Google / Vertex / Mistral / Groq / Cerebras / Cloudflare / xAI / OpenRouter / Vercel / MiniMax / Together / GitHub Copilot / Bedrock / Fireworks / Kimi / Xiaomi MiMo

### 3.2 本地模型支持（LAAS 隐私关键）✅

> **"Any OpenAI-compatible API: Ollama, vLLM, LM Studio, etc."**

→ **本地隐私推理原生支持**：Qwen3 30B-A3B / Phi-4 mini 通过 Ollama/vLLM 接入。描述里的 "vLLM pods" 指 Pi 有 vLLM 部署支持。

### 3.3 其他

- **只收录支持 tool calling 的模型**（agentic 工作流必需）
- **TypeBox** schema（`Type`/`Static`/`TSchema` 重导出）→ 工具参数类型安全 + 运行时验证
- **Context 可序列化**："easily serializable and transferable between models" → **会话持久化 + 跨模型 handoff** 原生
- **跨 provider handoff**：session 中途换模型（如本地模型做隐私预处理 → 云模型做复杂推理）
- **成本/token 追踪**、**OAuth providers**、**浏览器可用**

---

## 四、Pi vs 我们的需求——契合度评估

| 我们的需求 | Pi 的支持 | 类型 |
|----------|----------|------|
| ASM 协议消息（M5）| 自定义消息类型 + convertToLlm | **原生钩子** |
| LAAS 数据过滤（数据不出本地）| transformContext + beforeToolCall | **原生钩子** |
| 本地隐私模型推理 | pi-ai OpenAI-compatible（Ollama/vLLM）| **原生** |
| 安全分层 / 权限模型 | beforeToolCall 阻断 | **原生钩子** |
| web3（ERC-8004/SBT/credit）| AgentTool + viem | **自建工具** |
| Nostr relay 连接 | AgentTool / streamFn + nostr-tools | **自建工具** |
| 四层记忆 | transformContext 注入 + 自建存储 | **自建**（Pi 不含记忆）|
| 会话持久化 | Context 序列化 + sessionId | **原生** |
| 审计追溯 | 事件流 + 消息历史序列化 | **原生** |
| Human-in-the-Loop | steer() / followUp() | **原生** |
| 自进化（自扩展工具）| coding-agent 的 read/write/edit/bash 自扩展 | **原生（编码 agent）** |
| MCP 工具 | 作为 AgentTool 接入 | **自建工具**（待确认是否有原生 MCP）|

**结论**：Pi 的扩展点几乎 **1:1 覆盖** 我们的核心需求。最大优势是它**不强加架构**——我们通过钩子注入 ASM/LAAS/声誉，而不是对抗框架。TypeScript 生态让 viem（符合我们技术栈规范）、nostr-tools 原生可用。

**待确认的不确定项**（调研未完全覆盖）：
- Pi 是否有原生 MCP client/server 支持（需查 pi.dev/docs 或 source）
- Pi 是否有类似 pydantic-evals 的评测框架（自净化 fitness function 需要）
- "vLLM pods" 的具体部署形态
- 测试工具（是否有 TestModel/FunctionModel 等 mock 能力）
