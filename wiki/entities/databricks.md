---
title: "Databricks"
tags: [entity, company, data-platform, lakehouse, semantic-layer]
date: 2026-05-05
---

# Databricks

Data + AI company behind the **Lakehouse** architecture — a unified platform combining data lake flexibility with data warehouse reliability. Founded 2013 by the creators of Apache Spark.

## Key Products

- **Databricks Lakehouse Platform** — unified data engineering, analytics, and AI on open formats (Delta Lake, Apache Spark)
- **Unity Catalog** — governance layer for data, AI models, and assets across the lakehouse
- **Unity Catalog Business Semantics** — platform-native [[semantic-layer]] embedded within Unity Catalog; semantics co-located with data, policies, lineage, and audit history

## Semantic Layer Positioning

Databricks positions **platform-native semantic layers** as a third architectural type alongside metrics-as-code (dbt) and headless API layers ([[cube]]). The Unity Catalog approach co-locates metric definitions with governance infrastructure — access controls, lineage, and audit trails travel with assets automatically rather than being reinvented per BI tool.

Key claim: when semantics reside in the platform alongside data and policies, every surface reads from governed truth, enabling reliable AI-driven analytics rather than "dangerously plausible" text-to-SQL against raw tables.

## Relationship to Wiki

- [[semantic-layer]] — Databricks publishes authoritative architectural guidance; Unity Catalog Business Semantics is canonical example of platform-native semantic layer type
- [[databricks-semantic-layer-architecture]] — source article: 5-era history, traditional vs platform-native semantic layers, AI agent grounding pattern
