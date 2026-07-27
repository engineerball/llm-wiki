---
title: "Identity Resolution"
tags: [concept, cdp, identity-resolution, data-engineering, customer-data]
date: 2026-07-27
sources: ["sources/identity-resolution-data-warehouse-vs-cdp-amplitude-2023.md", "sources/kafka-and-cdps-twilio-2021.md", "sources/cdp-architecture-aws-2022.md"]
---

# Identity Resolution

**Identity Resolution** is the process of linking fragmented customer records from different touchpoints into a coherent, persistent identity.
For most CDP architectures, this is the single capability that most strongly determines whether personalization and activation are trustworthy or misleading.

## Why It Matters

A warehouse full of customer events is not yet a usable customer truth.
Without identity resolution, the organization may have many records about the same person but no reliable way to know that they belong together.

This is why poor identity resolution leads to:

- duplicate or split customer profiles,
- wrong personalization,
- broken attribution,
- and incomplete deletion or consent handling.

## Deterministic vs Probabilistic

### Deterministic

Deterministic matching links records using explicit identifiers such as:

- email,
- phone number,
- account ID,
- loyalty number,
- authenticated user ID.

This is usually the preferred foundation for marketing activation and privacy-sensitive use cases.

### Probabilistic

Probabilistic matching infers likely identity overlap from softer signals such as device, IP, location, or behavior.
It can be useful in some analytical or fraud contexts, but is riskier for direct personalization because it introduces guesswork.

## Architectural Implication

A platform that supports a CDP should treat identity resolution as a first-class system with:

- identifier capture strategy,
- merge and split rules,
- identity graph or equivalent linking model,
- survivorship logic for profile fields,
- provenance and explainability,
- and deletion / suppression propagation.

## Relationship to [[customer-360]]

The [[customer-360]] is the downstream product.
Identity resolution is the process that determines whether the 360 is a coherent person, account, or household rather than a stitched fiction.

## Relationship to [[customer-data-platform]]

A [[customer-data-platform]] is valuable largely because it combines data unification with identity resolution and activation.
If identity resolution is weak, the rest of the CDP stack becomes an amplifier for bad assumptions.

## Relationships

- [[customer-data-platform]] - broader system where identity resolution is a core capability
- [[customer-360]] - resolved identities become profile objects used for analytics and activation
- [[composable-cdp]] - composable architectures still need explicit identity services and rules
- [[customer-data-platform#Three Core Functions]] - identity resolution is one of the three non-negotiable CDP functions
