---
title: "Recommendation Systems"
type: concept
tags: [concept, ml, retrieval, recommendation-systems, embeddings]
sources: [".raw/articles/scaling-deep-retrieval-tensorflow-two-towers-architecture-2026-05-05.md"]
date: 2026-05-05
---

# Recommendation Systems

ML systems that predict what items (products, content, tracks, documents) are most relevant to a user or query at a given moment. Core infrastructure for e-commerce, streaming, search, and feed ranking.

## Multi-Stage Architecture

Large-scale recommenders use a pipeline of stages to balance recall, relevance, and latency:

```
All candidates (billions)
      ↓
  [Retrieval] — fast, coarse-grained; narrow to ~1000 candidates
      ↓
  [Ranking] — expensive model; score 1000 candidates
      ↓
  [Re-ranking / Filtering] — business rules, diversity, freshness
      ↓
  Top-K results shown to user
```

**Retrieval** is the bottleneck. Must be fast enough (milliseconds) while still capturing relevant candidates. This is where [[two-tower-architecture]] and [[approximate-nearest-neighbors]] operate.

## Retrieval Approaches

| Generation | Method | Pros | Cons |
|---|---|---|---|
| Token-based | Inverted n-gram index | Interpretable, precise | Poor recall; exact match only |
| Factorization | Matrix factorization (collaborative filtering) | Better generalization | Limited feature expressivity |
| Neural Deep Retrieval | Two-tower DNN + ANN | High recall, rich features | Higher complexity |

## Collaborative vs. Content-Based

Two orthogonal signal types:
- **Collaborative filtering** — learns from user-item interaction history; "users like you also liked..."
- **Content-based** — uses item/user features directly; "this track has similar audio to what you like"

Modern systems combine both. The [[two-tower-architecture]] supports either or both — feature choice determines the embedding space geometry.

## Key Metrics

- **Recall@K** — fraction of relevant items in top-K results; primary retrieval quality metric
- **Precision@K** — fraction of top-K results that are relevant
- **NDCG** — Normalized Discounted Cumulative Gain; accounts for position of relevant items
- **Factorized Top-K** — metric used in TFRS during training (approximation of Top-K recall)

## Training Data Design

Training examples are positive `<query, candidate>` pairs. Signal choice matters:

> From YouTube DNN paper: Watch-time features outperform click-through rate for preventing clickbait recommendations. The optimization target shapes the system's behavior.

Feature pair examples and their effect:
- `<playlist title, track title>` → title-similarity embedding space
- `<audio features, audio features>` → audio-profile embedding space
- `<user history, item features>` → collaborative embedding space

## Tools and Services

- [[tensorflow-recommenders]] (TFRS) — TF library for building two-tower retrieval models
- [[vertex-ai-matching-engine]] — Google managed ANN service for serving
- BigQuery ML — matrix factorization on structured data
- Recommendations AI (Google) — fully managed, end-to-end

## Related Pages

- [[two-tower-architecture]] — primary neural retrieval pattern
- [[approximate-nearest-neighbors]] — serving layer for dense retrieval
- [[tensorflow-recommenders]] — TFRS implementation library
- [[vertex-ai-matching-engine]] — Google's managed ANN index
- [[two-towers-deep-retrieval-google-cloud]] — source article
