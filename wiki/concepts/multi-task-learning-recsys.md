---
title: "Multi-Task Learning in Recommendation Systems"
type: concept
tags: [concept, ml, multi-task-learning, recommendation-systems, moe, ranking]
sources: [".raw/articles/moe-for-recsys-2026-05-05.md"]
date: 2026-05-05
---

# Multi-Task Learning in Recommendation Systems

Recommendation systems must optimize multiple objectives simultaneously — engagement (clicks, watchtime), satisfaction (likes, ratings), and business objectives (revenue, retention). Training a single model jointly on all objectives is multi-task learning (MTL).

## The Core Problem

Different objectives can have **conflicting gradients**. Maximizing clicks may degrade satisfaction (clickbait). A shared-bottom architecture forces all tasks through one representation, causing gradient interference.

## Architecture Approaches

### Shared-Bottom (Baseline)
```
Input → Shared DNN → Task-specific towers
```
Simple but suffers when tasks conflict. Gradients from one task corrupt shared representations.

### MMoE — Multi-Gate MoE (dominant approach)
Each task selects a weighted combination of shared experts via its own gate:
```
Input
  ↓
[Expert Pool: E1, E2, ... En]
[Gate-A] → [Tower-A] → Objective A
[Gate-B] → [Tower-B] → Objective B
```
Tasks with conflicting gradients naturally route to different experts. Shared experts handle common patterns; task-specific gating handles divergence.

See [[mixture-of-experts]] for full MoE taxonomy.

## Production Patterns

### YouTube
Two objective groups requiring separate optimization:
- **Engagement**: watch time, clicks — immediate behavioral signals
- **Satisfaction**: likes, explicit ratings — quality signals

MMoE replaces the shared-bottom layer. Each group has its own gate over the shared expert pool.

**Key insight from YouTube DNN paper**: Watch-time features outperform CTR as training signal — CTR optimizes for clickbait, watch-time better predicts actual user value. MTL with both prevents either pathology from dominating.

### Kuaishou
Sequential features (user history) → multi-head attention → MMoE → task-specific predictions. The attention step creates a rich sequential representation before the multi-objective gate.

## Trade-offs

| Approach | Gradient Isolation | Compute | Complexity |
|----------|-------------------|---------|------------|
| Single task | N/A | Low | Low |
| Shared-bottom | Poor | Medium | Low |
| MMoE | Good | Medium+ | Medium |
| Separate models | Perfect | High | High |

MMoE is the sweet spot: near-independent task optimization without the compute cost of fully separate models.

## Related Pages

- [[mixture-of-experts]] — MoE/MMoE architecture fundamentals
- [[recommendation-systems]] — where MTL fits in the pipeline
- [[two-tower-architecture]] — retrieval stage; MTL typically at ranking stage
- [[youtube]] — engagement vs satisfaction MTL case study
- [[kuaishou]] — sequential MTL for cold start
- [[moe-for-recsys-reachsumit]] — source article
