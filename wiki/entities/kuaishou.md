---
title: "Kuaishou (Kwai)"
type: entity
tags: [entity, organization, recommendation-systems, ml, china, short-video]
sources: [".raw/articles/moe-for-recsys-2026-05-05.md"]
date: 2026-05-05
---

# Kuaishou (Kwai)

Chinese short-video platform (competitor to Douyin/TikTok). Active ML research program focused on recommendation at scale.

## ML Contributions

### Personalized Cold Start Modules
MMoE-based architecture for addressing the [[cold-start-problem]] for new users and items:

```
User history (sequential)
  ↓
Multi-head attention (feature fusion)
  ↓
MMoE layers
  ↓
Task-specific predictions
```

Multi-head attention first creates a rich sequential representation from user history, then MMoE handles multiple prediction objectives. This fusion allows the model to generalize from limited interaction data (cold start scenario).

## Related Pages

- [[mixture-of-experts]] — MMoE architecture used in Kuaishou's cold start system
- [[multi-task-learning-recsys]] — multi-task ranking with MMoE
- [[cold-start-problem]] — primary problem Kuaishou's system addresses
- [[recommendation-systems]] — broader pipeline context
- [[moe-for-recsys-reachsumit]] — source article
