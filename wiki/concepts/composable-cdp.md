---
title: "Composable CDP"
tags: [concept, cdp, data-engineering, martech, lakehouse, reverse-etl]
date: 2026-07-27
sources: ["sources/composable-customer-data-platform-databricks-2022.md", "sources/actionable-customer-360-snowflake-hightouch-2023.md", "sources/cdp-architecture-aws-2022.md"]
---

# Composable CDP

A **Composable CDP** is a customer data platform built from modular layers rather than a single proprietary all-in-one system.
Its central idea is that customer data should remain on the organization's main data foundation - typically a warehouse or lakehouse - while collection, identity resolution, audience building, and activation are composed around it.

## Core Idea

Traditional packaged CDPs often bundle storage, identity, segmentation, and activation into a black-box product.
A composable CDP keeps these capabilities separable.

Typical layers include:

- event collection,
- raw and modeled storage,
- identity resolution,
- customer profile materialization,
- audience building,
- and activation to downstream systems.

## Why Teams Choose It

The main advantages are:

- the warehouse or lakehouse remains the system of truth,
- customer data is not duplicated into yet another silo,
- data engineering, analytics, marketing, and ML teams can work from the same foundation,
- architecture can evolve without replacing the whole stack,
- and governance stays closer to the core data platform.

## What It Requires

A composable CDP is not "free flexibility."
It requires real platform maturity:

- governed event collection,
- explicit identity resolution logic,
- robust profile modeling,
- activation tooling,
- and strong privacy operations.

Without these, composable CDP can degrade into a pile of loosely connected tools.

## Relationship to [[customer-data-platform]]

A composable CDP is an architectural style for implementing a [[customer-data-platform]].
It keeps the core CDP functions - unification, identity resolution, and activation - but changes where and how they are implemented.

## Relationship to [[customer-360]]

The [[customer-360]] is one of the main outputs of a composable CDP.
The difference is that the 360 profile is modeled on the governed data platform rather than trapped inside a vendor's proprietary storage.

## Relationship to [[identity-resolution]]

Composable CDPs do not remove the hard part of identity.
They make it more visible.
Identity resolution still needs carefully designed identifiers, merge rules, and governance.

## Relationships

- [[customer-data-platform]] - broader concept; composable CDP is one implementation pattern
- [[customer-360]] - major artifact produced by composable CDP design
- [[identity-resolution]] - central capability that determines profile quality
- [[semantic-layer]] - related pattern where business-friendly access is separated from raw physical data structures
