---
title: "Design Gold Layers with AI in Mind"
tags: [source, semantic-layer, gold-layer, ai-readiness, fabric, microsoft]
date: 2026-05-02
sources: ["https://learn.microsoft.com/en-us/training/modules/fabric-prepare-semantic-layer/3-design-gold-layers"]
---

# Design Gold Layers with AI in Mind

**Source:** Microsoft Learn — Microsoft Fabric training module
**Author:** Angie Rudduck
**URL:** https://learn.microsoft.com/en-us/training/modules/fabric-prepare-semantic-layer/3-design-gold-layers
**Updated:** 2026-05-01

## Overview

A training unit on designing the gold data layer for effective AI Copilot and data agent consumption. Whether built in a lakehouse (Delta tables) or warehouse (SQL tables), the structure and naming conventions directly affect how well AI tools interpret data.

## Core Principles

### 1. Design with Entities in Mind

AI tools work best when tables represent clear business entities:

| Rule | Example |
|------|---------|
| **One entity per table** | Customers, Products, Sales, Stores — not mixed concepts |
| **Star schema** | Dimensions describe entities; facts capture events |
| **Business-friendly names** | `Sales Transactions` not `fact_sales_v2` or `dbo_FactSales` |

When tables represent clear entities with well-defined relationships, AI tools can traverse the model to answer multi-step questions. Example: Copilot follows relationships from `Sales` → `Products` → `Categories` to answer "What was the top product category by revenue?"

### 2. Name for Clarity

Copilot uses table names, column names, and measure names as primary signals when interpreting natural language prompts.

**Column naming:**

| Do This | Not This |
|---------|----------|
| Full words: `Customer Name` | Abbreviations: `CustNm` or `cust_name` |
| Specific: `Order Date` | Generic: `Date` (when multiple dates exist) |
| Include units: `Revenue (USD)` | No units when relevant |
| No prefixes | `dim_` or `fact_` — meaningless to users & AI |
| Consistent | Use same name across tables (e.g., always `Product Name`, never mix `ProductTitle`) |

Measure naming:
- Describe the calculation: `Total Sales` ✓, `TS` ✗
- Include scope: `YTD Revenue`, `Sales (last 12 months)`
- Never use the same name for a measure and a column — confuses both users and AI

### 3. Document for AI Consumption

**Table descriptions** — what the table represents and what records it contains:
> "Contains one row per completed sales transaction, including the product sold, the store location, and the transaction amount in USD."

**Column descriptions** — clarify values and business rules:
> "The unique identifier for each customer account. Assigned at account creation and doesn't change."

**Measure descriptions** — business logic, what's included/excluded:
> "Sum of all completed transaction amounts in USD. Excludes returns, refunds, and canceled orders. Uses the transaction date for time filtering."

**Important:** Descriptions are truncated after 200 characters for AI grounding. Put the most important context at the beginning.

### 4. Simplify for AI Consumption

**Hide from AI:**
- Surrogate keys (`ProductKey`, `CustomerID`) when natural key/name columns exist
- ETL metadata (`LoadDate`, `BatchID`, `SourceSystem`)
- Deprecated/unused columns kept for backward compatibility

**Keep visible:**
- Business-facing columns users reference in questions
- Key business metrics (measures)
- Date table columns for time intelligence

Hiding removes fields from Copilot's grounding surface entirely.

### 5. Linguistic Modeling (Power BI)

Two components to enhance natural language query understanding:

| Component | Purpose |
|-----------|---------|
| **Synonyms** | Map alternate terms to field names (`Revenue` ← `Sales`, `Turnover`, `Income`) |
| **Linguistic relationships** | Define verbs connecting entities (`Customers **buy** Products`, `Stores **are located in** Regions`) |

## Physical vs Semantic Distinction

The gold layer principles (one entity per table, star schema, business names) apply at the **data warehouse** level. The [[semantic-layer]] then builds on top of this clean structure to provide unified metrics, federated queries, and LLM-friendly business context.

## Relationship to [[semantic-layer]]

This training module is specifically about preparing the gold layer for AI Copilot consumption — which is the same pattern as building a [[semantic-layer]]. The naming conventions, entity-orientation, and documentation practices here directly improve LLM accuracy and reduce hallucination.
