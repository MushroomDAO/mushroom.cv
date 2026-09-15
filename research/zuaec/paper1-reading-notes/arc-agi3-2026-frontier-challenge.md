# [ARC-AGI-3 2026] ARC-AGI-3: A New Challenge for Frontier Agentic Intelligence
**arXiv**: 2603.24621 | **Year**: 2026 (as of March 2026) | **Authors**: ARC Prize team | **Venue**: Preprint / Benchmark Release
**Cluster**: Capability Benchmarks & Frontier Limits
**Status**: Full read (ar5iv succeeded — detailed tables retrieved)

## Core Claim
ARC-AGI-3 introduces an interactive benchmark measuring agentic intelligence through action efficiency in novel environments; as of March 2026, humans solve 100% of environments while all frontier AI systems score below 1%, marking the next unsolved capability frontier.

## Key Evidence / Numbers
**Human Baseline:**
- Humans: **100%** success rate on all environments
- Median human attempt duration: **7.4 minutes** per environment
- Successful human attempts median: **8.1 minutes**
- **486 unique participants** in benchmark validation
- **414 candidate environments** designed
- **2,893 total environment attempts** recorded
- **427.9 hours** total human play time

**Frontier Model Scores (Semi-Private Leaderboard, March 2026):**
| Provider | Model | Score |
|----------|-------|-------|
| Google | Gemini 3.1 Pro Preview | **0.37%** |
| OpenAI | GPT 5.4 (High) | **0.26%** |
| Anthropic | Opus 4.6 (Max) | **0.25%** |
| xAI | Grok-4.20 (Beta 0309 Reasoning) | **0.00%** |

- All frontier models: **"below 1%"** — the human-AI gap is essentially complete
- Best competition approach (StochasticGoose, informed search): **12.58%** on public environments only
- Academic approaches (Duke University, Symbolica AI): solved public environments via domain-specific optimization — not generalizable

**Benchmark Structure:**
- Public demonstration set: **25 environments**
- Semi-private set: **55 environments**
- Fully private set: **55 environments**
- Each environment contains minimum **6 levels**
- Tutorial levels: solvable by **100%** of humans (calibration)

**Key Failure Modes Identified:** Exploration strategies, hypothesis revision under uncertainty, efficient planning — these are collaborative/social capabilities, not pure knowledge retrieval.

## Paper 1 Relevance
**§1 (Motivation — bounded but rapid progress)**: ARC-AGI-3 provides the essential counterpoint to the 87% SWE-Bench forecast (2502.15850). The story is: *within narrow task domains* (structured software dev), agents approach human-level; *in general agentic intelligence* (novel environment navigation), the gap remains almost complete. This dual-track framing motivates the Three Pillars as a design response to capability *heterogeneity* — agents excel in specialized domains, making *collaboration* (P pillar) and *reputation by domain* (SC pillar) essential.

**§1 quote anchor**: "humans solve 100% of environments, frontier AI systems score below 1%" — use to show capability frontier is still actively expanding, validating timeliness of Paper 1.

**§1 (rapid progress evidence)**: The fact that ARC-AGI-3 was designed *because* ARC-AGI-2 was solved shows the benchmark frontier is advancing — not static.

## Paper 2 Relevance
The failure modes (exploration, hypothesis revision, planning under uncertainty) are precisely where multi-agent collaboration via ASM protocol would have impact — agents with complementary specializations could collectively navigate novel environments better than any single agent. This is a potential future work direction.

## Verdict
⭐⭐⭐⭐ | Essential counterweight to capability optimism — the "humans 100%, frontier AI <1%" statistic is the most dramatic capability gap figure available as of 2026; use in §1 alongside the SWE-Bench 87% forecast to argue for domain-specialized, collaborating agents rather than universal superintelligence.

## Jason's feedback

