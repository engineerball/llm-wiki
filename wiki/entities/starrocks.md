---
title: "StarRocks"
tags: [entity, tool, data-engineering, olap, semantic-layer]
sources: [Building a Semantic Layer_ Lessons Learned.md]
created: 2026-06-03
updated: 2026-06-03
---

# StarRocks

High-performance open-source OLAP database designed for real-time analytics. Capable of sub-second multi-table broadcast joins on the fly, enabling ad-hoc metric aggregation without pre-computed cubes.

## Role at Airbnb

Airbnb migrated [[Airbnb Minerva]] from Apache Druid to StarRocks after hitting the [[Pre-computation Trap]]: Druid required pre-computing and denormalizing data into cubes, but ratios and distinct counts can't always be pre-computed — they must aggregate on the fly based on user selections. StarRocks handles these on-the-fly joins at sub-second speed.

## Positioning

Serves as the **Execution Engine** layer in [[Semantic Layer]] architectures. Alternatives for different scale:

| Scale | Recommended Engine |
|-------|--------------------|
| Enterprise (Airbnb-scale) | StarRocks |
| Mid-scale | [[ClickHouse]] |
| Small / local | [[DuckDB]] |

## Relationships

- [[Airbnb Minerva]] — production execution engine
- [[Pre-computation Trap]] — StarRocks solves this by handling on-the-fly aggregation
- [[Semantic Layer]] — execution engine component
