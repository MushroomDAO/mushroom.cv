# Executive Summary（执行摘要）

总体判断：两篇论文的方向有发表潜力，但当前 v0 版本还不能进入“写完即投 arXiv”的状态。Paper 1 的最大风险不是框架本身，而是方法论信用：草稿多处声称“PRISMA-ScR compliant”，但关键 N 值、筛选流程、数据 charting 表、PRISMA-ScR checklist 仍为 TODO；这会触发“借 PRISMA 名义包装 narrative review”的审稿攻击。Paper 2 的最大风险是工程事实与论文表述不一致：标题、摘要和章节标题暗示 OP mainnet / Ethereum mainnet 部署，但实现状态文档显示多项核心 ASM、VC、ZK、reputation accumulator 仍待设计或待实现。

建议：可以立即进入 Phase 1，但 Phase 1 的定义必须收窄为“文献核实 + PRISMA-ScR 证据链补齐 + Paper 2 工程事实冻结”，不能理解为直接推进 arXiv 版本。Paper 1 若先修 PRISMA-ScR 和引用核实，有希望在 6-8 周内形成可公开预印的版本；Paper 2 若继续坚持“协议 + ZK + reputation + mainnet deployment + security analysis”全栈叙事，14 周内形成经得起系统审稿的版本不现实。

---

# D1-D10 analysis（十维分析）

## D1. Paper 1 PRISMA-ScR §3 方法论合规性

[research/zuaec/paper1-draft-v0.md §0/8, §3/107-152, Appendix A/559-561] 问题：草稿文件头和正文明确写“PRISMA-ScR compliant”，但 §3 只有数据库、一个通用 Boolean string、I/E 表、charting 字段和 narrative synthesis；selection process 仍是“TODO: PRISMA-ScR flow diagram with actual N values”，Appendix A 也仍是 TODO。观察到的文本事实是：目前没有 identification、screening、eligibility、included 的 N 值，没有去重规则，没有全文排除理由表，也没有完整 22 项 checklist。审稿人可能会认为这是“claims PRISMA-ScR but does not deliver”。修订建议：在 §3 增加独立的 PRISMA-ScR flow table/figure、每个数据库的检索日期和完整检索式、去重方法、title/abstract/full-text 筛选人数或流程、排除理由、charting 表样例，并把 Appendix A 从 TODO 改成逐项合规说明。

[research/zuaec/paper1-draft-v0.md §3.2/119-131, §3.3/137-140] 问题：search strategy 不可复现。“Google Scholar top 200 results per query”没有说明 query 数量、排序方式、语言/日期过滤方式；I2 写“peer-reviewed OR ≥50 citations OR notable community impact”，但 2026 年新论文很难满足 50 citations，且“notable community impact”没有操作定义。修订建议：把 I2 拆成可审计标准，例如 peer-reviewed、preprint with verifiable arXiv record、framework/platform paper reproduced in two independent surveys、or system with public deployment evidence；同时记录每条入选论文满足哪一条标准。

[research/zuaec/paper1-bibliography.md §四/134-217, §五/229-239] 问题：规划文档已经给出了更完整的 PRISMA-ScR 方法论模板和行动清单，但 draft v0 只吸收了框架，没有吸收完整 reporting。修订建议：直接把 bibliography plan §四转化为 Paper 1 §3 的正式文本，并新增 `paper1-literature-screen.md` 或 appendix 表格作为证据链，避免正文只剩方法论宣称。

## D2. Paper 1 §6 三要素定义与 §7 P1-P5 命题逻辑一致性

[research/zuaec/paper1-draft-v0.md §6.1-6.4/270-348, §7/356-394] 问题：P1 可以从三要素框架中推出，但目前只是必要性断言；P2、P3、P4、P5 与三要素的推导关系不均衡。P2 的“human authorization”不是 §6 三要素定义中的独立构件，P3 主要来自 Feng et al. 的嵌入比例结果，P5 则是对 SC 概念边界的自我限制，而不是三要素框架的正向预测。修订建议：在 §7 前增加一张“Pillar → Proposition → Evidence → Refutation”表，明确哪些命题是框架内生推论，哪些是外部文献启发的扩展命题。

