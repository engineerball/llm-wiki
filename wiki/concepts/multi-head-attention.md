---
title: "Multi-Head Attention"
tags: [concept, ml, attention, transformer, neural-networks]
sources: ["attention-is-all-you-need-adnanmasood-2026-01-13"]
date: 2026-05-12
---

# Multi-Head Attention

Running multiple [[self-attention|self-attention]] operations in parallel, each with its own learned linear projections (its own "head"), then combining the results. Each head captures a different type of relationship or "relational view" within the data.

> "Instead of a single attention mechanism, it runs several in parallel, each with its own learned projections. This allows the model to simultaneously focus on different types of relationships or 'relational views' within the sentence." — Adnan Masood

## Intuition

Think of reading a sentence:
- You can track grammar (subject-verb agreement)
- Simultaneously track semantics (what does this pronoun refer to?)
- Simultaneously track topic (what is this sentence about?)
- All at once, not sequentially

Multi-head attention does something analogous — each head specializes in a different kind of pattern, learned automatically during training.

## Architecture

```
Input
  ↓
[Linear: Q₁ K₁ V₁] [Linear: Q₂ K₂ V₂] ... [Linear: Qₙ Kₙ Vₙ]  (different projections per head)
  ↓                     ↓                        ↓
[Head 1: Attention]  [Head 2: Attention]      [Head n: Attention]
  ↓                     ↓                        ↓
Concatenate heads → [Linear: Output projection]
  ↓
Output
```

## How It Works

1. **Split:** The input dimension is divided across h heads (each head operates in a reduced `d_model/h` dimensional subspace)
2. **Independent attention:** Each head computes its own [[attention-mechanism|attention with its own Q, K, V]]
3. **Concatenate:** Results from all heads are concatenated
4. **Output projection:** A final linear layer mixes the head outputs together

## Why Multiple Heads?

- **Diversity:** Different heads learn to capture different relationships — some track syntax, some semantics, some positional patterns
- **Capacity:** More parameters than single-head while keeping the same total computation cost
- **Robustness:** If one head fails to capture something important, others may compensate
- **Original Transformer used 8 heads**

## Practical Impact

In practice:
- Some heads develop attention to adjacent tokens (local context)
- Some develop attention to syntactically related tokens
- Some attend to tokens with similar semantic roles
- The model learns this specialization during training — no manual assignment

## See Also

- [[self-attention]] — the mechanism each head implements
- [[attention-mechanism]] — broader attention concept
- [[transformer-architecture]] — uses multi-head attention in every layer
