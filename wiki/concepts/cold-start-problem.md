---
title: "Cold Start Problem"
type: concept
tags: [concept, ml, recommendation-systems, cold-start, embeddings]
sources: [".raw/articles/two-tower-deep-learning-movie-recommender-system-2026-05-05.md"]
date: 2026-05-05
---

# Cold Start Problem

In recommendation systems: difficulty making accurate recommendations for new users or items with no (or very little) interaction history. A fundamental challenge for ID-based collaborative filtering.

## Three Cold Start Cases

| Case | Problem | Severity |
|---|---|---|
| **New user** | No interaction history; no user embedding to look up | High |
| **New item** | No ratings/interactions; no item embedding to look up | Medium |
| **New system** | No data at all; bootstrapping from scratch | Extreme |

New user cold start is the most common production pain point — users expect personalized results from their first session.

## Why ID Embeddings Fail at Cold Start

Standard collaborative filtering and basic two-tower models represent users/items as **learned ID embeddings**:
```
user_123 → lookup embedding table → [0.2, -0.4, 0.8, ...]
```

A new user_999 has no row in the embedding table. Options:
- Return a global popularity-based default (low quality)
- Retrain to add new row (expensive, offline)
- Use the zero vector / random init (noise)

None are satisfactory for real-time serving.

## Feature-Based Solution

Represent users as **feature vectors** derived from observable signals rather than learned IDs:

```
new_user_999 → [watched: Alien, The Thing] + [horror_genre_rating: +1.2, romance_genre_rating: -0.8]
             → feature vector → User Tower → embedding
```

This generalizes immediately: any user with similar features maps to similar embedding space regions, without retraining.

**Signals commonly used:**
- Watch/purchase/click history (binary presence vector)
- Per-category/genre rating averages (debiased from user mean)
- Demographic features (age range, location)
- Session context (device, time of day)
- Explicit preferences (onboarding questionnaire)

## Debiased Rating Features

Raw ratings carry user-level scale bias (some users always rate 4–5 stars; others use 1–3). Debiasing normalizes:

```
debiased_genre_rating = mean(actual_ratings_in_genre) - user_mean_rating
```

A +0.5 debiased score means the user rates this genre half a star above their personal average — comparable across users with different baseline tendencies.

## Item Cold Start

Analogous problem for new items. Solutions:

- **Content-based features** — represent item by its attributes (genre, director, description) rather than a learned ID embedding
- **Side information** — use item metadata to initialize or supplement the ID embedding
- **Warm-up period** — collect initial interactions before serving personalized results

The three-tower approach ([[two-tower-movie-recommender-pytorch]]) splits the item side into a feature tower + ID tower, so genre information is available even for items with sparse interaction history.

## Trade-offs

| Approach | Cold Start | Accuracy (warm) | Complexity |
|---|---|---|---|
| ID embeddings only | Fails | High | Low |
| Features only | Good | Medium | Medium |
| Features + ID (three-tower) | Good | High | Higher |

A feature+ID hybrid captures both the generalizable signal (features) and the item-specific patterns that features can't explain (ID).

## Related Pages

- [[two-tower-architecture]] — base pattern; cold start depends on user/item representation choice
- [[recommendation-systems]] — broader context
- [[two-tower-movie-recommender-pytorch]] — three-tower approach that solves user cold start
