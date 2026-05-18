---
title: "Getting Started with FinOps on GCP"
tags: [source, finops, gcp, google-cloud]
date: 2026-05-02
updated: 2026-05-18
sources: ["raw/finops-getting-started-gcp.pdf", "raw/text/finops-getting-started-gcp.md"]
---

# Getting Started with FinOps on GCP

**Source:** Google Cloud Technical Paper (PDF, 49 pages)
**Authors:** Sam Moss, Kinjal Tanna, Tan-Minh Truong
**Date:** May 2021

## Overview

Google Cloud's FinOps framework aligned with the [[finops-framework-principles|FinOps Foundation]] standard. Provides GCP-specific implementation guidance organized around the three phases: Inform, Optimize, Operate — structured as 8 Epics across these phases.

## Scope

Covers: teams required, processes/behaviors to embrace, expected outcomes, GCP-specific tooling for each Epic. Explicitly excludes: security basics, cloud cost management setup, product-specific optimization, and accounting practices.

## When to Start

Start FinOps early — ideally during the first stages of cloud transformation alongside security and IAM setup. Common mistake: waiting until the bill becomes significant. Late adoption leads to "spend panic" (emergency cost freeze that hurts delivery), and entrenched bad practices are harder to change. Start small, iterate through the lifecycle, continuously improve — do not wait for full maturity.

## Seven Cultural Principles

Based on Google's culture of collaboration, openness, and blamelessness. Not phase-specific — these permeate every Epic:

| Principle | Key Insight |
|-----------|-------------|
| **Variable nature of cloud** | Fluctuating costs are normal and positive. A server spinning down = good cost control. Finance must unlearn fixed-cost mindset. |
| **Business-value decisions** | New cloud benefits (innovation, AI/ML, speed to market, staff productivity) outweigh managed-service premium. Don't do like-for-like on-prem comparisons. |
| **Accountability** | Push cost ownership to the edge. Central team surfaces patterns; project teams act on them. Empowerment + accountability together. |
| **Collaboration** | Central team has org-wide cost data but lacks workload context. Teams must share rationale (e.g. "why managed services vs VMs") to bridge the gap. |
| **Blamelessness** | "Make it safe to fail fast." Blameless ≠ no accountability. When mistakes happen: identify cause, anonymize, share org-wide so they don't recur. |
| **Data democratization** | Avoid default "no access" policies. Real-time visibility drives better behavior across all stakeholder levels. |
| **Agility** | Iterative improvement, automation at every step, continuous adjustments over infrequent reactive cleanups. |

## FinOps Central Team

- Coordinates cloud financial strategy; drives all Epics
- Brings together finance, platform, workload owners
- **NOT the cost optimization team** — common anti-pattern that bottlenecks the org
- Best placed in a Cloud Adoption Office or Cloud Centre of Excellence

**Epic responsibilities by team:**

| Team | Focus Epics |
|------|-------------|
| **FinOps Central** | Report, Forecast, Product Efficiency, Measure Value, Educate & Enable |
| **Finance/procurement** | Allocate, Report, Forecast, Pricing Efficiency, Measure Value, Educate & Enable |
| **Platform team** | Allocate, Product Efficiency, Guardrails, Onboard, Incentivize, Educate & Enable |
| **Workload owners** | Report, Pricing Efficiency, Onboard, Incentivize, Educate & Enable |

## Phase 1: Inform — Make Information Visible

Three Epics. The FinOps Foundation 2021 State of FinOps Report found that 3 of the top 4 challenges were allocation (26%), shared costs (33%), and forecasting (26%) — getting Inform right is foundational.

### Epic 1: Allocate

Assign 100% of costs to the right teams in a fair and transparent way.

**Billing accounts:** Multiple GCP projects → one billing account. Best practice: single billing account with internal chargeback mechanisms. (Exception cases: conglomerates, multi-country tax, reseller accounts.)

**Labeling strategy:**
- Labels in GCP tag projects with key-value pairs for cost attribution
- Strategy should follow the org's chargeback mechanism
- **Best practice: label at project level**, not resource level — resource-level labels add complexity
- Apply labels automatically at project creation (e.g. using Cloud Foundation Toolkit, Project Factory module in Terraform) — manual application causes drift and missing data
- Labels drive granular cost categorization in reporting

