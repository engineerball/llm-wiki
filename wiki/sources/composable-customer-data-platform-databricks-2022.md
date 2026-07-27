---
title: "The Emergence of the Composable Customer Data Platform"
tags: [source, cdp, composable-cdp, databricks, lakehouse, reverse-etl]
date: 2026-07-27
sources: ["https://www.databricks.com/blog/2022/06/24/the-emergence-of-the-composable-customer-data-platform.html"]
---

# The Emergence of the Composable Customer Data Platform

**Source:** Databricks  
**URL:** https://www.databricks.com/blog/2022/06/24/the-emergence-of-the-composable-customer-data-platform.html

## Main Thesis

The composable CDP replaces the monolithic proprietary CDP stack with modular layers for collection, storage/modeling, identity, and activation centered on the lakehouse as the single source of truth.

## Problem With Packaged CDPs

The article argues that many off-the-shelf CDPs create a new customer-data silo.
That leads to rigid data models, redundant storage, long onboarding, and friction between data engineering, analytics, and marketing teams.

## Composable Pattern

The proposed architecture is built from distinct layers:

- **behavioral data creation**,
- **storage and modeling in the lakehouse**,
- **identity stitching**,
- **data activation via Reverse ETL and audience tools**.

## Why It Matters

The lakehouse-native pattern makes customer data:

- more governable,
- reusable across analytics and ML,
- less trapped inside marketing software,
- and easier to evolve as requirements change.

## Relationships

- [[composable-cdp]] - primary concept page for this design pattern
- [[customer-data-platform]] - broader umbrella concept within which composable CDPs are one architecture choice
- [[customer-360]] - one of the major artifacts produced by a composable CDP
- [[identity-resolution]] - one of the hardest capabilities that must still be solved explicitly
