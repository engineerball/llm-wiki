---
title: "YouTube"
type: entity
tags: [entity, organization, google, recommendation-systems, ml]
sources: [".raw/articles/moe-for-recsys-2026-05-05.md"]
date: 2026-05-05
---

# YouTube

Video streaming platform owned by [[google]]. Pioneer in large-scale neural recommendation systems. Research published from YouTube has defined industry-standard patterns for retrieval and ranking.

## Key ML Contributions

### YouTube DNN (2016)
"Deep Neural Networks for YouTube Recommendations" — seminal paper establishing the multi-stage retrieval/ranking pipeline:
- Two-tower retrieval (candidate generation)
- Ranking model
- Watch-time as primary training signal (over CTR)

Referenced in [[two-tower-architecture]] and [[recommendation-systems]].

### MMoE for Next-Video Recommendation
Deployed [[mixture-of-experts|Multi-Gate MoE (MMoE)]] to jointly optimize competing objectives:
- **Engagement objectives** — watch time, clicks
- **Satisfaction objectives** — likes, ratings

MMoE replaces the shared-bottom layer in the ranking model. Each objective group has its own gating network selecting from a shared expert pool. Prevents clickbait-style optimization from dominating.

See [[multi-task-learning-recsys]] for the architectural pattern.

## Related Pages

- [[google]] — parent organization
- [[mixture-of-experts]] — MMoE architecture
- [[multi-task-learning-recsys]] — engagement vs satisfaction objective framing
- [[recommendation-systems]] — industry pipeline context
- [[two-tower-architecture]] — retrieval pattern from YouTube DNN paper
