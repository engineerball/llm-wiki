---
title: "Negative Sampling"
type: concept
tags: [concept, ml, training, recommendation-systems, two-tower, contrastive-learning]
sources: [".raw/articles/shaped-ai-two-tower-model-deep-dive-2026-05-05.md"]
date: 2026-05-05
---

# Negative Sampling

Technique for training recommendation and retrieval models: given a positive user-item pair `(u, v_pos)`, construct negative examples `(u, v_neg)` to teach the model to distinguish relevant from irrelevant items. Essential for two-tower training — the model has no explicit negative labels in most recommendation datasets (only implicit positives from interactions).

## Why Negatives Are Needed

Training data = observed interactions (clicks, purchases, plays). Everything else is unobserved — not necessarily disliked, just unseen. Negatives approximate the set of items the user would not interact with.

The choice of negative sampling strategy directly shapes what the model learns to distinguish.

## Strategies

### Random Sampling

Draw negatives uniformly at random from the item catalog.

- **Pro:** Simple, no bias
- **Con:** Easy negatives — random items are obviously irrelevant; model doesn't learn fine-grained distinctions
- **Best for:** Baseline; early training epochs

### Popularity-Based Sampling

Sample negatives proportional to item popularity (interaction count).

```
P(item i as negative) ∝ count(interactions_i)^α   (α ∈ [0.5, 1])
```

- **Pro:** Popular items are more competitive negatives; forces model to distinguish relevance from mere popularity
- **Con:** Can under-represent long-tail items as negatives
- **Note:** Without this, models learn to boost popular items indiscriminately

### Hard Negative Mining

Select items that the model currently ranks highly for a user but the user hasn't interacted with. These are "confusing" negatives — close to the positive in embedding space.

- **Pro:** Strongest training signal; pushes decision boundary where it matters
- **Con:** Risk of **false negatives** — items the user would like but hasn't seen yet (unobserved ≠ disliked)
- **Con:** Requires running inference during training (expensive)
- **Mitigation:** Mix hard and random negatives; filter items with high predicted relevance

### In-Batch Negatives

Treat all other items in the same training batch as negatives for each user. If batch has 256 `(user, item)` pairs, each user gets 255 negatives for free.

```python
# Conceptual: batch of (user_emb, item_emb) pairs
# Similarity matrix: [batch_size × batch_size]
# Diagonal = positive pairs; off-diagonal = in-batch negatives
scores = user_embs @ item_embs.T         # [B, B]
labels = torch.eye(B)                    # diagonal = 1
loss = cross_entropy(scores / tau, labels)
```

- **Pro:** Extremely efficient — no extra sampling; scales naturally with batch size
- **Pro:** Natural fit with InfoNCE / contrastive losses
- **Con:** Negative quality depends on batch composition
- **Con:** Can degrade if the same item appears multiple times in a batch (false negatives)

## Loss Functions by Strategy

| Loss | Strategy | Notes |
|---|---|---|
| Log Loss (binary cross-entropy) | Random / popularity-based | Pointwise; explicit pos/neg pairs |
| BPR | Random / popularity-based | Pairwise; rank pos above neg |
| InfoNCE | In-batch negatives | Contrastive; temperature-controlled |

## Temperature in Contrastive Losses

InfoNCE uses a temperature parameter τ:

```
L = -log[ exp(u·v_pos / τ) / Σᵢ exp(u·vᵢ / τ) ]
```

- **Low τ** (e.g., 0.07) — sharp distribution; hard training signal; gradients focus on the hardest negatives
- **High τ** (e.g., 1.0) — soft distribution; stable but weaker signal
- τ is typically tuned as a hyperparameter; some implementations learn it

## False Negative Problem

A "negative" item the user would actually interact with if exposed. Contaminates training signal.

Sources:
- Popular items likely to be liked by many users appear frequently as in-batch negatives
- Hard negatives selected near the decision boundary are most likely to be false negatives

Mitigations:
- Deduplicate within batches
- Filter items from negative pool that appear in user's positive history
- Mixed negatives: blend random + hard to dilute false negative rate

## Related Pages

- [[two-tower-architecture]] — training context where negative sampling applies
- [[recommendation-systems]] — pipeline context
- [[shaped-ai-two-tower-deep-dive]] — source article
