# ZUAEC 两篇论文规划学术 Review

审阅对象：`research/zuaec-competition` 分支，HEAD `148efc6`。审阅范围包括 `paper-submission-plan.md`、`01-ai-agent-evolution-analysis.md`、`02-human-ai-collaboration-framework.md`、`03-dual-network-experiment.md`、`04-agent-communication-protocol.md`、`project-concept.md`，并阅读 `paper-suggestions-local.md` 作为背景参照但不沿用其判断表述。

## 一、信息来源是否扎实

**Finding 1：当前信息基础可以支持“规划讨论”，但不足以直接支撑 arXiv 论文的学术论证。** doc01 的文件头明确写明来源为 DeepSeek 对话整理，且关联 Mushroom.cv 博客；doc02、doc03、doc04 也均标注为 DeepSeek 对话整理。[research/zuaec/01-ai-agent-evolution-analysis.md, 文件头“来源：DeepSeek对话整理”, L3-L5] [research/zuaec/02-human-ai-collaboration-framework.md, 文件头“来源：DeepSeek对话整理”, L3-L5] [research/zuaec/03-dual-network-experiment.md, 文件头“来源：DeepSeek对话整理”, L3-L5] [research/zuaec/04-agent-communication-protocol.md, 文件头“来源：DeepSeek对话整理”, L3-L5] 这意味着所有文献、数据和归纳判断都必须回到原始论文、标准或官方规范逐条核实，不能把对话整理本身当作二手综述来源。

**Finding 2：文献时间覆盖偏向 2025-2026，对 2022-2024 的 Agent 关键发展脉络覆盖不足。** doc01 摘要自称系统梳理 2025-2026 年前沿研究，参考文献核心列表也集中在 2025-2026 年，只有“斯坦福小镇”作为 2023 年实验被正文提及但未列入参考文献。[research/zuaec/01-ai-agent-evolution-analysis.md, §摘要“系统梳理了2025—2026年”, L11-L13] [research/zuaec/01-ai-agent-evolution-analysis.md, §参考文献（核心）, L162-L173] [research/zuaec/01-ai-agent-evolution-analysis.md, §5.1“经典的‘斯坦福小镇’实验”, L90-L94] 主计划虽然意识到要补“2024 年相关文献”，但行动清单只写 2024，没有覆盖 2022-2023 的 ReAct、generative agents、AutoGen、CAMEL、MetaGPT、AgentBench、tool-use agent 等奠基阶段。[research/zuaec/paper-submission-plan.md, §工作量评估“补充2024年相关文献”, L74-L81] [research/zuaec/paper-submission-plan.md, §行动清单“检索补充2024年相关文献”, L210-L218]

**Finding 3：`[reference:N]` 编号体系在已读文件中不存在，因此“编号可追溯性”目前无法核实。** 我对指定文件全文检索后，没有发现 `[reference:N]` 或同类编号引用。当前引用主要是作者-年份式短称，例如 Mitchell、Feng、Li、Yee、Huang 等；doc01 有核心参考文献列表，doc02-04 没有独立参考文献表。[research/zuaec/01-ai-agent-evolution-analysis.md, §参考文献（核心）, L160-L173] [research/zuaec/02-human-ai-collaboration-framework.md, §与前沿研究的对应, L40-L45] [research/zuaec/03-dual-network-experiment.md, §从“涌现观察”到“涌现培育”, L37-L47] [research/zuaec/04-agent-communication-protocol.md, §二至六技术设计, L17-L140] 若后续论文草稿采用 `[reference:N]`，必须建立完整 bibliography；目前所有“reference 编号”均应标记为未建立、无法核实。

**Finding 4：若干量化主张和机构报告主张缺少可追溯原文，属于 must-fix。** doc01 引用“日本总务省的报告”和“卡内基国际和平基金会2026年报告”，但没有报告题名、链接或文献条目；同时声称 GPT 5.4 在 220 项任务中 83% 达到或超过人类，也没有出处。[research/zuaec/01-ai-agent-evolution-analysis.md, §引言“日本总务省的报告指出”, L23-L24] [research/zuaec/01-ai-agent-evolution-analysis.md, §3.1“GPT 5.4模型在220项任务测试中”, L60-L60] 这些属于强事实主张，正式论文中应降级为“待核实观察”或删除，直到拿到原始报告。

