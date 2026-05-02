---
title: "FinOps Principles"
tags: [source, finops, cloud]
date: 2026-05-02
sources: ["raw/text/finops-framework-principles.md"]
---

# FinOps Principles

**Source:** FinOps Foundation — FinOps Framework
**URL:** https://www.finops.org/framework/principles/
**Fetched:** 2026-05-02

## Overview

The FinOps Principles act as a north star for FinOps practice. Six principles (in no particular order) guide how organizations manage cloud and technology spending with financial accountability.

## The Six Principles

### 1. Teams Need to Collaborate
- Finance, technology, product, and leadership work together at appropriate speed and granularity
- Cross-functional coordination ensures alignment on strategic goals
- Continuous improvement through collaboration

### 2. Business Value Drives Technology Decisions
- Unit economics and value-based metrics > aggregate spend
- Conscious trade-offs among cost, quality, and speed
- Use FinOps Scopes to target business value of specific goals

### 3. Everyone Takes Ownership for Their Technology Usage
- Push accountability to the edge — engineers own costs from design through operations
- Feature/product teams manage their own technology usage against budgets
- Decentralize decision-making around cost-effective architecture
- **Cost as a first-class metric** from the start of the SDLC

### 4. FinOps Data Should Be Accessible, Timely, and Accurate
- Process and share cost data immediately as it becomes available
- Real-time visibility drives better utilization
- Fast feedback loops → more efficient behavior
- Consistent visibility across all organizational levels
- Use FOCUS for data normalization and consistency

### 5. FinOps Should Be Enabled Centrally
- Centralized FinOps function enables best practices in a shared accountability model
- Executive communication and strategy alignment through a central team
- Rate, commitment, and discount optimization centralized for economies of scale
- Engineers stay focused on optimizing their usage

### 6. Take Advantage of the Variable Cost Model of the Cloud
- Cloud, data centers, SaaS, licenses — each has distinct cost model characteristics
- Embrace consumption-based, granular, variable cost models
- Just-in-time prediction, planning, and purchasing to reduce waste
- Agile iterative planning preferred over static long-term planning
- Proactive system architecture with continuous adjustments

## Key Patterns

The principles reveal a **centralized enablement + decentralized execution** model:
- Central team handles rate optimization, executive communication, best practices
- Engineering teams own their usage costs and make trade-off decisions
- Data transparency connects both layers through fast feedback loops

## Relationship to [[harness-engineering]]

FinOps principles share interesting parallels with harness engineering:
- **Central enablement** mirrors the [[guides-and-sensors]] pattern — central function sets up guides (budgets, policies) and monitors sensors (cost data, utilization)
- **Decentralized ownership** parallels the coding agent model — individual agents/teams work within constraints they help define
- **Cost as first-class metric** is analogous to treating technical debt as a harness constraint
