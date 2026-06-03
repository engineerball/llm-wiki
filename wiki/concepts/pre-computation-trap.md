---
tags: [concept, data-engineering, semantic-layer, anti-pattern, olap]
sources: [Building a Semantic Layer_ Lessons Learned.md]
created: 2026-06-03
updated: 2026-06-03
---

# Pre-computation Trap

Anti-pattern in [[Semantic Layer]] / OLAP architecture where systems pre-aggregate every possible combination of dimensions into cubes (Druid-style). Appears performant at first but breaks on metric types that cannot be pre-computed.

## The Failure Modes

| Metric Type | Why Pre-computation Breaks |
|-------------|---------------------------|
| Ratios | Numerator and denominator must be aggregated independently at query time; pre-summing either invalidates the ratio across slices |
| Distinct counts | `COUNT(DISTINCT user_id)` across date ranges cannot be summed from daily pre-aggregates (overlap between days) |
| Dynamic dimension combos | Pre-aggregating every permutation is combinatorially explosive |

## Canonical Example

[[Airbnb]] built [[Airbnb Minerva]] on Apache Druid (pre-aggregated cubes). As metrics grew more complex, analysts needed ratios like "7-day rolling conversion rate by device × region × campaign." Druid's pre-aggregated cubes couldn't serve this without a massive pre-computation explosion. Airbnb migrated to [[StarRocks]] for on-the-fly joins.

## The Escape

Use a modern OLAP execution engine capable of **on-the-fly multi-table broadcast joins**:

| Scale | Engine |
|-------|--------|
| Enterprise | [[StarRocks]] |
| Mid-scale | [[ClickHouse]] |
| Small / local | [[DuckDB]] |

These engines execute ad-hoc aggregations in sub-seconds without requiring pre-computed cubes, giving full flexibility for any metric shape.

## Relationship to Semantic Layer Design

A [[Semantic Layer]] that falls into the pre-computation trap has to encode dimension combinations into its materialization strategy rather than letting the execution engine handle them at query time. This creates coupling between the definition layer and execution strategy, defeating the separation-of-concerns goal.

**Design principle:** your [[Semantic Layer]] should define metrics once; the execution engine handles all aggregation shapes on-the-fly.

## Relationships

- [[Airbnb Minerva]] — canonical escape story (Druid → StarRocks migration)
- [[Semantic Layer]] — pre-computation trap is the primary execution-layer failure mode
- [[StarRocks]] — standard escape for large-scale setups
- [[SQLGlot]] — SQL generation approach avoids pre-computation by generating queries at request time