**Finding 5：Paper 2 的技术栈引用缺口最大。** doc04 使用 libp2p、QUIC、TLS 1.3、DID、Nostr、EIP-8004、BBS+、Groth16、Merkle tree、累加器等概念，但没有任何参考文献或标准链接。[research/zuaec/04-agent-communication-protocol.md, §网络架构, L19-L25] [research/zuaec/04-agent-communication-protocol.md, §身份绑定, L27-L31] [research/zuaec/04-agent-communication-protocol.md, §Nostr + EIP-8004, L35-L55] [research/zuaec/04-agent-communication-protocol.md, §ASM消息格式, L62-L97] [research/zuaec/04-agent-communication-protocol.md, §ZK声誉系统, L120-L140] 协议论文至少需要引用 W3C DID/VC、Nostr NIPs、Ethereum EIP、ZK-SNARK/BBS+ 原始或综述文献，以及 Agent Communication Language/FIPA 等前史。

## 二、论证逻辑是否成立

**Finding 1：doc01 到 doc02 的“缺口→框架”链条方向正确，但缺少中间推导。** doc01 的关键缺口是机机社会缺乏共享社会记忆，doc02 将缺口扩展为“共享社会记忆和制度化交换机制”，再提出协作协议、量化社会资本、无许可网络三要素。[research/zuaec/01-ai-agent-evolution-analysis.md, §5.3“核心障碍：缺乏共享社会记忆”, L107-L112] [research/zuaec/02-human-ai-collaboration-framework.md, §一“Agent的根本局限与结构性缺口”, L22-L29] [research/zuaec/02-human-ai-collaboration-framework.md, §二“三要素框架”, L32-L39] 目前“共享社会记忆”能推出社会资本与协作记录，但不能自动推出“无许可网络”；无许可性本身还会放大安全与治理问题，doc02 后文也承认这一点。[research/zuaec/02-human-ai-collaboration-framework.md, §无许可网络的安全与治理, L67-L70] 正式论文需要证明：为什么开放接入是社会化的必要条件，而不只是工程偏好。

**Finding 2：Paper 1 当前容易从“描述三条路径”跳到“人机协作最佳”，论证尚未闭合。** doc01 的结论是替代、人机协作、机机协作是相互嵌套的三个维度，而 doc02 的原始问题和总体判断把焦点转到人机协作新范式。[research/zuaec/01-ai-agent-evolution-analysis.md, §八“三条路径的量化对比”, L153-L157] [research/zuaec/02-human-ai-collaboration-framework.md, §核心观点（Jason提出）, L9-L18] 如果论文主张“人机协作是当前最佳方向”，必须增加一个判据：最佳是就近期可治理性、任务成功率、社会风险，还是长期文明演化而言。否则审稿人会认为三路径综述只是铺垫，结论已预设。

**Finding 3：Paper 1 到 Paper 2 的“框架→协议”关系有可用骨架，但需要显式映射。** 主计划把 Paper 1 定为三要素理论框架，把 Paper 2 定为双网架构与 ASM 协议；doc03 的人类子网、社会记忆层、Agent 子网可对应 doc02 的社会资源嵌入、社会资本积累、无许可网络；doc04 的 ASM 可对应协作协议。[research/zuaec/paper-submission-plan.md, §Paper 1论文结构, L57-L65] [research/zuaec/paper-submission-plan.md, §Paper 2论文结构, L139-L148] [research/zuaec/03-dual-network-experiment.md, §四“从双网到三层结构”, L74-L91] [research/zuaec/04-agent-communication-protocol.md, §ASM消息格式, L58-L97] 但目前没有一张映射表说明“三要素中的每个理论构件在协议中如何被实现、保留了什么性质、牺牲了什么性质”。建议 Paper 2 开头放一张 `theoretical construct -> system component -> security/property goal` 表。

