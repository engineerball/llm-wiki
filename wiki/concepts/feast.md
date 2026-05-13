---
title: "Feast"
type: concept
tags: [concept, ml, feature-store, data]
date: 2026-05-13
---

# Feast — Feature Store

An open-source [[ml|machine learning]] feature store for serving, discovering, and managing features. Used for both training data loading and online inference lookups.

## Role in Recommender Systems

In the Red Hat OpenShift AI product recommender:

1. **Training data loading** — Historic user, product, and interaction data (purchases, cart additions, ratings) is loaded from Feast into the KFP pipeline
2. **Recommendation caching** — After candidate generation, pre-computed top-N recommendations for each user are pushed back to Feast as a quick lookup table
3. **Online serving** — When users log in, their fast lookup table in Feast provides instant recommendations without real-time computation

## Key Benefits

- **Shared storage pool** across [[kubeflow-pipelines|KFP]] pods, avoiding pod ephemeral storage limits
- **Fast retrieval** for online recommendation scenarios
- **Feature consistency** between training and serving

## Related Pages

- [[kubeflow-pipelines|KFP — Kubeflow Pipelines]]
- [[openshift-ai|Red Hat OpenShift AI]]
- [[recommendation-systems|Recommendation Systems]]
- [[redhat-two-tower-model-openshift-2026|Red Hat's two-tower recommender]] — uses Feast for data loading and caching
