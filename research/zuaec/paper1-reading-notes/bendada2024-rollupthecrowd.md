# RollupTheCrowd: Leveraging ZkRollups for a Scalable and Privacy-Preserving Reputation-based Crowdsourcing Platform
**arXiv**: 2407.02226 | **Year**: 2024 | **Authors**: Ahmed Mounsf Rafik Bendada, Mouhamed Amine Bouchiha, Mourad Rabah, Yacine Ghamri-Doudane | **Venue**: IEEE COMPSAC 2024, Osaka, Japan

## Core Claim
ZkRollup-based crowdsourcing achieves 20× gas reduction while preserving worker reputation privacy — demonstrating that trustworthy crowdsourcing can be scaled on blockchain without forcing a choice between transparency and privacy.

## Key Evidence / Numbers
- **20× reduction in gas consumption** through zkRollup layer
- Blockchain-powered framework with off-chain storage for performance
- ZK proofs + smart contracts at Rollup layer for reputation model
- Privacy-preserving worker trustworthiness assessment
- Verified in proof-of-concept implementation

## ASM Comparison (Paper 2 focus)
- **What it does**: ZkRollup-based privacy-preserving reputation for crowdsourced task completion — demonstrates that on-chain reputation verification is feasible at scale with 20× efficiency gains
- **Gap vs ASM**: (1) Crowdsourcing-specific — task paradigm (requester assigns work, workers complete) does not map to agent-to-agent collaboration; (2) No DID-based agent identity — worker identity is not portable; (3) No role-bearing; (4) The zkRollup is the scaling mechanism, not the trust primitive
- **Paper 2 §5 use**: Cite as precedent for ZK-based privacy-preserving reputation on blockchain — relevant if ASM's reputation layer uses ZKP for selective disclosure of reputation scores

## Paper 1 Relevance
- **§4.3 (S pillar)**: Background evidence that on-chain reputation with privacy preservation is technically feasible; 20× efficiency precedent for reputation-on-chain
- Low direct relevance — crowdsourcing paradigm differs from agent collaboration

## Verdict
⭐⭐ | Background only — cite in P2 §5 footnote as ZK reputation precedent; limited relevance to agent collaboration model. IEEE COMPSAC venue adds modest credibility.

---
*Jason's feedback*: [待填]
