---
title: "Cube"
tags: [entity, tool, semantic-layer, data-engineering, open-source]
date: 2026-05-05
sources: ["sources/best-open-source-semantic-layer-tools-2026.md"]
---

# Cube

Open-source **headless semantic layer** — an API-first standalone service that sits between data warehouses and all consuming tools (BI, apps, AI agents).

## Key Characteristics

| Property | Value |
|----------|-------|
| **Architecture** | Headless — standalone service, not embedded in BI tool |
| **Query interface** | REST API, GraphQL, SQL, JDBC/ODBC |
| **Pre-aggregation** | Yes — pre-computation engine for sub-second responses |
| **Open source** | Yes (Cube.js / Cube) |
| **Specialized Capabilities** | **Semantic caching** and native **vector database support** (2026) |
| **Best for** | Embedded analytics, SaaS platforms, multi-consumer metric APIs, AI grounding |

## Headless Model

Cube's defining property is decoupling the semantic layer from any specific BI tool. Metrics are defined once in Cube's data model (YAML or JS), then served to any consumer via API. This makes it the most natural fit for:

- Multi-BI-tool environments where one definition must serve Metabase + Superset + a custom app simultaneously
- Embedded analytics in SaaS products that need a metrics API
- **AI agents** consuming business metrics programmatically

## Compared to Alternatives

| vs. | Difference |
|-----|-----------|
| dbt Semantic Layer | dbt SL generates SQL; Cube provides full API. Cube requires its own infra; dbt SL reuses existing dbt jobs |
| Lightdash | Lightdash is a BI tool that reads dbt; Cube is BI-agnostic infrastructure |
| MetriQL | MetriQL is lighter-weight, warehouse-only pushdown; Cube adds caching + multi-protocol API layer |

## Related

- [[semantic-layer]] — concept; Cube is the canonical headless semantic layer example
- [[best-open-source-semantic-layer-tools-2026]] — source survey
- [[dbt-semantic-layer-introduction]] — the main alternative for dbt-native teams
