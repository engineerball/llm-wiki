---
title: "Semantic Layer"
tags: [concept, semantic-layer, data-engineering, metrics, bi]
date: 2026-05-02
sources: ["sources/semantic-layer-duckdb-tutorial.md"]
---

# Semantic Layer

A **semantic layer** (also known as a **metrics layer**) is a virtual translation layer that sits between a physical data warehouse and data consumers (BI tools, AI agents, notebooks, web apps). Instead of querying raw tables with complex SQL joins, users query **business concepts** defined in the semantic layer.

> A semantic layer lies between business users and the database, and lets those users compose queries in the concepts that they understand. It also governs access to the data, manages data transformations, and can tune the database by defining materializations.
> — Julian Hyde

> "Revenue is defined once in a single source of truth — no need to re-implement it over and over again in different tools."

## Core Concept

| Component | Description |
|-----------|-------------|
| **Dimensions** | Descriptive attributes (e.g., region, date, product category) |
| **Measures** | Calculated metrics (e.g., total_revenue, avg_trip_time, YoY_growth) |
| **Logical Data Model** | Abstracted business definitions above physical tables |
| **Query translator** | Translates business-friendly queries into optimized SQL |

## Key Benefits

### 1. Single Source of Truth
- Define metrics **once** in YAML/SQL/etc.
- Version-controlled, collaborative definitions
- Pull into multiple downstream tools (BI, Excel, notebooks, AI/MCP)
- Eliminates metric duplication and inconsistency

### 2. Federation & Caching
- Pre-calculated metrics for sub-second responses
- Query data where it lives (federated queries)
- Dialect-optimized SQL pushdown across heterogeneous sources
- Reduces cloud computing costs

### 3. Unified Security
- Centralized row-level and column-level security across ALL tools
- Works through REST, GraphQL, SQL, ODBC/JDBC, MDX

### 4. Dynamic Query Rewriting
- Handle ratios at different grains, time intelligence (YoY, trailing 12 months)
- Custom calendars, complex aggregations
- Users write intuitive queries without knowing the data model

### 5. Context for LLMs & AI Agents
- Provides structured business context to LLMs and RAG systems
- Dimension + fact connections prevent AI hallucination
- Helps LLMs suggest better SQL or natural language responses

## When NOT to Use One

- Just getting started with analytics — single consumer (one BI tool)
- No extensive business logic — simple COUNT/SUM/AVG
- All metrics pre-processed into physical tables via ETL

## How It Works — Simple Example

Using **Boring Semantic Layer (BSL)** + **Ibis** + **DuckDB**:

```yaml
fhvhv_trips:
  table: trips_tbl
  time_dimension: pickup_datetime
  smallest_time_grain: TIME_GRAIN_SECOND
  dimensions:
    hvfhs_license_num: _.hvfhs_license_num
    trip_miles: _.trip_miles
  measures:
    trip_count: _.count()
    total_revenue: _.base_passenger_fare.sum()
    avg_trip_miles: _.trip_miles.mean()
```

The YAML defines the semantic model; Ibis translates it into SQL; DuckDB executes against the data.

## The Physical vs Semantic Distinction

| Physical | Semantic (Logical) |
|----------|-------------------|
| Dataset | Aggregations |
| Table columns | Metrics |
| Physical table | Logical definition |

This is the key insight: **ad-hoc queries need semantic flexibility**. Someone might change granularity from daily → weekly → monthly, add a region, roll up to country — all in seconds. A semantic layer handles this on-the-fly without ETL jobs.

## Metric Drift

The failure mode that makes semantic layers non-optional at scale: the same business metric produces different values across systems because logic is embedded inside individual BI tools instead of centralized. Metric drift is the primary motivation for adopting a semantic layer.

## Architectural Patterns

Three dominant open-source approaches:

| Pattern | How | Examples |
|---------|-----|---------|
| **Metrics-as-code** | YAML/config in Git, compiled to SQL by dedicated engine | dbt Semantic Layer (MetricFlow), MetriQL |
| **Headless semantic layer** | Standalone API service between warehouse and all consumers | [[cube]] |
| **Semantic modeling language** | New DSL above SQL for higher-abstraction model definitions | Malloy |

## Open-Source Tool Landscape (2026)

| Tool | Type | Best For |
|------|------|----------|
| [[cube]] | Headless / API-first | Embedded analytics, multi-consumer, AI agent access |
| dbt Semantic Layer (MetricFlow) | Metrics-as-code | dbt-native orgs; see [[dbt-semantic-layer-introduction]] |
| MetriQL | Lightweight declarative | Lakehouse setups, minimal infra |
| Malloy | Analytical DSL (Google) | AI-assisted query environments |
| Lightdash | dbt-integrated BI tool | dbt teams wanting simple BI (not standalone SL) |
| Evidence | Analytics app framework | Internal data portals |
| DataForge | Logical DWH modeling | Semantic-layer-first platform design |
| BSL (Boring Semantic Layer) | Lightweight / DuckDB | Simple Python-based implementation; see [[semantic-layer-duckdb-tutorial]] |

Commercial: Looker (Google), Tableau, Power BI, AtScale, GoodData.

## Relationship to Other Concepts

- **[[agentic-ai-system]]** — Layer 5 (Memory & Knowledge) in the reference architecture maps to semantic layer; Layer 3 (Data Agent) queries through it. LLMs use semantic layer definitions as structured context for natural language queries
- **[[guides-and-sensors]]** — Semantic dimensions are feedforward **guides**; the resulting metrics are feedback **sensors**
- **[[finops-getting-started-gcp|FinOps Inform phase]]** — "Report KPI & cost" Epic maps directly to semantic layer: unified metric definitions across reporting tools
- **[[finops]]** — FinOps KPIs defined once in a semantic layer, queried by multiple BI tools — the exact use case semantic layers solve
- **[[naming-conventions-for-semantic-layers]]** — gold-layer design principles for AI-friendly semantics: entity-oriented tables, star schema, business names, AI documentation
