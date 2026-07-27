---
title: "What is analytics engineering?"
tags: [source, analytics-engineering, analytics-engineer, dbt, modern-data-stack, data-team]
date: 2026-07-27
sources: ["https://www.getdbt.com/blog/what-is-analytics-engineering"]
---

# What is analytics engineering?

**Source:** dbt Labs Blog  
**URL:** https://www.getdbt.com/blog/what-is-analytics-engineering

## Core Definition

Analytics engineers create **clean, transformed, tested, documented, code-reviewed datasets** for end users.
They sit between classic data engineering and classic analytics work.
Rather than spending most of their time producing one-off analyses, they shape warehouse data into reusable assets that let business users and analysts answer their own questions reliably.

> Analytics engineers provide clean data sets to end users, modeling data in a way that empowers end users to answer their own questions.

## How the Role Differs from a Data Analyst

The article frames the difference this way:

- **Data analyst**: analyzes existing data to answer business questions.
- **Analytics engineer**: transforms, tests, deploys, and documents data so those questions can be answered repeatedly and consistently.

The shift is from ad hoc query production toward **reusable analytical infrastructure**.

## Signature Problems Analytics Engineers Care About

dbt's framing is especially useful because it defines the role by the kinds of questions people obsess over:

- Can one well-modeled table answer a whole class of business questions?
- What naming conventions make warehouse models understandable?
- How do we detect bad data *before* a stakeholder sees a broken dashboard?
- What documentation does another analyst need in order to use this model safely?
- How do we fix data quality earlier in the pipeline instead of cleaning everything downstream?

This is a good shorthand for spotting the role in practice: analytics engineers optimize for **clarity, trust, reuse, and self-service**.

## Why the Role Emerged

The article ties the emergence of analytics engineering to changes in the modern data stack:

- Cloud warehouses made compute/storage fast and cheap.
- Managed ingestion tools made loading raw data easy.
- BI tools improved self-service for business stakeholders.
- The remaining bottleneck became the gap between raw warehouse data and trusted, analysis-ready business models.

This gap was previously filled awkwardly by either:
- BI-tool-specific modeling hacks, or
- waiting in a data engineering queue.

dbt is presented as the enabling technology that made this middle layer workable and scalable.

## The Modern Data Team View

dbt describes a common early-stage pattern where one person effectively owns most of the stack:

- configure ingestion,
- maintain the warehouse,
- build SQL transformations,
- and support reporting.

That person is neither a classic data engineer nor a pure analyst.
That hybrid role is what the industry started calling the **analytics engineer**.

## Responsibilities

The article lists a recurring set of responsibilities:

- transform data in SQL,
- test model quality,
- document datasets,
- maintain naming and modeling conventions,
- collaborate with business users,
- and apply software-engineering practices such as Git, code review, version control, and CI to analytics work.

## Relationships

- [[analytics-engineer]] — concept page for the role summarized here
- [[dbt-labs]] — company most associated with formalizing the role
- [[semantic-layer]] — downstream layer that benefits from clean, well-modeled business data
- [[metrics-as-code]] — adjacent pattern where business logic becomes version-controlled analytics code