[research/zuaec/paper1-framework-logic.md §四/144-154, §八/264-286] 问题：规划文档承认 P1 是“规范性较强的命题”，应写为 posit 而非 prove；draft v0 在 §7.1 已写“Posited”，但 abstract 和 contributions 仍把框架包装得像已被 scoping review 充分支持。修订建议：摘要中把“we identify”与“we propose”分开，P1/P2 用“we posit”或“we hypothesize”，P3 用“we adapt and conjecture generalization”，避免把证据强度混成一个层级。

[research/zuaec/paper1-draft-v0.md §7.5/388-394, research/zuaec/paper1-framework-logic.md §四/186-192] 问题：P5“任何完全机器可计算的社会资本量化都会损失 Bourdieu 维度”不会毁掉论文，但会削弱“quantified social capital”作为 pillar 的雄心；如果处理不好，审稿人会说核心概念自己承认不可完整。修订建议：把 P5 从“五个同级命题”降为“Boundary Proposition”或“Limitation Proposition”，明确 SC 追求的是 task-relevant, machine-verifiable proxy，而不是社会学概念的完整再现。

## D3. Paper 1 §8 Mycelium Protocol case study 与 COI 处理

[research/zuaec/paper1-draft-v0.md §0/15-20, §8.1/400-405, §8.3-8.4/414-420] 问题：COI 披露的方向正确，明确说明作者是核心贡献者，并把 Mycelium 定位为 empirical anchor 而非 endorsement。修订建议：保留这种披露方式，但补 ACM/IEEE 常见要素：funding、author contributions、data/code availability、which claims are independently verifiable、which claims are author-reported。

[research/zuaec/paper1-draft-v0.md Abstract/25, §8.2/408-412; research/zuaec/paper2-draft-v0.md §7.3/523-530; research/zuaec/agent-network-architecture.md §5.1/196-207] 问题：Paper 1 abstract 称 Mycelium 在 Ethereum/Optimism mainnet，§8.2 也写 public Ethereum/Optimism mainnet；但 Paper 2 §7.3 写当前是 Sepolia testnet，mainnet deployment scheduled，架构文档也显示 VC_auth、VC_rep、reputation accumulator、mainnet deployment 均待设计或计划中。审稿人会把这视为事实不一致甚至过度宣传。修订建议：所有“mainnet”表述必须改成“Sepolia testnet deployment with planned OP mainnet deployment”，除非提交前主网交易和合约验证链接已经存在。

[research/zuaec/paper2-draft-v0.md §1.4/77-80, §7.1/500-508] 问题：WireGuard / Signal Protocol 类比在 Paper 2 中可作为“系统论文可先给安全分析、后续补 formal proofs”的弱类比，但不应暗示 ASM 已达到同等工程成熟度或部署规模。修订建议：把类比限制为“genre of protocol-design papers”，并加一句“we do not claim comparable maturity, adoption, or security pedigree”。

## D4. Paper 1 §4 文献综述证据强度

[research/zuaec/paper1-draft-v0.md §4.1/160-173] 问题：replacement cluster 目前几乎只靠 Mitchell 2026 和 Carnegie 2026，且还有“Compute and report citation patterns” TODO。修订建议：每个 cluster 至少列 8-12 篇核心文献，并把 replacement cluster 拆成 labor economics、organizational oversight、education/political economy 三个子类，否则三集群的证据重量严重不平衡。

[research/zuaec/paper1-draft-v0.md §4.2/175-190, §4.3/191-207; research/zuaec/paper1-bibliography.md §1.1/18-32, §4.1/102-111] 问题：human-AI 和 machine-machine cluster 大量依赖 2026 preprint 或待核实会议接收状态，status 文档也列出 Mitchell、Chakraborty、Han、Evans、Huang、Quan、EvolveR 等仍需核实。修订建议：在正式 draft 中给每篇核心文献标注 peer-reviewed / arXiv / working paper，并把未核实来源从支撑性主张中移到“emerging evidence”段落。

