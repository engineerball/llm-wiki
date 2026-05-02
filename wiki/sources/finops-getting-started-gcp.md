---
title: "Getting Started with FinOps on GCP"
tags: [source, finops, gcp, google-cloud]
date: 2026-05-02
sources: ["raw/finops-getting-started-gcp.pdf", "raw/text/finops-getting-started-gcp.md"]
---

# Getting Started with FinOps on GCP

**Source:** Google Cloud Technical Paper (PDF, 49 pages)
**Authors:** Sam Moss, Kinjal Tanna, Tan-Minh Truong
**Date:** May 2021

## Overview

Google Cloud's FinOps framework aligned with the [[finops-framework-principles|FinOps Foundation]] standard. Provides GCP-specific implementation guidance organized around the three phases: Inform, Optimize, Operate.

## Scope

This paper covers: teams required, processes/behaviors to embrace, expected outcomes, and a GCP-specific approach to implement FinOps. It explicitly excludes: security basics, cloud cost management setup, product-specific optimization, and accounting practices.

## Seven Cultural Principles

Based on Google's culture of collaboration, openness, and blamelessness:

| Principle | Description |
|-----------|-------------|
| **Variable nature of cloud** | Embrace pay-as-you-go variability; fluctuating costs are normal and positive |
| **Business-value decisions** | Don't just cut costs — consider innovation, speed to market, new capabilities |
| **Accountability** | Everyone owns their costs; push decisions to the edge |
| **Collaboration** | Finance, engineering, product work together; break down silos |
| **Blamelessness** | Cost mistakes are learning opportunities, not reasons for finger-pointing |
| **Data democratization** | Data accessible to all; avoid "no access" default policies |
| **Agility** | Iterative approach, continuous improvement, automation at every step |

## FinOps Central Team

- Coordinates cloud financial strategy across the organization
- Drives all Epics across Inform, Optimize, and Operate
- Brings together finance, platform, workload owners
- **NOT** the cost optimization team (common anti-pattern)
- Best placed in a Cloud Adoption Office or Cloud Centre of Excellence

**Structure for the Central Team:**

| Team | Focus Epics |
|------|-------------|
| **FinOps Central Team** | Report, Forecast, Product Efficiency, Measure Value, Educate & Enable |
| **Finance/procurement** | Allocate, Report, Forecast, Pricing Efficiency, Measure Value, Educate & Enable |
| **Platform team** | Allocate, Product Efficiency, Guardrails, Onboard, Incentivize, Educate & Enable |
| **Workload owners** | Report, Pricing Efficiency, Onboard, Incentivize, Educate & Enable |

## Three Phases with GCP Epics

### Inform (Make information visible)

1. **Allocate** — assign all costs to the right teams
   - GCP label strategy (project-level preferred)
   - Shared resources allocation
   - Anomaly detection for unlabeled projects

2. **Report KPI & cost** — transparent data for all
   - GCP billing reports + cost insights dashboard
   - Cost Explorer, billing exports

3. **Forecast** — project future spend
   - GCP billing forecasting reports
   - BigQuery ML custom forecasting

### Optimize (Drive cloud efficiency)

1. **Product efficiency** — use right products efficiently
   - Refactor workloads (e.g., serverless migration)
   - Rightsizing (delete/resize over-provisioned resources)

2. **Pricing efficiency** — get better rates for GCP resources
   - Committed use discounts
   - Preemptible VMs, custom VMs

3. **Guardrails** — control spending
   - GCP budgets & alerts
   - Quotas, capping for sandbox environments

### Operate (Embed FinOps, drive self-sufficiency)

1. **Onboard workloads** — cost-efficient architecture from start
   - Cost reviews in delivery governance
   - Cost estimation during business case creation

2. **Educate & enable** — continuous upskilling
   - Training on cost optimization techniques
   - Enablement through internal wiki, workshops

3. **Incentivize** — reward cost-conscious behavior
   - Gamification, recognition for cost champions
   - Showback and chargeback

4. **Measure value** — show business impact of cloud spend
   - Cloud value scorecards
   - Business KPIs tied to cloud usage

5. **Funding** — align cloud investment with business strategy
   - Cloud investment planning and prioritization
   - Cross-functional investment committee

## Key GCP Tools

- BigQuery billing exports + Cost Insights dashboard
- GCP billing reports and forecasting
- Recommender API (right-sizing, idle resources)
- Budgets and alerts

## Related Wiki Pages

- [[finops]] — overarching FinOps framework
- [[finops-framework-principles|FinOps Principles]] — FinOps Foundation's six principles
- [[guides-and-sensors]] — guardrails as feedback sensors in FinOps
