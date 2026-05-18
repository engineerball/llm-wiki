---
title: "Positional Encoding"
tags: [concept, ml, transformer, positional-encoding, sequence-modeling]
sources: ["attention-is-all-you-need-adnanmasood-2026-01-13"]
date: 2026-05-12
---

# Positional Encoding

A mechanism to inject token position information into Transformer inputs. Since [[self-attention]] is permutation-invariant (it treats "dog bites man" the same as "man bites dog"), the model needs a separate signal for token order.

## The Problem

Attention computes relationships between tokens based purely on content — it has no notion of "this token comes before/after that one." Without positional encoding:
- Word order is lost
- "I saw the man with a telescope" and "With a telescope I saw the man" are indistinguishable
- Sequence structure collapses

## Sinusoidal Positional Encoding

The original Transformer uses fixed sinusoidal encoding:

```
PE(pos, 2i) = sin(pos / 10000^(2i/d_model))
PE(pos, 2i+1) = cos(pos / 10000^(2i/d_model))
```

Where:
- `pos` = position in the sequence
- `i` = dimension index
- `d_model` = embedding dimension

## Why Sinusoidal?

- **Unique representation** — every position gets a distinct encoding
- **Extrapolation beyond training length** — can handle sequences longer than seen during training
- **Linear relationship for relative positions** — a fixed offset in position corresponds to a linear transformation in the encoding space, making relative positions learnable

## How It's Applied

Positional encodings are **added** (element-wise) to the input token embeddings before the first Transformer layer. The model learns to use the combined signal for both content and position.

## Modern Variants

Since the original, several alternatives have emerged:

| Variant | Key Idea | Used By |
|---------|----------|---------|
| **Absolute PE (sinusoidal)** | Fixed sine/cosine functions | Original Transformer (2017) |
| **Learned PE** | Trainable embedding table | BERT, GPT-2/3, many others |
| **Rotary PE (RoPE)** | Rotary position embeddings via complex rotation | LLaMA, PaLM |
| **ALiBi** | Attention with Linear Biases — penalty in attention scores based on distance | Some recent models |

## Trade-offs

- Sinusoidal: No trainable parameters for position; can extrapolate
- Learned PE: Simpler; may not extrapolate well beyond training length
- RoPE: Better theoretical properties for relative position encoding; became standard in open-source LLMs
- ALiBi: Simpler to implement; naturally handles variable-length sequences

## See Also

- [[transformer-architecture]] — architecture using positional encoding
- [[attention-mechanism]] — the mechanism that needs positional encoding
- [[self-attention]] — the permutation-invariant operation
