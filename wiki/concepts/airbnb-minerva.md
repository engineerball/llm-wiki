---
title: "Airbnb Minerva"
tags: [concept, semantic-layer, metrics-as-code, data-engineering, airbnb]
sources: [Building a Semantic Layer_ Lessons Learned.md]
created: 2026-06-03
updated: 2026-06-03
---

# Airbnb Minerva

[[Airbnb]]'s internal [[Semantic Layer]] / metrics platform. The reference implementation that popularized [[Metrics as Code]] at scale. Manages ~12,000 metrics and ~4,000 dimensions at Airbnb.

## The Problem It Solved

Airbnb's early `core_data` initiative standardized tables but not metrics. Five analysts given the same clean table still produced five different SQL queries for "Active Users." The root insight: **standardizing tables is not enough — you must standardize the business logic itself.**

## Version History

### Minerva 1.0
- Used Python-based logic for transformations
- Problem: Python reinvents what SQL already does well; complexity grew unsustainably

### Minerva 2.0
- Shifted to SQL generation as primary paradigm
- [[SQLGlot]] as the transpiler/semantic engine
- Migrated execution from Apache Druid → [[StarRocks]] to escape the [[Pre-computation Trap]]
- Business logic version-controlled as code (Git + YAML/Python)

## Architecture (Minerva 2.0)

```
Definition Layer (Git + YAML/Python)
        ↓
Semantic Engine (SQLGlot — SQL generator)
        ↓
Execution Engine (StarRocks — on-the-fly OLAP)
        ↓
Interface (Standard SQL API proxy)
```

## The Pre-computation Escape

Early Minerva + Druid required pre-computing every possible dimension combination into cubes. This failed on:
- **Ratios** (e.g., conversion rate by segment × time × device) — combinatorial explosion
- **Distinct counts** — cannot be summed across pre-aggregated partitions

Solution: move to a fast OLAP engine ([[StarRocks]]) that joins on-the-fly in sub-seconds, eliminating the need to pre-aggregate.

## Key Innovation

The conceptual shift from "standardize tables" → "standardize business logic as version-controlled code." This is what [[Christian Edensor Arbon]] terms the core takeaway: **if a metric isn't defined in the Definition Layer, it doesn't exist.**

## Simplified Implementation Pattern

[[Christian Edensor Arbon]] distilled Minerva 2.0 into a four-component pattern accessible without Airbnb's budget. See [[building-a-semantic-layer-lessons-learned|Building a Semantic Layer: Lessons Learned]] for the full breakdown.

## Relationships

- [[Semantic Layer]] — Minerva is the canonical large-scale implementation
- [[Metrics as Code]] — Minerva 2.0 is the reference implementation
- [[Pre-computation Trap]] — Minerva's Druid → StarRocks migration is the canonical escape story
- [[SQLGlot]] — serves as Minerva 2.0's semantic engine
- [[StarRocks]] — Minerva 2.0's execution engine