**Finding 4：责任链论证存在过强跳跃。** doc03 声称每项 Agent 行为背后绑定一个承担最终责任的人类节点，从而解决 Mitchell 所说的名义监督与实质监督缺口。[research/zuaec/03-dual-network-experiment.md, §授权关系的社会学意义, L31-L34] 绑定责任来源只能解决可追溯性的一部分，不能自动解决人类是否理解、可否干预、能否承担赔付、跨代理协作中责任如何分割等问题。doc03 后文又提出责任链无限递归问题，说明该缺口尚未被解决。[research/zuaec/03-dual-network-experiment.md, §责任链的无限递归问题, L64-L67] 论文应把“授权绑定”降格为责任分析的起点，而不是已完成的解法。

**Finding 5：doc04 的“自然语言低效→Agent 原生协议必要”动机成立，但协议选择缺少替代方案比较。** doc04 提出 Agent 之间不应只用自然语言，而应使用结构化、可验证、隐私保护的社会语义协议。[research/zuaec/04-agent-communication-protocol.md, §一“为什么需要Agent原生通信协议”, L9-L14] 但从这个动机并不能唯一推出 Nostr + EIP-8004 + ZK + ASM；还需要比较 MCP、FIPA ACL、Matrix、ActivityPub/AT Protocol、DIDComm、libp2p 原生 pubsub 等备选设计。没有 design-space analysis，协议论文的选择会显得像方案陈列，而不是研究贡献。

## 三、写法与文章定位

**Finding 1：Paper 1 最合适定位不是普通 Survey，而是“scoping review + conceptual framework + research agenda”。** 主计划把 Paper 1 写成“基于系统性文献综述的理论框架论文”，但当前材料没有系统综述方法：没有检索数据库、关键词、纳入排除标准、筛选流程、编码维度。[research/zuaec/paper-submission-plan.md, §类型定位, L32-L44] [research/zuaec/01-ai-agent-evolution-analysis.md, §2.1“三个主要研究集群”, L29-L38] 因此不建议自称 systematic literature review；更稳妥的定位是 scoping review，用有限但明确的文献范围提出概念框架和可测试命题。

**Finding 2：Paper 1 必须把“框架论文”和“立场论文”的边界写清。** doc02 的“文明操作系统”“社会义肢”“Agent社会工程学”等表述有启发性，但目前更像 position paper 的概念宣言。[research/zuaec/02-human-ai-collaboration-framework.md, §一“社会义肢”, L24-L29] [research/zuaec/02-human-ai-collaboration-framework.md, §二“三要素框架”, L32-L39] [research/zuaec/02-human-ai-collaboration-framework.md, §五“Agent社会工程学”, L77-L83] 若定位为 Conceptual Framework，需要补：概念定义、边界条件、命题、反例、可观测指标；若定位为 Position Paper，则应主动承认其规范性，强调研究议程而非证明结论。建议选择前者，但用最后一节保留 research agenda。

**Finding 3：Paper 2 应聚焦为 Protocol Specification / Architecture Paper，不宜写成“Agent 文明宣言”。** doc04 既有具体协议字段，也有“HTTP时刻”“迈向Agent文明”等宏大表述。[research/zuaec/04-agent-communication-protocol.md, §四“ASM消息格式”, L58-L97] [research/zuaec/04-agent-communication-protocol.md, §十“Agent社会网络的HTTP时刻”, L190-L204] 正式论文应把贡献压缩为：系统模型、消息语法、状态机、身份与授权、声誉证明、安全分析、性能/可部署性。宏大类比可以保留在 Introduction 的一小段，不能成为结论的主要证据。

**Finding 4：应用案例应服务于协议验证，而不是变成故事素材。** doc04 的全球采购案例能较好对应预算证明、验收合格率证明等协议要素；婚恋案例包含“灵魂音乐向量”“模拟约会”等强叙事内容，容易分散协议论文的严肃性。[research/zuaec/04-agent-communication-protocol.md, §全球采购, L146-L153] [research/zuaec/04-agent-communication-protocol.md, §大龄青年找伴侣, L154-L165] 建议 Paper 2 正文保留采购或学术研讨会组织作为主案例，婚恋案例若保留，应放入 appendix 或 discussion，用于说明伦理风险和非商业场景，而不是核心评估。

