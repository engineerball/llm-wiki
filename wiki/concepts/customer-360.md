---
title: "Customer 360"
tags: [concept, cdp, customer-data, customer-360, data-platform]
date: 2026-07-27
sources: ["sources/actionable-customer-360-snowflake-hightouch-2023.md", "sources/cdp-architecture-aws-2022.md", "sources/composable-customer-data-platform-databricks-2022.md"]
---

# Customer 360

A **Customer 360** is a unified, activation-ready representation of a customer built from data across multiple touchpoints, systems, and interaction histories.
It is one of the main end products that a CDP-supporting data platform is expected to produce.

## What It Contains

A Customer 360 often combines:

- behavioral events,
- transactional history,
- CRM attributes,
- support interactions,
- channel engagement,
- consent state,
- computed traits and scores,
- and audience memberships.

## What Makes It Useful

A Customer 360 is useful when it is:

- identity-resolved,
- governed,
- explainable,
- sufficiently fresh for its use case,
- and exposed in forms that both humans and systems can use.

This usually means the platform needs more than one serving shape:

- analytical views for BI,
- profile tables for segmentation,
- and lower-latency serving layers or APIs for real-time personalization.

## Relationship to [[identity-resolution]]

A Customer 360 is only as good as the identity logic beneath it.
If the identity layer merges the wrong records or fails to connect real ones, the 360 becomes misleading.

## Relationship to [[composable-cdp]]

In a [[composable-cdp]], the Customer 360 is modeled on the warehouse or lakehouse rather than being trapped in a proprietary application store.
That makes it easier to reuse across marketing, analytics, service, and ML use cases.

## Relationship to [[customer-data-platform]]

The Customer 360 is the most visible artifact of a [[customer-data-platform]].
It turns scattered data into something profiles, audiences, and downstream tools can act on.

## Relationships

- [[customer-data-platform]] - system responsible for building and activating unified customer profiles
- [[identity-resolution]] - prerequisite capability for making the 360 coherent
- [[composable-cdp]] - architecture pattern that centers 360 modeling on the data platform
- [[semantic-layer]] - analogous pattern for metrics and business definitions rather than customer identities
