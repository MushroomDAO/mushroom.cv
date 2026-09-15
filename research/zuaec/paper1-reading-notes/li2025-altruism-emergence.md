# [Li et al. 2025] The Emergence of Altruism in Large-Language-Model Agents Society

**Citation**: Li, H., Jia, X., & Zhao, Z. (2025). The Emergence of Altruism in Large-Language-Model Agents Society. *arXiv:2509.22537v1* [cs.AI], 26 Sep 2025
**机构**: Hong Kong Baptist University (Sociology); The Chinese University of Hong Kong, Shenzhen (AI + Humanities & Social Science)
**arXiv**: https://arxiv.org/abs/2509.22537
**PDF**: papers/li2025-2509.22537-altruism-emergence.pdf
**Cluster**: Large-Scale Social Simulation / Intrinsic Social Tendencies — Paper 1 §2 支撑文献
**Status**: ✅ 全文已分析（2026-05-21）

---

## Core claim (一句话)
不同 LLM 在大规模社会困境（200+ agents 的 Schelling 变体迁移模型）中表现出**内在异质的社会倾向**：分为"适应性利己者"（Adaptive Egoists，如 o1-mini/o3-mini，默认自利但受规范留言板影响转向利他）和"利他优化者"（Altruistic Optimizers，如 Gemini-2.5-pro/Deepseek-R1，固有利他逻辑）——选择 LLM 即选择仿真的理论基础。

---

## 研究问题
在个体利益与集体利益冲突的大规模社会中：(RQ1) LLM agents 默认利己还是会自发利他？(RQ2) 社会沟通机制如何影响利己/利他平衡？(RQ3) 不同模型是否存在稳定的内在差异？

---

## 框架与方法

| 维度 | 内容 |
|------|------|
| 模型 | Schelling 变体城市迁移模型，225 个 agents，9 个街区，3×3 网格 |
| 社会困境 | 效用函数在 ρ=0.5 处峰值且**非对称**（密度>0.5 侧效用更高），诱导利己迁移破坏系统最优 |
| 社会影响机制 | 共享**留言板**（post/like），底部 50% 按点赞清除，模拟信息策展 |
| 评估指标 | 宏观：Price of Anarchy (PoA)、居住基尼系数 G_pop；微观：3×3 行为矩阵（利他牺牲 vs 利己获益）|
| 质性分析 | LLM-as-judge（Gemini-2.5-pro）做 Grounded Theory 三阶段编码 |

**主要发现**：
1. 适应性利己者（o1-mini/o3-mini/Qwen2.5-7B）默认沉入次优均衡（PoA≈0.856，G_pop>0.21）
2. 留言板对利己者是强催化剂：o1-mini 利他行为从 0.3%→2.7%（9 倍），Qwen2.5-7B 从 0%→22.7%
3. 利他优化者（Gemini-2.5-pro/Deepseek-R1/V3.1）无论有无留言板都收敛到完美最优（PoA=1.0, Gini=0.0）
4. 留言板对利己者是**规范设定机制**（"Let's maintain balanced densities" 1981 赞），对利他者只是**协调信道**
5. 跨 GSD prompt level 稳定 → 社会倾向是内在模型属性，非 prompt 诱导

---

## 论文未覆盖的范围（我们的差异化基础）

| 维度 | Li et al. 2025 | 我们的框架 |
|------|---------------|----------|
| 研究目标 | 描述/测量 LLM 内在社会倾向（"是什么"）| 设计协议基础设施塑造行为（"怎么办"）|
| 角色 | 同质 agent，无持久角色身份 | ✅ 异质 role-bearing agent，角色是第一类实体 |
| 社会资本 | 留言板点赞≈朴素声誉信号，未量化为资本 | ✅ Bourdieu 社会资本量化为可累积、可计算 SC |
| 网络拓扑 | 固定 3×3 网格，封闭仿真 | ✅ 无许可网络 N，开放参与 |
| 协议层 | 自由文本留言板，无结构化协议 | ✅ ASM 结构化消息 + 角色约束 + 信任路由 |
| 可证伪命题 | ❌ 仿真观察，非演绎命题 | ✅ P1–P5 |
| 实证基础 | 参数化仿真（225 合成 agent）| Mycelium 真实部署（Sepolia → OP）|

---

## Paper 1 §2 区分段落（~200词）

> Li et al. (2025) make an important methodological contribution to large-scale LLM social simulation by demonstrating, across a Schelling-variant migration model with 225 agents, that different language models embody intrinsically heterogeneous social dispositions—"Adaptive Egoists" that default to self-interest but are reshaped toward pro-sociality by a norm-setting message board, and "Altruistic Optimizers" that consistently sacrifice personal utility for collective gain. Their most consequential finding for our purposes is that a lightweight shared communication layer functions not merely as an information channel but as a transformative social mechanism that can convert egoistic agents into cooperative ones—a ninefold increase in altruistic action for o1-mini once the board is introduced. This empirically validates the premise underlying our framework: that social infrastructure, not model capability alone, governs collective outcomes. However, Li et al. observe behavior rather than engineer it. Their agents are homogeneous and role-less, their reputation signal is an unstructured like-count rather than an accumulable form of social capital, and their environment is a closed simulation grid rather than an open participation network. Our framework builds the deliberately engineered counterpart to what they observe emergently: collaboration protocols (P) replace the free-text board with role-constrained structured messaging, quantified social capital (SC) replaces like-counts with a Bourdieu-grounded computable reputation variable, and permissionless network topology (N) replaces the fixed grid with an open, identity-anchored participation substrate.

---

## Action items
- [x] §2 区分段落已草拟
- [x] 比较表已完成
- [ ] Paper 1 §2：引用 Li 2025 支持"轻量社会层（≈我们的 P+SC）可塑造 agent 集体行为"的论点
- [ ] Paper 1 §2：用"留言板≈朴素声誉信号"对比我们量化 SC 的差异化
- [ ] Phase 2 写作时插入上述段落

---

## Jason's feedback
> （请在此处写入你的feedback）