[research/zuaec/paper1-bibliography.md §2.1/63-73; research/zuaec/paper1-draft-v0.md §2.1/85-87, References/511-553] 问题：规划文档把 ReAct、Generative Agents、AutoGPT、AutoGen、MetaGPT、CAMEL、AgentBench、Wang survey、Xi survey列为 must-cite，但 draft v0 只在背景或 references 中浅提 ReAct/AutoGen/MetaGPT/Generative Agents，CAMEL 和 AgentBench 没有进入 Paper 1 references。修订建议：把 2022-2024 文献作为“agent capability and orchestration foundations”小节，而不是只在历史背景中一句带过。

[research/zuaec/paper1-draft-v0.md §2.2/99-101, §6.2/302-313, §6.3/327] 问题：Bourdieu/Putnam/Ostrom 的接入比 v1 好，但仍偏“术语映射表”，缺少论证。审稿人可能会认为 sociology 只是借名提高理论重量。修订建议：为每个社会学理论加一段“why this theory changes the agent literature interpretation”，并补 Granovetter weak ties 或 Coleman/Lin 的网络资源视角，说明 Rel 不只是链上图结构。

## D5. Paper 1 整体写作语气、引用完整性与过度承诺

[research/zuaec/paper1-draft-v0.md Abstract/25, §1.3/55-61, References/481-495] 问题：摘要写 N=[TODO]、References 写 TODO，但 §1.3 又声称“PRISMA-ScR-compliant scoping review”；同时“three contributions”下面列了五项贡献。修订建议：在 v1 前，任何 TODO 不得出现在 abstract、methodology、references、appendix；贡献列表改为三类，每类下可有子贡献。

[research/zuaec/paper1-draft-v0.md §1.1/35, §1.1/43, §10.4/475-477; research/zuaec/paper-revision-status.md §4.1/98-111] 问题：draft 中仍有“verify source”的 AGI 五阶段、日本总务省、Carnegie 报告；AI disclosure 却写“all literature citations, data claims, and theoretical arguments have been independently verified”。观察到的文本事实是 status 文档仍列 10 项文献核实未完成。修订建议：在所有核实完成前，AI disclosure 必须改为“will be independently verified before public release”，否则存在学术诚信风险。

[research/zuaec/paper-innovation-points.md §Paper 1/13-24; research/zuaec/paper1-draft-v0.md §5.1-5.3/225-258] 问题：“not capability, not data, not alignment, but institutional embedding”是有冲击力的 one-liner，但目前证据只能支持“not only capability/data/alignment”。修订建议：把排他性诊断降级为“we argue that capability, data, and alignment accounts are incomplete without institutional embedding”，避免被一个反例击穿。

## D6. Paper 2 System Model §3 形式化深度

[research/zuaec/paper2-draft-v0.md §1.2/52-55, §3.4/197-215] 问题：contribution 声称 §3 formalizing trust assumptions, network model, key lifecycle, failure model，但 §3 实际只有 5 个定义：Human Authorizer、Agent、Authorization VC、Reputation VC、Social Memory Layer。修订建议：新增 Definitions：Verifier、Relay、Collaboration Event、Reputation Accumulator、Authorization Scope、Credential Validity/Revocation、Network Assumption、Finality Assumption、Fault Model。

[research/zuaec/paper2-draft-v0.md §3.3/187-195, §5.2/367-380] 问题：VC_auth 的 scope/expiry/revocation 与 reputation accumulator 的 witness/public value 没有形式语义；后续安全分析却依赖这些概念。修订建议：定义 `ValidAuth(a,h,t,scope)`、`CanAct(a, action, scope)`、`Accumulate(VC_set) -> acc`、`ProveRep(acc, predicate, witness) -> proof`，并说明 verifier 可见哪些字段。

[research/zuaec/paper2-draft-v0.md §3.4/213-215, §6.2/446-449] 问题：SML 被定义为“Byzantine-fault-tolerant append-only log”，部署又说是 Ethereum/Optimism mainnet；这需要区分 L1 finality、L2 sequencer risk、reorg、bridge/finality delay。修订建议：把 ledger assumptions 写成明确 threat model，不要用“BFT append-only log”一笔带过。

