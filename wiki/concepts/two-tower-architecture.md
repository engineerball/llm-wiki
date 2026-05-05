---
title: "Two-Tower Architecture"
type: concept
tags: [concept, ml, retrieval, embeddings, recommendation-systems, neural-networks]
sources: [".raw/articles/scaling-deep-retrieval-tensorflow-two-towers-architecture-2026-05-05.md", ".raw/articles/two-tower-deep-learning-movie-recommender-system-2026-05-05.md", ".raw/articles/shaped-ai-two-tower-model-deep-dive-2026-05-05.md", ".raw/articles/reachsumit-two-tower-model-2026-05-05.md"]
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

Trained on positive `<query, candidate>` pairs with negative sampling. The model learns to score positive pairs higher than negatives.

**Training data determines embedding geometry.** Feature selection = implicit geometry selection. See [[two-towers-deep-retrieval-google-cloud]] for examples.

### Loss Functions

Three families:
- **Pointwise** — Log Loss (binary cross-entropy on pos/neg pairs) or MSE (rating regression)
- **Pairwise** — BPR (Bayesian Personalized Ranking): maximize P(positive ranked above negative)
- **Contrastive** — InfoNCE with in-batch negatives: `L = -log[exp(u·v_pos/τ) / Σᵢ exp(u·vᵢ/τ)]`; τ = temperature

### Sequential Features

User history sequences (watch history, purchase sequence) processed via:
- LSTM / GRU — recurrent; captures order
- Attention / Transformers — parallel; captures long-range dependencies
- Output fed into user tower as one input among others

### Negative Sampling

See [[negative-sampling]] for full taxonomy. Common strategies:
- **In-batch negatives** — other items in batch = negatives; efficient, natural fit for InfoNCE
- **Hard negative mining** — items ranked high but not interacted; strongest signal, risk false negatives
- **Popularity-based** — sample ∝ item popularity; corrects popularity bias

Loss function in TFRS:
```python
self.task = tfrs.tasks.Retrieval(
    metrics=tfrs.metrics.FactorizedTopK(...)
)
```

## DNN Retrieval Paradigm Taxonomy

Four paradigms along the interaction-depth spectrum:

| Paradigm | Examples | Interaction | Serving |
|---|---|---|---|
| Representation-based | **Two-Tower** | Output only (dot product) | Highest (ANN precompute) |
| Late-interaction | ColBERT | Token-level, decoupled | Medium |
| Interaction-focused | DRMM, KNRM | Word/phrase interaction matrices | Low |
| Cross-encoder | BERT | Full cross-sequence | Lowest |

Two-tower trades interaction depth for serving efficiency — the offline precomputation is the core tradeoff. ColBERT is the middle ground: decoupled encoding (ANN-compatible) with richer token-level scoring.

## Siamese vs Asymmetric Dual Encoders

Two variants by parameter sharing:

- **Siamese Dual Encoder (SDE)** — shared parameters for both towers; often used in symmetric retrieval (document–document)
- **Asymmetric Dual Encoder (ADE)** — distinct parameters per tower; standard for recommenders where user ≠ item domain

Research: SDEs outperform ADEs unless ADE adds shared projection layers (ADE-SPL), which can match or exceed SDE performance.

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

## Three-Tower Variant

The candidate side can itself be split into multiple towers — one for content features, one for the item ID. This pattern:

```
User Tower → user_emb (50-dim)
                                   ↘
                              dot product → score
                                   ↗
Item Feature Tower → feature_emb (25-dim) ─┐
                                            concat → item_combined_emb (50-dim)
Item ID Tower → id_emb (25-dim) ───────────┘
```

**Why:** Feature tower captures genre/category semantics (generalizes to new items); ID tower captures item-specific patterns features can't explain. Combining gives both recall and precision.

**Cold start benefit:** If an item is new (no ID history), the feature tower still contributes. See [[cold-start-problem]].

Source: [[two-tower-movie-recommender-pytorch]]

## User Representation: Features vs IDs

Standard two-tower uses a user ID embedding. Feature-based alternative represents users as observable signals:
- Watch/purchase history (binary vector over known items)
- Per-category debiased rating averages (`actual_rating - user_mean`)
- Session/contextual signals

**Trade-off:** ID embeddings give higher accuracy for known users; feature vectors generalize to new users ([[cold-start-problem]]). Three-tower approach on both sides captures both benefits.

## Research Extensions

Architectures that inject cross-tower information while preserving serving efficiency:

### DAT — Dual Augmented Two-Tower (Yu et al.)
Augments each tower's **input** with interaction vectors from the other side:
- User tower input: user features + $a_u$ (aggregated item interaction info)
- Item tower input: item features + $a_v$ (aggregated user interaction info)

Interaction vectors are static aggregates — candidate embeddings still precomputable. Also adds category alignment loss for item category imbalance.

### IntTower — Interaction Enhanced Two Tower (Li et al.)
Three stacked enhancements:
1. **Light-SE Block** — channel attention within each tower; single FC layer identifies feature importance
2. **FE-Block** — ColBERT-inspired fine-grained interaction between multi-layer user reps and final item rep
3. **CIR** — auxiliary InfoNCE loss (contrastive interaction regularization) + standard log loss

Claims to outperform other pre-ranking algorithms at comparable latency to standard two-tower.

Source: [[reachsumit-two-tower-model]]

## Known Implementations

- **TensorFlow Recommenders (TFRS)** — `tfrs.models.Model` base class with `tfrs.tasks.Retrieval` loss; see [[tensorflow-recommenders]]
- **PyTorch (raw)** — see [[two-tower-movie-recommender-pytorch]] for a three-tower MovieLens implementation
- **YouTube DNN** ("Deep Neural Networks for YouTube Recommendations", 2016) — early large-scale production two-tower system
- **Google Play, Spotify, Pinterest** — production systems using this pattern

## Related Pages

- [[recommendation-systems]] — broader context
- [[cold-start-problem]] — how user/item representation choice affects cold start
- [[approximate-nearest-neighbors]] — how to serve two-tower embeddings at scale
- [[vertex-ai-matching-engine]] — Google's managed ANN service
- [[tensorflow-recommenders]] — TFRS library for training two-tower models
- [[negative-sampling]] — negative sampling strategies for training
- [[two-towers-deep-retrieval-google-cloud]] — Google Cloud source article
- [[two-tower-movie-recommender-pytorch]] — PyTorch three-tower implementation
- [[shaped-ai-two-tower-deep-dive]] — loss functions + negative sampling deep dive
- [[reachsumit-two-tower-model]] — DNN taxonomy, SDE/ADE, DAT/IntTower extensions
