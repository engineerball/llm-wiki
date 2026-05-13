---
title: "StarSpace"
type: concept
tags: [concept, ml, embeddings, facebook-research, nlp]
date: 2026-05-13
---

# StarSpace

A general-purpose embedding model by Chopra et al. (Facebook Research) that learns to represent entities (words, sentences, documents, users, items) in a shared vector space where **dot product** correlates with task relevance.

## Key Idea

Given a set of entities and a task (e.g., recommendation, classification, retrieval), StarSpace learns embeddings such that the dot product between relevant entity pairs is high. This is a generalization of the [[two-tower-architecture|two tower]] approach beyond just user-item recommendation.

## Applications

- Text classification
- Information retrieval
- Personalized recommendation
- Entity linking
- Multi-label classification

## Connection to Two Towers

StarSpace and two-tower models share the same fundamental insight: learn embeddings where dot product ≈ relevance. StarSpace provides a broader theoretical framework that works across NLP, information retrieval, and recommendation domains.

## Related Pages

- [[two-tower-architecture|Two Tower Architecture]]
- [[embeddings|Embeddings]]
- [[recsysml-two-tower-models-retrieval|RecSysML: Two Tower Models for Retrieval]] — references StarSpace