## D7. Paper 2 Security Analysis §6 完整性

[research/zuaec/paper2-draft-v0.md §6.1/416-428, §6.2-6.3/429-481, §6.4/483-494] 问题：8 类 adversary 覆盖了基础协议攻击，但安全性质只有 S1-S5 和 L1-L4，且 A8 resource-rich entity 在正文中明确 TODO。修订建议：增加 E 类 economic/game-theoretic properties，例如 Sybil cost lower bound、bribery resistance limits、whitewashing cost、reputation market/rental attack、issuer diversity under collusion。

[research/zuaec/paper2-draft-v0.md §6.2/436-439] 问题：S2 只保证“exceed authorized scope without detection”不可行，但承认 prevention 需要 off-chain enforcement；这与摘要中的“addresses authorization escalation”容易被读成已经防止越权。修订建议：把安全属性名改为“Detectable authorization violation”，并把“prevention not guaranteed”前移到 abstract/scope limitation。

[research/zuaec/paper2-draft-v0.md §6.2/451-454, §1.3/62-67] 问题：privacy 只覆盖 passive observer 和 ZK proof 内容隐藏，没有覆盖 traffic analysis、relay metadata correlation、timing correlation、human funding address linkage。修订建议：增加 active/network privacy adversary，并明确 ASM 当前只保护 credential contents，不保护所有网络层 metadata。

[research/zuaec/paper2-draft-v0.md §5.3/382-391, §5.4/393-402] 问题：Sybil 和 collusion 防御依赖“acquiring K distinct humans”“diversity weights”“time decay”，但 diversity weighting 仍 TODO，也没有证明 K humans 的成本足够高。修订建议：把这部分降级为 mitigation，不写 resistance；加入失败模式：paid humans、identity farms、reputation brokerage、long-horizon collusion。

## D8. Paper 2 §2.6 对比表“ASM 唯一全 ✅”风险

[research/zuaec/paper2-draft-v0.md §2.6/136-146; research/zuaec/paper-innovation-points.md §Paper 2/53-64] 问题：表格把 FIPA ACL、MCP、DIDComm、Nostr、EigenTrust 放在同一协议比较维度中，但它们分别是 agent communication language、tool/RPC interface、DID messaging、relay social protocol、trust algorithm；“permissionless”“multi-party coordination”等列对部分对象是类别不匹配。修订建议：把表改成“requirement coverage for decentralized agent socialization”，并为每个 ⚠️/❌ 写脚注说明范围，而不是简单判负。

[research/zuaec/paper2-draft-v0.md §2.1-2.5/86-132] 问题：Related Work 对每个系统的描述太短，容易让审稿人认为比较表是为 ASM 量身定制的。修订建议：为 FIPA ACL、MCP、DIDComm 分别增加“what it is good at / what is out of scope / why ASM needs more”的三段式分析，避免显得不公平。

[research/zuaec/paper-innovation-points.md §Paper 2/41-51, §Combined Pitch/72-75] 问题：“first agent communication protocol that simultaneously...”和“ASM 是唯一全 ✅”是最容易被审稿人攻击的 novelty claim。修订建议：改成“To our knowledge, ASM is an early protocol specification that integrates...”并限定比较集合、版本日期、评价标准。

## D9. Planning docs 中创新 one-liners 的稳健性

[research/zuaec/paper-innovation-points.md §Paper 1/13-24] 问题：Paper 1 的“bridge institutional theory + diagnose as institutional problem”基本可守，但“first falsifiable three-pillar framework”证据不足。审稿人会问：为什么传统 MAS、institutional economics、computational social science 中没有类似框架？修订建议：把 first claim 改成“we offer a falsifiable three-pillar framework”并在 Related Work 增加“closest frameworks and why they differ”表。

