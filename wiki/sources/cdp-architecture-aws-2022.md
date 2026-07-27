---
title: "An overview and architecture of building a Customer Data Platform on AWS"
tags: [source, cdp, data-platform, aws, architecture, governance]
date: 2026-07-27
sources: ["https://aws.amazon.com/blogs/architecture/overview-and-architecture-building-customer-data-platform-on-aws/"]
---

# An overview and architecture of building a Customer Data Platform on AWS

**Source:** AWS Architecture Blog  
**URL:** https://aws.amazon.com/blogs/architecture/overview-and-architecture-building-customer-data-platform-on-aws/

## Main Thesis

A scalable CDP should be designed as a layered, data-lake-centric platform with clear separation between ingestion, processing, storage, governance, cataloging, and consumption.

## Core Architectural Pattern

AWS frames the CDP as six logical layers:

1. **Ingestion** - internal and external sources, batch and streaming.
2. **Processing** - validation, normalization, identity resolution, segmentation, ML.
3. **Storage** - raw, clean, and curated zones.
4. **Unified governance and security** - encryption, masking, access control, auditing, compliance.
5. **Cataloging** - metadata, schema tracking, discoverability.
6. **Consumption** - analytics, collaboration, activation.

## Important Storage Design

The storage layer is explicitly split into:

- **Raw zone** for immutable source data,
- **Clean zone** for first-pass quality and format normalization,
- **Curated zone** for identity-resolved, enriched, activation-ready subject data.

This makes replay, compliance, and future re-modeling possible.

## Important Governance Point

The article treats privacy and governance as first-class architectural concerns, not add-ons.
It explicitly calls out encryption, secrets management, fine-grained access controls, PII masking, auditing, retention, and compliance frameworks.

## Relationships

- [[customer-data-platform]] - broad concept page for what a CDP is and why it matters
- [[composable-cdp]] - this layered architecture is a foundation for composable CDP design
- [[identity-resolution]] - one of the central processing-layer responsibilities
- [[customer-360]] - a major output of the curated zone