## 四、arXiv 子版块选择建议

**Finding 1：Paper 1 建议主分类 `cs.AI`，交叉 `cs.CY` 与 `cs.MA`。** 主计划给出的 `cs.AI` 主分类、`cs.CY` 和 `cs.MA` 交叉分类总体合适。[research/zuaec/paper-submission-plan.md, §Paper 1投稿分类, L67-L70] 理由是论文核心对象是 AI Agent 进化和多智能体社会化，社会学部分是解释框架而非唯一贡献。[research/zuaec/01-ai-agent-evolution-analysis.md, §摘要, L11-L13] 如果后续大幅削弱技术框架、转向社会影响与治理，则可把 `cs.CY` 调为主分类；但以当前计划看，`cs.AI` 更稳。

**Finding 2：Paper 1 不建议主投 `cs.MA`。** 虽然 doc01 和 doc02 涉及多智能体系统，但当前 Paper 1 不提供新的 MAS 算法、博弈模型或实验结果。[research/zuaec/paper-submission-plan.md, §Paper 1论文结构, L57-L65] `cs.MA` 更适合作为 cross-list，以覆盖多智能体读者；主分类放 `cs.MA` 可能让读者期待形式化 MAS 模型和实验。

**Finding 3：Paper 2 的主分类取决于安全分析深度；当前阶段建议 `cs.DC` 主分类，`cs.CR` 和 `cs.MA` 交叉。** 主计划把 Paper 2 主分类设为 `cs.DC`，交叉 `cs.CR`、`cs.MA`。[research/zuaec/paper-submission-plan.md, §Paper 2投稿分类, L150-L153] 这是保守且合适的选择，因为 doc04 目前更像去中心化网络和协议架构，ZK 安全证明尚未形成。[research/zuaec/04-agent-communication-protocol.md, §物理底层, L17-L31] [research/zuaec/04-agent-communication-protocol.md, §ZK声誉系统, L120-L140] 若最终能写出标准攻击者模型、安全定义、证明或严谨 reduction，再考虑 `cs.CR` 主分类；否则 `cs.CR` 主投会招来更严苛的密码学审查。

**Finding 4：Paper 2 不建议主投 `cs.CY`，除非改写为治理/社会影响论文。** doc03 的双网设计和 doc04 的协议规范都以系统架构、消息格式、安全性质为核心。[research/zuaec/03-dual-network-experiment.md, §四“三层结构”, L74-L91] [research/zuaec/04-agent-communication-protocol.md, §四“ASM消息格式”, L58-L97] `cs.CY` 可在 Paper 1 承载社会分析，Paper 2 应避免分类上同时宣称社会理论和协议安全两条主线。

## 五、形式化定义和安全性证明的覆盖深度建议

**Finding 1：Paper 1 需要“轻形式化”，不是密码学式证明。** 主计划已经把“框架部分形式化表达（定义、命题）”列为任务。[research/zuaec/paper-submission-plan.md, §工作量评估, L74-L81] 建议补三类定义：Agent socialization、shared social memory、institutional embedding；再给 3-5 条命题，例如“在任务复杂度和交互重复度达到阈值时，只有具备可追溯记忆的 Agent 网络才可能形成稳定声誉”。这些命题应连接 doc01 的社会化失败、doc02 的三要素框架和 doc03 的社会记忆层。[research/zuaec/01-ai-agent-evolution-analysis.md, §5.3, L107-L112] [research/zuaec/02-human-ai-collaboration-framework.md, §二, L32-L45] [research/zuaec/03-dual-network-experiment.md, §四, L74-L91]

**Finding 2：Paper 2 必须先补 System Model，再谈定理。** 主计划给出 Agent 身份、ASM 消息、隐私性、不可伪造性的形式化示例。[research/zuaec/paper-submission-plan.md, §形式化定义示例, L103-L126] 但 doc04 目前只有分层描述、字段表和工作流，没有定义参与方集合、网络假设、状态集合、转移函数、失败模型、密钥生命周期。[research/zuaec/04-agent-communication-protocol.md, §网络架构, L19-L25] [research/zuaec/04-agent-communication-protocol.md, §工作流设计, L100-L117] 建议顺序是：actors and trust assumptions -> message syntax -> state machine -> safety/liveness goals -> adversary model -> analysis。

