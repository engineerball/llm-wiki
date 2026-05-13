---
title: "GraphSage"
type: concept
tags: [concept, ml, graph-neural-network, embeddings]
date: 2026-05-13
---

# GraphSage

An inductive representation learning method for large graphs by Hamilton et al. Unlike [[deepwalk|DeepWalk]] which requires retraining for new nodes, GraphSage learns an aggregation function that can generate embeddings for unseen nodes by sampling and aggregating features from their local neighborhood.

## Key Innovation

- **Inductive** — generalizes to previously unseen nodes without retraining
- **Neighborhood sampling** — samples and aggregates features from a node's local neighborhood
- **Aggregation functions** — mean, LSTM, or pooling-based aggregation over neighbor features

## Role in Recommendations

GraphSage enables real-time recommendations for new users and items by computing embeddings on-the-fly rather than requiring offline retraining, making it relevant for the [[cold-start-problem|cold-start problem]].

## Related Pages

- [[deepwalk|DeepWalk]] — transductive predecessor
- [[cold-start-problem|Cold-Start Problem]] — GraphSage addresses this via inductive learning
- [[recsysml-two-tower-models-retrieval|RecSysML: Two Tower Models for Retrieval]] — references GraphSage as graph-based recommendation lineage
- [[embeddings|Embeddings]]
