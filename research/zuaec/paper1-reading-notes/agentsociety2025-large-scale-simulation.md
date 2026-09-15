# AgentSociety: Large-Scale Simulation of LLM-Driven Generative Agents Advances Understanding of Human Behaviors and Society
**arXiv**: 2502.08691 | **Year**: 2025 | **Authors**: Jinghua Piao, Yuwei Yan, Jun Zhang, Nian Li, Junbo Yan, Xiaochong Lan, Zhihong Lu, Zhiheng Zheng, Jing Yi Wang, Di Zhou, Chen Gao, Fengli Xu, Fang Zhang, Ke Rong, Jun Su, Yong Li | **Venue**: arXiv preprint (Tsinghua FIB Lab)

## Core Claim
AgentSociety achieves the first large-scale LLM-driven social simulator (10,000+ agents, 5M+ daily interactions) that reproduces four real-world social phenomena — polarization, information cascade, UBI policy effects, hurricane responses — by grounding agents in psychology-based behavioral models and realistic multi-dimensional urban/social/economic environments.

## Key Evidence / Numbers
- **10,000+ agents** across a single simulation
- **5 million daily interactions** (avg. 500 per agent per day)
- Four validated social phenomena reproduced: opinion polarization, inflammatory message propagation, universal basic income effects, hurricane impact adaptation
- Technical stack: Ray for distributed computing, MQTT publish-subscribe for agent messaging, PostgreSQL with COPY for batch storage
- Agents grounded in: Maslow hierarchy of needs, Theory of Planned Behavior, emotional appraisal frameworks
- Environment: OpenStreetMap road networks, SafeGraph POI data for physical grounding
- Supports real-time intervention: GUI for live agent communication and state manipulation

## Paper 1 Relevance
- **Role**: KEY empirical evidence for SC (Social Capital) pillar and for N (Permissionless Network) scalability; shows that agents with social/psychological grounding produce emergent macro-social behaviors that capability-only agents cannot
- **§3 use**: §3.3 (SC pillar) — cite as large-scale empirical evidence that social dynamics (trust, relationship strength, reputation context) are necessary drivers of realistic agent behavior; "relationship strength modulates communication tone" is direct SC evidence
- **§3 use**: §3.4 (N pillar) — 10,000-agent scale with distributed MQTT messaging is empirical proof that permissionless-scale networks are feasible; architecture choices directly inform N's infrastructure requirements
- **§5 use**: §5 Evaluation / Future Directions — the four validated social experiments are a model for how Paper 1's framework could be empirically tested
- **Pillar**: SC (primary) + N (secondary)

## Paper 2 Relevance
The MQTT publish-subscribe messaging at 5M interactions/day is a practical precedent for ASM's message envelope design under scale. The paper shows that message-level metadata (sender relationship context, social role) matters for agent decision-making. Cite in ASM §5 (scalability discussion).

## Verdict
⭐⭐⭐⭐⭐ | Include as citation — HIGHEST PRIORITY for SC pillar; the 10k-agent/5M-interaction scale is the key empirical number to cite when arguing for SC and N pillar necessity

## Jason's Feedback

> **2026-05-24**
> 实际上这些研究跟人类社会是接近的。第七篇（MacNet）的 16 到 32 这个数字，跟人类的邓巴数字也是很接近的。
>
> 这一篇实际上映射了人类群落的聚集过程：很小的部落时，无法产生涌现——没有语言，没有买卖，因为氏族部落本身是自组的。但当大型部落散落在不同地理位置时，每个小部落的特长、人数和诉求都不同，就可能模拟像社会一样的协作涌现，包括这里观察到的职业分化、信任网络、经济不平等。
>
> 这是比较符合常规认知的，也映射到了人类社会的进化：需要人类达到一定数量规模并且有一定聚集程度，才会向下一个阶段进化。这也符合小世界理论（6 度分隔），每个层级都是一个跃迁。
>
> 对这里边测试的具体方式方法、测量维度比较好奇，也希望借鉴核心实验路径和测量准则，包括底层技术栈的实现：通信如何实现？如何让他们日常产生协作？是赋予了什么，还是什么都没赋予让他们自由行动？
>
> **对于我们 N 支柱来说，这是最强的论证，记录下来作为论据。**

## 技术实验路径深度提取（Jason 要求）

### 1. 给 agent 赋予了什么（初始化设置）

