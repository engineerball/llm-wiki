---
title: "DeepWalk"
type: concept
tags: [concept, ml, graph-neural-network, embeddings]
date: 2026-05-13
---

# DeepWalk

A graph embedding algorithm that uses random walks to learn node representations. By treating random walks as sentences, DeepWalk applies [[word2vec|word2vec]]-style learning to produce low-dimensional [[embeddings|embeddings]] for graph nodes.

## Role in Recommendations

DeepWalk is part of a lineage of graph-based recommendation approaches:
- Build a graph of users, items, and interactions
- Use random walks to explore the graph
- Learn embeddings where connected nodes are closer

See also [[graphsage|GraphSage]] for inductive extension to unseen nodes.

## Related Pages

- [[graphsage|GraphSage]] — inductive graph representation learning
- [[recsysml-two-tower-models-retrieval|RecSysML: Two Tower Models for Retrieval]] — references DeepWalk as graph-based recommendation lineage
