---
title: "Matrix Factorization"
type: concept
tags: [concept, ml, recommendation-systems, collaborative-filtering, embeddings]
date: 2026-05-13
---

# Matrix Factorization

A foundational recommendation technique that decomposes a user-item interaction matrix into low-dimensional latent factor vectors (called [[embeddings|embeddings]]) for users and items. The dot product of a user and item embedding approximates their interaction strength.

## Core Idea

Given a sparse user-item interaction matrix (e.g., which users watched which items), matrix factorization finds:

- **User embeddings**: Each user represented as a D-dimensional vector
- **Item embeddings**: Each item represented as a D-dimensional vector

Such that `user_embedding · item_embedding ≈ observed interaction`

This was first popularized during the [[netflix-prize|Netflix Prize]] competition, where researchers learned latent "categories" from interaction patterns alone — no side information needed.

## Key Limitations

1. **Skewed data distribution** — few popular items dominate; long-tail items get little signal
2. **No side information** — cannot incorporate item titles, descriptions, user location, search queries, or any metadata. Only the interaction matrix is used
3. **Scale challenges** — computationally expensive at very large scale

[[weighted-alternating-least-squares|Weighted Alternating Least Squares (WALS)]] improved computational efficiency but did not solve the side information problem.

## Connection to Modern Methods

Two tower models supersede matrix factorization by incorporating side features: where matrix factorization only sees the interaction matrix, two towers can process arbitrary item metadata (title, description, language) and user metadata (location, search history, demographics) to produce embeddings that generalize beyond observed interactions.

## Related Pages

- [[netflix-prize|Netflix Prize]] — seminal competition that popularized matrix factorization for recommendations
- [[weighted-alternating-least-squares|Weighted Alternating Least Squares (WALS)]] — improved variant
- [[two-tower-architecture|Two Tower Architecture]] — successor incorporating side information
- [[embeddings|Embeddings]] — the latent factors learned by matrix factorization
