---
title: "Mixture-of-Experts Based Recommender Systems (Sumit Kumar)"
type: source
tags: [source, ml, recommendation-systems, moe, multi-task-learning, youtube, gmail, kuaishou]
sources: [".raw/articles/moe-for-recsys-2026-05-05.md"]
source_url: https://blog.reachsumit.com/posts/2023/04/moe-for-recsys/
date: 2026-05-05
---

# Mixture-of-Experts Based Recommender Systems

**Source**: [blog.reachsumit.com](https://blog.reachsumit.com/posts/2023/04/moe-for-recsys/) | Sumit Kumar | April 2023

Survey of how Mixture of Experts (MoE), an ensemble technique from 1991, has been adapted for production recommendation systems — covering architectural variants and real-world deployments at YouTube, Gmail, and Kuaishou.

## Key Contributions

- Taxonomy of MoE variants: HME, DMoE, Sparsely-Gated MoE, MMoE
- Explains Multi-Gate MoE (MMoE) as the dominant pattern for multi-task recommendation
- Three production case studies with architectural detail

## MoE Fundamentals

Gate does soft partition of input space; experts specialize in different regions. Unlike boosting (residual cooperation), MoE experts produce complete independent outputs. Error function: `E^c = ||y^c - o_i^c||^2`.

Core tension: early training hard (all experts initialized identically) + expert load imbalance (gating collapses to one expert).

## Variant Taxonomy

| Variant | Key Idea |
|---------|----------|
| HME | Tree-structured recursive gating |
| DMoE | Stacked MoE layers for dynamic assembly |
| Sparsely-Gated | Top-k selection + Gaussian noise; 1000x capacity gain |
| **MMoE** | Shared experts + task-specific gates; dominant for multi-task recsys |

## Production Case Studies

### YouTube — MMoE for Next Video
- Replaces shared-bottom layer in multi-task model with MMoE
- Two objective groups: **engagement** (watch time, clicks) vs **satisfaction** (likes, ratings)
- Each objective has its own gate over the same shared expert pool

### Gmail — MoSE (Mixture-of-Sequential-Experts)
- LSTM-based experts + gating
- Captures temporal patterns in email interaction sequences

### Kuaishou (Kwai) — Personalized Cold Start
- Multi-head attention over sequential features → MMoE layers → task-specific predictions
- Specifically addresses cold start for new users/items via sequential feature fusion

## Connections to Wiki

- [[mixture-of-experts]] — concept page for MoE fundamentals and variants
- [[multi-task-learning-recsys]] — concept page for multi-task learning in recommendations
- [[recommendation-systems]] — broader pipeline context
- [[two-tower-architecture]] — retrieval stage; MMoE typically used at ranking stage
- [[youtube]] — case study: MMoE for next-video recommendation
- [[kuaishou]] — case study: personalized cold start modules
- [[cold-start-problem]] — Kuaishou case study addresses this directly
