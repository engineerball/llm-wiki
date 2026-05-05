---
source_url: https://blog.reachsumit.com/posts/2023/03/two-tower-model/
fetched: 2026-05-05
published: 2023-03-04
author: Sumit Kumar
---

# Two Tower Model Architecture: Current State and Promising Extensions

## Core Design Philosophy

"Late interaction" — towers process inputs independently; interaction only at output via inner product. Enables embedding freezing and offline indexing after training → inference efficient.

## DNN Retrieval Paradigm Taxonomy

Four paradigms, positioned on the interaction-depth spectrum:

1. **Representation-based rankers (Two Tower)** — independent embedding computation; interaction only at output (inner product)
2. **Interaction-focused rankers (DRMM, KNRM)** — word/phrase-level relationship modeling via interaction matrices
3. **Cross-encoders (BERT)** — simultaneous within AND cross-sequence interaction; highest expressivity, lowest throughput
4. **Late-interaction hybrids (ColBERT)** — preserves query-document decoupling; richer interactions than dot product but without full cross-encoder cost

Position: Two Tower trades interaction depth for serving efficiency. ColBERT is a middle ground.

## Dual Encoder Classification

### Siamese Dual Encoders (SDE)
Identical sub-networks with shared parameters processing both inputs.

### Asymmetric Dual Encoders (ADE)
Distinctly parameterized encoders (user and item towers are different networks).

Research finding: SDEs outperform ADEs UNLESS shared projection layers (ADE-SPL) are added, which can match or exceed SDE performance.

## Cascade Ranking Context

Pre-ranking systems: earlier stages prioritize recall with simpler algorithms; large-scale DNNs used at ranking and re-ranking stages.

Key constraint: even 100ms latency increase leads to degraded user experience and measurable revenue impact.

## Research Extensions

### DAT — Dual Augmented Two-Tower (Yu et al.)

Augments each tower's embedding input with **interaction vectors** ($a_u$ and $a_v$) capturing historical positive interaction information from the OTHER tower.

- User tower input: user features + $a_u$ (aggregated item interaction info)
- Item tower input: item features + $a_v$ (aggregated user interaction info)

Also introduces **category alignment loss** for handling data imbalance across item categories.

The interaction vectors bring cross-tower information into the early encoding stage without coupling inference — candidate embeddings can still be precomputed.

### IntTower — Interaction Enhanced Two Tower (Li et al.)

Three novel components:

**1. Light-SE Block (Lightweight Squeeze-and-Excitation)**
Channel attention mechanism. Single FC layer instead of SENET's multi-step approach. Identifies feature importance and refines representations within each tower.

**2. FE-Block (Fine-grained Early Feature Interaction)**
Inspired by ColBERT's late interaction. Performs fine-grained interactions between multi-layer user representations and final-layer item representation.

**3. CIR Module (Contrastive Interaction Regularization)**
InfoNCE loss minimizing distances between users and positive items during training, combined with traditional log-loss.

Result: Outperforms other pre-ranking algorithms while maintaining comparable serving latency to standard two-tower.

t-SNE visualization: users and positive items cluster together; negative items remain distant — better semantic alignment than standard two-tower.

## Single-Tower Alternatives

**COLD** (Computing power cost-aware Online and Lightweight Deep): offline feature selection optimizing for QPS and response time metrics.

**FSCD** (Feature Selection via Complexity and variational Dropout): learnable dropout for feature-wise regularization.

## Key References

- Bromley et al. (1993) — original Siamese networks (signature verification)
- Huang et al. (2013) — semantic search with dual encoders
- Khattab & Zaharia (2020) — ColBERT late-interaction
- Covington et al. (2016) — YouTube DNN
