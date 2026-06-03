---
title: "Airbnb"
tags: [entity, organization, data-engineering, semantic-layer, metrics-as-code]
sources: [Building a Semantic Layer_ Lessons Learned.md]
created: 2026-06-03
updated: 2026-06-03
---

# Airbnb

Online marketplace for short-term rentals and experiences. In the data engineering world, Airbnb is notable for pioneering [[Metrics as Code]] at scale through their internal semantic layer system [[Airbnb Minerva]].

## Data Engineering Contributions

### The "Five Dashboards, Five Different Numbers" Problem
Airbnb's early data growth led to the canonical metric inconsistency problem: five analysts querying the same clean table (`core_data`) produced five different "Active Users" numbers because business logic was embedded in individual BI tool queries.

### Minerva Evolution

| Version | Approach | Problem Solved |
|---------|----------|---------------|
| Early (core_data) | Standardize tables | Tables ≠ metrics; SQL logic still diverges per analyst |
| Minerva 1.0 | Python-based transformations | Reinvents the wheel; SQL should do the heavy lifting |
| Minerva 2.0 | SQL generation (via [[SQLGlot]]); fast OLAP execution ([[StarRocks]]) | Ratios/distinct counts can't be pre-aggregated; need on-the-fly joins |

Minerva 2.0 manages ~12,000 metrics and ~4,000 dimensions. See [[Airbnb Minerva]] for the full concept page.
