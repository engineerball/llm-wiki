---
title: "Two Tower Model Architecture: Current State and Promising Extensions"
type: source
tags: [source, ml, retrieval, recommendation-systems, two-tower, architecture, research]
sources: [".raw/articles/reachsumit-two-tower-model-2026-05-05.md"]
date: 2026-05-05
original_published: 2023-03-04
author: Sumit Kumar
url: https://blog.reachsumit.com/posts/2023/03/two-tower-model/
---

# Two Tower Model Architecture: Current State and Promising Extensions

Blog post by Sumit Kumar (Mar 2023). Places [[two-tower-architecture]] in the broader DNN retrieval taxonomy, distinguishes SDE vs ADE variants, and surveys research extensions (DAT, IntTower) that inject cross-tower interaction while preserving serving efficiency.

Most distinct contribution vs. other sources in this wiki: **DNN paradigm taxonomy** and **research enhancement architectures** (DAT, IntTower).

## DNN Retrieval Paradigm Taxonomy

Four paradigms along the interaction-depth spectrum:

| Paradigm | Examples | Interaction Depth | Serving Efficiency |
|---|---|---|---|
| Representation-based | Two-Tower | Output only (dot product) | Highest (ANN) |
| Late-interaction | ColBERT | Token-level, decoupled | Medium |
| Interaction-focused | DRMM, KNRM | Word/phrase interaction matrices | Low |
| Cross-encoder | BERT | Full cross-sequence | Lowest |

Two-tower sits at the maximum-efficiency end. ColBERT is a middle ground: decoupled encoding (like two-tower) but richer token-level interaction at scoring time.

**Design philosophy:** "late interaction" — towers independent → embeddings freezeable → offline indexing → O(1) serving.

## SDE vs ADE

Two-tower instances differ in whether towers share parameters:

- **Siamese Dual Encoder (SDE)** — shared parameters for user and item towers
- **Asymmetric Dual Encoder (ADE)** — distinct parameters per tower (typical for recommenders where user ≠ item domain)

Research finding: SDEs outperform ADEs unless ADE adds shared projection layers (ADE-SPL), which can match or exceed SDE.

In recommender systems, ADE is standard — user features and item features are fundamentally different inputs, so separate tower architectures make sense.

## Research Extensions

### DAT — Dual Augmented Two-Tower (Yu et al.)

Problem: standard two-tower has no cross-tower signal during encoding.
Solution: augment each tower's *input* with interaction vectors from the other side.

```
User Tower input = user features + a_u (aggregated item interaction info)
Item Tower input = item features + a_v (aggregated user interaction info)
```

Interaction vectors $a_u, a_v$ encode historical positive interaction information. Crucially: inference still decoupled — candidate embeddings precomputable (item interaction vector is static aggregate).

Also adds **category alignment loss** for item category imbalance in training data.

### IntTower — Interaction Enhanced Two Tower (Li et al.)

Three enhancements stacked on the two-tower base:

**Light-SE Block** — channel attention within each tower. Single FC layer identifies feature importance and reweights features. Lighter than standard Squeeze-and-Excitation (no multi-step reduction).

**FE-Block (Fine-grained Early Feature Interaction)** — cross-tower interaction at intermediate layers. Multi-layer user representations interact with final-layer item representation (ColBERT-inspired). Brings richer interaction without full cross-encoder cost.

**CIR (Contrastive Interaction Regularization)** — auxiliary InfoNCE loss minimizing user-positive_item distance during training, alongside standard log loss.

> IntTower outperforms other pre-ranking algorithms while maintaining comparable serving latency to standard two-tower.

t-SNE evidence: positive items cluster near users; negatives remain distant — better semantic alignment than standard dot-product two-tower.

## Latency Context

> Even a 100ms increase in response time leads to degraded user experience and measurable revenue impact.

This is why the two-tower's offline precomputation matters: serving = one forward pass (query tower) + ANN lookup, not two forward passes + dot product per candidate.

## Related Pages

- [[two-tower-architecture]] — base architecture; SDE/ADE and extensions added from this source
- [[negative-sampling]] — training techniques (InfoNCE referenced in CIR module)
- [[recommendation-systems]] — cascade ranking context
- [[approximate-nearest-neighbors]] — why late interaction matters for serving efficiency
