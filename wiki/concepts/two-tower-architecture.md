---
title: "Two-Tower Architecture"
type: concept
tags: [concept, ml, retrieval, embeddings, recommendation-systems, neural-networks]
sources: [".raw/articles/scaling-deep-retrieval-tensorflow-two-towers-architecture-2026-05-05.md"]
date: 2026-05-05
---

# Two-Tower Architecture

A neural retrieval pattern that maps **queries** and **candidates** to a shared embedding space using two separate neural networks (towers). Similarity is measured as the dot product between the two embedding vectors.

Core to large-scale recommender systems, search, and retrieval at companies like Google, YouTube, and Spotify.

## How It Works

```
Query (playlist, user, search query)
       ↓
  Query Tower (DNN)
       ↓
  Query Embedding ──────────────────────┐
                                        ↓
                                   Dot Product → Similarity Score
                                        ↑
Candidate Embedding ───────────────────┘
       ↑
  Candidate Tower (DNN)
       ↑
Candidate (track, item, document)
```

Both towers independently produce embeddings in the **same vector space**. The dot product (or cosine similarity) of query and candidate embeddings represents relevance.

## Key Property: Decoupled Inference

The towers are independent — candidate embeddings can be precomputed offline:

1. **Offline:** Run candidate tower over all candidates → store embeddings in ANN index
2. **Online:** Run query tower on live query → ANN lookup in precomputed index

This reduces serving to O(1) in corpus size. Scales to billions of candidates.

## Architecture Components

### Tower Structure

Each tower is typically:
- Feature input layer(s) per feature type
- Concatenation of all feature embeddings
- Optional: cross layer (explicit feature interactions)
- Dense layers (progressive dimensionality reduction)
- Final embedding output

### Feature Processing by Type

| Feature Type | Processing |
|---|---|
| Text | TextVectorization (n-grams) → Embedding → Pooling |
| Sequences | Embedding → Reshape → 2D Pooling |
| Categorical | Hashing or StringLookup → Embedding |
| Numerical | Normalize |
| Pre-trained embeddings | Pass through |

### Dense vs Cross Layers

- **Dense layers** — depth; successive non-linear transformations
- **Cross layers** — explicit feature interaction modeling before dense layers; better expressivity at higher compute cost

## Training

Trained on positive `<query, candidate>` pairs with in-batch negative sampling. Loss: maximizing dot product similarity for positive pairs.

**Training data determines embedding geometry.** If trained on `<playlist title, track title>` pairs, the embedding space reflects title similarity. If trained on `<audio features, audio features>`, it reflects audio similarity. Feature selection = implicit geometry selection.

Loss function in TFRS:
```python
self.task = tfrs.tasks.Retrieval(
    metrics=tfrs.metrics.FactorizedTopK(...)
)
```

## Retrieval Evolution: Where Two-Tower Fits

| Generation | Method | Recall | Expressivity |
|---|---|---|---|
| 1 | Token-based (inverted n-gram index) | Low | None |
| 2 | Factorization (collaborative filtering) | Medium | Low |
| 3 | Neural Deep Retrieval (two-tower) | High | High |

Two-tower is NDR. Conceptually related to factorization (both use dot product), but adds deep non-linear feature processing.

## Serving with ANN

Two-tower output is used with [[approximate-nearest-neighbors]] indexes ([[vertex-ai-matching-engine]], Faiss, ScaNN, Pinecone) for sub-linear retrieval over large corpora.

Deployment pattern:
1. Train combined model, save towers separately
2. Batch predict candidate tower → generate all embeddings → build ANN index
3. Deploy query tower as online inference endpoint
4. Serving: query → embedding → ANN lookup → top-N candidates

## Known Implementations

- **TensorFlow Recommenders (TFRS)** — `tfrs.models.Model` base class with `tfrs.tasks.Retrieval` loss; see [[tensorflow-recommenders]]
- **YouTube DNN** ("Deep Neural Networks for YouTube Recommendations", 2016) — early large-scale production two-tower system
- **Google Play, Spotify, Pinterest** — production systems using this pattern

## Related Pages

- [[recommendation-systems]] — broader context
- [[approximate-nearest-neighbors]] — how to serve two-tower embeddings at scale
- [[vertex-ai-matching-engine]] — Google's managed ANN service
- [[tensorflow-recommenders]] — TFRS library for training two-tower models
- [[two-towers-deep-retrieval-google-cloud]] — source article
