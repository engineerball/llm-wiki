---
tags: [source, semantic-layer, data-engineering, metrics-as-code, architecture, airbnb-minerva]
sources: [Building a Semantic Layer_ Lessons Learned.md]
created: 2026-06-03
updated: 2026-06-03
---

# Building a Semantic Layer: Lessons Learned

**Source:** Building a Semantic Layer_ Lessons Learned.md
**Author:** [[Christian Edensor Arbon]]
**Published:** 2026-05-12
**URL:** https://medium.com/towards-data-engineering/building-a-semantic-layer-lessons-learned-d97458e11d40
**Date ingested:** 2026-06-03
**Type:** article

## Summary

Practitioner distillation of [[Airbnb Minerva]] 2.0 into a simplified four-component architecture that small teams can actually build. Core argument: Airbnb's real innovation wasn't Minerva's scale — it was the conceptual shift from standardizing tables to standardizing business logic as version-controlled code. That shift is accessible to anyone.

## Key Claims

- The "five dashboards, five different numbers" problem stems from embedding metric logic in BI tools, not from bad data
- [[Metrics as Code]] (Definition Layer in Git + YAML/Python) is the foundational shift — if a metric isn't defined there, it doesn't exist
- [[Airbnb Minerva]] 2.0 switched from Python-based transformations (Minerva 1.0) to SQL generation via [[SQLGlot]] after realizing SQL should do the heavy lifting
- Druid's pre-aggregated cube architecture is a [[Pre-computation Trap]] — ratios and distinct counts can't be pre-computed, requiring on-the-fly aggregation
- [[StarRocks]] (and [[ClickHouse]], [[DuckDB]] for smaller setups) solves the pre-computation trap with sub-second multi-table broadcast joins
- Separating definitions from execution gives governance + consistency from version-controlled code combined with speed from modern OLAP

## Four-Component Simplified Architecture

| Component | Role | Tech |
|-----------|------|------|
| Definition Layer | Single source of truth; YAML/Python in Git | dbt, MetricFlow, custom YAML |
| Semantic Engine | SQL generator; translates semantic requests to optimized SQL dialect | [[SQLGlot]] |
| Execution Engine | Fast on-the-fly OLAP; avoids pre-aggregation lock-in | [[StarRocks]], [[ClickHouse]], [[DuckDB]] |
| Interface (API Routing) | Standard SQL proxy; BI tools see it as a database | Custom API, Cube |

## Entities Mentioned

- [[Christian Edensor Arbon]] — author; practitioner building a personal semantic layer
- [[Airbnb]] — origin of [[Airbnb Minerva]] that inspired the architecture
- [[SQLGlot]] — open-source Python SQL parser/transpiler used as semantic engine
- [[StarRocks]] — fast OLAP database Airbnb migrated to from Apache Druid

## Concepts Covered

- [[Metrics as Code]] — business logic standardized in version-controlled YAML/Python
- [[Airbnb Minerva]] — Airbnb's internal semantic layer; v1 Python-based, v2 SQL-generation-based
- [[Pre-computation Trap]] — anti-pattern of pre-aggregating all dimension combinations; breaks on ratios/distinct counts
- [[Semantic Layer]] — broader concept; this source contributes a simplified implementation pattern
