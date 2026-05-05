---
title: "Headless BI"
tags: ["#concept", "#bi", "#semantic-layer", "#architecture"]
sources: ["sources/rise-of-semantic-layer-airbyte-2026-05-05.md"]
date: 2026-05-05
---

# Headless BI

**Headless BI** is an architectural pattern where the [[semantic-layer]] (metric definitions, joins, and governance) is decoupled from the visualization layer (dashboards and reports).

## Key Characteristics

- **Universal Accessibility:** Metrics are defined once and accessed via APIs (REST, GraphQL, SQL) by any downstream consumer, including multiple different BI tools, custom web apps, and [[generative-ai]] agents.
- **Decoupled Logic:** The "brains" of the BI system live in a standalone service rather than being locked inside a specific proprietary visualization tool.
- **Consistency:** Ensures that a "Revenue" metric is identical whether viewed in Tableau, a React app, or queried by an LLM.

## Notable Tools

- [[Cube]]: A primary leader in the headless BI space.
- [[dbt-labs|dbt Semantic Layer]]: Provides headless metric capabilities for dbt-centered stacks.
- [[AtScale]]: Offers enterprise-grade universal semantic modeling.
