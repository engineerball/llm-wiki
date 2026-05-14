---
title: "FinOps"
tags: [concept, finops, cloud, cost-management, thai-government]
date: 2026-05-14
sources: ["sources/finops-framework-principles.md", "sources/finops-getting-started-gcp.md", "sources/gcp-finops-hub.md", "sources/finops-atlassian-what-is-finops.md", "sources/finops-personas-finops-foundation.md", "sources/cdv-government-cloud-usage-guideline.md"]
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
- **Principles** — six guiding principles
- **Personas** — roles and responsibilities
- **Phases** — inform → optimize → operate
- **Maturity Model** — crawl → walk → run progression
- **Domains** — spheres of activity
- **Capabilities** — functional areas within domains
- **Scopes** — defined segments of technology spending

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

## GCP FinOps Hub

Google's opinionated implementation of the Inform and Optimize phases in a single dashboard ([[gcp-finops-hub|FinOps Hub docs]]):

- **Optimization Summary** — realized savings (CUDs, right-sizing, idle removal), active recommendation count, potential savings/month, CUD coverage rate
- **FinOps Score** — maturity metric across six dimensions: spend monitoring, tagging, optimization activities, commitments, budgets, automation
- **Peer benchmarking** — compares score against industry-aggregated data (opt-in, daily updated)
- **25+ integrated recommenders** — Compute Engine, GKE, Cloud SQL, Cloud Run, CUD recommenders
- **Wasted Usage widget** (Preview) — underutilized resource identification across compute services
- **Carbon Footprint** (Preview) — GHG emissions estimate from cloud usage

Access: `console.cloud.google.com/billing/optimize` (requires Billing Account Viewer or Administrator)

## FinOps Personas

From the [[finops-personas-finops-foundation|FinOps Foundation Framework]], personas are broad stakeholder groups (not individuals) who collaborate in FinOps practice.

### Core Personas (always involved)
- **Engineering** — build, deploy, operate cloud services; need cost as first-class metric alongside performance
- **Finance** — budget planning, forecasting, cost allocation; need predictability and accountability
- **Procurement** — vendor contracts, rate negotiations, commitments; need optimal pricing terms
- **IT Operations** — infrastructure management, capacity planning; balance reliability vs cost trade-offs
- **Product / Business** — define strategy, manage P&L; connect cloud costs to unit economics
- **Executive / CCoE** — set strategic direction, allocate budget; translate FinOps to business impact

### Allied Personas (intersect as needed)
- **ITAM** — asset discovery, auditing, license management
- **ITFM** — budgeting support, cost accounting, financial analysis
- **Sustainability** — environmental optimization, waste reduction
- **ITSM / ITIL** — service design, SLI/SLO management, change management
- **Security** — anomaly monitoring, policy compliance, identity/access management

The **Intersecting Disciplines** framework capability formalizes where allied personas connect with FinOps.

## FinOps Best Practices (Atlassian)

From the [[finops-atlassian-what-is-finops|Atlassian FinOps guide]], five concrete best practices:

1. **Plan before migration** — design FinOps strategy *before* cloud migration; cloud billing differs fundamentally from on-prem (buy-what-you-need, auto-expire licenses)
2. **Don't sacrifice value for savings** — balance trade-offs; cheapest doesn't equal best value
3. **Calculate actual costs** — TCO and ROI are harder than expected in siloed orgs; forecast regularly
4. **Build it as ongoing practice** — not one-time; set ongoing roles, audits, forecasting
5. **Set clear responsibilities** — If nobody owns it, it goes by the wayside; freed-up IT capacity is a great starting point

The lifecycle (Inform → Optimize → Operate) is iterative — top teams cycle back, they don't just stay in operate.

## FinOps in Thai Government Context (DGS 9-2:2568)

[[dga|DGA Thailand's Digital Government Standard DGS 9-2:2568]] mandates FinOps as the required operating model for all Thai government agencies using cloud under the **"Go Cloud First" (นโยบายการใช้คลาวด์เป็นหลัก)** policy declared by Cabinet on 11 September 2023.

The standard frames FinOps as bridging **IT/DevOps** and **Finance** teams, with four principles adapted from the FinOps Foundation framework for government adoption:

| Thai Government Principle | Description |
|---|---|
| **Visibility & Transparency (การมองเห็น)** | Real-time cost dashboards accessible to all teams; identify unnecessary spend immediately |
| **Collaboration (การทำงานร่วมกัน)** | IT owns resource management; Finance owns budgeting/planning; shared understanding essential |
| **Optimization (การเพิ่มประสิทธิภาพ)** | Remove idle resources, use Spot/Reserved Instances, architect for Auto-scaling |
| **Measure & Plan (การวัดผล)** | KPIs to track savings; forecast future usage from historical data |

**Government-specific constraints on FinOps:**
- Policy mandates **Pay-per-use pricing as the first choice** — agencies must evaluate Pay-per-use before committing to reserved/subscription models. This creates tension with the FinOps Foundation's commitment-based optimisation strategy (Reserved Instances / CUDs), requiring agencies to justify any deviation
- Cloud budget requests submitted via the national **DGA portal** (https://kb.dga.or.th/cloud/) under the Digital Government Integration Budget Programme — each cloud project's costs must be separately itemised
- **TCO analysis** (Total Cost of Ownership) is mandatory for any Private Cloud exception requests, covering full lifecycle from acquisition through decommissioning
- **Not-To-Exceed (NTE) Ceiling** must be established using CSP Pricing Calculators as part of procurement documentation

**Applicable laws:**
- พระราชบัญญัติการบริหารงานและการให้บริการภาครัฐผ่านระบบดิจิทัล พ.ศ. 2562 (Digital Government Administration Act 2019)
- พระราชบัญญัติการจัดซื้อจัดจ้างและการบริหารพัสดุภาครัฐ พ.ศ. 2560 (Government Procurement Act 2017)

→ Details: [[cdv-government-cloud-usage-guideline]]

## Relationship to Other Concepts

- **[[harness-engineering]]** — FinOps principles parallel harness design: centralized enablement + decentralized execution, [[guides-and-sensors]] pattern (budgets as guides, reports as sensors), cost as a first-class metric
- **[[guides-and-sensors]]** — budgets/policies as feedforward guides; cost data/alerts as feedback sensors
- **[[initializer-coding-agent-architecture]]** — similar pattern: initializer sets up constraints and tracking, agents/teams work incrementally within them
- **[[semantic-layer]]** — semantic layer as a guide pattern for business metrics across tools
- **[[finops-foundation]]** — nonprofit that governs the FinOps Framework; source of principles, personas, and maturity model
- **[[dga]]** — Digital Government Development Agency (Thailand); mandates FinOps under Go Cloud First policy