[research/zuaec/paper-innovation-points.md §Paper 2/41-51, §Paper 2/64] 问题：Paper 2 的“first to satisfy all three properties simultaneously”目前依赖 §2.6 表格，而表格分类不稳。审稿人会攻击指标选择、对 DIDComm/MCP 的低估、以及 ASM 自身尚未完整实现。修订建议：把创新点从“唯一全满足”改成“joint design goal + reference implementation path”，把“satisfies”改成“is designed to support”。

[research/zuaec/paper-innovation-points.md §Combined Pitch/72-75] 问题：“first work to articulate AI Agent Social Engineering as a unified discipline”野心过大，而且“social engineering”在安全领域有负面含义。修订建议：不要在 abstract 或 arXiv comments 中使用“new discipline”措辞；改成“a framework/protocol stack for socially embedded AI agents”。

## D10. Execution plan 现实性

[research/zuaec/master-execution-plan.md §目标/3-7, §里程碑/333-343] 问题：计划要求 2026-08-31 前完成 Paper 1 arXiv、Paper 2 arXiv、Mycelium 主网部署；这是 14 周内三条高风险路径并行。观察到的文本事实是：Phase 1 需要 800-1000 候选、30-50 全文阅读，Phase 6 同时要求 mainnet、ASM Codec、Nostr、ZK MVP、2 demo agents、性能数据。修订建议：把 8/31 目标分层：必须完成 Paper 1 arXiv；Paper 2 只承诺 technical report 或 in-preparation；Mycelium 只承诺 Sepolia evidence unless mainnet is actually live。

[research/zuaec/agent-network-architecture.md §5.1-5.2/204-219] 问题：核心支撑 Paper 2 的 VC_auth、VC_rep、Reputation Accumulator、ASM Codec、Nostr integration、libp2p、ZK proof、state machine runtime 都是待设计或待实现。修订建议：Paper 2 v1 不应声称“deployed protocol”；应重写为“protocol specification with partial reference implementation”。

[research/zuaec/master-execution-plan.md §风险清单/345-355, §应急预案/356-365] 问题：风险清单低估了 Paper 2 工程和安全分析的延期概率，把 ZK 实现遇阻标为中风险，但它同时影响 privacy-preserving reputation、performance data 和 security claims。修订建议：把 ZK、mainnet、reputation accumulator 和 Paper 2 arXiv 分别列为高风险，并设置明确 kill criteria：若 Week 10 前无 end-to-end demo，Paper 2 不上 arXiv。

---

# Must-Fix（Top-10）

1. [research/zuaec/paper1-draft-v0.md §3/142-152, Appendix A/559-561] Paper 1 不能在 PRISMA flow、N 值、charting 表、checklist 都是 TODO 时声称 PRISMA-ScR compliant。先补完整 methodology evidence，再写合规声明。

2. [research/zuaec/paper1-draft-v0.md Abstract/25, References/483-495; research/zuaec/paper-revision-status.md §4.1/102-111] 删除 abstract 和 references 中所有 TODO；未核实引用不得支撑核心论断。AI disclosure 也必须与实际核实状态一致。

3. [research/zuaec/paper1-draft-v0.md Abstract/25, §8.2/408-412; research/zuaec/paper2-draft-v0.md §7.3/523-530] 统一 Mycelium 部署状态。没有主网合约和数据前，全部改为 Sepolia testnet / planned OP mainnet。

4. [research/zuaec/paper1-draft-v0.md §7/356-394] 重写 P1-P5 的证据等级。P1/P2 是假设，P3 是外部理论推广，P4 是弱证据命题，P5 应作为边界条件而非同级预测。

5. [research/zuaec/paper1-draft-v0.md §4.1/160-173] 补强 replacement cluster。现在证据过薄，无法与另外两个 cluster 平衡。

6. [research/zuaec/paper1-bibliography.md §2.1/63-73; research/zuaec/paper1-draft-v0.md References/511-553] 把 CAMEL、AgentBench、AutoGPT 等 2022-2024 基础文献真正纳入 §4 论证，而不是只在背景或规划文档中出现。

7. [research/zuaec/paper2-draft-v0.md §3.4/197-215] Paper 2 必须补 system model 定义。当前 5 个定义不足以支撑后续 ZK reputation 和 security analysis。

