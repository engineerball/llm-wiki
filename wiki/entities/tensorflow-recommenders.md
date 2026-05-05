---
title: "TensorFlow Recommenders (TFRS)"
type: entity
entity_type: library
tags: [entity, library, ml, tensorflow, recommendation-systems, google]
sources: [".raw/articles/scaling-deep-retrieval-tensorflow-two-towers-architecture-2026-05-05.md"]
date: 2026-05-05
---

# TensorFlow Recommenders (TFRS)

Open-source TensorFlow library by [[google]] for building recommendation system models. Provides base classes, loss functions, and metrics optimized for [[two-tower-architecture]] retrieval models.

**GitHub:** tensorflow/recommenders  
**Ecosystem:** TensorFlow / Keras

## Key Components

### `tfrs.models.Model`
Base class for retrieval models. Provides `compute_loss()` hook and training loop integration.

### `tfrs.tasks.Retrieval`
Loss task for two-tower training. Computes in-batch softmax loss over query-candidate pairs. Accepts candidate dataset for metric computation.

```python
self.task = tfrs.tasks.Retrieval(
    metrics=tfrs.metrics.FactorizedTopK(
        candidates=parsed_candidate_dataset.batch(128).map(
            self.candidate_tower,
            num_parallel_calls=tf.data.AUTOTUNE
        ).prefetch(tf.data.AUTOTUNE)
    )
)
```

### `tfrs.metrics.FactorizedTopK`
Approximates Top-K recall during training. Uses candidate dataset to compute factorized metrics without exhaustive scoring.

## Two-Tower Model Pattern

```python
class TheTwoTowers(tfrs.models.Model):
    def __init__(self, layer_sizes, vocab_dict, parsed_candidate_dataset):
        super().__init__()
        self.query_tower = Playlist_Tower(layer_sizes, vocab_dict)
        self.candidate_tower = Candidate_Track_Tower(layer_sizes, vocab_dict)
        self.task = tfrs.tasks.Retrieval(...)
    
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

## Keras Integration

Towers are `tf.keras.Model` subclasses. Feature processing uses standard Keras layers:
- `tf.keras.layers.TextVectorization` — n-gram tokenization
- `tf.keras.layers.Embedding` — dense embedding lookup
- `tf.keras.layers.GlobalAveragePooling1D/2D` — sequence aggregation
- `tf.keras.layers.StringLookup` — vocabulary-based categorical encoding
- `tf.keras.layers.Hashing` — hash-based categorical encoding

## Deployment Path

TFRS trains the combined model; saves query and candidate towers separately. Each saved tower is a standard Keras SavedModel, compatible with:
- Vertex AI Model Registry
- Vertex AI Batch Prediction (candidate embeddings)
- Vertex AI online endpoints (query tower)

See [[vertex-ai-matching-engine]] for the ANN serving layer.

## Related Pages

- [[two-tower-architecture]] — the pattern TFRS implements
- [[recommendation-systems]] — broader context
- [[vertex-ai-matching-engine]] — serving layer for TFRS-trained models
- [[google]] — creator
- [[two-towers-deep-retrieval-google-cloud]] — source article
