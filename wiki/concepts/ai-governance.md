---
title: "AI Governance"
tags: [concept, ai-governance, responsible-ai, risk-management, compliance, ai-management-system]
sources: ["sources/ai-governance-databricks-2026.md", "sources/iso-iec-42001-pecb-2026.md", "sources/nist-ai-rmf-2023.md", "sources/eu-ai-act-oecd-ai-principles-2026.md"]
date: 2026-09-10
---

# AI Governance

AI governance is the organizational system of decision rights, policies, processes, controls, evidence, and oversight used to direct and control AI systems across their lifecycle.

It governs the complete sociotechnical system - data, prompts, models, workflows, people, tools, downstream decisions, and operating context - rather than treating the model as the only object of control.

## Why Organizations Need It

AI governance addresses fragmented ownership, shadow AI, unclear use-case boundaries, sensitive data exposure, bias, weak auditability, untracked model changes, unsafe outputs, regulatory obligations, and production incidents.

Good governance is not only a compliance activity.
It can reduce rework, clarify accountability, improve trust, and make responsible scaling of AI more predictable.

## Operating Model

A practical enterprise model has two layers:

1. **Central governance function** - defines policy, risk taxonomy, minimum controls, standard artifacts, escalation paths, training, regulatory watch, and assurance.
2. **Federated domain teams** - own local AI systems, apply controls, maintain evidence, monitor production behavior, and remain accountable for business outcomes.

A cross-functional AI governance committee should include business owners, product or delivery, data and AI engineering, security, privacy, legal/compliance, risk, and internal audit where appropriate.

Every AI use case needs a named accountable owner.
RACI should distinguish who is accountable for business outcomes, who approves risk, who operates controls, who can override or stop the system, and who is consulted or informed.

## Risk-Based Lifecycle

### 1. Inventory and intake

Maintain an inventory of AI systems and experiments.
Record purpose, owner, provider or model version, data categories, users, jurisdictions, downstream decisions, dependencies, and deployment status.

### 2. Define intended and prohibited use

Document what the system is designed to do, what it must not do, who may use it, and which decisions it may influence.
Reassess when scope, users, data, model, or decision context changes.

### 3. Classify risk

Risk classification should consider affected people, decision impact, data sensitivity, autonomy, reversibility of harm, human intervention, scale, jurisdiction, and failure consequences.
Risk tier should determine documentation depth, approval authority, testing, human oversight, monitoring frequency, and incident severity.

### 4. Assess and design controls

Assess fairness, privacy, security, robustness, reliability, explainability, misuse, supply-chain, copyright, safety, and operational risks.
Select preventive, detective, and corrective controls.

### 5. Evaluate and approve

Define evaluation metrics, thresholds, representative test data, known limitations, unacceptable failure modes, and trade-offs before release.
Require named owner, completed evidence, and risk-tier approval.
Define rollback or shutdown criteria before production.

### 6. Deploy and monitor

Monitor performance, drift, data changes, unexpected inputs or outputs, access, usage outside intended scope, safety events, and control effectiveness.
Keep logs and change records that support traceability and audit.

### 7. Respond and improve

Use an AI incident process covering detection, classification, containment, communication, root-cause analysis, remediation, post-incident review, and updates to risk assessments and controls.

## Minimum Governance Artifacts

- AI use-case inventory record
- system purpose, scope, intended and prohibited use summary
- data source, ownership, consent, quality, and limitation record
- risk assessment and risk-tier decision
- model or application evaluation summary
- human-oversight and escalation plan
- security and privacy assessment
- release approval and rollback plan
- monitoring and review plan
- incident and remediation record
- change history and audit evidence

## Relationship to Frameworks and Standards

- [[iso-iec-42001]] provides the management-system lens for establishing, implementing, maintaining, and continually improving an AIMS.
- [[nist-ai-risk-management-framework]] provides a voluntary risk-management reference for trustworthy AI across design, development, use, and evaluation.
- [[eu-ai-act-oecd-ai-principles-2026|EU AI Act and OECD AI Principles]] combines a legal risk-based reference with international values-based principles; the EU AI Act must be assessed for applicability by jurisdiction and role.
- [[databricks-ai-governance-best-practices]] contributes practical operating guidance on ownership, lifecycle gates, centralized-federated execution, monitoring, and standardized artifacts.

## Implementation Sequence

1. Establish executive sponsorship and a cross-functional governance owner.
2. Inventory existing AI, including experiments and shadow AI.
3. Define risk taxonomy and minimum evidence by tier.
4. Pilot the process on a small number of high-impact systems.
5. Integrate gates into procurement, data access, model development, release, change management, and incident response.
6. Train teams and provide reusable templates.
7. Measure control adoption, review quality, incidents, drift, exceptions, and time to approval.
8. Improve the AIMS and governance controls through management review and lessons learned.

## Important Distinctions

AI governance is broader than model governance.
Model governance focuses on model development and performance, while AI governance also includes use context, people, data, application logic, tools, decisions, and organizational accountability.

ISO/IEC 42001 is a management-system standard.
A PECB training or individual certificate is not the same as organizational certification to ISO/IEC 42001.
NIST AI RMF is voluntary guidance.
The EU AI Act is law with applicability and enforcement questions that must be assessed separately.
