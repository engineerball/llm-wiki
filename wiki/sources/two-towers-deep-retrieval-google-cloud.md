---
title: "Scaling Deep Retrieval with TensorFlow Recommenders and Vertex AI Matching Engine"
type: source
tags: [source, ml, retrieval, recommendation-systems, two-tower, embeddings, google-cloud]
sources: [".raw/articles/scaling-deep-retrieval-tensorflow-two-towers-architecture-2026-05-05.md"]
date: 2026-05-05
original_published: 2023-04-20
authors: [Jeremy Wortz, Jordan Totten]
url: https://cloud.google.com/blog/products/ai-machine-learning/scaling-deep-retrieval-tensorflow-two-towers-architecture
---

# Scaling Deep Retrieval with TensorFlow Recommenders and Vertex AI Matching Engine

Google Cloud blog post (Apr 2023) by Jeremy Wortz and Jordan Totten. Covers implementing large-scale retrieval systems using the [[two-tower-architecture]] pattern with [[tensorflow-recommenders]] (TFRS), served via [[vertex-ai-matching-engine]] for approximate nearest neighbor search.

Uses the Spotify Million Playlist Dataset as a concrete playlist-continuation use case.

## Three Retrieval Approaches Compared

| Approach | When to Use |
|---|---|
| Recommendations AI | Fully managed, minimal ML expertise needed |
| BigQuery ML matrix factorization | Collaborative filtering on structured data |
| Two-tower + Vertex AI Matching Engine | Custom features, maximum expressivity, large scale |

## Core Architecture

Two-tower model maps queries and candidates to a **shared embedding space**:
- Query tower → query embedding
- Candidate tower → candidate embedding
- Similarity = dot product of the two embeddings

**Key benefit:** Decoupled inference. All candidate embeddings can be precomputed offline. Serving reduces to (1) query → embedding, (2) ANN search.

## Retrieval Evolution

Three milestones from the article:
1. **Token-based matching** — inverted n-gram index; high precision, poor recall
2. **Factorization-based** — matrix factorization; better generalization via latent factors
3. **Neural Deep Retrieval (NDR)** — deep networks; complex non-linear feature interactions

NDR and factorization are conceptually similar (dot product similarity) — NDR adds expressivity.

## Feature Processing Pipeline

| Feature Type | Pipeline |
|---|---|
| Text | TextVectorization (n-grams) → Embedding → GlobalAveragePooling1D |
| Sequence of text | TextVectorization → Embedding → Reshape → GlobalAveragePooling2D |
| Categorical | Hashing or StringLookup → Embedding |
| Numerical | Normalize → pass through |
| Pre-trained embeddings | Pass through unchanged |

**Hashing vs StringLookup:** Hashing is faster but risks hash collisions at small bin sizes. StringLookup requires vocabulary adaptation scan.

**Dense vs cross layers:** Cross layers model explicit feature interactions before dense layers. Improves performance at computational cost — evaluate parallel vs. stacked.

## Training Data Design

Training examples are `<query, candidate>` positive pairs. The feature choice determines the embedding space orientation:
- `<playlist title, track title>` pairs → title-based similarity space
- `<audio features, audio features>` pairs → audio profile similarity space

From YouTube DNN paper: watch-time features outperform click-through rate for preventing clickbait recommendations — signals matter.

## Deployment Architecture

```
Train both towers → Save separately
Query tower → Vertex AI online endpoint
Candidate tower → batch predict all candidates → JSON embeddings
→ Vertex AI Matching Engine ANN index
Serving: user request → query embedding → ANN search → top-N candidates
```

## Vertex AI Matching Engine

Managed ANN service. Supports:
- Up to 1 billion vectors
- Incremental index updates (no full rebuild)
- Dynamic index reorganization
- Autoscaling
- Boolean predicate filtering + diversity crowding tags

Uses **Tree-AH (Tree + Asymmetric Hashing)**:
1. Distributed search tree: hierarchically clusters embedding space
2. Asymmetric Hashing (AH): fast dot product approximation for scoring

See [[vertex-ai-matching-engine]] and [[approximate-nearest-neighbors]].

## Key Insights

> [!key-insight] Semantic match defines the embedding space
> Whatever semantic relationship the training pairs encode becomes the geometry of the embedding space. Feature selection is architecture selection.

> [!key-insight] Decoupled inference enables scale
> By precomputing candidate embeddings offline, the serving path only runs the query tower + ANN lookup — constant time regardless of corpus size.

## Related Pages

- [[two-tower-architecture]] — the core pattern
- [[approximate-nearest-neighbors]] — ANN indexing concepts
- [[recommendation-systems]] — broader context
- [[tensorflow-recommenders]] — TFRS library
- [[vertex-ai-matching-engine]] — managed ANN service
- [[google]] — publisher
