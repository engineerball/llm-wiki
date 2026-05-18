---
title: "Self-Attention"
tags: [concept, ml, attention, transformer, neural-networks]
sources: ["attention-is-all-you-need-adnanmasood-2026-01-13"]
date: 2026-05-12
---

# Self-Attention

A mechanism where each token in a sequence attends to every other token **in the same sequence**, determining which tokens are most relevant to understanding its own meaning. It's "attention within a single sequence" rather than attention from one sequence to another.

> "For each word, it determines which other words in the sequence are most relevant and then blends information from them." — Adnan Masood

## How It Works

For every token in the input:
1. Create **query**, **key**, and **value** vectors via learned linear projections
2. Compare this token's query against all tokens' keys (dot product)
3. Apply softmax to get attention weights
4. Compute weighted sum of all tokens' values
5. Each token gets a new representation informed by the most relevant others

## Why It Matters

### Short Paths

In an RNN, two tokens n positions apart are separated by n computation hops. With self-attention, **any two tokens are one hop away** — direct connection, regardless of distance. This makes long-range dependencies fundamentally easier to learn.

### Contextual Understanding

"The bank is near the river" vs "I deposited money at the bank" — self-attention lets "bank" look at surrounding words and disambiguate its meaning based on context. This is what gives modern language models their contextual understanding.

### Parallelization

Unlike RNNs that process tokens sequentially, self-attention computes all pairwise relationships simultaneously. This is the key to fast training.

## Scaled Dot-Product Formula

```
Attention(Q, K, V) = softmax(Q × K^T / sqrt(d_k)) × V
```

Where:
- Q = query matrix
- K = key matrix
- V = value matrix
- d_k = key dimension (scaling factor for gradient stability)

## Attention Patterns in Practice

Self-attention naturally discovers patterns like:
- **Syntactic dependencies** — subject-verb agreement, pronoun resolution
- **Coreference** — linking "he" to the right entity
- **Semantic scope** — connecting qualifiers to the right noun phrase
- **Long-distance dependencies** — connecting the beginning of a sentence to the end

## Limitations

- **O(n²) complexity** — every token attends every other token; quadratic in sequence length
- **No ordering awareness** — purely permutation-invariant; needs [[positional-encoding]]
- **Quadratic memory** — the attention matrix itself grows quadratically

## See Also

- [[attention-mechanism]] — the broader attention concept
- [[multi-head-attention]] — running multiple self-attention heads in parallel
- [[transformer-architecture]] — architecture built from stacked self-attention layers
- [[positional-encoding]] — fixes self-attention's order-blindness
