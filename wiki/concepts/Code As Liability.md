---
title: "Code As Liability"
tags: [software-engineering, tech-lead, ai-agents]
sources: [Software Engineering at the Tipping Point Navigating Second-Order Impacts of the AI "10x Moment".md]
created: 2026-06-01
updated: 2026-06-01
---

# Code As Liability

Mental model: software is not an asset — it is a liability. Every line of code is future maintenance burden, potential bug surface, and cognitive load on the team.

Attributed to [[Adam Bender]] quoting it in the context of the [[AI 10x Moment]].

## Implication in AI Era

Because AI makes writing code extremely cheap, codebases will swell. The AI productivity gain in generation is partially or fully offset by the liability explosion:

- 10x more code → 10x more technical debt
- 10x more code → 10x more maintenance surface
- 10x more code → loss of intellectual control (see [[Architecture Diagram Test]])

## Countermeasures

- [[Code Isolation]]: prevent experimental code from infecting production
- [[Robust Abstractions]]: force agents to use standardized substrates, not roll their own
- Aggressive deletion: prefer deleting code over keeping it

## Relevance for Tech Leads

When reviewing AI-generated code, the question is not "does it work?" but "is the liability worth it?" Accepting code that works but nobody understands is a deferred cost.

## Sources

- [[Software Engineering at the Tipping Point]]
