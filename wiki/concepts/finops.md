---
title: "FinOps"
tags: [concept, finops, cloud, cost-management]
date: 2026-05-02
sources: ["sources/finops-framework-principles.md", "sources/finops-getting-started-gcp.md"]
---

# FinOps

Financial Operations for cloud and technology spending. A practice and operating model that brings financial accountability to the variable spend model of cloud.

FinOps is not about reducing cloud spend — it's about **getting more value** from every dollar spent on technology through collaboration, ownership, data transparency, and centralized enablement.

## Core Principles

Six north-star principles ([[finops-framework-principles|source]]):

1. **Teams collaborate** — finance, engineering, product, leadership work together
2. **Business value drives decisions** — unit economics > aggregate spend
3. **Everyone owns their usage** — engineers own costs from design through operations
4. **Data is accessible, timely, accurate** — real-time visibility, fast feedback loops
5. **Centralized enablement** — central function enables best practices, rate optimization at scale
6. **Variable cost model advantage** — embrace consumption-based, agile planning over static budgets

## Operating Model

**Centralized enablement + decentralized execution:**

| Layer | Responsibility |
|-------|---------------|
| **Central FinOps** | Rate optimization, executive comms, best practices, governance |
| **Engineering teams** | Usage optimization, architecture decisions, cost as first-class metric |
| **Data platform** | Real-time cost visibility, FOCUS-aligned data, forecasting, benchmarking |

## FinOps Framework Components

From the [[finops-framework-principles|FinOps Framework]]:
- **[[finops-principles]]** — six guiding principles
- **[[finops-personas]]** — roles and responsibilities
- **[[finops-phases]]** — inform → optimize → operate
- **[[finops-maturity-model]]** — crawl → walk → run progression
- **[[finops-domains]]** — spheres of activity
- **[[finops-capabilities]]** — functional areas within domains
- **[[finops-scopes]]** — defined segments of technology spending

## Implementation: GCP Example

Google provides a detailed GCP-specific implementation in [[finops-getting-started-gcp|Getting Started with FinOps on GCP]]:

**Organizational structure:** Central FinOps team enables but doesn't own optimization work. Anti-pattern: central team becomes the optimization team and bottlenecks the org.

**Three-phase approach:**
1. **Inform** — cost allocation (GCP labels), shared cost handling, reporting, forecasting
2. **Optimize** — product efficiency (rightsizing, refactoring), pricing (CUDs, preemptibles), guardrails (budgets, quotas)
3. **Operate** — onboarding, education & enablement, incentives, value measurement, funding alignment

## Cultural Principles

Key cultural enablers from Google's practice:
- **Variable nature of cloud** — accept and optimize for fluctuating costs
- **Business-value decisions** — don't just optimize for cost; optimize for value
- **Accountability** — cost ownership at the edge, not centralized
- **Collaboration** — break silos between finance, engineering, product
- **Blamelessness** — postmortems for cost spikes, not finger-pointing
- **Democratization of data** — single source of truth, open visibility into spend
- **Agility** — iterative improvement, don't wait for perfection

## Relationship to Other Concepts

- **[[harness-engineering]]** — FinOps principles parallel harness design: centralized enablement + decentralized execution, [[guides-and-sensors]] pattern (budgets as guides, reports as sensors), cost as a first-class metric
- **[[guides-and-sensors]]** — budgets/policies as feedforward guides; cost data/alerts as feedback sensors
- **[[initializer-coding-agent-architecture]]** — similar pattern: initializer sets up constraints and tracking, agents/teams work incrementally within them
- **[[semantic-layer]]** — semantic layer as a guide pattern for business metrics across tools