**Finding 3：Liveness 至少要覆盖“可终止”和“可恢复”，否则双阶段协议不完整。** doc04 的工作流从 Relay 留言进入直连洽谈，但没有说明对方不响应、Relay 审查、网络分区、ZK 证明生成超时、WebRTC 建连失败时协议如何结束或恢复。[research/zuaec/04-agent-communication-protocol.md, §第一阶段（留言阶段）, L102-L110] [research/zuaec/04-agent-communication-protocol.md, §第二阶段（直连洽谈）, L112-L117] 最低要求：定义 timeout、retry、abort、fallback relay、eventual settlement/failure acknowledgement。可以不证明强同步网络下的严格活性，但必须说明在部分同步或异步网络下，诚实 Agent 不会无限等待。

**Finding 4：Safety 至少要覆盖五类不变量。** doc04 已触及身份隐私、不可伪造、抗女巫、抗投机、留言轰炸等安全点。[research/zuaec/04-agent-communication-protocol.md, §身份绑定, L47-L55] [research/zuaec/04-agent-communication-protocol.md, §ZK声誉系统, L120-L140] [research/zuaec/04-agent-communication-protocol.md, §技术挑战, L179-L187] 正式论文应写成安全目标：授权不越权、消息不可伪造、历史不可回滚或篡改、预算/抵押不被重复花费、隐私不泄露。每一项用“攻击场景-防御机制-剩余风险”表达即可；若没有密码学合作者，不宜承诺完整定理证明。

**Finding 5：攻击者模型要覆盖社会层和网络层，不只覆盖密码学攻击者。** doc03 已提出风险放大、责任递归、时间尺度错位；doc04 提出留言轰炸、Relay 索引、ZK 实时性、人类交接边界。[research/zuaec/03-dual-network-experiment.md, §三“潜在风险与必须攻克的理论难题”, L50-L70] [research/zuaec/04-agent-communication-protocol.md, §九“技术挑战”, L179-L187] 攻击者模型至少包括：恶意 Agent、合谋 Agent 集团、恶意或审查 Relay、被盗密钥、恶意授权人、被动监听者、垃圾请求者、资源强者的声誉垄断。对于每类攻击者，明确其能力边界和不解决的问题。

## 六、两篇论文边界划分是否合理

**Finding 1：当前二篇拆法总体合理，但边界必须更硬。** 主计划把 doc01+doc02 归入 Paper 1，把 doc03+doc04 归入 Paper 2，这符合“理论框架”和“协议设计”的自然分工。[research/zuaec/paper-submission-plan.md, §内容来源（Paper 1）, L52-L55] [research/zuaec/paper-submission-plan.md, §内容来源（Paper 2）, L134-L137] 风险是三要素框架、双网架构、社会记忆层在两篇中重复出现。建议 Paper 1 只定义理论构件和命题；Paper 2 只把这些构件作为 requirements，并给出实现。

**Finding 2：如果时间和引用核实压力很大，合并为一篇更稳，但要降级为“position/framework paper”。** 主计划认为合并为 18000-20000 字会稀释论点，不推荐。[research/zuaec/paper-submission-plan.md, §备选方案, L241-L245] 我同意不作为首选，但若 7 月前只能保证一篇，合并版可以写成“Agent Social Infrastructure: A Conceptual Framework and Protocol Sketch”。代价是 Paper 2 的安全性和协议规范不能宣称成熟贡献，只能作为 design implications。

**Finding 3：拆为三篇只有在补充实验或形式化后才值得。** 主计划否定“综述单独成篇”和“框架单独成篇”，理由是工作量或论证链不足。[research/zuaec/paper-submission-plan.md, §为什么是2篇而不是3篇, L18-L26] 更可行的三篇拆法不是“综述/框架/协议”，而是：Paper A scoping review + framework；Paper B 双网实验平台与评估方案；Paper C ASM/ZK protocol。前提是 doc03 能发展出实际实验设计、指标、样本规模、伦理审批和数据采集方案；否则第二篇会变成空架构。[research/zuaec/03-dual-network-experiment.md, §五“中等规模在线实验平台”, L95-L101]

