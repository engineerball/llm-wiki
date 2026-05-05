---
title: "Vertex AI Matching Engine"
type: entity
entity_type: service
tags: [entity, service, ml, google-cloud, vector-search, ann, retrieval]
sources: [".raw/articles/scaling-deep-retrieval-tensorflow-two-towers-architecture-2026-05-05.md"]
date: 2026-05-05
---

# Vertex AI Matching Engine

Google Cloud's managed [[approximate-nearest-neighbors]] (ANN) service for large-scale vector similarity search. The serving layer for [[two-tower-architecture]] retrieval models on GCP.

Also called **Vector Search** in newer GCP documentation.

## Capabilities

| Feature | Detail |
|---|---|
| Scale | Up to 1 billion embedding vectors |
| Updates | Incremental updates (no full rebuild required) |
| Index management | Dynamic rebuilds; auto-reorganizes for optimal performance |
| Scaling | Autoscaling infrastructure |
| Filtering | Boolean predicates on metadata |
| Diversity | Crowding tags to control result diversity |

## Algorithm: Tree-AH

Matching Engine uses **Tree-AH** — combination of two algorithms:

### Distributed Search Tree
- Hierarchically organizes the embedding space
- Each level clusters nodes from the next level
- Leaf level: clusters of candidate embedding vectors
- At query time: traverse tree to find relevant partitions

### Asymmetric Hashing (AH)
- Fast dot product approximation
- Query and database use different hash representations
- Allows vectors to be stored compressed while maintaining accuracy
- Scores similarity between query embedding and search tree nodes

### Query Process
```
Query embedding vector
→ Score all partition centroids
→ Identify most similar partitions
→ Score candidate vectors within top partitions
→ Aggregate and re-score
→ Top-N candidate IDs returned
```

Google claims their compression algorithm improves both relevance AND speed (not the usual accuracy/speed trade-off).

## Integration with Two-Tower Models

Canonical deployment pattern with [[tensorflow-recommenders]]:

1. Train two-tower model offline
2. Run candidate tower as **batch prediction** over all candidates → JSON embeddings
3. Create ANN index from embeddings JSON
4. Deploy index to online index endpoint
5. Deploy query tower to separate Vertex AI online endpoint
6. Serving:
   - App → `endpoint.predict(playlist_data)` → query embedding
   - App → Matching Engine ANN query → top-N candidate IDs

## GCP Ecosystem

Part of Vertex AI platform alongside:
- **Vertex AI Model Registry** — stores query and candidate tower SavedModels
- **Vertex AI Batch Prediction** — generates candidate embeddings at scale
- **Vertex AI Training** — trains two-tower models
- **BigQuery ML** — alternative for simpler matrix factorization

## Relation to TFRS

[[tensorflow-recommenders]] produces the models and embeddings; Matching Engine indexes and serves them. The two are complementary — TFRS for training, Matching Engine for retrieval.

## Related Pages

- [[two-tower-architecture]] — pattern Matching Engine serves
- [[approximate-nearest-neighbors]] — the algorithm class
- [[tensorflow-recommenders]] — companion training library
- [[recommendation-systems]] — broader context
- [[google]] — creator
- [[two-towers-deep-retrieval-google-cloud]] — source article
