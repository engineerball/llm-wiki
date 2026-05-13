---
title: "Understanding the Recommender System's Two-Tower Model (Red Hat)"
type: source
tags: [source, ml, recommendation-systems, two-tower, red-hat, openshift-ai, kubeflow-pipelines, feast]
date: 2026-05-13
original_published: 2026-01-26
authors: [Hadar Cohen, Ori Fridman, Itay Katav, Manna Kong, Ganesh Murthy, Peter Samouelian, Matan Talvi]
url: https://developers.redhat.com/articles/2026/01/26/understanding-recommender-systems-two-tower-model
---

# Understanding the Recommender System's Two-Tower Model (Red Hat)

Part 2 of a Red Hat series on building an AI-driven product [[recommendation-systems|recommender]] with [[openshift-ai|Red Hat OpenShift AI]]. Covers the full training pipeline architecture using [[kubeflow-pipelines|KFP]] and the dual encoder (two-tower) model implementation.

Source: https://developers.redhat.com/articles/2026/01/26/understanding-recommender-systems-two-tower-model

## ML Pipeline Architecture

The recommender training pipeline uses [[kubeflow-pipelines|KFP]] integrated with OpenShift AI, with orchestrated deployment via [[argo-workflows|Argo Workflows]] or [[tekton|Tekton]].

### Pipeline Stages

1. **Load training data** — Fetches historic user, product, and user-product interaction data (purchases, cart additions, ratings) from [[feast|Feast]]
2. **Train model** — Pre-processes data, computes interaction magnitudes, trains [[two-tower-architecture|two-tower model]] to create user and product encoders in a shared embedding space
3. **Generate candidates** — For each user embedding, finds top similar product embeddings and pushes to Feast as a quick lookup table

```python
@dsl.pipeline(name="batch_recommendation")
def batch_recommendation():
    load_data_task = load_data_from_feast()
    train_model_task = train_model(
        item_df_input=load_data_task.outputs["item_df_output"],
        user_df_input=load_data_task.outputs["user_df_output"],
        interaction_df_input=load_data_task.outputs["interaction_df_output"],
    ).after(load_data_task)
```

Each KFP component is a Python function decorated with ` @kfp.dsl.component`. OpenShift containerizes and deploys each component in a dedicated pod.

## KFP Data Sharing

KFP bridges [[kubernetes|Kubernetes]] pod isolation using a `kfp-launcher` init container:
- Components write data to local ephemeral filesystem in parquet format
- KFP copies data between pods using S3-compatible storage (MinIO)
- Engineers effectively treat cloud object storage as local filesystem
- Data lineage and logs are preserved after pod termination

For large datasets exceeding pod ephemeral storage, alternatives include sharing only data locations between pods or using external storage like Feast directly.

## Dual Encoder (Two-Tower) Architecture

### EntityTower Network

Each tower instance processes multiple numeric and text features to produce a **64-component embedding**:

1. Text features → converted to 384-D embeddings via BGE model → linearly transformed to 58-D per attribute → averaged together
2. Numeric features → normalized → linearly transformed to 6-D layer
3. Concatenation → 64-unit layer → normalization
4. Two non-linear transformations: 64 → 128 → 64

The same `EntityTower` class is used for both users and products, differing only in input features.

### Two-Tower Training Objective

The [[two-tower-architecture|two-tower model]] computes **Euclidean distance** between user and product embeddings, then compares against **magnitude scores** based on actual interaction data:

- **Mean squared error (MSE)** loss between embedding distances and scaled interaction magnitudes
- Magnitude scoring inverts user sentiment: larger values for negative interactions (bad ratings), smaller for positive (purchases)
- [[embeddings|Backpropagation]] updates both towers' weights to minimize distance error

Interaction types are scored differently:
- Purchases: scaled by quantity purchased
- Ratings: direct inverse mapping
- Cart additions: lower magnitude than purchases

## Cold Start Strategy

For newly registered users without lookup table entries:

1. User selects product categories during registration
2. System returns most popular products in selected categories
3. Selected products saved as positive interactions for future training

Alternative approach: use the user encoder on registration data to produce an embedding, then compare against precomputed product embeddings — the encoder generalizes patterns from other users and products even without personal history data.

## Limitations

The authors note several limitations of this notional model:
- Needs additional normalization layers on every activation
- Text-weight bias (58 vs 6 units) unsuitable for numeric-heavy domains like finance
- Simple expansion bottleneck; alternatives like [[mixture-of-experts|autoencoder]]-style compression could improve regularization
- Real production models include more features (age, demographics)
- MSE loss is simple but production may need cross-entropy alternatives

## KFP Pod Architecture

Each pipeline submission creates multiple ephemeral pods:

| Pod | Function | Count |
|---|---|---|
| `kfp-run-job` | Compiles/submits pipeline | 1 |
| `*-system-dag-driver` | Coordinates task execution order | 1 |
| `*-system-container-driver` | Creates pod specs, monitors, retries, manages output data | N per task |
| `*-system-container-impl` | Executes developer's task-specific code | N per task |

## Key Insights

> [!key-insight] KFP abstracts Kubernetes pod storage
> KFP's init container bridge transparently handles data sharing between pods via S3, making cloud storage feel like local filesystem while preserving lineage.

> [!key-insight] Magnitude scoring shapes the embedding space
> By inverting user sentiment (high score = bad interaction), the model naturally learns to minimize distances for positive interactions, aligning the embedding geometry with user satisfaction.

> [!key-insight] EntityTower shares architecture across domains
> Using the same network class for users and products simplifies code and ensures consistent embedding dimensions, but requires careful weight tuning per domain's feature mix.

## Related Pages

- [[two-tower-architecture]] — the core retrieval pattern
- [[shaped-ai-two-tower-deep-dive]] — loss functions and negative sampling
- [[two-towers-deep-retrieval-google-cloud]] — Google Cloud's Vertex AI approach
- [[reachsumit-two-tower-model]] — comprehensive two-tower survey
- [[recommendation-systems]] — broader context
- [[cold-start-problem]] — cold start strategies
- [[embeddings]] — embedding vectors
- [[mixture-of-experts]] — alternative architectures for complex domains
- [[openshift-ai]] — Red Hat OpenShift AI platform
- [[kubeflow-pipelines]] — KFP pipeline framework
- [[feast]] — feature store
- [[hadar-cohen]] — lead author
- [[red-hat]] — publisher
