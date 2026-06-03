---
title: "Metrics as Code"
tags: [concept, semantic-layer, data-engineering, metrics, version-control, governance]
sources: [Building a Semantic Layer_ Lessons Learned.md]
created: 2026-06-03
updated: 2026-06-03
---

# Metrics as Code

The practice of defining business metric logic as version-controlled code (YAML, Python, or DSL in a Git repository) rather than embedding SQL in BI tool dashboards or ETL scripts. The foundational principle behind modern [[Semantic Layer]] architectures.

## The Core Shift

| Before (Table Standardization) | After (Metrics as Code) |
|--------------------------------|-------------------------|
| Standardize physical tables (`core_data`) | Standardize business logic definitions |
| Five analysts, five SQL queries for "Active Users" | One definition, all tools consume it |
| Business logic lives in Tableau/Looker/notebook | Business logic lives in Git |
| Bug in BI tool = invisible inconsistency | Bug in definition = visible, reviewable, auditable |

**Key rule from [[Airbnb Minerva]] 2.0:** *If a metric isn't defined in the Definition Layer, it doesn't exist.*

## How It Works

```
Definition Layer (Git + YAML/Python)
  ↓ metric definition: Revenue = Sum(Price) - Sum(Discount)
Semantic Engine (e.g., [[SQLGlot]])
  ↓ translates to dialect-specific SQL
Execution Engine ([[StarRocks]] / [[ClickHouse]] / [[DuckDB]])
  ↓ runs query
Interface (standard SQL API)
```

## Benefits

- **Single source of truth** — one definition, consumed by every BI tool, AI agent, and notebook
- **Version control** — diffs, PRs, and reviews for metric changes; rollback on bad definitions
- **Auditability** — every metric has an author, review history, and deprecation record
- **Eliminates [[Semantic Layer#Metric Drift|metric drift]]** — divergence becomes structurally impossible when logic is centralized

## Relationship to Semantic Layer History

[[Looker]] pioneered "semantics as code" with LookML and Git-based version control (2012+). [[Airbnb Minerva]] took it to enterprise scale (~12,000 metrics). Modern open-source tools like dbt Semantic Layer (MetricFlow), [[Cube]], and MetriQL implement the same pattern for any stack.

## Relationships

- [[Semantic Layer]] — metrics-as-code is the defining principle of modern semantic layers
- [[Airbnb Minerva]] — canonical large-scale implementation
- [[Pre-computation Trap]] — metrics-as-code + on-the-fly execution is the alternative to pre-aggregation
- [[SQLGlot]] — translates metric definitions into SQL