**有意赋予的（Designed）**：
```
每个 agent 的初始档案：
  - 人口学属性：年龄、职业、收入水平、居住地（OpenStreetMap 坐标）
  - 心理模型：Maslow 需求层次（生存→安全→社交→尊重→自我实现）
  - 行为框架：Theory of Planned Behavior（态度 + 主观规范 + 行为控制感）
  - 情绪状态：情绪评估框架（喜悦/恐惧/愤怒/悲伤等基础情绪）
  - 社交网络：初始关系图（谁认识谁，关系强度权重）
```

**没有赋予、自然涌现的（Emergent）**：
- 职业分化：agent 根据需求和能力自发专业化
- 信任网络的动态演化：关系强度随交互历史变化
- 经济不平等（Gini 系数 = 0.38）：没有编程不平等，是分工和交换自然产生的
- 舆论极化：没有设定派系，从信息传播中自发产生

**关键洞见**：只给了"人"的基本属性和初始关系图，宏观社会结构是涌现出来的，不是设计出来的 → **完美支持 N 支柱"无许可自组织"的哲学**。

---

### 2. 通信与日常协作的实现方式

**通信技术栈**：
```
MQTT（Message Queuing Telemetry Transport）发布-订阅协议：
  - agent 向 topic 发布消息（"我在咖啡馆，愿意聊天"）
  - 订阅同一 topic 的 agent 收到消息并响应
  - 5M 次/天 = 每个 agent 平均 500 次交互/天
  - 分布式：Ray 框架并行运行 10,000 agent
  - 存储：PostgreSQL + COPY 批量写入（不是逐条写，保证性能）
```

**日常协作如何产生**：
1. agent 根据 Maslow 需求产生"今天想做什么"的意图（如：需要食物→去超市；需要社交→找朋友）
2. 意图触发位置移动（在 OpenStreetMap 上）
3. 在同一地点的 agent 自然相遇，通过 MQTT 通信
4. 通信内容由 LLM 生成，受情绪状态和关系强度调制
5. 交互结果更新关系强度、情绪状态、经济状态

**对我们 ACN 设计的借鉴**：

| AgentSociety 设计 | 我们 ASM/ACN 对应 |
|-----------------|----------------|
| MQTT 发布-订阅 | Nostr relay 发布-订阅（已有，协议兼容）|
| 关系强度权重 | SC 支柱的 VC_rep 评分 + TrustFlow 向量传播 |
| Maslow 需求驱动意图 | ASM 的 Interaction Intent 字段（agent 声明本次协作意图）|
| 地理位置触发相遇 | Relay 发现机制（相同 topic 的 agent 被路由到一起）|
| 情绪调制通信 | ASM 暂不支持（可作为 v2 扩展）|

---

### 3. 测量维度（可借鉴用于评估我们 ACN）

| 测量对象 | 指标 | 我们的对应测量 |
|---------|------|-------------|
| 经济不平等 | Gini 系数 | SC 分布的 Gini（是否少数 agent 垄断社会资本）|
| 信息传播效率 | 消息到达时间、覆盖率 | relay 网络的消息传播延迟 |
| 网络结构 | 聚类系数、平均路径长度（小世界指标）| Mycelium relay 网络的拓扑测量 |
| 涌现验证 | 4 个社会现象的复现精度 | 我们的 3 个场景任务完成率 |

---

### 4. 邓巴数与 MacNet 饱和点的连接（Jason 的洞见）

**邓巴数（Dunbar's Number）= 150**：人类大脑能维持稳定社交关系的上限。
- 核心圈（intimate）：5人
- 支持层（support clique）：15人 ← 接近 MacNet 的 16-32 饱和点
- 同情层（sympathy group）：50人
- 熟人层（acquaintance）：150人

**Jason 的洞见**：MacNet 的 16-32 agent 饱和点对应邓巴数的"支持层"（15 人）——这不是巧合，而是 LLM agent 在信息处理能力上天然继承了人类的认知边界。

**在 Paper 1 §4（N 支柱）的论证链**：
> "MacNet [Qian et al. 2025] shows diminishing returns beyond 16–32 agents in a single collaboration subgraph — a number strikingly close to Dunbar's (1992) 'support clique' of 15 stable social relationships. AgentSociety [Piao et al. 2025] demonstrates that at 10,000-agent scale, macro-social structures (occupational differentiation, trust networks, economic inequality) emerge from agent interaction, just as they do in human societies that exceed the Dunbar threshold. The N pillar's permissionless design is validated at both scales: small (16–32, MacNet) for task collaboration, and large (10,000+, AgentSociety) for societal emergence."
