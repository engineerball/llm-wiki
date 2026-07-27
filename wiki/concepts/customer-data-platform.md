---
title: "Customer Data Platform (CDP)"
tags: [concept, cdp, data-engineering, customer-data, identity-resolution, martech]
date: 2026-07-27
sources: ["sources/cdp-comparison-2026.md", "sources/cdp-architecture-aws-2022.md", "sources/kafka-and-cdps-twilio-2021.md", "sources/identity-resolution-data-warehouse-vs-cdp-amplitude-2023.md", "sources/composable-customer-data-platform-databricks-2022.md", "sources/actionable-customer-360-snowflake-hightouch-2023.md"]
---

# Customer Data Platform (CDP)

A **CDP** is a data platform capability that unifies customer data across touchpoints, resolves fragmented identities into persistent profiles, and activates those profiles into downstream systems.
The modern architectural debate is no longer just whether to have a CDP, but whether the CDP should be a proprietary silo or a capability layer built on the organization's main data platform.

## Three Core Functions

| Function | What It Does | Why It Matters |
|----------|-------------|---------------|
| **Unification** | Ingests data from web, mobile, CRM, support, commerce, POS, and other sources into a coherent foundation | Creates the raw material for a usable customer view |
| **Identity Resolution** | Links identifiers and records into persistent customer-level profiles | Prevents personalization and attribution from being built on fragmented or fictional identities |
| **Activation** | Pushes audiences, traits, and profile data into downstream tools and workflows | Turns customer understanding into operational action |

## CDP as a Platform Problem

A CDP is not just a marketer-facing UI.
It is also a platform design problem spanning:

- event collection,
- storage architecture,
- identity services,
- profile modeling,
- governance,
- and downstream delivery.

This is why many modern teams treat CDP as an extension of the warehouse or lakehouse rather than as a separate product silo.

## Packaged vs Composable CDP

| Type | Architecture | Pros | Cons |
|------|-------------|------|------|
| **Packaged** | All-in-one proprietary storage and application stack | Faster initial rollout, simpler for standard use cases | Creates another data silo, limits flexibility, increases lock-in |
| **Composable / Warehouse-Native** | Uses the existing governed data platform for storage and modeling | Better reuse, governance, extensibility, and cross-team alignment | Requires stronger platform engineering and clearer ownership |

## What a CDP-Supporting Data Platform Needs

Across the sources, the recurring design requirements are:

1. **Standardized data collection** with schemas or data contracts.
2. **Immutable raw landing zones** and replay-friendly storage.
3. **Processing layers** for normalization, enrichment, and segmentation.
4. **First-class identity resolution** with deterministic identifiers as a core foundation.
5. **Customer 360 modeling** that exposes usable profiles, traits, and audiences.
6. **Activation infrastructure** that decouples collection from downstream delivery.
7. **Governance and privacy controls** for masking, consent, retention, lineage, and deletion.

## Relationship to [[identity-resolution]]

Identity resolution is not just one feature in the CDP.
It is the capability that determines whether the entire system is trustworthy.

## Relationship to [[customer-360]]

A [[customer-360]] is one of the main outputs of a CDP.
It is the profile layer that downstream tools and teams actually consume.

## Relationship to [[composable-cdp]]

A [[composable-cdp]] is an implementation style for a CDP where the warehouse or lakehouse remains the source of truth and modular tools provide collection, modeling, and activation capabilities around it.

## Relationship to [[semantic-layer]]

Both the CDP and [[semantic-layer]] translate raw technical data into business-usable form.
A semantic layer translates raw data into trusted metrics and dimensions.
A CDP translates fragmented customer data into unified identities, profiles, and activation-ready segments.

## Relationship to [[agentic-ai-system]]

Customer profiles can serve as high-value business context for data and personalization agents within an [[agentic-ai-system]].
A well-designed CDP therefore becomes part of the knowledge and action substrate for AI-native customer systems.
