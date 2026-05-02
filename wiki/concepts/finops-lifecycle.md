---
title: "FinOps Lifecycle"
tags: [concept, finops, cloud, lifecycle]
date: 2026-05-02
sources: ["sources/finops-getting-started-gcp.md"]
---

# FinOps Lifecycle

The three-stage iterative process for implementing FinOps practices: **Inform → Optimize → Operate**.

## Inform — Make Information Visible

Aim: Provide transparent, accurate, and actionable data to all stakeholders.

| Epic | Description |
|------|-------------|
| **Allocate** | Assign all costs to teams via labeling strategies, handle shared resources |
| **Report KPI & cost** | Visualize data through actionable dashboards and reports |
| **Forecast** | Project future spend based on past trends and known changes |

Three of the top four challenges in the 2021 State of FinOps Report were: full cost allocation (26%), shared costs (33%), and accurate forecasting (26%).

## Optimize — Drive Cloud Efficiency

Aim: Translate information from Inform into actions to optimize cloud spend.

| Method | Description |
|--------|-------------|
| **Product efficiency** | Right product, right usage — refactoring workloads, rightsizing |
| **Pricing efficiency** | Reduce rate paid — CUDs, preemptible VMs, custom VMs |
| **Guardrails** | Passive controls — budgets, alerts, capping, quotas |

Prioritization is based on: existing spend analysis, business objectives, and effort vs. benefit ratio.

## Operate — Embed FinOps

Aim: Make FinOps practices business-as-usual, not one-off exercises.

| Epic | Description |
|------|-------------|
| **Onboard workloads** | Cost-efficient architecture from the start of projects |
| **Educate & enable** | Continuous upskilling through learning and enablement services |
| **Incentivize** | Reward cost-conscious decisions with tangible benefits |
| **Measure value** | Unit economics to show business impact beyond raw costs |
| **Funding** | Enterprise-wide investment decisions informed by value data |

## Iterative Nature

The lifecycle is iterative. After completing one cycle, the process starts again with improved practices. Don't wait for the end of a cycle to embrace improvement — improve at every step.

Don't wait for full maturity before starting. Start small, iterate, and continuously improve.

## Relationship to Other Concepts

- **[[finops]]** — overarching practice that uses this lifecycle
- **[[guides-and-sensors]]** — Guardrails in Optimize act as sensors; budgets as guides
- **[[harness-engineering]]** — similar iterative improvement cycle; centralized enablement in Operate mirrors harness design