**Shared resources:**
- Common data stores, multi-tenant clusters, shared services require explicit handling
- Divide shared service costs proportionally across departments
- For specific services, "Requester Pays" charges operational costs to the consumer not the owner
- Best practice: ensure shared services are allocated relative to actual GCP usage

**Anomaly detection:**
- Unlabeled projects = invisible in reports
- Use policy-as-code or CSPM tools (e.g. Forseti Config Validator) to detect labeling violations and configuration drift

### Epic 2: Report KPI & Cost

Make data available, consumable, and actionable for all stakeholders.

**Reports should show:**
- New spending trends
- Largest spenders by project and by product
- Areas of irregular spend
- Anomaly detection
- Trends over time, month-on-month patterns
- Internal benchmarking between teams
- Validation that bills are accurate

**Data sources:**
- Start with raw billing export from BigQuery
- As maturity grows: integrate business metrics (from Measure Value Epic), pipeline metrics, custom KPIs

**GCP tooling:**
- GCP Console Billing Reports (ready-made, comprehensive)
- Cost Insights Dashboard (templatized, surfaced from Recommendations Hub + billing export)
- GCP Billing Visualization Dashboard (pre-built in Data Studio)
- GCP Cost Optimization Dashboard (templatized)

**Best practices:**
- Lowest possible latency for reports — real-time drives better behavior
- Start with centrally maintained dashboards; evolve to team-customizable as maturity grows
- Prioritize correct but incomplete data over large volumes of unreliable data
- Enable alerting on reports (distinct from budget alerts — any notification mechanism)

### Epic 3: Forecast

Project future spend to allow planning and decision-making.

**Two types of forecast data:**
1. Extrapolations from past spend (e.g. workload with 1% MoM growth over 12 months)
2. Projections from known changes (e.g. new workload going into production in 3 months)

**Tooling:**
- GCP Console smart forecasting reports (built on cost history, short-term predictions)
- BigQuery ML + Data Studio for custom models (linear regression, multi-variable)
- Third-party tools for multi-cloud views

**Process:**
- Define what happens when a forecast exceeds or undershoot budget (triggers Optimize phase analysis)
- Reforecast frequently (monthly is a good cadence) — cloud services are ephemeral; forecasts go stale quickly
- Define who monitors the forecast and at what intervals

## Phase 2: Optimize — Drive Cloud Efficiency

Three Epics. Translates Inform outputs into cost reduction actions. Each optimization has a cost (implementation effort) — must be proportional to benefit generated.

### Prioritization Framework

Hold a cross-functional session to Analyze → Prioritize & Target → Implement:

1. **Analyze** (FinOps Central Team) — spend trends, progress against previous targets, anomalies in high-spend projects
2. **Prioritize** (cross-functional: Finance + Engineering + Business) — based on existing spend, business objectives, effort vs benefit ratio
3. **Implement** (workload-dependent team)

**Effort vs Savings matrix:**

| | Low Savings | High Savings |
|---|---|---|
| **Low Effort** | Custom machine types | **CUDs, idle resource cleanup** |
| **High Effort** | BigQuery slots tuning | Re-architecting (serverless, containers) |

→ Start with low-effort/high-savings: CUDs and idle resource removal. High-effort/high-savings (re-architecting to serverless, GKE) is worth pursuing as org matures.

**Target-setting:** Set time-bound, metric-driven targets. Focus on efficiency ratios, not usage reduction:
- Effective: "Average CPU utilization ≥ XX% by Q3" (allows growth, measures efficiency)
- Ineffective: "Reduce Compute Engine usage" (conflates good efficiency with concerning under-migration)

**Cadence:** Start with monthly optimization sessions. Increase frequency as practices mature; eventually becomes continuous without FinOps Central Team involvement.

### Epic 4: Product Efficiency

Optimize how GCP products are used — right product, right usage:

