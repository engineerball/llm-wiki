---
title: "The Two-Tower Model for Recommendation Systems: A Deep Dive"
type: source
tags: [source, ml, retrieval, recommendation-systems, two-tower, embeddings, training, negative-sampling]
sources: [".raw/articles/shaped-ai-two-tower-model-deep-dive-2026-05-05.md"]
date: 2026-05-05
author: Shaped.ai
url: https://www.shaped.ai/blog/the-two-tower-model-for-recommendation-systems-a-deep-dive
---

# The Two-Tower Model for Recommendation Systems: A Deep Dive

Shaped.ai blog post. Comprehensive treatment of [[two-tower-architecture]] covering training techniques, loss functions, [[negative-sampling]] strategies, multi-stage pipeline context, and comparison to alternatives.

Most distinct contribution vs. other sources in this wiki: detailed taxonomy of loss functions and negative sampling strategies for two-tower training.

## Architecture Recap

User Tower → user embedding **u** | Item Tower → item embedding **v**
Score = **u · v** (dot product) or cosine similarity.

Feature handling per type:

| Feature | Processing |
|---|---|
| IDs | Learned embedding layers |
| Categorical | Embedding |
| Numerical | Normalize → MLP |
| Text | TF-IDF to BERT |
| Images | Pretrained CNN |
| Sequential (history) | LSTM/GRU, Attention, Transformers |

## Loss Functions Taxonomy

Three families:

### Pointwise
- **Log Loss** — binary cross-entropy on positive/negative pairs; treat as classification
- **MSE** — regression on explicit ratings (e.g., 1–5 stars)

### Pairwise
- **BPR (Bayesian Personalized Ranking)** — directly maximize P(positive item ranked above negative item); more aligned with ranking objective than pointwise losses

### Contrastive
- **InfoNCE** — treats all other items in the batch as negatives:

```
L = -log[ exp(u·v_pos / τ) / Σᵢ exp(u·vᵢ / τ) ]
```

`τ` = temperature hyperparameter. Lower τ → sharper distribution, harder training signal. Higher τ → softer, more stable. InfoNCE naturally combines with in-batch negatives.

## Negative Sampling

See [[negative-sampling]] for full treatment. Summary:

| Strategy | Mechanism | Trade-off |
|---|---|---|
| Random | Uniform draw | Simple; easy negatives |
| Popularity-based | Sample ∝ item popularity | Corrects popularity bias |
| Hard negative mining | Items ranked high but not interacted | Harder signal; risk false negatives |
| In-batch negatives | Other items in same batch = negatives | Efficient; no extra sampling |

## Role in Multi-Stage Pipeline

```
Billions of items
    ↓  [Two-Tower Retrieval] — recall-focused, ANN search
~1000 candidates
    ↓  [Ranker] — feature-interaction-focused
Top-K results
```

Named ranking models used after two-tower retrieval:
- **Deep & Wide** (Google)
- **DCN / Deep & Cross Network** (Google)
- **DeepFM**
- **LightGBM** (gradient boosting; popular for production ranking)

Two-tower's limitation (shallow dot product) is handled by the ranker, which uses explicit feature cross terms.

## Limitations Worth Noting

- Dot product is a shallow similarity function — can't model complex user-item interactions (that's the ranker's job)
- Can amplify popularity bias if training data reflects it
- Cold start still requires feature-based mitigation (see [[cold-start-problem]])

## Comparison to Alternatives

| Method | Catalog Scale | Feature Richness | Feature Interaction |
|---|---|---|---|
| Matrix factorization | Large | Low (IDs only) | None |
| Two-tower | Massive (ANN) | High | Shallow (dot product) |
| FM / DeepFM / DCN | Small-medium | High | Deep (cross terms) |
| GNN | Depends on graph | High | Graph-structured |

## Related Pages

- [[two-tower-architecture]] — full architecture reference
- [[negative-sampling]] — sampling strategies for training
- [[recommendation-systems]] — pipeline context; ranker models
- [[approximate-nearest-neighbors]] — ANN serving
- [[cold-start-problem]] — limitation + mitigation
