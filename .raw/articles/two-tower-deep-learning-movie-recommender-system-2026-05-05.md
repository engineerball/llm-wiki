---
source_url: https://nickgreenquist.github.io/blog/projects/2024/02/04/two-tower-deep-learning-movie-recommender-system.html
fetched: 2026-05-05
published: 2024-02-04
author: Nick Greenquist
---

# Two-Tower Deep Learning Movie Recommender System in PyTorch

## Overview

Tutorial building a production-ready recommendation system using a two-tower (three-tower variant) neural network in PyTorch. Key departure from traditional matrix factorization: embeds user and item FEATURES rather than unique IDs.

## Core Architecture: Three Towers

Three input towers:
1. **User Tower** — processes user context (watch history + debiased genre preferences)
2. **Item Feature Tower** — encodes movie genres
3. **Item ID Tower** — learns movie-specific embeddings

Combines via concatenation: `item_combined = concat(item_feature_emb, item_id_emb)`

Final prediction: `dot_product(user_embedding, item_combined_embedding)`

## Key Innovation: Feature-Based User Representation

Instead of a user ID lookup, users represented as feature vectors:
- Binary vector over top-250 movies (watched = 1, not watched = 0)
- Per-genre debiased rating averages (actual rating minus user mean)

**Cold start benefit:** New users can be represented immediately via features. No retraining required. Model generalizes across similar preference patterns.

## Dataset: MovieLens

- Small: 100K ratings, 9K movies, 600 users
- Large: 33M ratings, 86K movies, 331K users

Processing:
- Filtered to 2,071 movies with ≥1,000 ratings (memory constraints)
- 20 unique genres as binary features
- Debiased rating vectors: actual_rating - user_mean_rating
- 80/20 split: watch history vs. prediction labels

## Model Architecture Parameters

- Item feature embedding: 25 dimensions
- Item ID embedding: 25 dimensions
- User embedding output: 50 dimensions (matches item combined = 25+25)
- Activation: tanh nonlinearity
- Total trainable parameters: ~220,000

## Training Details

- Loss: MSELoss (regression on rating prediction)
- Batch size: 64
- Learning rate schedule: 0.1 → 0.05 → 0.01 → 0.005 (decreasing per 10K iterations)
- Total iterations: 50,000
- Validation every 1,000 steps

## Results

**For horror enthusiasts:** Alien (1979), Videodrome (1983), The Thing (1982)
**For children's content fans:** Zootopia (2016), Kung Fu Panda 2 (2011), The Incredibles
**Anti-recommendations for horror fans:** Inspector Gadget, Home Alone 3, Free Willy

Model correctly captures preference geometry.

## Inference Process

```
Post-training: precompute all movie embeddings offline

Serving:
1. Build user feature vector from preferences
2. User tower forward pass → user embedding
3. Lookup precomputed movie embeddings
4. Dot product user_emb × all_movie_embs
5. Rank → return top-N
```

## Debiased Ratings

Rating debiasing: `debiased_rating = actual_rating - user_mean_rating`

Removes per-user rating scale bias. Some users rate everything 4-5 stars; others use 1-3. Debiasing normalizes user preference signals.

## Extensions

- Rich features: director/actor info, movie decade, review sentiment
- Temporal modeling: use timestamps to create sequential training examples
- Transformer attention for watch history sequences
- Batch normalization + dropout for robustness
