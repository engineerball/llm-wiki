---
title: "Thailand Digital Government Standard — Government Cloud Usage Guideline (DGS 9-2:2568)"
tags: [source, finops, cloud, thai-government, government-cloud, cloud-first-policy, cost-management]
sources: ["raw/articles/cdv-government-cloud-usage-guideline.md"]
date: 2026-05-14
---

# Thailand Digital Government Standard — Government Cloud Usage Guideline (DGS 9-2:2568)

**Standard:** มรด. 9-2:2568 / DGS 9-2:2568 — Version 1.0  
**Issued by:** [[dga|Digital Government Development Agency (DGA)]] — สำนักงานพัฒนารัฐบาลดิจิทัล (องค์การมหาชน)  
**Under authority:** Digital Government Development Committee (คณะกรรมการพัฒนารัฐบาลดิจิทัล)  
**Status:** Draft pending Royal Gazette announcement  
**Reference URL:** https://kb.dga.or.th/cloud/

## What This Is

A binding guideline standard for Thai government agencies on how to adopt cloud computing under the national "Go Cloud First" policy (นโยบายการใช้คลาวด์เป็นหลัก). Covers the full lifecycle: cloud type selection, pricing, migration, budget requests, procurement, FinOps cost management, security, and backup/recovery.

**Policy origin:** Cabinet announcement on 11 September 2023 (วันที่ 11 กันยายน 2566) committed to "Go Cloud First" as a national digital government transformation priority. On 25 June 2024, the Cabinet formally appointed a dedicated committee (คณะกรรมการเฉพาะด้านการขับเคลื่อนตามนโยบายการใช้คลาวด์เป็นหลัก) to implement it.

---

## 1. Cloud Type Selection (Cloud Deployment Models)

The policy defaults to **Public Cloud first** for all new projects from fiscal year 2569 (FY2026) onward, and for any project requiring new servers or renewed contracts.

Selection is driven by **data classification level** (from a companion standard on cloud data classification):

| Data Level | Recommended Cloud Type |
|---|---|
| Public (สาธารณะ), Internal (ใช้ภายใน), Confidential (ลับ) | Public Cloud (Public Cloud) |
| Secret (ลับมาก) and above | Community Cloud (government-owned/controlled) or Sovereign Cloud |
| Secret and above with specific justification | Private Cloud or Hybrid Cloud (requires approval from DGA committee) |

**Four deployment models defined:**

- **Public Cloud** — No infrastructure capex, provider-managed, unlimited scale; limited customisation, provider governance required
- **Private Cloud** — Full control and customisation, high security; high capex and maintenance cost
- **Hybrid Cloud** — Flexible capacity, resilience; integration complexity
- **Community Cloud** — Shared government-sector infrastructure, cost-shared; limited scale flexibility

**Key selection factors:** Security, Scalability/Flexibility, Cost, Management Complexity.

---

## 2. Cloud Service Models (IaaS / PaaS / SaaS)

The standard covers standard NIST definitions and applies government-specific guidance:

| Service Model | Use When | Government Examples | Watch-outs |
|---|---|---|---|
| IaaS | Need full infra control, bespoke systems | Virtual data centres, custom-built apps with no CSP equivalent | Requires expert infra staff; complex security management |
| PaaS | Developing or deploying applications | Database management systems, app development platforms | Vendor migration complexity; must understand platform limits |
| SaaS | Ready-made off-the-shelf software | Email/docs (M365, Google Workspace), CRM, e-Learning | Low customisation; data resides with provider |

**Guideline principle:** Prefer standard managed services from the CSP. Avoid customising (e.g. self-installing a database inside a VM) — it loses provider-managed updates and support.

**Shared Responsibility Matrix (summary):**

| Responsibility Area | On-Prem | IaaS | PaaS | SaaS |
|---|---|---|---|---|
| Application config | Customer | Customer | Customer | Customer |
| Identity & access | Customer | Customer | Shared | Shared |
| App data storage | Customer | Customer | Shared | Provider |
| OS | Customer | Customer | Provider | Provider |
| Physical security | Customer | Provider | Provider | Provider |

