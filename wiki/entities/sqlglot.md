---
tags: [entity, tool, data-engineering, semantic-layer, sql, open-source]
sources: [Building a Semantic Layer_ Lessons Learned.md]
created: 2026-06-03
updated: 2026-06-03
---

# SQLGlot

Open-source Python SQL parser, transpiler, and optimizer. Parses SQL from one dialect and reliably transpiles it into another (e.g., generic SQL → BigQuery, Snowflake, DuckDB, Spark dialects). Used heavily in modern data stacks.

## Role in Semantic Layers

In [[Airbnb Minerva]] 2.0 and simplified implementations following that pattern, SQLGlot serves as the **Semantic Engine** component: it receives semantic requests (e.g., "Revenue by Region") from the Definition Layer, resolves join paths, and generates optimized SQL for the target [[Execution Engine]].

Key insight from [[Christian Edensor Arbon]]: don't reinvent the wheel with Python transformations — let SQL do the heavy lifting, with SQLGlot as the translator layer.

## Relationships

- [[Semantic Layer]] — used as semantic engine component
- [[Airbnb Minerva]] — adopted in Minerva 2.0
- [[Pre-computation Trap]] — SQLGlot-based approach generates SQL on-the-fly, avoiding pre-aggregation lock-in