**Refactoring workloads:**
- Consider whether the right product is being used before tuning it
- Serverless products (Cloud Storage, App Engine, BigQuery, Cloud Functions) that scale to zero eliminate idle spend
- Define per-product efficient usage standards (e.g., BigQuery: avoid `SELECT *` on large tables since billing is per-data-processed)
- Use GCP Pricing Calculator to compare hypothetical architectures

**Rightsizing:**
- Identify over-provisioned instances (50 VMs at 15% utilization → fewer instances at 70%)
- GCP Rightsize Recommender provides specific recommendations for resizing without performance loss
- Re-architect for dynamic auto-scaling where possible: Managed Instance Groups on Compute Engine, GKE for containerized workloads

### Epic 5: Pricing Efficiency

Reduce the rate paid for equivalent resources:

| Discount Type | Best For |
|---|---|
| **Committed Use Discounts (CUDs)** | Stable baseline workloads; purchase committed usage contracts for deeply discounted VM rates; Shared CUDs allow multiple projects to consume one contract |
| **Preemptible VMs** | Fault-tolerant, time-flexible workloads; significant discount, no availability guarantee |
| **Custom VMs** | Known exact workload size; tailor machine type to specific CPU/memory needs |

Note: discounts are less important at low GCP usage levels. As usage grows, they represent increasingly significant savings and should be actively pursued.

### Epic 6: Guardrails

Passive controls that limit spending without requiring continuous human intervention:

| Control | Mechanism |
|---|---|
| **Budgets** | Track actual spend against planned spend; define per-department or per-project |
| **Alerts** | Threshold rules triggering email notifications when approaching budget limits |
| **Capping** | Absolute resource consumption limits; varies by product; use for sandbox/training environments **only** — capping removes all resources and data from the project |
| **Quotas** | Hard limits on resource types per project/location; guard against malicious use or misuse |

Best practices:
- Apply default high-water-mark budgets+alerts to all projects to catch extreme overspend
- Devolve budget maintenance to workload teams so budgets reflect current reality
- Apply capping only where blocking usage has negligible business impact (sandbox, dev environments)

## Phase 3: Operate — Embed FinOps

Five Epics. Goal: make FinOps the new normal — not a periodic optimization exercise but a continuous operating model embedded in all processes.

### Epic 7a: Onboard Workloads

Insert FinOps into the delivery lifecycle from the start:

- **Architecture reviews with cost criteria** — add cost reviews to existing delivery governance (security, architecture checkpoints); teams must demonstrate cost consideration and sound business rationale before production
- **Cost estimation in business cases** — estimate dev/test/prod costs as part of the project plan; feeds into FinOps forecasting and Finance budgeting
- **Volume & performance testing** — validate running costs during load testing, not just post-production
- **Update Operational Acceptance Criteria** — formally include cost efficiency as an acceptance gate alongside reliability and security

FinOps Central Team role at onboarding:
- Recommend relevant training and internal guidance for the workload type
- Set expectations for ongoing interactions (anomaly reports, lessons-learned sharing)
- Document cost-efficient patterns from similar workloads for re-use

### Epic 7b: Educate & Enable

Continuous upskilling so teams can make cost-conscious decisions independently:

**Learning services** (Why and How):
- Why: cost of wastage, impact of inefficiency
- How: optimize resources, use cost dashboards, new cost-efficient technologies

GCP training resources:
- "Understanding your GCP costs" (Coursera)
- "Optimizing your GCP costs" (Coursera)
- Custom tailored programs for specific tech (e.g., "BigQuery for engineers in our org")

**Enablement services** — enabling collaboration and adoption at scale:
1. FinOps portal/knowledge base: best practices, team introduction, lessons learned
2. Architectural pattern library: crowd-sourced cost-efficient patterns in version-controlled repo
3. FinOps community space: cross-functional collaboration forum
4. Regular communications: newsletter/digest tailored by audience (executive vs engineer)
5. Access to external GCP events: Google Cloud Next, GCP YouTube, webinars

Best practices:
- Identify cost champions across major business units; get them to host internal events
- Recognize contributions publicly (community channels, company-wide meetings)
- Maintain the portal as searchable, up-to-date, single source of FinOps knowledge

### Epic 7c: Incentivize