Source: NCSC UK Cloud Security Shared Responsibility Model.

---

## 3. Pricing Models

Two primary pricing approaches; **Pay-per-use must be selected first** when available under Cloud First Policy:

| Model | Pros | Cons | Best For |
|---|---|---|---|
| **Pay-per-use** | Pay only what you use; highly flexible; detailed usage tracking | Variable cost; hard to budget forecast; can spike without governance | New projects, variable load, cost-conscious starts |
| **Subscription (Reserved)** | Predictable budgeting; efficiency for stable loads; provider guarantees capacity | Low flexibility; long-term commitment (1–3 yr); overpayment risk if under-used | Stable steady-state workloads with known usage volumes |

Additional pricing variants: Pay-per-Reservation, Hybrid Pricing — understand the specific CSP's offering.

---

## 4. Cloud Migration Strategy (6Rs)

When migrating from on-premise to cloud, agencies select a migration strategy:

- **Rehost** (Lift & Shift) — Move as-is, no code changes
- **Re-platform** — Minor optimisations for cloud (containerisation with Docker/Kubernetes)
- **Repurchase** — Swap to a SaaS alternative
- **Refactor / Re-architect** — Full redesign for cloud-native architecture
- *(Retire and Retain are implied in the 6Rs decision tree)*

**Migration phases:**
1. **Assessment** — Risk assessment + cost comparison (cloud vs keep on-prem)
2. **Strategy selection** — Choose one of the 6Rs per system
3. **Migration and testing** — Incremental data migration + system testing post-move
4. **Post-migration management** — Continuous cost monitoring, performance tuning

---

## 5. Cloud Exit (Anti-Lock-In)

Plan exit strategy from day one. Key principles:
- Specify data return, retention period, portability, and post-cancellation support in the CSP contract
- Design for **interoperability** — store data in transferable formats, avoid proprietary-only services
- Consider Multi-cloud or Hybrid Cloud to avoid single-vendor dependency
- Steps: inventory all cloud assets → backup to trusted storage → migrate to new platform → test integrity → securely delete data from old system

---

## 6. Pricing Assessment & Budget Planning

### Direct Costs (ต้นทุนทางตรง)
Compute (CPU/RAM), Storage, Networking (data transfer), Database, Analytics, Developer Tools, Security tools, Support Plan.

### Indirect / Hidden Costs (ต้นทุนแฝง)
DevOps tooling, monitoring, encryption services, and other services outside the support plan.

### Pricing Calculator Requirement
Agencies must use CSP-provided Pricing Calculators to build a **Not-To-Exceed (NTE) Ceiling** estimate for procurement. Calculators should support: resource customisation, cost comparison across options, transparent cost breakdowns, and multi-year budget planning.

### Cost Monitoring
- Real-time monitoring with billing alerts (email/app notifications when approaching budget thresholds)
- Tag/label resources by project and department for cost attribution
- Cost analysis to identify over-provisioned or idle resources (e.g. VMs running off-hours)

---

## 7. FinOps — Cloud Financial Operations

The standard explicitly introduces **FinOps** (Financial Operations, Fin-ops) as the required operating model for cloud cost governance. References: [[finops-foundation]] and [[finops]].

**FinOps in Thai government context** bridges IT (DevOps) and Finance teams to make budget decisions aligned with actual cloud usage.

**Four FinOps principles per this standard:**

| Principle | Description |
|---|---|
| **Visibility & Transparency (การมองเห็น)** | All teams see real-time cloud costs via dashboards; identify unnecessary spend immediately |
| **Collaboration (การทำงานร่วมกัน)** | IT manages cloud resources; Finance manages budget/planning; shared understanding required |
| **Optimization (การเพิ่มประสิทธิภาพ)** | Shut down unused resources, use Spot/Reserved Instances, architect for Auto-scaling |
| **Measure & Plan (การวัดผล)** | KPIs to measure cost reduction and efficiency; forecast future usage from historical trends |

