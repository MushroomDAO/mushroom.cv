# [Pimpale et al. 2025] Forecasting Frontier Language Model Agent Capabilities
**arXiv**: 2502.15850 | **Year**: 2025 | **Authors**: Govind Pimpale, Axel Højmark, Jérémy Scheurer, Marius Hobbhahn | **Venue**: Apollo Research (preprint)
**Cluster**: Capability Benchmarks & Forecasting
**Status**: Abstract + key results read (ar5iv fatal error; arxiv.org abstract retrieved)

## Core Claim
Using a validated two-step forecasting method (Release Date → Elo → Benchmark), the paper predicts that by early 2026 non-specialized LM agents will reach 54% on SWE-Bench Verified, while state-of-the-art LM agents will reach 87%.

## Key Evidence / Numbers
- **87%** predicted SWE-Bench Verified success rate for SOTA LM agents by **beginning of 2026**
- **54%** predicted SWE-Bench Verified success rate for non-specialized (low capability elicitation) LM agents by same date
- **6 forecasting methods** evaluated: one-step (compute or release date → benchmark) and two-step (release date → Elo → benchmark)
- **38 LMs** from OpenLLM 2 leaderboard used for backtesting validation
- Three benchmark domains covered: SWE-Bench Verified (software dev), Cybench (cybersecurity), RE-Bench (ML research engineering)
- Authors note the two-step method "might be too conservative" given recent inference-compute scaling advances — actual trajectory may exceed forecasts
- Intermediate metric: PC-1 (principal component of cross-benchmark performance) and human-evaluated competitive Elo ratings

## Paper 1 Relevance
**§1 (Motivation — development speed)**: The 87% SOTA / 54% non-specialized split is the single strongest quantitative anchor for the claim that agent capabilities are advancing at unprecedented speed, justifying the need for a collaboration network paradigm now. The gap between SOTA and average also motivates the SC (Social Capital) pillar — not all agents are equal; reputation/trust differentiation matters.

**§5 (Deployment evidence)**: Can be cited alongside SWE-Bench current scores to show the trajectory from ~2022 baselines toward near-human coding performance within 3 years.

## Paper 2 Relevance
Indirectly: rapid capability growth means ASM protocol must be designed for a high-performance, heterogeneous agent landscape rather than today's limited baselines.

## Verdict
⭐⭐⭐⭐⭐ | The single most important quantitative forecast for Paper 1 §1 — "87% by early 2026" is the headline number that motivates urgency for the Three Pillars framework.

## Jason's feedback

> **2026-05-25**
> 这篇论文让我想到了复杂系统。所谓复杂系统，就是它的发展轨迹前期是漫长的低迷时期，当复杂系统达到涌现的级别的时候，会快速成长，达到幂指数级别的增长——直线式的直接上升。
>
> 反观这个 benchmark 预测，它的方法可能有点过拟合，因为拿历史数据回测验证预测方法，这个方法是后置的。
>
> 实际上我们可以借鉴复杂系统这个框架。当前 agent 的发展，包括 agent 本身获取的信息量，可以说是一个复杂系统——吃了这么多信息会孕育出什么，其实是挺难预测的。但它的能力本身的增长，和对人类社会生活的影响，可以明显感知到是在一个加速的过程中。
>
> 我相信这个 agent 可能进入了一个涌现时期。因为它从一个纯粹的性能指标的增长，发展到从软件工程这个行业——软件工程本身既和 AI 有重叠，又和社会有重叠——真正的发展到了社会生活的完整领域。比如找工作、找男朋友和外贸采购销售，这样的场景完全进入了人类的社会领域，而不仅仅是像软件工程这种既覆盖 AI 和信息、又覆盖人类社会工作的领域。换句话说，他的跨领域在加速。
>
> 当然这是一个过程。拿后置的方法来做回测，只能说聊胜于无。我们可能能观察出一些数据，但无法确定未来趋势。把这个科技发展当作复杂系统来看，未来是什么样的趋势，很乐观但谨慎，秉持科学严谨的态度。同时也借鉴复杂系统这个科学学科——它有很多对不可预测的复杂系统给出的科研经验，比如有限的定义（复杂在哪里）、指数级发展的趋势在什么时候爆发。

