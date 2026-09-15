/*
 * Mycelium 数字公共物品 —— 共享数据源
 *
 * index.html（花园首页）与 public-goods.html（完整索引）都从这里读数据，
 * 新增或修改公共物品只需改这一个文件。
 *
 * 所有面向用户的字段都是 [中文, English] 二元组；owner 用于索引页筛选。
 */
(function (global) {
  'use strict';

  // 圈层：花园韦恩图里的四个圈，只在侧栏展示，不进索引表
  var LAYERS = {
    ecosystem: {
      grad: 'linear-gradient(135deg,#667eea,#764ba2)',
      cat: ['生态', 'Ecosystem'],
      name: ['Mycelium 生态', 'Mycelium Ecosystem'],
      meta: ['整座数字公共物品花园', 'The whole garden of digital public goods'],
      service: ['所有个体、社区与城市', 'Every individual, community & city'],
      cap: ['无许可加入的开放生态，由 Infra / Protocol / Network 三层构成', 'Permissionless open ecosystem built from Infra / Protocol / Network'],
      hw: ['—', '—'],
      org: ['无门槛', 'No barrier'],
      repo: 'https://github.com/MushroomDAO'
    },
    city: {
      grad: 'linear-gradient(135deg,#667eea,#764ba2)',
      cat: ['层级', 'Layer'],
      name: ['城市 City', 'City'],
      meta: ['花园里最大的圈', 'The largest circle in the garden'],
      service: ['区域与城市尺度的协作', 'Regional & city-scale collaboration'],
      cap: ['容纳社区与个体，共享大型公共设施', 'Holds communities & individuals sharing large public goods'],
      hw: ['—', '—'],
      org: ['城市 / 区域组织', 'City / regional orgs'],
      repo: 'https://github.com/MushroomDAO'
    },
    community: {
      grad: 'linear-gradient(135deg,#e0724a,#d94f7a)',
      cat: ['层级', 'Layer'],
      name: ['社区 Community', 'Community'],
      meta: ['城市中的协作单元', 'A collaboration unit within the city'],
      service: ['社区与其成员', 'Communities & their members'],
      cap: ['共建、共治、共享公共物品', 'Co-build, co-govern & share public goods'],
      hw: ['视具体物品而定', 'Depends on the good'],
      org: ['需社区组织与运维', 'Needs community org & ops'],
      repo: 'https://github.com/MushroomDAO'
    },
    individual: {
      grad: 'linear-gradient(135deg,#d94f7a,#f5576c)',
      cat: ['层级', 'Layer'],
      name: ['个体 Individual', 'Individual'],
      meta: ['与社区交汇的一环', 'Overlapping with the community'],
      service: ['独立的个人用户', 'Independent individual users'],
      cap: ['许多公共物品个人也能直接使用', 'Many public goods are usable directly by individuals'],
      hw: ['个人设备', 'Personal device'],
      org: ['无', 'None'],
      repo: 'https://github.com/MushroomDAO'
    }
  };

  /*
   * 设施：花园里可点击的节点，同时构成索引表的行。
   * word      —— 花园隐喻（摩天轮 / 桥 / 喷泉 …），显示在节点标签与表格副标题
   * pos       —— 韦恩图舞台上的位置（百分比）；为 null 表示只进索引表，不在舞台上放节点
   * owner     —— aastar | auraai | mycelium，索引页按此筛选
   * dot       —— 索引页行首的色点
   * repoLabel —— 索引页仓库列的显示名
   */
  var FACILITIES = {
    cityos: {
      owner: 'mycelium', pos: { left: 46, top: 30 }, dot: '#667eea',
      grad: 'linear-gradient(135deg,#667eea,#764ba2)',
      cat: ['Mycelium · 协议', 'Mycelium · Protocol'], status: null,
      name: ['CityOS', 'CityOS'], word: ['摩天轮', 'Ferris wheel'],
      meta: ['俯瞰全城的摩天轮', 'A ferris wheel overlooking the whole city'],
      service: ['城市 / 区域', 'City / region'],
      cap: ['城市尺度的协作与公共物品调度', 'City-scale collaboration & public-goods scheduling'],
      hw: ['区域基础设施', 'Regional infrastructure'],
      org: ['城市 / 区域组织', 'City / regional orgs'],
      repo: 'https://github.com/MushroomDAO', repoLabel: 'MushroomDAO'
    },
    airaccount: {
      owner: 'aastar', pos: { left: 60, top: 51 }, dot: '#4facfe',
      grad: 'linear-gradient(135deg,#4facfe,#00f2fe)',
      cat: ['AAStar · Infra', 'AAStar · Infra'], status: null,
      name: ['AirAccount', 'AirAccount'], word: ['桥', 'Bridge'],
      meta: ['连接用户与链的桥', 'A bridge connecting users to the chain'],
      service: ['个体 / 社区', 'Individual / Community'],
      cap: ['账户抽象钱包：无私钥、社交恢复、passkey 登录；Session Keys，446/446 测试通过', 'Account-abstraction wallet: keyless, social recovery, passkey login; Session Keys, 446/446 tests passing'],
      hw: ['imx93（可自托管）', 'imx93 (self-hostable)'],
      org: ['无（个人可用）', 'None (individual-ready)'],
      repo: 'https://github.com/AAStarCommunity', repoLabel: 'AAStarCommunity'
    },
    superpaymaster: {
      owner: 'aastar', pos: { left: 56, top: 85 }, dot: '#00c2d6',
      grad: 'linear-gradient(135deg,#4facfe,#00f2fe)',
      cat: ['AAStar · Infra', 'AAStar · Infra'], status: null,
      name: ['SuperPaymaster', 'SuperPaymaster'], word: ['喷泉', 'Fountain'],
      meta: ['源源不断赞助 gas 的喷泉', 'A fountain that keeps sponsoring gas'],
      service: ['个体 / 社区 / 城市', 'Individual / Community / City'],
      cap: ['无 gas 交易与 Web3 代理微支付：分布式 gas 赞助与 PNTs 结算', 'Gasless transactions & Web3 proxy micropayments: distributed gas sponsorship and PNTs settlement'],
      hw: ['imx93 / 服务器', 'imx93 / server'],
      org: ['需运行 paymaster 节点', 'Needs a paymaster node'],
      repo: 'https://github.com/AAStarCommunity', repoLabel: 'AAStarCommunity'
    },
    yaaa: {
      owner: 'aastar', pos: { left: 60, top: 25 }, dot: '#45b7d1',
      grad: 'linear-gradient(135deg,#45b7d1,#00f2fe)',
      cat: ['AAStar · Infra', 'AAStar · Infra'], status: null,
      name: ['YAAA', 'YAAA'], word: ['温室', 'Greenhouse'],
      meta: ['育苗用的参考温室', 'A reference greenhouse for growing seedlings'],
      service: ['开发者 / 社区', 'Developers / Community'],
      cap: ['YetAnotherAA：Passkey、账户流与 AAStar 集成的一体化参考实现', 'YetAnotherAA — Passkey, account flow & AAStar integration in one reference build'],
      hw: ['—', '—'],
      org: ['无（参考实现）', 'None (reference build)'],
      repo: 'https://github.com/AAStarCommunity', repoLabel: 'AAStarCommunity'
    },
    kms: {
      owner: 'aastar', pos: { left: 88, top: 51 }, dot: '#96ceb4',
      grad: 'linear-gradient(135deg,#96ceb4,#43e97b)',
      cat: ['AAStar · Infra', 'AAStar · Infra'], status: null,
      name: ['KMS', 'KMS'], word: ['地窖', 'Root cellar'],
      meta: ['把种子妥善封存的地窖', 'A cellar that keeps the seeds safe'],
      service: ['个体 / 社区', 'Individual / Community'],
      cap: ['TEE 私钥托管：指纹登录，无需持有 ETH', 'TEE-secured private-key management: fingerprint login, no ETH required'],
      hw: ['TEE 设备 / imx93', 'TEE device / imx93'],
      org: ['无（个人可用）', 'None (individual-ready)'],
      repo: 'https://github.com/AAStarCommunity', repoLabel: 'AAStarCommunity'
    },
    cometens: {
      owner: 'aastar', pos: { left: 12, top: 51 }, dot: '#667eea',
      grad: 'linear-gradient(135deg,#667eea,#764ba2)',
      cat: ['AAStar · Infra', 'AAStar · Infra'], status: null,
      name: ['CometENS', 'CometENS'], word: ['路标', 'Signpost'],
      meta: ['让人找得到路的路标', 'A signpost so people can find their way'],
      service: ['个体 / 社区', 'Individual / Community'],
      cap: ['链上可读身份与命名：为每个账户命名', 'Human-readable on-chain identity and naming for every account'],
      hw: ['—', '—'],
      org: ['无（个人可用）', 'None (individual-ready)'],
      repo: 'https://github.com/AAStarCommunity', repoLabel: 'AAStarCommunity'
    },
    dvt: {
      owner: 'aastar', pos: { left: 67, top: 69 }, dot: '#b07ad6',
      grad: 'linear-gradient(135deg,#b07ad6,#764ba2)',
      cat: ['AAStar · Infra', 'AAStar · Infra'], status: null,
      name: ['DVT', 'DVT'], word: ['蜂巢', 'Beehive'],
      meta: ['没有单只蜜蜂说了算的蜂巢', 'A hive where no single bee decides'],
      service: ['社区 / 城市', 'Community / City'],
      cap: ['分布式验证：信任不落在单点', 'Distributed validation — trust never rests on one node'],
      hw: ['验证节点', 'Validation node'],
      org: ['需运行验证节点', 'Needs a validation node'],
      repo: 'https://github.com/AAStarCommunity', repoLabel: 'AAStarCommunity'
    },
    opennest: {
      owner: 'aastar', pos: { left: 23, top: 63 }, dot: '#2bbd6e',
      grad: 'linear-gradient(135deg,#43e97b,#38f9d7)',
      cat: ['AAStar · Infra', 'AAStar · Infra'], status: null,
      name: ['OpenNest', 'OpenNest'], word: ['凉亭', 'Pavilion'],
      meta: ['孵育小微创新的凉亭', 'A pavilion that shelters small innovations'],
      service: ['社区', 'Community'],
      cap: ['社区微小创新赞助机制：为社区内的小微创新提供资助与孵化', 'Community micro-innovation sponsorship: funds and incubates small innovations inside a community'],
      hw: ['—', '—'],
      org: ['需社区组织', 'Needs community org'],
      repo: 'https://github.com/AAStarCommunity', repoLabel: 'AAStarCommunity'
    },
    idoris: {
      owner: 'auraai', pos: { left: 33, top: 48 }, dot: '#f5576c',
      grad: 'linear-gradient(135deg,#f093fb,#f5576c)',
      cat: ['AuraAI · AI', 'AuraAI · AI'], status: ['Beta', 'Beta'],
      name: ['iDoris', 'iDoris'], word: ['路灯', 'Streetlight'],
      meta: ['照亮社区决策的路灯', 'A streetlight lighting community decisions'],
      service: ['社区', 'Community'],
      cap: ['联邦分层微调的社区大脑：消费 / 招聘 / 投资决策辅助', 'Federated-layer community brain: consumption / hiring / investment assist'],
      hw: ['本地 GPU 或远程 API', 'Local GPU or remote API'],
      org: ['需社区数据与运维', 'Needs community data & ops'],
      repo: 'https://github.com/MushroomDAO/Doris', repoLabel: 'MushroomDAO/Doris'
    },
    agent24: {
      owner: 'auraai', pos: { left: 52, top: 70 }, dot: '#f093fb',
      grad: 'linear-gradient(135deg,#f093fb,#f5576c)',
      cat: ['AuraAI · AI', 'AuraAI · AI'], status: ['Beta', 'Beta'],
      name: ['Agent24', 'Agent24'], word: ['走廊', 'Corridor'],
      meta: ['连通各处消息的走廊', 'A corridor linking messages everywhere'],
      service: ['个体 / 社区', 'Individual / Community'],
      cap: ['24/7 沟通代理：聚合 WeChat/TG/Discord/邮件、排程、签署积分合约', '24/7 comms agent: aggregate WeChat/TG/Discord/email, schedule, sign points contracts'],
      hw: ['本地或云', 'Local or cloud'],
      org: ['无（基础版免费）', 'None (free at base)'],
      repo: 'https://github.com/AuraAI', repoLabel: 'AuraAI'
    },
    opencrab: {
      owner: 'auraai', pos: { left: 15, top: 79 }, dot: '#fa709a',
      grad: 'linear-gradient(135deg,#fa709a,#fee140)',
      cat: ['AuraAI · AI', 'AuraAI · AI'], status: ['Research', 'Research'],
      name: ['OpenCrab', 'OpenCrab'], word: ['河流', 'River'],
      meta: ['数据流动的河流', 'A river where data flows'],
      service: ['社区 / 城市', 'Community / City'],
      cap: ['分布式数据抓取与策展，为 iDoris 等供给上游数据集', 'Distributed crawling & curation, feeding upstream datasets to iDoris'],
      hw: ['抓取节点', 'Crawling node'],
      org: ['需贡献者运行节点（赚 PNTs）', 'Contributors run nodes (earn PNTs)'],
      repo: 'https://github.com/AuraAI', repoLabel: 'AuraAI'
    },
    park: {
      owner: 'mycelium', pos: { left: 35, top: 87 }, dot: '#43e97b',
      grad: 'linear-gradient(135deg,#43e97b,#38f9d7)',
      cat: ['Mycelium · 协议', 'Mycelium · Protocol'], status: null,
      name: ['Park Protocol', 'Park Protocol'], word: ['长椅', 'Bench'],
      meta: ['供人歇脚的公共长椅', 'A public bench to rest on'],
      service: ['社区', 'Community'],
      cap: ['社区公地与公共物品治理框架', 'Community commons & public-goods governance framework'],
      hw: ['—', '—'],
      org: ['需社区组织', 'Needs community org'],
      repo: 'https://github.com/MushroomDAO', repoLabel: 'MushroomDAO'
    },
    sin90: {
      owner: 'auraai', pos: { left: 78, top: 53 }, dot: '#c9a7f5',
      grad: 'linear-gradient(135deg,#a8edea,#fed6e3)',
      cat: ['AuraAI · AI', 'AuraAI · AI'], status: ['Beta', 'Beta'],
      name: ['Sin90', 'Sin90'], word: ['私人花园', 'Garden'],
      meta: ['属于你自己的私人花园', 'Your very own private garden'],
      service: ['个体', 'Individual'],
      cap: ['本地优先的个人 AI OS：Agent 团队 + 知识管理', 'Local-first personal AI OS: agent team + knowledge management'],
      hw: ['个人电脑（llama.cpp / Ollama）', 'Personal computer (llama.cpp / Ollama)'],
      org: ['无', 'None'],
      repo: 'https://github.com/AuraAI', repoLabel: 'AuraAI'
    },
    cos72: {
      owner: 'mycelium', pos: { left: 80, top: 76 }, dot: '#fa709a',
      grad: 'linear-gradient(135deg,#fa709a,#fee140)',
      cat: ['Mycelium · 协议', 'Mycelium · Protocol'], status: ['Beta', 'Beta'],
      name: ['COS72', 'COS72'], word: ['跳楼机', 'Drop tower'],
      meta: ['社区的中央游乐设施（跳楼机）', 'The community’s central ride (drop tower)'],
      service: ['社区 / 个体', 'Community / Individual'],
      cap: ['社区操作系统套件：共识（SnapShot 镜像改进版）、任务 OpenTask、积分记录 OpenPNTs / xPNTs、兑换台 Redeem Counter', 'Community OS suite: consensus (improved Snapshot mirror), OpenTask, OpenPNTs / xPNTs records, and a Redeem Counter'],
      hw: ['个人设备 / 服务器', 'Personal device / server'],
      org: ['需社区组织', 'Needs community org'],
      repo: 'https://github.com/MushroomDAO/COS72', repoLabel: 'MushroomDAO/COS72'
    },
    // 只进索引表，不在花园舞台上放节点（舞台已满）
    openpnts: {
      owner: 'mycelium', pos: null, dot: '#ffb703',
      grad: 'linear-gradient(135deg,#fa709a,#fee140)',
      cat: ['Mycelium · 协议', 'Mycelium · Protocol'], status: ['Beta', 'Beta'],
      name: ['OpenPNTs', 'OpenPNTs'], word: ['音乐 / 激励', 'Music / incentives'],
      meta: ['让花园响起音乐的激励层', 'The incentive layer that sets the garden to music'],
      service: ['个体 / 社区 / 城市', 'Individual / Community / City'],
      cap: ['开放积分协议：任意组织与个人发行忠诚积分（xPNTs / aPNTs / mPNTs）', 'Open points protocol: any org or individual issues loyalty points (xPNTs / aPNTs / mPNTs)'],
      hw: ['—', '—'],
      org: ['任意组织可发行', 'Any org can issue'],
      repo: 'https://github.com/MushroomDAO/OpenPNTs', repoLabel: 'MushroomDAO/OpenPNTs'
    },
    openlog: {
      owner: 'mycelium', pos: { left: 20, top: 10 }, dot: '#667eea',
      grad: 'linear-gradient(135deg,#667eea,#764ba2)',
      cat: ['Mycelium · 内容', 'Mycelium · Content'], status: null,
      name: ['OpenLog', 'OpenLog'], word: ['公告牌', 'Notice board'],
      meta: ['花园里的公告牌', 'A notice board in the garden'], link: ['Blog', 'Blog'],
      service: ['所有关注者', 'Everyone following along'],
      cap: ['研发团队的科技进展分享博客', 'The R&D team’s blog sharing tech progress'],
      hw: ['—', '—'],
      org: ['无', 'None'],
      repo: 'https://blog.mushroom.cv', repoLabel: 'blog.mushroom.cv'
    },
    sprout: {
      owner: 'mycelium', pos: { left: 80, top: 10 }, dot: '#2bbd6e',
      grad: 'linear-gradient(135deg,#43e97b,#38f9d7)',
      cat: ['Mycelium · 内容', 'Mycelium · Content'], status: null,
      name: ['Sprout', 'Sprout'], word: ['新芽', 'Seedling'],
      meta: ['破土而出的新芽', 'A seedling breaking through the soil'], link: ['小红书', 'Xiaohongshu'],
      service: ['个体 / 学习者', 'Individuals / learners'],
      cap: ['小红书 5–7 分钟短视频：「AI 用起来，follow me」', '5–7 min shorts on Xiaohongshu — “Put AI to work, follow me”'],
      hw: ['—', '—'],
      org: ['无', 'None'],
      repo: 'https://www.xiaohongshu.com', repoLabel: ['小红书 @Mycelium', 'Xiaohongshu @Mycelium']
    }
  };

  // 索引表 / 花园节点的渲染顺序
  var ORDER = [
    'cityos', 'airaccount', 'superpaymaster', 'yaaa', 'kms', 'cometens', 'dvt',
    'opennest', 'idoris', 'agent24', 'opencrab', 'park', 'sin90', 'cos72',
    'openpnts', 'openlog', 'sprout'
  ];

  // 组织显示名，索引页行副标题用
  var OWNERS = {
    mycelium: ['Mycelium 协议', 'Mycelium Protocol'],
    aastar: ['AAStar', 'AAStar'],
    auraai: ['AuraAI', 'AuraAI']
  };

  global.MYCELIUM_GOODS = {
    layers: LAYERS,
    facilities: FACILITIES,
    order: ORDER,
    owners: OWNERS,
    // 圈层 + 设施合集，供侧栏按 id 查
    all: (function () {
      var m = {};
      Object.keys(LAYERS).forEach(function (k) { m[k] = LAYERS[k]; });
      Object.keys(FACILITIES).forEach(function (k) { m[k] = FACILITIES[k]; });
      return m;
    })(),
    // 取本地化字段：数组按语言下标取，非数组原样返回
    pick: function (v, langIndex) {
      return Array.isArray(v) ? v[langIndex] : v;
    }
  };
})(window);
