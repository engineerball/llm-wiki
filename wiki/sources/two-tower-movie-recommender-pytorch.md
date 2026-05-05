---
title: "Two-Tower Deep Learning Movie Recommender System in PyTorch"
type: source
tags: [source, ml, retrieval, recommendation-systems, two-tower, embeddings, pytorch, cold-start]
sources: [".raw/articles/two-tower-deep-learning-movie-recommender-system-2026-05-05.md"]
date: 2026-05-05
original_published: 2024-02-04
author: Nick Greenquist
url: https://nickgreenquist.github.io/blog/projects/2024/02/04/two-tower-deep-learning-movie-recommender-system.html
---

# Two-Tower Deep Learning Movie Recommender System in PyTorch

Blog post by Nick Greenquist (Feb 2024). Builds a two-tower movie recommender in PyTorch on MovieLens data. Key departure from standard two-tower: uses a **three-tower variant** (User + Item Feature + Item ID) and represents users as feature vectors rather than IDs — solving the [[cold-start-problem]] by design.

## Architecture: Three Towers

Standard two-tower splits query vs. candidate. This system splits the *candidate* side further:

```
User features (watch history + genre ratings)
       ↓
  User Tower → user_emb (50-dim)
                                        ┐
                                   concat → item_combined_emb (50-dim)
                                        ┘
  Item Feature Tower → feature_emb (25-dim)   ↑
       ↑
  Movie genres (20 binary features)

  Item ID Tower → id_emb (25-dim)
       ↑
  Movie ID

Final score = dot_product(user_emb, item_combined_emb)
```

Item combined embedding = concat(genre features emb, item ID emb). The feature tower captures genre semantics; the ID tower captures movie-specific patterns not explained by genres.

## User Representation (Feature-Based)

Users represented as feature vectors, not IDs:
- **Watch history vector** — binary, top-250 movies (1=watched)
- **Debiased per-genre ratings** — `actual_rating - user_mean_rating` per genre

**Why debiasing matters:** Some users rate everything 4–5 stars; others use 1–3. Subtracting user mean normalizes the signal to relative preference. A "3" from a 4-star-average user means something different than a "3" from a 2-star-average user.

## Cold Start Solution

Because users are represented by features (not a learned ID embedding), new users can be represented immediately from their first interactions:

> A new user who watched 3 horror films and rated them highly gets a feature vector that maps to the horror-preference region of embedding space — no retraining required.

See [[cold-start-problem]] for the full concept.

## Dataset: MovieLens

- Small: 100K ratings, 9K movies, 600 users
- Large: 33M ratings, 86K movies, 331K users
- Filtered to 2,071 movies with ≥1,000 ratings (memory constraint)
- 80/20 split: watch history / prediction labels

## Training Configuration

| Param | Value |
|---|---|
| Loss | MSELoss (rating regression) |
| Batch size | 64 |
| Iterations | 50,000 |
| LR schedule | 0.1 → 0.05 → 0.01 → 0.005 (per 10K steps) |
| Trainable params | ~220,000 |
| Activation | tanh |

Loss is MSE on rating prediction — framed as regression, not retrieval. Contrast with [[tensorflow-recommenders]] which uses in-batch softmax for retrieval ranking.

## Results

Qualitatively correct:
- Horror preference user → Alien (1979), Videodrome (1983), The Thing (1982)
- Children's content user → Zootopia (2016), Kung Fu Panda 2 (2011), The Incredibles
- Anti-recommendations reverse correctly (horror fans ≠ Inspector Gadget)

## Comparison to Standard Two-Tower

| Aspect | Standard Two-Tower | This Approach |
|---|---|---|
| User representation | User ID embedding | Feature vector (watch history + genre ratings) |
| Item representation | Item ID embedding | Item feature emb + Item ID emb (concatenated) |
| Cold start | Fails for new users | Graceful via feature generalization |
| Framework | TF Recommenders | PyTorch (raw) |
| Loss | Retrieval (in-batch softmax) | MSE (rating regression) |

## Suggested Extensions

- Rich item features: director, cast, decade, review sentiment
- Temporal modeling: use timestamps for sequential training examples
- Transformer attention over watch history sequences
- Batch norm + dropout for regularization

## Related Pages

- [[two-tower-architecture]] — base pattern; three-tower variant described here
- [[cold-start-problem]] — the user cold start problem this approach solves
- [[recommendation-systems]] — broader context
- [[tensorflow-recommenders]] — alternative framework (TF-based)
