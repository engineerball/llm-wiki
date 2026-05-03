---
title: "dbt Labs"
type: organization
tags: [entity, organization, data, semantic-layer, analytics]
sources: []
date: 2026-05-04
---

# dbt Labs

Data transformation company; creator of dbt (data build tool) and the dbt Semantic Layer. Pioneered the "metrics alongside models" approach to the [[semantic-layer]].

## What They Build

- **dbt** — SQL-based transformation framework; the dominant tool for analytics engineering
- **dbt Semantic Layer** — codifies business metrics (revenue, churn, etc.) alongside dbt models so metrics stay DRY and consistent across all consumers (BI, AI, embedded analytics)
- **MetricFlow** — the metric query framework underlying the dbt Semantic Layer

## Relevant Work in This Wiki

- [[dbt-semantic-layer-introduction]] — source summary: hub-and-spoke architecture, five semantic layer use cases (BI, embedded analytics, AI/LLMs, self-serve, exploratory), DRY principle for metrics
- [[semantic-layer]] — concept page; dbt Semantic Layer cited as a primary implementation

## Key Contribution

dbt's hub-and-spoke model: one semantic layer definition → many downstream consumers. Solves the "define revenue once" problem that plagues organizations with 4+ BI tools.

## Links

- <https://www.getdbt.com/>
- <https://www.getdbt.com/blog/semantic-layer-introduction>
