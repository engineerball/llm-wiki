---
title: "Approximate Nearest Neighbors (ANN)"
type: concept
tags: [concept, ml, retrieval, embeddings, vector-search, indexing]
sources: [".raw/articles/scaling-deep-retrieval-tensorflow-two-towers-architecture-2026-05-05.md"]
date: 2026-05-05
---

# Approximate Nearest Neighbors (ANN)

Algorithm class for finding vectors similar to a query vector in a large corpus — trading exactness for speed. Essential for serving [[two-tower-architecture]] retrieval models at scale.

**Core trade-off:** ANN returns vectors that are *approximately* nearest (not guaranteed exact), but runs orders of magnitude faster than exhaustive search over millions/billions of vectors.

## Why ANN Is Necessary

Exact nearest neighbor search is O(n) per query — linear scan of all candidates. At 1M candidates with 128-dim embeddings and 10ms latency budget, exhaustive search is infeasible.

ANN enables sub-linear retrieval by pre-indexing the vector space.

## Common ANN Algorithms

### Tree-Based
- Hierarchically partition vector space using clustering
- At query time: traverse tree, score only relevant partitions
- Example: KD-trees, Ball trees, Google's Distributed Search Tree

### Hashing-Based
- Map similar vectors to same hash buckets (Locality Sensitive Hashing / LSH)
- Query: compute hash, score vectors in matching buckets
- **Asymmetric Hashing (AH)**: query and database vectors use different hash representations — allows compressed storage with better accuracy

### Graph-Based
- Build proximity graph: edges between nearby vectors
- Query: greedy traversal starting from random entry points
- Example: HNSW (Hierarchical Navigable Small World)

### Product Quantization (PQ)
- Compress high-dim vectors into compact codes
- Approximate dot products using lookup tables on codes

## Tree-AH (Google's Approach)

[[vertex-ai-matching-engine]] uses **Tree-AH** — combination of distributed search tree + asymmetric hashing:

1. **Distributed Search Tree:** Hierarchically clusters the embedding space. Each level clusters nodes from the next level. Leaf level = clusters of candidate vectors.
2. **Asymmetric Hashing (AH):** Approximates dot products between query embedding and search tree node embeddings. Enables fast scoring without decompressing stored vectors.

Query inference:
```
Query embedding
→ Score all partition centroids
→ Identify most similar partitions
→ Score candidate vectors within top partitions
→ Aggregate + re-score
→ Top-N candidates
```

## ANN Libraries and Services

| Tool | Type | Notes |
|---|---|---|
| [[vertex-ai-matching-engine]] | Managed cloud service | Up to 1B vectors, Tree-AH, autoscaling |
| Faiss (Facebook) | Open-source library | IVF, HNSW, PQ; popular for research |
| ScaNN (Google) | Open-source library | Anisotropic quantization; high recall |
| Pinecone | Managed cloud service | Developer-friendly, serverless |
| Weaviate | Open-source + cloud | HNSW + vector DB features |
| pgvector | Postgres extension | For moderate-scale workloads |

## Compression and Recall

ANN indexes typically compress vectors to reduce memory and improve cache efficiency. Compression degrades recall (fraction of true nearest neighbors returned). Google's novel compression in Matching Engine claims to improve both relevance AND speed (vs. standard trade-off).

## Relation to Two-Tower Systems

ANN is the serving layer for [[two-tower-architecture]]:
- Training produces dense embeddings
- Candidate embeddings are indexed in ANN store
- Query tower runs online → ANN lookup returns top-N candidates
- [[vertex-ai-matching-engine]] is Google's managed option for this

## Related Pages

- [[two-tower-architecture]] — produces the embeddings indexed by ANN
- [[vertex-ai-matching-engine]] — Google's managed ANN service
- [[recommendation-systems]] — broader retrieval context
- [[two-towers-deep-retrieval-google-cloud]] — source article