Motivate teams to optimize costs in proportion to the value their workload provides:

**Incentive mechanisms (examples):**
- Reinvest saved costs into the team's own change budget — creates direct alignment
- Gamify Epics; compare KPI performance across teams (friendly competition, open culture)
- Pattern attribution: teams that create reusable cost-saving patterns get recognition when other teams use them
- Feature teams/individuals in newsletters and company-wide communications
- Maintain a central discretionary budget to fund changes with org-wide benefit (e.g., reusable pattern a single team can't justify alone)
- **Showback** — pay the cost centrally but make it visible to the team that generated it; creates awareness without chargeback friction

Rules must be clear, transparent, and publicly available to drive expected behaviors.

### Epic 7d: Measure Value

Determine whether workloads justify their cost — connects cloud spending to business outcomes.

**Unit Economics:** Express cost in terms meaningful to each team's actual business goal. Examples:
- E-commerce: cost per unique site visit × conversion rate → cost to generate $1 of revenue
- SaaS product: $X cloud cost per daily active user → inform pricing and infrastructure trade-offs
- Restaurant chain: "$20,000 in idle VMs = 4,000 pizzas" — makes abstract waste concrete

**Two types of value metrics:**
1. **Centralized value metrics** (owned by FinOps + business leaders)
   - Single source of truth for business value assessment
   - Inform funding decisions (see Funding Epic)
   - Example: "$40,000/month → $4 per daily user"
2. **Team-based value metrics** (owned by FinOps for specific behavioral change)
   - Designed to motivate targeted improvement in a team
   - Example: highlight high wastage in terms the team relates to
   - Warning: do NOT incentivize raw cost reduction — it can shift costs elsewhere or limit growth

### Epic 7e: Funding

Align investment decisions with cloud value data:

**Evolve individual workload business cases:**
- Go beyond hosting cost comparisons (on-prem vs cloud)
- Include: increased availability, reduced TTM, staff productivity, risk reduction
- Forecast value against centralized value metrics

**Build enterprise-wide cloud business cases** for:
- Migrating all apps underlying a business service
- Environment agility (spinning up full-company test environment for major changes)
- Data center exits
- License/vendor lock-in reduction

**Portfolio investment management:**
- Use granular value data to make frequent investment decisions: accelerate high-value workloads, inject funding into proven services, redirect optimization effort where needed most
- FinOps enables a continuous portfolio review rather than annual planning

## Closing the Loop

After each complete iteration, the lifecycle restarts with improved practices and higher maturity. At the end of each cycle:

**Communicate FinOps value** to secure ongoing investment for the Central Team and practices:
- Show comparison between similar business units — one FinOps-mature, one not — to demonstrate impact and drive remediation
- Show risk mitigation value: e.g. multi-region redundancy reduces downtime probability + regulator fine risk + customer complaint volume — all with dollar estimates

Effective FinOps requires ongoing sponsorship. Making value visible keeps it funded.

## GCP Tool Reference

| Tool | Use |
|------|-----|
| BigQuery billing export | Raw billing data for custom analysis |
| GCP Console Billing Reports | Ready-made spend visibility |
| Cost Insights Dashboard | Templatized reporting + recommender insights |
| Billing Visualization Dashboard (Data Studio) | Customizable reporting |
| Rightsize Recommender | VM sizing optimization |
| CUD Recommender | Commitment purchasing suggestions |
| Recommender API | All 25+ recommendation types |
| Cloud Foundation Toolkit / Project Factory | Label automation at project creation |
| BigQuery ML | Custom forecast models |
| Forseti Config Validator | Label compliance / policy-as-code |
| GCP Budgets & Alerts | Guardrails |

## Related Wiki Pages

- [[finops]] — overarching FinOps framework
- [[finops-lifecycle]] — concept page: Inform → Optimize → Operate
- [[finops-framework-principles|FinOps Principles]] — FinOps Foundation's six principles
- [[gcp-finops-hub]] — GCP's dashboard implementation of Inform + Optimize
- [[unit-economics-finops]] — unit economics as a FinOps measurement pattern
- [[guides-and-sensors]] — guardrails (Guardrails Epic) as feedback sensors
