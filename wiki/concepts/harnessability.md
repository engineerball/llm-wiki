---
title: "Harnessability"
tags: [concept, agent-engineering, harness-engineering, codebase-design]
sources: [https://martinfowler.com/articles/harness-engineering.html]
date: 2026-05-02
---

# Harnessability

The degree to which a codebase enables effective harness controls for AI coding agents.

Introduced by [[birgitta-bockeler]] in *Harness Engineering for Coding Agent Users* (martinfowler.com, 2026).

## Properties That Increase Harnessability

- **Strongly-typed languages** — type checkers catch a wide class of errors computationally and cheaply
- **Clear module boundaries** — enables structural and dependency linting
- **Defined service topologies** — narrows the production space; makes comprehensive [[guides-and-sensors]] achievable (Ashby's Law)
- **Established frameworks** — existing tooling integrates more easily; less custom harness code needed
- **Consistent naming and patterns** — reduces agent inference burden; see Ambient Affordances (Ned Letcher)

## Ashby's Law Applied

A regulator needs sufficient variety to govern a system. Without topology constraints, the space of possible agent outputs is too large for comprehensive harness coverage. Defined topologies narrow this space, making it tractable.

## Practical Implication

Before investing heavily in harness engineering, assess whether the codebase has adequate harnessability. Refactoring toward better harnessability — cleaner boundaries, stronger types, defined topologies — may have higher leverage than building sophisticated controls on a weakly-structured codebase.

## Related Concepts

- [[harness-engineering]] — the discipline that depends on harnessability
- [[guides-and-sensors]] — the controls that harnessability enables
