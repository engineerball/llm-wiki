---
source_url: https://cloud.google.com/blog/products/ai-machine-learning/scaling-deep-retrieval-tensorflow-two-towers-architecture
fetched: 2026-05-05
published: 2023-04-20
authors: Jeremy Wortz (ML Specialist, Google Cloud), Jordan Totten (Machine Learning Specialist)
---

# Scaling Deep Retrieval with TensorFlow Recommenders and Vertex AI Matching Engine

## Overview

Demonstrates implementing recommendation systems using three approaches:
1. Fully managed Recommendations AI
2. Matrix factorization via BigQuery ML
3. Custom deep retrieval with two-tower encoders and Vertex AI Matching Engine

Focus: Two-tower encoder architecture for playlist-continuation using Spotify Million Playlist Dataset (MPD), implemented with TensorFlow Recommenders (TFRS), served via Vertex AI Matching Engine (ANN).

---

## Multi-Stage Recommendation Systems Architecture

Large-scale recommenders use multi-stage deployments with two core objectives:

1. **During Training:** Compile knowledge into `<query, candidate>` embeddings
2. **During Serving:** Retrieve relevant items fast enough to meet latency requirements

Candidate retrieval is the first stage, followed by ranking and filtering.

---

## Two-Tower Architecture Fundamentals

Two-tower architectures map query and candidate entities to a shared embedding space:
- One deep neural network tower produces the **query embedding**
- Second tower computes the **candidate embedding**
- **Dot product** between embedding vectors determines similarity

**Key Advantage:** Decoupled inference allows precomputing all candidate embeddings, reducing serving computation to:
1. Converting queries to embedding vectors
2. Searching for similar vectors among precomputed candidates

---

## Evolution of Retrieval Modeling

### Milestone 1: Token-Based Matching
- Uses inverted index of n-grams
- **Pros:** Interpretable, easy to maintain, high precision
- **Cons:** Poor recall (difficult finding all relevant candidates)
- **Limitation:** Requires exact keyword matches

### Milestone 2: Factorization-Based Retrieval
- Embedding-based approach with better generalization
- Uses collaborative filtering techniques
- Factorizes query-candidate interaction matrix into lower-rank matrices
- Learns latent factors from implicit interactions

### Milestone 3: Neural Deep Retrieval (NDR)
- Uses deep learning to create embeddings
- Processes multi-modal features through successive network layers
- Creates layered representations with non-linear relationships
- Enables complex feature interactions

NDR and factorization models both produce embedding representations where dot product determines similarity. NDR adds expressivity through deep neural networks.

---

## Implementation with TensorFlow Recommenders

### Tower Structure

```python
class Playlist_Tower(tf.keras.Model):
    '''produced embedding represents the features of a Playlist known at query time'''
    
    def __init__(self, layer_sizes, vocab_dict):
        super().__init__()
        # TODO: build sequential model for each feature here
    
    def call(self, data):
        '''defines what happens when the model is called'''
        all_embs = tf.concat(
            [
                # TODO: concatenate output of all features defined above
            ], axis=1)
        # pass output to dense/cross layers
        if self._cross_layer is not None:
            cross_embs = self._cross_layer(all_embs)
            return self.dense_layers(cross_embs)
        else:
            return self.dense_layers(all_embs)
```

### Feature Processing - Text Features

```python
# Feature: pl_name_src
self.pl_name_src_text_embedding = tf.keras.Sequential(
    [
        tf.keras.layers.TextVectorization(
            vocabulary=vocab_dict['pl_name_src'],
            ngrams=2,
            name="pl_name_src_textvectorizor"
        ),
        tf.keras.layers.Embedding(
            input_dim=MAX_TOKENS,
            output_dim=EMBEDDING_DIM,
            name="pl_name_src_emb_layer",
            mask_zero=False
        ),
        tf.keras.layers.GlobalAveragePooling1D(name="pl_name_src_1d"),
    ],
    name="pl_name_src_text_embedding"
)
```

### Feature Processing - Sequence Features

```python
# Feature: artist_genres_pl
self.artist_genres_pl_embedding = tf.keras.Sequential(
    [
        tf.keras.layers.TextVectorization(
            ngrams=2,
            vocabulary=vocab_dict['artist_genres_pl'],
            name="artist_genres_pl_textvectorizor"
        ),
        tf.keras.layers.Embedding(
            input_dim=MAX_TOKENS,
            output_dim=EMBED_DIM,
            name="artist_genres_pl_emb_layer",
            mask_zero=False
        ),
        tf.keras.layers.Reshape([-1, MAX_PL_LENGTH, EMBED_DIM]),
        tf.keras.layers.GlobalAveragePooling2D(name="artist_genres_pl_2d"),
    ],
    name="artist_genres_pl_emb_model"
)
```

### Combined Two-Tower Model

