# [Li et al. 2023] CAMEL: Communicative Agents for "Mind" Exploration of Large Language Model Society

**Citation**: Guohao Li*, Hasan Abed Al Kader Hammoud*, Hani Itani*, Dmitrii Khizbullin, Bernard Ghanem. "CAMEL: Communicative Agents for 'Mind' Exploration of Large Language Model Society." *37th Conference on Neural Information Processing Systems (NeurIPS 2023)*. arXiv:2303.17760v2 [cs.AI], 2 Nov 2023. (*Equal contribution.) Project: https://www.camel-ai.org ; code: https://github.com/camel-ai/camel
**机构**: King Abdullah University of Science and Technology (KAUST)
**arXiv**: https://arxiv.org/abs/2303.17760
**PDF**: papers/camel2023-communicative-agents.pdf
**Cluster**: 经典基石文献（多智能体协作 / role-as-persona 谱系的奠基之作）。是 Paper 1 §2 范式综述中"角色 = prompt 指派人格（role-as-persona）"路线的**典范对照对象**——正是我们"可验证社会角色代理"论点必须超越的框架；同时为 Paper 2 §2 提供 inception prompting 通信范式的对照基线。
**Status**: ✅ 全文已分析（2026-05-22）；标题、作者、机构、arXiv id 全部核实一致

## Core claim (一句话)
通过给两个 LLM 各传一段声明角色的 system prompt（"Never forget you are a `<ASSISTANT_ROLE>` and I am a `<USER_ROLE>`. Never flip roles!"），再用 inception prompting 让它们自动相互提示、循环对话直至完成任务，即可在最小人类干预下实现可扩展的自主多智能体协作，并借此大规模生成对话式指令数据用于研究 LLM 社会的行为与能力涌现。

## 研究问题
能否用一个自主的 communicative agent 取代人类干预，引导对话走向任务完成，从而免除"用户必须依据自身领域专长精心撰写 prompt"的负担？由此进一步探究：当一群 agent 被要求自主协作时会出现哪些挑战（role flipping、助手重复指令、flake replies、消息死循环），以及如何让它们与人类意图对齐并有效合作。

## 方法与主要内容
**Role-Playing 框架（Fig. 1）**：以人类的一个初步 idea + 选定两个角色启动（如 "Python Programmer" × "Stock Trader"）。流程为三段式：(1) **Task Specifier agent** 把模糊 idea 头脑风暴成一个具体任务（在 AI Society/Code 大规模实验中，角色与 idea 本身也由 LLM 自动生成而非人工指定）；(2) **AI Assistant–User 角色分派**：把 system message `P_A`、`P_U` 分别传给两个自回归模型 `F_1`、`F_2`，得到 `A ← F_1^{P_A}`、`U ← F_2^{P_U}`。AI User 充当 task planner（出指令），AI Assistant 充当 task executor（给方案）；(3) **指令跟随式对话**：形式化为 `I_{t+1}=U(M_t)`、`S_{t+1}=A(M_t, I_{t+1})`，消息集 `M_{t+1} ← M_t ∪ (I_{t+1}, S_{t+1})`，直到 AI User 判定任务完成。框架可经 message-passing graph 推广到 >2 个 agent，并可插入 **Critic-In-The-Loop**（AI 或人类）做树搜索式选择。

**Inception Prompting**：prompt 工程仅发生在对话开始时（task specifier prompt `P_T`、assistant prompt `P_A`、user prompt `P_U`），此后两 agent 自动循环互相提示。`P_A`/`P_U` 大体对称，含任务、角色、通信协议、终止条件以及"约束以避免不良行为"（如 Never flip roles、Never instruct me、一次只给一条指令、必须以 `Solution:` 开头、无法执行须诚实拒绝并说明原因）。

**产出与评估**：用框架收集四类数据集——AI Society、Code（双 agent 对话）、Math、Science（单轮 QA），外加 Misalignment 数据集（演示未对齐自主系统的潜在风险）。结果显示 role-playing 方案在 GPT4 与人工评估中优于 gpt-3.5-turbo 单次生成；用渐增数据集微调 LLaMA 研究知识涌现；在 HumanEval / HumanEval+ 上 benchmark 代码生成能力。**Limitations/Future Work**：明确提到当前主要研究"两个 agent 共享共同兴趣"的设定，承认所揭示的只是 AI society 的冰山一角；评估可能因评测者局限而有偏。