**Finding 4：Paper 2 应把“协议规范”置于核心，把“双网实验”降为系统模型或评估场景。** doc03 的双网/三层结构是理论到系统的桥，doc04 的 ASM、ZK 声誉和工作流才是协议论文的主体。[research/zuaec/03-dual-network-experiment.md, §四“三层结构”, L74-L91] [research/zuaec/04-agent-communication-protocol.md, §四至六, L58-L140] 标题中可以保留 dual-network architecture，但正文贡献列表建议写成：1. threat-aware dual-network model；2. ASM message syntax and state machine；3. privacy-preserving reputation analysis。

## 七、风险提示

**Finding 1：学术诚信风险必须前置处理，尤其是 AI 生成文献和数据幻觉。** doc01-04 均标注 DeepSeek 对话整理，且包含大量具体论文、数据和强判断。[research/zuaec/01-ai-agent-evolution-analysis.md, 文件头, L3-L5] [research/zuaec/02-human-ai-collaboration-framework.md, 文件头, L3-L5] [research/zuaec/03-dual-network-experiment.md, 文件头, L3-L5] [research/zuaec/04-agent-communication-protocol.md, 文件头, L3-L5] 这不禁止写论文，但必须建立核查表：每篇文献是否存在、题名和作者是否准确、年份/会议是否准确、数据是否来自原文、是否夸大结论。正式投稿可在 acknowledgements 或 author note 中披露 AI 工具用于 brainstorming/drafting，而不能把 AI 生成综述当作已验证事实。

