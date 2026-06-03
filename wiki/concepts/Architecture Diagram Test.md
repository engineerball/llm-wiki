---
tags: [tech-lead, software-engineering, project-management]
sources: [Software Engineering at the Tipping Point Navigating Second-Order Impacts of the AI "10x Moment".md]
created: 2026-06-01
updated: 2026-06-01
---

# Architecture Diagram Test

Diagnostic tool for measuring a team's intellectual control over its own system.

From [[Adam Bender]], Google I/O.

## Method

Ask every engineer on the team to independently draw the system's architecture diagram — no discussion, no reference to existing docs.

**Interpret results:**
- All diagrams look similar → high intellectual control, shared mental model
- Many different diagrams → intellectual control already lost, dangerous to accelerate with AI

## Why It Matters

[[Code As Liability]] grows fastest when nobody understands the codebase. The architecture diagram test surfaces this before an AI acceleration push makes it catastrophic.

In the [[AI 10x Moment]], senior engineers reviewing code they don't understand lose the ability to catch bad patterns. The test reveals this risk before it compounds.

## Practical Use

Run this before adopting AI coding tools at scale. If engineers can't agree on what exists, fix the mental model problem first — then accelerate.

Useful for onboarding new projects: run the test with existing team to surface undocumented assumptions.

## Relevance

Applicable directly to Digithun projects where multiple engineers work across GCP/data/AI stacks. Run before scaling AI agent use on any project.

## Sources

- [[Software Engineering at the Tipping Point]]
