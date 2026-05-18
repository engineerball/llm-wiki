---
title: "Transformer Architecture"
tags: [concept, ml, transformer, neural-networks, deep-learning, architecture]
sources: ["attention-is-all-you-need-adnanmasood-2026-01-13"]
date: 2026-05-12
---

# Transformer Architecture

A sequence-to-sequence architecture introduced by Vaswani et al. (2017) that relies **entirely on attention mechanisms**, eliminating recurrence (RNNs/LSTMs) and convolutions entirely. This is the foundational design behind all modern large language models.

## The Core Idea

Process the entire input sequence in parallel, let each token decide which other tokens matter to it (attention), and build up representations through stacked layers. The "at once" part is why it trains so fast; the "deciding who matters" part is why it understands so well.

## Why It Replaced RNNs

| Concern | RNN/LSTM | Transformer |
|---------|----------|-------------|
| Processing | Sequential (token by token) | Parallel (entire sequence) |
| Long-range dependencies | Hard (many computation hops) | Easy (direct connection, 1 hop) |
| Training speed | Slow (no parallelism within a sequence) | Fast (full parallelism) |
| State-of-the-art | Translation quality plateaued | New SOTA at lower cost |

## Architecture Components

### Encoder

Purpose: Transform the input sequence into contextualized representations capturing the full context.

Structure (original: 6 identical layers stacked):
1. **Multi-Head Self-Attention** — each token attends to all other tokens in the input
2. **Position-wise Feed-Forward Network** — applied independently to each position
3. **Residual connections** around each sub-layer
4. **Layer normalization** after each residual connection

### Decoder

Purpose: Generate output sequence autoregressively (one token at a time).

Structure (original: 6 identical layers stacked):
1. **Masked Multi-Head Self-Attention** — prevents looking ahead at future tokens (masking is critical for autoregressive generation)
2. **Multi-Head Cross-Attention** — decoder attends to encoder output to ground generation in the source
3. **Position-wise Feed-Forward Network**
4. **Residual connections + Layer normalization**

### Positional Encoding

Since attention is permutation-invariant (it doesn't know order), sinusoidal positional embeddings are added to input embeddings to encode position. See [[positional-encoding]].

## Design Principles

- **Residual connections** — help with gradient flow through deep stacks
- **Layer normalization** — stabilizes training
- **No recurrence, no convolutions** — pure attention, full parallelization
- **Fixed number of layers** — deep but not infinitely deep (original: 6 encoder + 6 decoder layers)

## Impact and Evolution

The Transformer enabled:
- State-of-the-art machine translation at dramatically lower training cost
- BERT (encoder-only) for understanding tasks
- GPT series (decoder-only) for generation tasks
- T5 (encoder-decoder) for unified text-to-text
- Modern LLMs (GPT-4, Claude, Gemini) — all Transformer descendants

The original paper's authors: **Vaswani, Shazeer, Parmar, Uszkoreit, Jones, Gomez, Kaiser, and Polosukhin** (Google Brain / Google Research, NeurIPS 2017).

## Computational Complexity

Self-attention is O(n²) in sequence length — quadratic scaling becomes a bottleneck for very long contexts. This has motivated extensive research into:
- Linear attention variants
- Sliding window attention
- Sparse attention patterns
- Mixture of Experts [[mixture-of-experts]] for parameter efficiency

## See Also

- [[attention-mechanism]] — the fundamental building block
- [[self-attention]] — attention within a single sequence
- [[multi-head-attention]] — parallel attention heads
- [[positional-encoding]] — injects order information
- [[generative-ai]] — the ecosystem built on Transformers
- [[mixture-of-experts]] — a scaling technique used in modern (decoder-only) LLMs
