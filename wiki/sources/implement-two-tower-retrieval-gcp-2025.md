---
title: "Implement Two-Tower Retrieval for Large-Scale Candidate Generation"
type: source
tags: [source, ml, retrieval, recommendation-systems, two-tower, embeddings, google-cloud, vertex-ai, ann]
sources: []
date: 2026-05-13
original_published: 2025-01-16
authors: [Jordan Totten, Jeremy Wortz, Lakshmanan Sethu, Kaz Sato]
url: https://docs.cloud.google.com/architecture/implement-two-tower-retrieval-large-scale-candidate-generation
---

# Implement Two-Tower Retrieval for Large-Scale Candidate Generation

Google Cloud Architecture Center reference architecture (Jan 2025) by Jordan Totten, Jeremy Wortz, Lakshmanan Sethu, and Kaz Sato. Provides an end-to-end reference for implementing a [[two-tower-architecture]] candidate generation workflow using [[google-cloud|Google Cloud]] products, with Vertex AI for training and serving.

Complements [[two-towers-deep-retrieval-google-cloud]] (the 2023 blog post) with a more detailed production architecture including VPC security, performance profiling, and recall-vs-latency evaluation.

## Architecture Overview

The end-to-end pipeline:

```
Training data (Cloud Storage)
  → Vertex AI Training (two-tower model)
  → Vertex AI Model Registry (separate query + candidate towers)
  → Query tower → Vertex AI online endpoint (serving)
  → Candidate tower → batch predict → JSON embeddings (Cloud Storage)
  → Vertex AI Vector Search → ANN index → deployed index endpoint
```

## Products Used

| Product | Role |
|---|---|
| [[vertex-ai-training|Vertex AI Training]] | Fully managed offline training |
| [[vertex-ai-vector-search|Vertex AI Vector Search]] | Vector similarity matching, ANN index |
| [[vertex-ai-model-registry|Vertex AI Model Registry]] | Model lifecycle management |
| [[cloud-storage|Cloud Storage]] | Training data + embedding outputs |

## Two-Stage Recommender

Large-scale recommenders use a two-stage (or multi-stage) pipeline:

1. **Candidate generation** — sifts through millions of items to retrieve hundreds
2. **Ranking** — filters hundreds down to dozens for final presentation

The two-tower model serves the candidate generation stage, optimized for:
- Learning the best [[embeddings]] representation of the problem during training
- Fast retrieval meeting latency requirements during serving

## Decoupled Inference

Each tower is deployed separately:

- **Candidate tower** — precomputes embeddings for all candidate items; embeddings are deployed to a [[vertex-ai-vector-search]] index optimized for low-latency retrieval
- **Query tower** — deployed to an online endpoint; converts raw user queries to embeddings at serving time

This decoupling enables:
- **Cold-start support** — describe unknown items in terms of known items via the candidate tower; items need not have been seen during training
- **Precomputed optimization** — all candidate embeddings are computed offline and indexed, making serving constant-time regardless of corpus size

## Security

- [[vertex-ai-vector-search|Vertex AI Vector Search]] supports both public and [[vpc|VPC]] endpoint deployments
- VPC deployment requires resources (workbench instances, pipelines) to be within the same VPC network as the index endpoint
- See [[vpc-network-peering]] for setup

## Performance Optimization

### Profile Training Jobs

- Use [[cloud-profiler|Cloud Profiler]] (managed TensorBoard Profiler implementation) with `--profiler` argument
- Capture traces from host CPU and device GPU/TPU for resource consumption analysis
- Start with 2–10 train steps profile duration to avoid OOM errors

### Fully Utilize Accelerators

Accelerators (GPU/TPU) are the most expensive component — full utilization is essential for cost management.

**Input pipeline optimization:**
- **Storage reads** — caching, [[prefetching|TensorFlow prefetching]], sequential access patterns, parallel I/O
- **Preprocessing** — parallel processing for extraction/transformation, tune [[interleave|interleave transformation]]
- **Data transfer to device** — transfer from host to multiple devices in parallel

**Device optimization:**
- Increase mini-batch size (balance with memory constraints)
- [[vectorize-functions|Vectorize user-defined functions]] — apply transform over batches rather than per-element

### Scale Up Before Scaling Out

Recommended progression:
1. Single worker + single device
2. Single worker + more powerful device
3. Single worker + multiple devices
4. Distributed training

## ANN Index Tuning: Recall vs Latency

Vertex AI Vector Search allows creating a brute-force index alongside an ANN index for evaluation:

- Brute-force returns absolute nearest neighbors (higher latency, serves as baseline)
- Compare recall/latency tradeoff against ANN search

**Factors affecting recall/latency:**

| Factor | Impact |
|---|---|
| Modeling parameters | Embedding space geometry; compare shallow vs deep retrieval models |
| Dimensions | Must match query + candidate tower vector dimensions |
| Crowding and filtering tags | Influence candidate diversity and performance |
| ANN count | Higher count → higher recall, proportionally higher latency |
| Leaf nodes search % | Most critical knob for recall vs latency tradeoff |

## Key Insights

> [!key-insight] The co-learning of towers enables bidirectional description
> Items can be described in terms of queries and queries in terms of items. Precomputing one half of the equation makes the rest fast.

> [!key-insight] Scale up before scaling out
> Choose a larger, more powerful single device before distributing across multiple smaller devices — better cost efficiency and simpler operations.

> [!key-insight] Brute-force index as evaluation baseline
> Deploy candidate embeddings to both ANN and brute-force indexes to measure real recall vs latency tradeoff, not just theoretical.

## Related Pages

- [[two-tower-architecture]] — the core pattern
- [[two-towers-deep-retrieval-google-cloud]] — Google's 2023 blog on the same topic with TFRS focus
- [[shaped-ai-two-tower-deep-dive]] — loss functions and negative sampling
- [[recommendation-systems]] — broader context
- [[approximate-nearest-neighbors]] — ANN indexing concepts
- [[cold-start-problem]] — how two-tower architectures address it
- [[vertex-ai-matching-engine]] — Google's managed ANN service
- [[google]] — publisher
- [[jordan-totten|Jordan Totten]] — author
- [[jeremy-wortz|Jeremy Wortz]] — author
