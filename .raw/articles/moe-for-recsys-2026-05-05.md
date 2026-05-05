---
source_url: https://blog.reachsumit.com/posts/2023/04/moe-for-recsys/
fetched: 2026-05-05
---

# Mixture-of-Experts Based Recommender Systems

Author: Sumit Kumar (reachsumit.com), April 2023

## Overview

MoE (Mixture of Experts) is a classical ensemble learning technique from 1991, adapted for modern recommendation systems. Systems combine multiple specialized expert models with a gating/routing function that determines which experts handle a given input.

## Core MoE Concepts

**Basic Architecture**: MoE combines multiple specialized models (experts) with a gating/routing function. "The gate does a soft partition of the input space and defines the regions where the individual experts are trustworthy."

**Key Principle**: Experts work independently, not cooperatively. Error function: E^c = ||y^c - o_i^c||^2 — experts produce complete outputs rather than residuals.

**Advantages**:
- Flexible combination with different model types
- Identifies natural data patterns and subsets
- Scalable with modest computational overhead
- Stable training (no expert collapse)

**Challenges**:
- Early training difficulty due to identical initialization
- Expert load imbalance (gating over-relies on specific experts)

## MoE Variants

### Hierarchical MoE (HME)
Recursive decomposition with tree-structured gating networks. Probabilistic splits vs greedy decision trees.

### Deep MoE (DMoE)
Stacks multiple MoE layers, "dynamically assembles a suitable expert combination for a given input" through layered gating.

### Sparsely-Gated MoE
Adds Gaussian noise before softmax, keeps only top-k expert values. Achieved "more than 1000x improvement in model capacity" with minimal efficiency loss.

### Multi-Gate MoE (MMoE)
Shares expert submodels across tasks while maintaining task-specific gating networks and towers. Designed for multi-task learning. Each task has its own gate that selects a weighted combination of shared experts.

```
Input
  ↓
[Expert 1] [Expert 2] ... [Expert N]
     ↓ (weighted by task-specific gates)
[Gate-A] → [Tower-A] → Output-A (task A)
[Gate-B] → [Tower-B] → Output-B (task B)
```

## Industry Applications

### YouTube: Next Video Recommendation
Implemented MMoE for next-video recommendations. Separates objectives into:
- **Engagement** (watch time, clicks)
- **Satisfaction** (likes, ratings)

System substitutes the shared-bottom layer in traditional multi-task models with MMoE components. Each objective gets its own gating network that selects how much each shared expert contributes.

### Gmail: MoSE (Mixture-of-Sequential-Experts)
Uses LSTM-based experts and gating networks to model temporal user behavior patterns. Captures sequential nature of email interactions.

### Kwai (Kuaishou): Personalized Cold Start Modules
Combines sequential features through multi-head attention, then processes through MMoE layers for task-specific predictions. Specifically addresses the cold-start challenge for new items/users.

## Why MoE for Recommendations

1. **Conditional computation** — only relevant network portions activate per input
2. **Multi-task efficiency** — shared experts amortize computation across objectives
3. **Parallelizable training** — experts can train independently
4. **Natural task specialization** — gates learn which experts are best for which input types