> **2026-05-25**
> Keras 作者这也算是大牛了，他算是 AI 领域的前辈。他给出的洞见，实际上是通过实证的方式证明了人类得满分的这些测试，而一些前沿模型——GPT-4o 是全模态的竟然还不行，得分小于 1%。这说明通用的单体的 agent 还不行。他是用来论证这个观点的：通用 agent 还不行，专业化协作才是现实路径。专业化协作实际上也映射了我们的观点，就是我们要去走这个 agent 协作网络的方式，因为能力和信息是达成协作的前提。比如我可以挣馒头，我可以做面包，同时别人也需要它，你就能达成一个基本的社会协作。
>
> 我认为我们的维度高于作者的维度。作者是从 AI 这个领域来看，我们是从整个 AI 进化大方向去看的。但是他给出的论证，我认为是很棒的——专业化协作 agent 才是实现的路径，才能真的向人靠近。因为他隐含了一个观点：agent 这个 intelligence 的 evolution 的路径就是接近于人才是正确的，我认为这是他隐含的观点。
>
> 现实也证明了，他这个论文是 2026 年发表，估计做的测试是 2025 年吧，现在可能很多已经接近了。专业化协作 agent 协作，我认为是一个很重要的关键词，也是我们认可和推崇的。

## 技术分析：Chollet 的隐含观点 + Jason 的维度框架 + 专业化协作论证

### 1. Chollet 的隐含观点——Jason 挖掘到了

Jason 说"他隐含的观点是：agent intelligence 的 evolution 路径就是接近于人才是正确的"——这个解读准确。

```
Chollet 的核心信念（从 ARC-AGI 1→2→3 一以贯之）：
  真正的 intelligence = 用极少样本解决新颖问题（few-shot generalization）
  → ARC 任务设计：每题仅 3-4 个示例，没有预训练数据泄露
  → 人类无需大量样本即可理解抽象规律 → 满分
  → 前沿 LLM 依赖海量预训练，遇到真正新颖的模式 → <1%

隐含逻辑链：
  LLM = "压缩的人类知识库"，不是"真正的推理者"
  → 向人靠近的路径不是更大的模型
  → 而是专业化 + 协作 = 组合出接近人类的集体推理能力
```

**Jason 补充了 Chollet 没有明说的一步**：单体通用 agent 无法达到人类抽象推理水平 → 通过**专业化 agent 的协作网络**来实现接近人类的集体智慧，才是现实路径 → 这正是 ACN 的核心动机。

### 2. "我们的维度高于作者维度"——正式化

```
Chollet 的视角（AI 能力评测维度）：
  问题：现有 AI benchmark 是否真的测量了 intelligence？
  → 结论：需要 ARC-AGI 测真正的 few-shot 泛化

我们的视角（AI 社会演化维度）：
  问题：即使单体 agent 能力达到人类水平，协作问题是否解决？
  → 结论：需要 P/SC/N 提供社会协作基础设施

维度关系：
  Chollet：agent 能力够不够 → 能力评测问题（低一层）
  我们：能力够了之后，如何协作 → 社会制度问题（高一层）
  → 我们的框架预设能力会继续发展，然后解决"能力有了之后的协作问题"
  → 即使 ARC-AGI 被解决，P/SC/N 框架的需求依然成立
```

### 3. "能力和信息是达成协作的前提"——Jason 的社会协作条件论

Jason 举例：我会做馒头，别人需要馒头 → 达成基本社会协作。这是比较优势 + 信息可见的协作条件：

```
社会协作的四个充分条件：
  条件 1：能力互补（我有你没有的专长）← ARC-AGI3 证明专业化是路径
  条件 2：信息可见（你知道我有这个能力）← N 支柱（relay 发现）
  条件 3：信任机制（你相信我会履行承诺）← SC 支柱（声誉）
  条件 4：协议约定（我们同意如何交换）← P 支柱（ASM 协议）

当前 agent 网络缺失：条件 2、3、4 → P/SC/N 补齐
```

### 4. 时效性处理

论文测试约在 2025 年，Jason 说现在能力可能已经提升。处理方式：
- 引用注明测试时间点（2025 年底 / 2026 年 3 月）
- 强调：即使分数提升，**人类满分 vs AI 显著差距的结构性发现**仍然有效
- 我们的框架不依赖"单体 agent 永远不行"——能力提升后专业化协作的价值只会更大

### 在论文中的引用位置

| 位置 | 引用方式 |
|------|---------|
| **Paper 1 §1**（动机）| "ARC-AGI-3 [2026] demonstrates that frontier models score <1% where humans score 100%, confirming that general-purpose single agents cannot yet match human-level abstract reasoning. The path toward human-level collective intelligence therefore requires specialized agents with proper collaboration infrastructure: capability discovery (N), trust accumulation (SC), and coordination protocols (P)." |
| **Paper 1 §1**（双轨论证）| 与 SWE-Bench 87% 并置：窄域任务 agent 接近人类水平，通用任务差距仍巨大 → 专业化协作才是现实路径 |