## 论文未覆盖的范围（我们的差异化基础）

| 维度 | This paper (CAMEL) | 我们的框架（P/SC/N） |
|------|--------------------|---------------------|
| 角色性质 | 角色 = 对话开始时由 system prompt 声明的人格标签（`<ASSISTANT_ROLE>`/`<USER_ROLE>`），仅是引导任务的剧本设定，无身份持久性、无委托人、不可验证 | 社会角色 = 承载**可验证委托人身份（principal identity）**的 role-bearing agent；角色是跨会话持久、可问责的单元，而非一次性 prompt 标签 |
| 协作机制 (P) | 通信靠 inception prompting 文本约定（"Never flip roles"），协议隐含在 prompt 措辞里，无独立于 prompt 的语义层、凭证或角色声明机制 | **协作协议（P）**为一等公民：消息语义、角色声明、可验证凭证在协议层显式定义，独立于任一模型的 prompt |
| 社会资本 (SC) | 完全缺位——agent 间无声望、信任、历史积累；每个 role-playing session 从零起步、彼此独立 | **量化社会资本（SC）**（Bourdieu/Putnam/Ostrom）作为可累积、可转移、影响准入与协作权重的内生状态变量 |
| 网络 (N) | 封闭的双 agent（或预设图）设定，角色由人类/LLM 预先指派，无开放准入、无 permissionless 加入退出 | **无许可网络（N）**：任意 role-bearing agent 可凭可验证身份无许可加入/退出开放协作网络 |
| 失败模式归因 | role flipping、死循环等被当作需用 prompt 约束修补的"对齐 bug" | 同类问题被重构为缺乏协议层身份/问责（P）与社会资本激励（SC）的**结构性后果** |

## Paper 1 §2 区分段落（~200词）
CAMEL (Li et al., 2023) is the canonical "role-as-persona" framework and a foundational reference for autonomous multi-agent cooperation: by passing each LLM a system message that declares its role ("Never forget you are a `<ASSISTANT_ROLE>` and I am a `<USER_ROLE>`. Never flip roles!") and then letting the two agents prompt each other via *inception prompting*, it elicits scalable, instruction-following collaboration with minimal human input, and harvests large conversational datasets for studying emergent LLM-society behavior. Yet in CAMEL a "role" is exactly a prompt-assigned persona instantiated at conversation start — it carries no persistent identity, no verifiable principal behind it, and no accountability beyond the current session. Our framework supersedes this on three axes. (P) Collaboration Protocols become first-class: message semantics, role declarations, and verifiable credentials live in a protocol layer, not in prompt wording such as "Never flip roles." (SC) Quantified Social Capital (Bourdieu/Putnam/Ostrom) makes reputation, trust, and contribution history accumulable, transferable state — entirely absent in CAMEL's stateless, from-scratch sessions. (N) a Permissionless Network lets any role-bearing agent with a verifiable identity join or leave an open collaboration network, replacing CAMEL's closed, pre-assigned dyad. CAMEL's recurring failures (role flipping, infinite loops) are thus reframed not as prompt-tuning bugs but as structural symptoms of missing protocol-level identity and social-capital incentives.

## Action items
- [ ] Paper 1 §2：将 CAMEL 列为 "role-as-persona / capability-invocation" 路线的代表，作为"我们必须超越的对照"引用（与 Park 2023 generative agents 并列为基石文献）。
- [ ] Paper 1 §1/§2：引用 CAMEL 的 inception prompting 例证"角色 = 对话起始 prompt 标签、无可验证委托人"这一论断。
- [ ] Paper 2 §2：将 inception prompting / 双 agent 指令跟随通信作为 ASM 协议层语义的对照基线（"prompt 内嵌约定" vs "协议层显式语义与凭证"）。
- [ ] 引用 CAMEL 承认的 limitation（仅研究双 agent 共享兴趣设定）支撑"现有工作未触及开放无许可多 agent 网络"的 gap 论述。

## Jason's feedback
> （请在此处写入你的feedback）
