---
title: "Blueprints"
aliases: ["Stripe Blueprints", "Blueprint System"]
tags: [concept, agent-engineering, harness-engineering, repository-legibility, stripe]
sources: [https://stripe.dev/blog/minions-stripes-one-shot-end-to-end-coding-agents]
date: 2026-05-02
---

# Blueprints

Stripe's structured documentation system for describing service contracts, expected code patterns, architectural rules, and interface specifications. Blueprints are the primary [[guides-and-sensors|guide]] mechanism in the [[stripe]] Minions system — feedforward controls that orient coding agents before they begin implementing.

Introduced in [[stripe-minions-one-shot-coding-agents]].

## What Blueprints Contain

For a given subsystem or service, a blueprint describes:
- Service contract: what the service does and what it promises to callers
- Expected code patterns: how code in this area should be structured
- Architectural rules: what dependencies are allowed, what is forbidden
- Interface specifications: API shapes, data types, conventions

## Role in the Harness

Blueprints are a concrete implementation of what [[birgitta-bockeler]] calls **guides** in the [[guides-and-sensors]] framework: feedforward controls that anticipate agent behavior and steer it before errors occur.

Without blueprints, an agent working in a large, complex codebase must infer architectural conventions from the code itself — a high-inference task prone to mistakes. Blueprints make conventions explicit and machine-readable.

## Comparison to Similar Concepts

| Concept | Source | Purpose |
|---------|--------|---------|
| Blueprints | Stripe (Minions) | Service/subsystem-level architecture documentation for agents |
| AGENTS.md | OpenAI / general | Repository-level conventions and table of contents |
| CLAUDE.md | Anthropic / general | Repository-level agent instructions |
| `docs/` directory | [[harness-engineering-leveraging-codex]] | Deep knowledge store indexed via AGENTS.md |

Blueprints are more granular and service-specific than a top-level AGENTS.md. Together they form a layered documentation architecture: repo-level overview → service-level blueprint → code-level conventions.

## Why Blueprints Improve [[harnessability]]

Blueprints encode the service topology explicitly, which is one of the key [[harnessability]] properties: "Defined service topologies narrow the production space, making comprehensive harness coverage achievable" (Ashby's Law applied).

An agent consulting a blueprint before writing code makes fewer architectural missteps — reducing the load on sensor controls downstream.

## See Also

- [[guides-and-sensors]] — the framework that classifies blueprints as feedforward guides
- [[harnessability]] — codebase property that blueprints help instantiate
- [[harness-engineering]] — broader discipline
- [[stripe]] — organization that developed and operates this pattern