**TCO — Total Cost of Ownership:** Agencies are required to evaluate full lifecycle cost — acquisition, operation, and decommissioning — not just initial purchase price. TCO applies to both OSS and commercial software.

---

## 8. Budget Request Process

Agencies submit cloud budget requests through the **Digital Government Integration Budget Programme** mechanism. Reference portal: https://kb.dga.or.th/cloud/

Required information includes:
- Project name, rationale, objectives
- Project type (new IT system, server replacement/expansion, contract renewal, software licence renewal)
- Cloud approach (which cloud type, service model: IaaS/PaaS/SaaS)
- Budget line items (IaaS rental, PaaS DevOps tools, SaaS office tools, training, consulting)
- Estimated user scale (pageviews, transaction counts, data volumes)
- System architecture diagram

**If Private Cloud is requested for non-Highly-Protected data** (exception case): must provide data classification result, TCO analysis, security standards alignment (e.g. ISO27001), and IT staff readiness assessment — submitted to DGA for review committee approval.

---

## 9. Procurement

All cloud procurement must follow:
- พระราชบัญญัติการจัดซื้อจัดจ้างและการบริหารพัสดุภาครัฐ พ.ศ. 2560 (Government Procurement Act 2017) — governs e-Bidding and vendor selection
- ระเบียบกระทรวงการคลัง (Ministry of Finance regulations 2017) — procedural detail
- CSP must hold **CSP Tier certification** appropriate to the data classification level (from companion standard on CSP standards)

---

## 10. Security Guidelines

References **มาตรฐานด้านการรักษาความมั่นคงปลอดภัยไซเบอร์ระบบคลาวด์ พ.ศ. 2567** (Cloud Cybersecurity Standard 2024), which becomes mandatory two years after Royal Gazette announcement.

Two security pillars:
1. **Cloud Cybersecurity Governance** — IS policy, organisational structure, legal compliance
2. **Cloud Infrastructure Security & Operations** — Physical/environmental controls, cyber controls, technology controls

For **Public Cloud** specifically: agencies should deploy using **Virtual Private Cloud (VPC)** to isolate resources and gain near-private-cloud control within a public cloud environment.

**Training requirement:** Cloud service consumers must run security awareness programmes for cloud managers, administrators, operators, and end users — including business units.

---

## 11. Backup & Recovery

Shared responsibility: agency (data owner) + CSP.

**Key parameters:**
- **RPO (Recovery Point Objective)** — acceptable data loss window → drives backup frequency
- **RTO (Recovery Time Objective)** — acceptable recovery time window → drives architecture/tools

**Backup types:** Full, Incremental, Differential.

**Storage tiers:** Cold Storage (low cost, long-term) vs Hot Storage (fast access, higher cost). Multi-region storage recommended for disaster resilience.

**Security:** encrypt data in transit and at rest; MFA for access control; comply with PDPA 2019 and GDPR where applicable.

**Recommended tools:** AWS Backup/S3 Versioning/EBS Snapshots, Azure Backup/Site Recovery, Google Cloud Backup, Veeam, Commvault, Druva, Acronis, Rubrik.

---

## Key Entities Referenced

- [[dga]] — Digital Government Development Agency (DGA / สพร.) — issuing authority
- [[finops-foundation]] — FinOps Foundation — referenced as the FinOps framework source
- [[finops]] — FinOps practice as required operating model for Thai government cloud spend

## Related Concepts

- [[finops]] — FinOps practice; this standard mandates FinOps as the operating model for government cloud cost governance
- [[finops-lifecycle]] — Inform → Optimize → Operate; maps to this standard's cost visibility → optimization → KPI measurement cycle

## Contradictions / Gaps vs Existing Wiki

- The standard's **4 FinOps principles** (Visibility, Collaboration, Optimization, Measure & Plan) differ slightly in framing from the FinOps Foundation's 6 principles — this is an intentional simplification for government adoption context, not a contradiction
- The standard mandates **Pay-per-use first** (government policy constraint) vs FinOps Foundation's more neutral stance on commitment-based pricing for cost optimisation — in practice, government agencies will need to balance policy compliance with reserved instance savings