```python
class TheTwoTowers(tfrs.models.Model):
    def __init__(self, layer_sizes, vocab_dict, parsed_candidate_dataset):
        super().__init__()
        self.query_tower = Playlist_Tower(layer_sizes, vocab_dict)
        self.candidate_tower = Candidate_Track_Tower(layer_sizes, vocab_dict)
        self.task = tfrs.tasks.Retrieval(
            metrics=tfrs.metrics.FactorizedTopK(
                candidates=parsed_candidate_dataset.batch(128).map(
                    self.candidate_tower,
                    num_parallel_calls=tf.data.AUTOTUNE
                ).prefetch(tf.data.AUTOTUNE)
            )
        )
    
    def compute_loss(self, data, training=False):
        query_embeddings = self.query_tower(data)
        candidate_embeddings = self.candidate_tower(data)
        return self.task(
            query_embeddings,
            candidate_embeddings,
            compute_metrics=not training,
            candidate_ids=data['track_uri_can'],
            compute_batch_metrics=True
        )
```

---

## Advanced Model Components

### Dense and Cross Layers
- **Dense layers:** Increase tower depth, emphasize successive feature representations
- **Cross layers:** Model explicit feature interactions before deep layers
- **Trade-off:** Improved performance vs. increased computational complexity
- **Recommendation:** Evaluate parallel vs. stacked implementations

### Feature Engineering Strategy

Two approaches:
1. **Collaborative Filtering:** Pure collaborative approach
2. **Content-Based + Collaborative:** Include features describing playlists/tracks for semantic understanding

Key Insight: Model trained on `<playlist title, track title>` pairs creates different embedding space than `<aggregated playlist audio features, track audio features>` pairs.

### Feature Processing Decision Tree
- Text features → TextVectorization() + Embedding
- Categorical features → Hashing or StringLookup() + Embedding
- Numerical features → Normalize + pass through
- Pre-trained embeddings → Pass through unchanged

### Hashing vs. StringLookup() Layers

**Hashing:**
- Pros: Faster performance, skips lookup table
- Cons: Risk of hash collisions if bin size too small
- Best for: Fast performance scenarios

**StringLookup:**
- Requires vocabulary adaptation from training data
- Scan training data to create lookup dictionaries

---

## Training Data Structure

Training examples should represent semantic matches:
- For Playlist-Continuation: pair playlists with tracks similar enough to maintain user engagement
- Training data sourced from positive `<query, candidate>` pairs

Critical: Embedding space placement depends on semantic relationships in training examples.

Feature influence examples:
- `<playlist title, track title>` → Title-based similarity clustering
- `<audio features, audio features>` → Audio profile similarity clustering

---

## Vertex AI Matching Engine for Serving

### The Computational Challenge

As candidate datasets scale to millions/billions of vectors, similarity search becomes a bottleneck:
- Solution: Approximate Nearest Neighbors (ANN) with compression
- Trade-off: Speed gains vs. accuracy impact
- Google's Approach: Novel compression algorithm that improves both relevance AND speed

### Matching Engine Capabilities

A managed ANN service offering:
1. Large-Scale Support: Up to 1 billion embedding vectors
2. Incremental Updates: Make small changes without full rebuilds
3. Dynamic Rebuilds: Auto-reorganizes index for optimal performance
4. Autoscaling: Infrastructure scales for consistent performance
5. Filtering & Diversity: Restrict and crowding tags with boolean predicates

### Tree-AH Strategy

Matching Engine uses Tree-AH (Tree + Asymmetric Hashing):

1. **Distributed Search Tree:** Hierarchically organizes embedding space
   - Each level clusters nodes from next level
   - Leaf level: clustering of candidate embedding vectors

2. **Asymmetric Hashing (AH):** Fast dot product approximation
   - Scores similarity between query and search tree nodes

### Query Inference Process

1. Input: Query embedding vector
2. Score all partition centroids
3. Identify most similar partitions
4. Score candidate vectors within top partitions
5. Aggregate and re-score vectors
6. Output: Top N candidate vectors

---

## Reference Architecture for Deployment

Two-Tower Training and Deployment Pipeline:

1. **Train:** Combined model (two-towers) offline; save towers separately
2. **Deploy Query Tower:** Upload to Vertex AI Model Registry → online endpoint
3. **Upload Candidate Tower:** To Vertex AI Model Registry
4. **Batch Predict:** Candidate tower predicts embeddings for all candidates
5. **Save Embeddings:** JSON format
6. **Create ANN Index:** From embeddings JSON
7. **Deploy Index:** To online index endpoint
8. **Serving:**
   - User app calls endpoint.predict() with playlist data
   - Returns embedding vector
   - Search for N nearest neighbors
   - Matching Engine returns product IDs of top candidates

---

## Problem Framing: Spotify Playlist Continuation

Using Spotify Million Playlist Dataset (MPD):
- Real relationships between entities (playlists, tracks, artists)
- Large enough to replicate production scalability issues
- Multi-modal features: IDs, text, numerical, datetime
- Enrichment possible via Spotify Web Developer API
- Allows validation by listening to recommendations

**Use Case:** Playlist Continuation
- **Query:** Given playlist
- **Task:** Recommend tracks to add to playlist
- **Candidates:** All available tracks

---

## Key Insights and Best Practices

1. Structure training examples to represent semantic matches
2. Feature choice influences embedding space orientation
3. Decoupled inference enables: precompute candidates in batch + deploy query tower separately
4. ANN search reduces latency vs. exhaustive search
5. Google's compression algorithm preserves vector distances
6. Dense + cross layers improve expressivity at computational cost
