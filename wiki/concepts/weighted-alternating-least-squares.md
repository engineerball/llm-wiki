---
title: "Weighted Alternating Least Squares (WALS)"
type: concept
tags: [concept, ml, recommendation-systems, optimization]
date: 2026-05-13
---

# Weighted Alternating Least Squares (WALS)

An optimization algorithm for [[matrix-factorization|matrix factorization]] in recommendation systems. Improves over basic alternating least squares by weighting observed interactions differently from missing entries, addressing the skewed data distribution problem.

## How It Works

1. **Alternating**: Fix one matrix (e.g., item factors), solve for the other (user factors) analytically via least squares; then fix the solved matrix and repeat
2. **Weighted**: Observed interactions get higher weight than missing entries (which could be either negative or unobserved), rather than treating all zeros equally

## Advantages

- More computationally efficient than basic SVD approaches
- Allows [[distributed-computing|distributed implementation]] across clusters
- Better handles sparse, skewed user-item matrices

## Shared Limitations with Matrix Factorization

Like matrix factorization, WALS cannot incorporate [[side-information|side features]] (item metadata, user demographics) — it only operates on the interaction matrix. This is why [[two-tower-architecture|two tower models]] supersede it for modern recommendation systems.

## Related Pages

- [[matrix-factorization|Matrix Factorization]] — base technique
- [[two-tower-architecture|Two Tower Architecture]] — successor incorporating side information
- [[recsysml-two-tower-models-retrieval|RecSysML: Two Tower Models for Retrieval]] — discusses the WALS → two tower evolution