8. [research/zuaec/paper2-draft-v0.md §6.3/477-481, §6.4/493-494] A8 和经济攻击不能留 TODO。若不做完整经济分析，就明确降级为 out-of-scope 并删除“comprehensive”措辞。

9. [research/zuaec/paper2-draft-v0.md §2.6/136-146; research/zuaec/paper-innovation-points.md §Paper 2/64] 删除或弱化“ASM 唯一全 ✅”。改成限定范围的 requirement coverage analysis。

10. [research/zuaec/master-execution-plan.md §Phase 6/257-269; research/zuaec/agent-network-architecture.md §5.1-5.2/204-219] 重排 14 周计划。Paper 2 arXiv 不能依赖一串仍待实现的核心模块，否则 deadline-driven writing 会制造事实风险。

# Should-Fix（Top-5）

1. [research/zuaec/paper1-draft-v0.md §1.3/55-61] “three contributions”下列了五项贡献。改成三大贡献，每项下面列子点。

2. [research/zuaec/paper1-draft-v0.md §2.2/99-101, §6.2/304-313] 社会学文献需要从“映射表”变成论证段。至少说明 Bourdieu、Putnam、Ostrom 各自如何改变 AI agent socialization 的解释。

3. [research/zuaec/paper2-draft-v0.md §4.2/271-286] BNF 不能只写省略号和 TODO。若声称 specification sufficient for reimplementation，BNF、CBOR schema、required/optional fields 必须完整。

4. [research/zuaec/paper2-draft-v0.md §6.2/451-454] 隐私声明要区分 credential privacy 与 network metadata privacy。不要让读者误以为 ZK 解决了所有 deanonymization。

5. [research/zuaec/target-venues.md §5/158-172] 投稿 checklist 应加入“COI statement、funding、author contribution、data/code availability”已经完成的状态跟踪。现在 checklist 只列任务，不保证论文文本已经落实。

# Nice-to-have（Top-5）

1. [research/zuaec/paper1-draft-v0.md §10.2/461-469] 为 research agenda 加一个表格：对应 P1-P5、可观测指标、最小实验设计、预期数据源。

2. [research/zuaec/paper1-framework-logic.md §五/196-208] 把 boundary conditions 移入 Paper 1 正文或 appendix。它能显著降低框架被过度泛化攻击的风险。

3. [research/zuaec/paper2-draft-v0.md §7.4/531-535] 即使没有主网，也可以报告 Sepolia microbenchmarks：message size、proof generation placeholder、relay latency、gas cost。没有数据时不要写“real-world deployment”。

4. [research/zuaec/agent-network-architecture.md §4.1-4.2/117-186] Paper 2 可以加入一个端到端 running example，但要选择与学术/企业任务相关的例子，例如 research assistant workflow 或 meeting transcript pipeline。

5. [research/zuaec/paper-innovation-points.md §Combined Pitch/72-75] 避免“AI Agent Social Engineering”这个标签。它容易触发安全领域负面联想，且新学科 claim 没必要。

# Execution Plan Score（执行计划评分）

评分：4/10。

[research/zuaec/master-execution-plan.md §目标/3-7, §里程碑/333-343] 14 周内完成 Paper 1 arXiv、Paper 2 arXiv、Mycelium 主网部署，对小团队过于激进。Paper 1 若把目标限定为合格 scoping review + conceptual framework，仍有现实路径；但 Paper 2 依赖的 VC、ASM Codec、Nostr、libp2p、ZK、reputation accumulator 多数仍待设计或待实现。[research/zuaec/agent-network-architecture.md §5.1-5.2/204-219] 最可能滑期的是 Phase 6 工程实现与性能数据采集，其次是 Paper 1 PRISMA-ScR 文献核实。[research/zuaec/master-execution-plan.md §风险清单/345-355] 当前风险表低估了 ZK 与主网部署对论文可信度的联动影响；建议把 8/31 的硬目标改为 Paper 1 arXiv + Paper 2 technical draft + Sepolia evidence package。
