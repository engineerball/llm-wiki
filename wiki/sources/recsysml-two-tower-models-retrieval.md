---
title: "Two Tower Models for Retrieval of Recommendations (RecSysML)"
type: source
tags: [source, ml, recommendation-systems, two-tower, retrieval, embeddings, negative-sampling]
date: 2026-05-13
original_published: null
authors: [Gaurav Chakravorty]
url: https://recsysml.substack.com/p/two-tower-models-for-retrieval-of
---

# Two Tower Models for Retrieval of Recommendations (RecSysML)

By Gaurav Chakravorty. Part IV of a personalized recommendation series covering [[two-tower-architecture|two tower models]] for candidate generation, with practical insights on [[negative-sampling|negative sampling]], user/item encoder design, and the evolution from [[matrix-factorization|matrix factorization]]. Accompanied by a [GitHub implementation](https://github.com/gauravchak/two_tower_models).

## Why Two-Stage Architecture

Content platforms with millions/billions of items cannot thoroughly rank all candidates at serving time — it would be too slow. The solution: break into two stages:

1. **Retrieval** (candidate generation) — returns a few hundred items via fast [[embeddings]] matching
2. **Ranking** (re-ranking) — thorough ordering considering all item and user features

This separation also allows optimizing two distinct loss types:
- **Type 1**: User was looking for an item nowhere on the list (retrieval failure)
- **Type 2**: The right item was ranked lower in the list (ranking failure)

## User Encoder

The user encoder (tower) takes all available user signals and produces a fixed-size vector:

### User features
- History of items the user liked + timestamps (relative to now)
- Past search queries
- Location (if shared)
- Preferred languages
- Other metadata (genres, employment history, etc.)
- In social contexts: attributes of users they follow/connect to

User Encoder Architecture → fixed-size user embedding

## Item Encoder

The item encoder produces a fixed-size embedding for each recommendable item:

### Item features
- Title, description
- Metadata (language, publisher, etc.)
- Dynamic metadata (views, likes over time)

Item Encoder Architecture → fixed-size item embedding

## Training Objective

The two encoders are trained such that the **dot product** of user-item pairs that actually interacted is high, and non-interacting pairs is close to zero:

```
dot(user_embedding, item_embedding) → high for positive pairs, ~0 for negative pairs
```

### Positive Examples

Historical user-item interactions are used as positive examples. Key technique: **only use features as they were just before the interaction occurred** — not the full feature set after the interaction.

### Negative Examples

Two approaches for generating negative (non-interaction) samples:

1. **Random negative sampling** — randomly pick items not watched by the user
2. **Negative impressions** — pick items presented by the app but not clicked/watched

> [!key-insight] Random sampling works better initially
> Start with random negative sampling. Once the model reaches high recall, add some negative impression training. Using only negative impressions can confuse the model — a "second best" Sci-fi option that wasn't clicked gets rated equally bad as an entirely irrelevant genre, losing nuance.

> [!key-insight] Negative impressions belong in the reranking layer
> The embedding method may not capture enough nuance from negative impressions. Let the **reranking layer** learn from negative impressions instead.

## Evolution from Matrix Factorization to Two Towers

### Historical Context

The [[netflix-prize|Netflix Prize]] era pioneered learning latent "categories" (now called [[embeddings|embeddings]]) through low-rank matrix factorization: decomposing a user-item matrix into user and item embeddings where the dot product approximates observed interactions.

### Problems with Matrix Factorization

Matrix factorization and [[weighted-alternating-least-squares|Weighted Alternating Least Squares (WALS)]] had critical limitations:
- **Skewed data distribution** — few popular items get most views, millions get little history
- **Computational inefficiency** — WALS, while more efficient, still faces scale challenges
- **No side information** — cannot incorporate item titles, descriptions, user location, search history, etc. Only uses the interaction matrix itself

### Two Tower Models Fix Side Information

Two tower models accept arbitrary side/information features alongside interaction data — this is the fundamental improvement over matrix factorization.

## Related Ideas

### Graph-Based Recommendations

Another lineage connects recommendation graphs:
- [[youtube-dnn|YouTube Video Recommendation System]] (Davidson et al.)
- [[deepwalk|DeepWalk]] — random walk graph embeddings
- [[graphsage|GraphSage]] — inductive representation learning on large graphs

The author notes Graph Neural Networks for personalized recommendations as a future topic.

### StarSpace

Facebook Research's [[starspace|StarSpace]] (Chopra et al.) demonstrates that finding embeddings where dot product correlates to downstream tasks works across NLP and recommendation domains.

### Tensorflow Recommenders

The author recommends using [[tensorflow-recommenders|TensorFlow Recommenders (TFRS)]] rather than building from scratch — there are several ways to trip when implementing manually.

## Key Insights

> [!key-insight] Two-stage separation enables targeted optimization
> Retrieval failures (missing items entirely) and ranking failures (wrong ordering) have different symptoms and can be optimized separately.

> [!key-insight] Side features are the key advantage of two towers
> Unlike matrix factorization which only sees the interaction matrix, two towers incorporate titles, descriptions, user profiles, search history — any available metadata.

> [!key-insight] Feature snapshots matter for training
> When training positive examples, use features as they existed *before* the interaction, not the full current feature set. This prevents data leakage in the training signal.

## Related Pages

- [[two-tower-architecture]] — the core retrieval pattern
- [[negative-sampling]] — constructing negative examples for training
- [[matrix-factorization]] — historical predecessor to two towers
- [[recommendation-systems]] — broader context
- [[tensorflow-recommenders]] — recommended implementation library
- [[youtube-dnn|YouTube DNN]] — seminal retrieval system using two-stage architecture
- [[deepwalk|DeepWalk]] — graph embedding via random walks
- [[graphsage|GraphSage]] — inductive graph representation learning
- [[starspace|StarSpace]] — unified embedding for entities and texts
- [[gaurav-chakravorty|Gaurav Chakravorty]] — author
- [[weighted-alternating-least-squares|Weighted Alternating Least Squares (WALS)]] — matrix factorization variant