**Finding 2：doc01 第七节对 Mushroom.cv 博客的学术评估有商业推广嫌疑，应从论文主体删除或彻底学术化。** doc01 文件头关联 Mushroom.cv 博客，正文第七节直接评价该博客“核心洞察准确”“有价值框架”。[research/zuaec/01-ai-agent-evolution-analysis.md, 文件头“关联：https://blog.mushroom.cv”, L3-L5] [research/zuaec/01-ai-agent-evolution-analysis.md, §七“对Mushroom.cv博客的评估”, L125-L138] arXiv 读者会把这看成自我背书或品牌导流。建议正式论文只保留“early Homo sapiens stage”作为一个类比，并用学术文献支撑或反驳；博客可作为非学术灵感来源放脚注，或完全不提。

**Finding 3：Mycelium Protocol 的直接绑定会削弱学术中立性。** doc02、doc03、doc04 末尾都把框架或协议要素逐项映射到 Mycelium Protocol；project-concept 又明确说该材料服务 ZUAEC 参赛，并将 Mycelium 作为区块链基础层。[research/zuaec/02-human-ai-collaboration-framework.md, §与 Mycelium Protocol 的关联, L87-L94] [research/zuaec/03-dual-network-experiment.md, §与 Mycelium Protocol 的关联, L105-L114] [research/zuaec/04-agent-communication-protocol.md, §与 Mycelium Protocol 的关联, L208-L216] [research/zuaec/project-concept.md, §用途与解决方案, L3-L5, L28-L40] 学术论文中应改成 vendor-neutral architecture；Mycelium 可作为 prototype implementation 或 case study，且需声明作者关联和潜在利益冲突。

**Finding 4：过强文明类比和产品愿景会增加审稿风险。** doc03 使用“社会子宫”“未来答案”“全新的社会有机体”，doc04 使用“HTTP时刻”“Agent文明”，这些表述适合愿景材料，但论文中容易被认为证据不足。[research/zuaec/03-dual-network-experiment.md, §一标题“社会子宫”, L20-L29] [research/zuaec/03-dual-network-experiment.md, §五“全新的社会有机体”, L95-L101] [research/zuaec/04-agent-communication-protocol.md, §十“HTTP时刻”, L190-L204] 建议把类比压缩为 motivation，不把类比当成结论。

## 八、各篇论文 Top-5 写作优先级

**Paper 1 Top-5**

| 优先级 | 事项 | 依据与定位 |
|---|---|---|
| must-fix | 建立可核查 bibliography，补齐 2022-2024 Agent、MAS、人机协作、社会资本和治理文献 | 当前 doc01 主要覆盖 2025-2026，计划只写补 2024 文献。[research/zuaec/01-ai-agent-evolution-analysis.md, §参考文献（核心）, L160-L173] [research/zuaec/paper-submission-plan.md, §Paper 1行动清单, L210-L218] |
| must-fix | 核实所有强数据主张和机构报告，无法核实则删除或降级 | 日本总务省报告、Carnegie 报告、GPT 5.4 83% 等缺完整出处。[research/zuaec/01-ai-agent-evolution-analysis.md, §引言, L23-L24] [research/zuaec/01-ai-agent-evolution-analysis.md, §3.1, L55-L60] |
| must-fix | 把三要素框架写成可定义、可反驳、可测试的理论框架 | doc02 目前给出三要素表，但缺定义、命题和边界条件。[research/zuaec/02-human-ai-collaboration-framework.md, §二“三要素框架”, L32-L45] |
| should-fix | 明确论文定位为 scoping review + conceptual framework，避免自称系统综述 | 主计划称“基于系统性文献综述”，但没有系统综述方法。[research/zuaec/paper-submission-plan.md, §类型定位, L32-L44] [research/zuaec/01-ai-agent-evolution-analysis.md, §2.1, L29-L38] |
| nice-to-have | 将 Mushroom.cv 类比转化为学术化隐喻或放入脚注 | doc01 第七节直接评估博客，易被视作推广。[research/zuaec/01-ai-agent-evolution-analysis.md, §七, L125-L138] |

**Paper 2 Top-5**

| 优先级 | 事项 | 依据与定位 |
|---|---|---|
| must-fix | 补 System Model：参与者、信任假设、网络模型、状态机、消息语法 | doc04 有字段和流程，但缺形式化模型。[research/zuaec/04-agent-communication-protocol.md, §四“ASM消息格式”, L58-L97] [research/zuaec/04-agent-communication-protocol.md, §五“工作流设计”, L100-L117] |
| must-fix | 写攻击者模型与安全目标，覆盖 privacy、authenticity、authorization safety、Sybil/collusion、spam、relay censorship | doc03 和 doc04 已列出风险，但未系统化为 threat model。[research/zuaec/03-dual-network-experiment.md, §三, L50-L70] [research/zuaec/04-agent-communication-protocol.md, §九, L179-L187] |
| must-fix | 补 Related Work 与技术标准引用，特别是 DID/VC、Nostr NIPs、EIP、FIPA ACL、MCP/Agent 协议、ZK 构造 | doc04 技术栈无参考文献。[research/zuaec/04-agent-communication-protocol.md, §二至六, L17-L140] |
| should-fix | 把安全证明承诺控制在能力范围内：若无密码学合作者，以 rigorous security analysis 替代 theorem-proof | 主计划示例使用 PPT 敌手和定理，但当前原料无证明框架。[research/zuaec/paper-submission-plan.md, §形式化定义示例, L118-L126] |
| nice-to-have | 增加轻量性能分析或原型指标：Relay 检索延迟、ZK 生成时间、消息大小、失败恢复时间 | doc04 提到 ZK 实时性和 Relay 索引挑战，但无指标。[research/zuaec/04-agent-communication-protocol.md, §九“技术挑战”, L181-L187] |

核心要点摘要：

- 两篇拆法总体可行：Paper 1 做理论框架，Paper 2 做协议规范；但必须切硬边界，避免重复讲三要素、双网和 Mycelium 映射。
- 最大短板是来源核实：`[reference:N]` 编号不存在，doc02-04 无参考文献，2022-2024 关键文献缺口明显。
- Paper 1 应写成 scoping review + conceptual framework，不宜冒充系统综述；Paper 2 应写成 protocol specification，不宜写成愿景宣言。
- Paper 2 当前更适合 `cs.DC` 主分类、`cs.CR`/`cs.MA` 交叉；只有在安全定义和证明显著增强后才建议 `cs.CR` 主投。
- DeepSeek 来源、Mushroom.cv 博客评价、Mycelium Protocol 直接绑定是三项必须处理的学术可信度风险。
