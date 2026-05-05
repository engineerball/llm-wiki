---
title: "Mixture of Experts (MoE)"
type: concept
tags: [concept, ml, architecture, moe, ensemble, multi-task-learning, recommendation-systems]
sources: [".raw/articles/moe-for-recsys-2026-05-05.md"]
date: 2026-05-05
---

# Mixture of Experts (MoE)

Ensemble technique (Jacobs et al., 1991) that combines multiple specialized sub-networks (experts) via a learned gating/routing function. Each input is processed by a weighted combination of experts, where the gate determines which experts are relevant for that region of the input space.

"The gate does a soft partition of the input space and defines the regions where the individual experts are trustworthy."

Core contrast with boosting: MoE experts produce **complete independent outputs** (not residuals). Error function: `E^c = ||y^c - o_i^c||^2`.

## Basic Architecture

```
Input
  ↓
[Gate Network] → weights per expert
[Expert 1] [Expert 2] ... [Expert N]
         ↓ (weighted sum)
      Final Output
```

## Key Challenges

- **Initialization collapse** — identical initial experts don't differentiate; training slow to start
- **Expert load imbalance** — gate collapses, routing most inputs to one expert; wastes capacity

## Variant Taxonomy

### HME — Hierarchical MoE
Tree-structured gating networks with recursive decomposition. Probabilistic soft splits instead of hard decision tree branches.

### DMoE — Deep MoE
Multiple stacked MoE layers. Each layer "dynamically assembles a suitable expert combination" for the current representation.

### Sparsely-Gated MoE
Adds Gaussian noise before softmax → keeps only top-k expert values (hard routing). Enables >1000x model capacity increase with modest compute overhead. Key insight: inactive experts don't consume compute during forward pass.

### MMoE — Multi-Gate MoE
Designed for multi-task learning. Shares expert pool across tasks; each task gets its own gating network.

```
Input
  ↓
[Shared Experts: E1, E2, ..., En]
       ↓
[Gate-A] → weighted combo → [Tower-A] → Output-A
[Gate-B] → weighted combo → [Tower-B] → Output-B
```

**Why MMoE beats hard parameter sharing**: Hard sharing forces all tasks through one representation. MMoE lets each task gate select which experts are relevant — tasks with conflicting gradients don't interfere as much.

## MoE in Production Recommendation Systems

MMoE is the dominant pattern for multi-objective recommenders. Typical use case: optimizing engagement and satisfaction simultaneously without one objective degrading the other.

| Company | System | Experts | Objectives |
|---------|--------|---------|------------|
| YouTube | Next-video recommendation | Shared DNNs | Engagement (clicks/watchtime) vs Satisfaction (likes/ratings) |
| Gmail | MoSE | LSTM experts | Temporal email behavior |
| Kuaishou | Cold Start Modules | MMoE after multi-head attention | Task-specific predictions from sequential features |

## Where MoE Fits in the Recsys Pipeline

MoE/MMoE is typically used at the **ranking stage** — after [[two-tower-architecture]] retrieval narrows candidates to ~1000. The ranking model scores each candidate; MMoE allows ranking to jointly optimize multiple objectives.

```
Retrieval (two-tower) → ~1000 candidates
                           ↓
              Ranking (MMoE) → multiple objective scores
                           ↓
                    Re-ranking / Blending
```

## Related Pages

- [[multi-task-learning-recsys]] — the problem MMoE solves
- [[recommendation-systems]] — pipeline context
- [[two-tower-architecture]] — retrieval stage (MoE used at ranking)
- [[cold-start-problem]] — Kuaishou's MMoE-based cold start solution
- [[youtube]] — MMoE production deployment
- [[kuaishou]] — cold start + MMoE case study
- [[moe-for-recsys-reachsumit]] — source article
