---
title: "GCP FinOps Hub"
tags: [source, finops, gcp, google-cloud, cost-optimization]
date: 2026-05-06
sources: ["https://docs.cloud.google.com/billing/docs/how-to/finops-hub"]
---

# GCP FinOps Hub

**Source:** Google Cloud Documentation
**URL:** https://docs.cloud.google.com/billing/docs/how-to/finops-hub
**Access:** `console.cloud.google.com/billing/optimize`

## Overview

FinOps Hub is a cost optimization dashboard within Google Cloud Billing that consolidates savings tracking, optimization recommendations, and performance metrics. Built on historical usage data + Google Cloud Recommender. Represents GCP's opinionated implementation of the [[finops-lifecycle|FinOps Lifecycle]] Inform and Optimize phases.

## Key Components

### Optimization Summary

Snapshot at the top of the hub:

| Metric | What It Shows |
|--------|---------------|
| Last month's realized savings | Actual savings from CUDs, right-sizing, idle removal |
| Active Recommendations | Count of available optimization suggestions |
| Potential savings/month | Total if all recommendations applied |
| CUD optimization rate | % of CUD-eligible usage covered by commitments |
| Gemini Cloud Assist insights | AI-generated top recommendations (if enabled) |

### FinOps Score

Performance metric across six areas of cost management maturity:

1. Active spend monitoring via Cloud Billing tools
2. Resource tagging and cost allocation
3. Optimization activities (idle removal, right-sizing)
4. Commitment purchasing (CUDs)
5. Budget creation and monitoring
6. Automation (BigQuery exports and APIs)

Includes **peer benchmarking** — compares against anonymized industry-aggregated data. Updated daily with 2-day lag. Billing Account Administrator can opt out (takes 2–4 days to reflect).

### Dashboards and Widgets

| Widget | Description |
|--------|-------------|
| Potential Savings/Month Chart | Monthly savings by service or project with drill-through to recommendations |
| Top Recommendations | 10 highest-impact optimization opportunities with estimated savings |
| Potential Wasted Usage (Preview) | Underutilized resources across Compute Engine, GKE, Cloud SQL, Cloud Run |
| Last Month's Realized Savings | Breakdown of actual savings by service |
| Carbon Footprint (Preview) | Estimated greenhouse gas emissions from cloud usage |

## Integrated Recommenders (25+)

| Category | Recommenders |
|----------|-------------|
| **CUD** | Resource-based and spend-based commitment purchasing |
| **Compute Engine** | Idle images, IPs, disks, VMs, reservations; machine type optimization |
| **GKE** | Cluster and workload utilization optimization |
| **Cloud SQL** | Idle and over/underprovisioned instances |
| **Cloud Run** | CPU allocation optimization |
| **General** | Unused project identification |

## Optimization Practices

Four main approaches surfaced by the hub:
- Shutting down idle resources
- Right-sizing instances
- Configuration optimization for specific resources
- Purchasing committed use discounts (CUDs)

## IAM and Permissions

### Access FinOps Hub

Predefined roles on Cloud Billing account:
- `Billing Account Viewer`
- `Billing Account Administrator`

Or custom role with:
- `billing.accounts.get`
- `billing.accounts.getSpendingInformation`
- `billing.finOpsBenchmarkInformation.get`
- `billing.finOpsHealthInformation.get`
- `recommender.costRecommendations.listAll`

### View and Apply Recommendations

- `Project Viewer` role on target projects
- `Recommender Viewer` on the billing account
- Recommender-specific permissions for implementation

### Peer Benchmark Participation

- `Billing Account Administrator` role
- `dataprocessing.groupcontrols.update` permission

## Caveats and Limitations

- Realized savings **exclude** idle resource shutdowns
- May show negative values for underutilized commitments
- Estimated savings use custom contract or list pricing based on permissions
- Savings calculations don't account for existing applicable CUDs
- Peer benchmark data has 2-day lag, updated daily

## Related Wiki Pages

- [[finops]] — FinOps practice and operating model
- [[finops-lifecycle|FinOps Lifecycle]] — Inform → Optimize → Operate framework
- [[finops-getting-started-gcp|Getting Started with FinOps on GCP]] — broader GCP FinOps implementation (CUDs, labels, BigQuery exports, budgets)
- [[finops-framework-principles|FinOps Framework Principles]] — Foundation's six principles
- [[google|Google]] — parent organization
