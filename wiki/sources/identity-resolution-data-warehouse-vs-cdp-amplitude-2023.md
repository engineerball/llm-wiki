---
title: "Identity Resolution: Data Warehouse vs. Customer Data Platform"
tags: [source, cdp, identity-resolution, customer-data, amplitude]
date: 2026-07-27
sources: ["https://amplitude.com/blog/identity-resolution"]
---

# Identity Resolution: Data Warehouse vs. Customer Data Platform

**Source:** Amplitude  
**URL:** https://amplitude.com/blog/identity-resolution

## Main Thesis

A warehouse alone is not a true single source of customer truth unless identity resolution is explicitly designed and operated.
Without identity resolution, customer data remains only partially unified.

## Warehouse vs CDP Framing

The article contrasts two patterns:

- **Warehouse-managed identity resolution** - analysts and engineers write unification logic with joins and materialized views.
- **CDP-managed identity resolution** - deterministic matching happens automatically at or near collection time.

## Key Distinction

The article strongly prefers **deterministic matching** for most personalization and privacy-sensitive use cases.
Probabilistic matching is more flexible, but not sufficiently reliable for many customer experience workflows.

## Design Implication

A data platform that supports a CDP must treat identity resolution as a first-class capability with:

- high-quality identifier capture,
- merge rules,
- cross-source record linking,
- and deletion / consent propagation across resolved identities.

## Relationships

- [[identity-resolution]] - main concept derived from this source
- [[customer-data-platform]] - CDP value depends heavily on strong identity resolution
- [[customer-360]] - unified profiles are downstream products of identity logic
- [[composable-cdp]] - warehouse-native architectures still need explicit identity services or models