## 复杂系统视角的技术分析（Jason 洞见）

### 复杂系统的发展轨迹模型

```
典型复杂系统发展曲线:
  阶段 1（积累期）: 漫长低迷，能力在积累但表面无显著变化
      → 原始汤积累有机分子（数十亿年）
      → AI 从 1956 达特茅斯会议到 GPT-3（60年）
  
  阶段 2（临界点）: 某个阈值被突破，涌现开始
      → 蛋白质折叠出现 → 生命涌现
      → GPT-4 → ChatGPT 全球现象
  
  阶段 3（幂指数期）: 不是线性增长，是幂指数（直线上升）
      → 技术渗透率从 5% 到 95% 可能只需几年
      → Agent 从"软件工程工具"到"社会生活参与者"
```

**对 Apollo 预测的质疑**（Jason 洞见）：
- 回测验证 = 后置方法，用已知历史拟合已知历史 → 过拟合风险
- 复杂系统在临界点附近的行为是**不可用历史外推**的
- 87% 这个数字更像是"已经发生的趋势的外推"，而非真正的预测

### Agent 已进入涌现时期的证据（Jason 判断）

**证据 1：跨领域加速**

| 时期 | Agent 覆盖的领域 |
|------|--------------|
| 2022 以前 | 纯技术域（代码生成、文本摘要）|
| 2023-2024 | 技术+专业域（法律、医疗、软件工程）|
| 2025-2026 | **社会生活完整域**（找工作、找伴侣、外贸采购）|

跨领域扩展速度本身就是复杂系统进入幂指数期的标志。

**证据 2：软件工程的特殊意义**（Jason 洞见）

软件工程是一个"中间层"领域：
- 既与 AI/信息深度重叠（SWE-Bench 是技术能力）
- 又与人类社会工作强关联（程序员是社会职业）

从软件工程（中间层）进入完整社会生活域（找对象/采购）= 复杂系统突破了最后一层壁垒，进入真实人类社会。

### 复杂系统科学的借鉴框架

对 Paper 1 §1 的理论支撑：

| 复杂系统概念 | 在 agent 发展中的对应 | 对 P/SC/N 的意义 |
|------------|-------------------|--------------|
| **涌现（Emergence）**| Agent 能力涌现出超越训练的社会行为 | ACN 的协议层是涌现的制度基底 |
| **临界点（Phase Transition）**| Agent 从工具→协作者的跃迁时刻 | P/SC/N 必须在临界点之前建好 |
| **幂指数增长**| 跨领域扩展加速 | 协议的可扩展性（N 支柱）必须能承载幂指数规模 |
| **不可预测性**| 后置回测无法预测涌现时机 | 框架设计需要鲁棒性，而非精确预测 |
| **自组织（Self-Organization）**| Agent 网络自发形成协作结构 | N 支柱的无许可自组织设计哲学 |

### 对 Apollo 预测数字的正确引用方式

**不要用**：
> "Apollo 预测 2026 年 SOTA agent 达到 87%，证明 agent 能力即将成熟" （过于线性/机械）

**正确用法**（结合复杂系统视角）：
> "Apollo Research 的预测（SOTA: 87%, 非专业: 54%，2026 年初）记录了技术能力基准的快速攀升 [Pimpale et al. 2025]。这一轨迹与复杂系统的幂指数增长特征相符——agent 能力从技术域向社会生活域的跨领域扩展，标志着可能已进入涌现阶段。正是在这一窗口，P/SC/N 框架的建立具有最大的战略价值：复杂系统的制度基础必须在涌现到来之前就位，而非之后。"

### 科学态度说明（Jason 亲述）

> 很乐观但谨慎，秉持科学严谨的态度。借鉴复杂系统学科的研究经验：
> - 有限定义：复杂在哪里？边界在哪里？
> - 涌现时机：什么条件触发指数级爆发？
> - 不可预测性的处理：设计鲁棒框架，而非精确预测时间表
