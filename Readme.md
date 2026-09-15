# Protocol Launch
[Chinese version](#中文版-chinese-translation)
## Three Questions
**1. Who are you?**
* **Introduction:** AAStar is an Ethereum open-source building group. Originating from a building group (AAStar) under Plancker^, it inherited the Plancker spirit and began operating independently in November 2024.

**2. Where do you come from?**
* **Overview:** Following a discussion with Vitalik at Zuzalu in April 2023, the AAStar (Account Abstraction) group was established by Plancker^, focusing primarily on AA and infrastructure.

**3. Where are you going?**
* **Vision:** By advocating and exploring the establishment of the Mycelium open protocol, we aim to empower communities and free individuals. We focus on addressing motivational challenges in the blockchain space, empowering the community to inspire greater innovation and collaboration.
---
check this doc:[Humanity Light](./docs/HumanityLight.md)
Organizations that foster the exploration of life's meaning are what I simply define as: Community.

## Links
1. [Roadmap](https://www.mushroom.cv/documentation/5/roadmap-2026-2027)
2. [Realtime Progress on Tasks](https://www.mushroom.cv/), Milestones,[Research](https://www.mushroom.cv/milestones)
3. [Cold Launch](./docs/Coldlaunch.md)
4. [Mushroom Forest](./docs/CommuTouch.md)
5. [Docs](https://www.mushroom.cv/documentation/1/broodbrain-readme)


## Launching
We following: Problem --> Academic Research --> Digital Public Goods --> Validation.
We are seeking for grant, sponsorship, and partnerships to support our work.

### Cos72 & Sin90
### iDoris-Community Brain

## Repo Structure

```
site/           ← Static pages (index/cold-launch/architecture/sustainability/dashboard)
contracts/      ← Foundry project (GToken, SaleContract, APNTsSaleContract + tests)
docs/brood/     ← Docs from Brood (manifesto/roadmap/milestones/progress-report)
submodules/
  mushroomdao-site  ← mushroom.cv main site
  mushroomdao-docs  ← docs site
wrangler.toml   ← Cloudflare Pages deploy config (launch.mushroom.cv)
```

### Deploy
```bash
npx wrangler pages deploy site --project-name launch-mushroom-box
```

### Contracts (Foundry)
```bash
cd contracts && forge install && forge test
```

### Operations / 运维
- **开放 / 关闭销售**（手动 pause/unpause 控制分发节奏）：[docs/SALE-OPEN-CLOSE.md](./docs/SALE-OPEN-CLOSE.md) · 脚本 `scripts/sale-toggle.sh {status|open|close}`
- **重部署后周知上下游**（SDK / DVT relay）：[docs/DOWNSTREAM-DEPS.md](./docs/DOWNSTREAM-DEPS.md) · 脚本 `scripts/release-notify.sh`
- **已部署合约地址**：[contracts/DEPLOYED.md](./contracts/DEPLOYED.md)

# 中文版-chinese-translation
三个问题：
1. 你是谁？
- 简介：AAStar，一个以太坊开源建设小组，前身来自于Plancker^的建设小组（AAStar），2024年11月继承普朗克精神，独立运营。
2. 从哪来？
- 概述：23年4月Zuzalu与Vitalik沟通后，Plancker^建立的AAStar（账户抽象）小组，专注AA和infra。
3. 到哪去？
- 愿景：通过倡导和探索建立Mycelium开放协议，赋能社区，自由个体，聚焦区块链的动机问题，赋能社区从而激发更多创新和协作。

## License

This project is licensed under the [Apache License, Version 2.0](LICENSE).  
Copyright 2024-present MushroomDAO Contributors.  
See [NOTICE](./NOTICE) · [TRADEMARK.md](./TRADEMARK.md) · [LICENSE-zh.md](./LICENSE-zh.md) · [TRADEMARK-zh.md](./TRADEMARK-zh.md) for details.
