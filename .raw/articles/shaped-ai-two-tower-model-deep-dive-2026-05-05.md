---
source_url: https://www.shaped.ai/blog/the-two-tower-model-for-recommendation-systems-a-deep-dive
fetched: 2026-05-05
author: Shaped.ai team
---

# The Two-Tower Model for Recommendation Systems: A Deep Dive

## Architecture

User Tower: processes user ID, demographics, history, context → user embedding u
Item Tower: processes item ID, category, description, images → item embedding v
Score = dot product u·v (or cosine similarity)

## Training vs. Serving Paradigm

Training: joint optimization with loss functions + negative sampling
Serving: precompute all item embeddings offline; compute user embedding real-time; ANN search (Faiss, ScaNN, HNSW)

## Input Feature Handling

- IDs → learned embedding layers
- Categorical → embedding-based
- Numerical → normalize + MLP
- Text → TF-IDF to BERT
- Images → pretrained CNN outputs
- Sequential (user history) → RNN/LSTM/GRU, Attention, Transformers

## Network Architectures

- MLPs for feature combination
- CNNs, RNNs, Transformers for modalities
- GNNs when graph data available

## Training Techniques

### Loss Functions

Pointwise:
- Log Loss (binary cross-entropy on positive/negative pairs)
- MSE (rating regression)

Pairwise:
- BPR — Bayesian Personalized Ranking: maximize P(pos item ranked above neg item)

Contrastive:
- InfoNCE — treats other items in batch as negatives; optimizes:
  L = -log[ exp(u·v_pos/τ) / Σ exp(u·v_i/τ) ]
  where τ = temperature, sum over all items in batch

### Negative Sampling Strategies

1. Random sampling — sample negatives uniformly at random
2. Popularity-based — sample proportional to item popularity (addresses popularity bias)
3. Hard negative mining — sample items ranked highly but not interacted with
4. In-batch negatives — treat all other items in the batch as negatives for each user (efficient, no extra sampling needed)

### Optimization
- Dropout, batch normalization
- Temperature scaling (τ) for contrastive losses
- Adam optimizer

## Multi-Stage Pipeline

Retrieval stage: two-tower retrieves hundreds–thousands of candidates from billions (recall-focused)
Ranking stage: secondary model re-ranks candidates (feature-interaction-focused)
- Rankers: Deep & Wide, DCN (Deep & Cross Network), DeepFM, LightGBM

## Additional Use Cases

- Related item recommendation: item-only tower + nearest neighbor search
- Direct ranking for small catalogs
- Cold-start mitigation in high-velocity marketplaces

## Advantages

- Handles enormous catalogs via ANN precomputation
- Flexible multi-modal feature integration
- Modular: towers can be iterated independently

## Limitations

- Limited user-item feature interaction (dot product is shallow)
- Cold-start challenges
- Can amplify historical biases
- Simple scoring may oversimplify complex preferences

## Comparison

vs. Matrix Factorization: two-tower = non-linear generalization with rich side features
vs. FM/Deep Rankers: FM excels at feature interaction but can't score entire catalogs efficiently
vs. GNNs: GNNs model interaction graphs directly; choice depends on data structure

## Shaped.ai Example Config

```yaml
embedding_policy:
  policy_type: two-tower
  embedding_dims: 128
  negative_samples_count: 5
  n_epochs: 5
  batch_size: 256
  lr: 0.001
```

## Seminal Work

- "Deep Neural Networks for YouTube Recommendations" (Covington et al., 2016)
- Adopted at: Google, Facebook, LinkedIn, Pinterest
