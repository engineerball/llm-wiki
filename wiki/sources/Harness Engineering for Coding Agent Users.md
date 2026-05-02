---
title: "Harness Engineering for Coding Agent Users"
tags: [source, harness-engineering, agent-engineering, software-development, guides, sensors]
sources: [https://martinfowler.com/articles/harness-engineering.html]
date: 2026-05-02
author: Birgitta Böckeler
---

# Harness Engineering for Coding Agent Users

Summary of article by [[Birgitta Böckeler]], published on martinfowler.com.

**URL:** https://martinfowler.com/articles/harness-engineering.html

## Core Framework: Agent = Model + Harness

Organising equation: everything surrounding the model — the **harness** — is what engineers control and must design well. The article provides a structured taxonomy for reasoning about what a harness contains.

## Guides vs Sensors

Two types of harness controls, distinguished by *when* they act:

- **Guides (feedforward)**: Anticipate and steer agent behavior before action. Increase first-attempt quality. Examples: AGENTS.md, architecture rules, code templates, style guides.
- **Sensors (feedback)**: Observe post-action results and enable self-correction. Examples: tests, linters, type checkers, AI code review.

Using only feedback → agents repeat the same mistakes. Using only feedforward → rules never get validated. Both are required for a closed-loop system.

See [[Guides and Sensors]].

## Computational vs Inferential Execution

| Type | Examples | Speed | Cost | Determinism |
|------|---------|-------|------|-------------|
| Computational | Tests, linters, type checkers | ms–seconds | Low | Deterministic |
| Inferential | AI code review, semantic analysis | seconds–minutes | High | Non-deterministic |

Use computational controls first (coverage, reliability). Use inferential where semantic judgment is unavoidable.

## Three Harness Categories

### Maintainability Harness

Regulates internal code quality. The most mature category — uses existing tooling: linters, coverage analysis, code review agents, mutation testing.

### Architecture Fitness Harness

Validates architecture characteristics — dependency rules, performance, module boundaries. Implemented via fitness functions and custom structural tests. Aligns with [[OpenAI]]'s layer enforcement via custom linters (from [[Harness Engineering - Leveraging Codex in an Agent-First World]]).

### Behaviour Harness

Validates functional requirements. Currently underdeveloped. Relies heavily on AI-generated tests, which lack sufficient reliability for high-confidence automation. Identified as the most critical gap.

## Harnessability

Not all codebases are equally amenable to harness controls. Properties that increase harnessability:

- Strongly-typed languages
- Clear module boundaries
- Defined service topologies
- Established frameworks

See [[Harnessability]].

## Ambient Affordances

Term from Ned Letcher: environmental properties that make a system **legible to agents**. Well-named identifiers, consistent patterns, discoverable structure — these reduce the agent's inference burden, meaning less context needed and fewer errors from misreading the codebase.

## Ashby's Law Applied

A regulator needs sufficient variety to govern a system. Defining service topologies (e.g., "all services follow this pattern") narrows the production space, making comprehensive harness coverage achievable. Without topology constraints, the harness must govern an unbounded output space.

## Timing Strategy

| Phase | Controls |
|-------|---------|
| Pre-commit | Fast linters, basic review agents |
| Pre-integration | Quick sensors |
| Post-integration | Mutation testing, comprehensive review |
| Continuous | Drift detection, runtime feedback monitoring |

## Harness Templates

Pre-packaged guide-and-sensor bundles for common service topologies. Encode institutional best practices; reduce per-project harness setup overhead.

## Critical Insight: The Human Implicit Harness

Higher-impact problems — misdiagnosis, overengineering — remain hard to automate. Human developers carry **implicit harnesses**: experience, accountability, and organizational awareness that agents lack. These are currently irreplaceable for catching high-stakes architectural decisions.

## Real-World Implementations Cited

- **[[OpenAI]]**: Layered architecture enforced through custom linters and structural tests
- **[[Stripe]] "Minions"**: Pre-push hooks and blueprint-integrated feedback — see [[Minions - Stripe's One-Shot End-to-End Coding Agents]]
- **ThoughtWorks teams**: Architecture drift detection using computational + inferential sensors

## Open Questions

- Maintaining harness coherence as systems grow
- Evaluating harness coverage quality
- Preventing contradictory instructions across guides
- Unified tooling for harness controls across the full delivery lifecycle

## Connections to Other Sources

- [[Harness Engineering - Leveraging Codex in an Agent-First World]] — OpenAI's concrete implementation (linters, layer enforcement, entropy management)
- [[Harness Design for Long-Running Application Development]] — Anthropic's multi-agent harness; evaluator role = sensor pattern in action

## Key Entities

- [[Birgitta Böckeler]] — author, ThoughtWorks principal technologist
- Ned Letcher — coined "Ambient Affordances"
- [[Stripe]] — cited for "minions" with pre-push hooks; see [[Minions - Stripe's One-Shot End-to-End Coding Agents]]
- [[OpenAI]] — cited for layered architecture enforcement
- ThoughtWorks — cited for architecture drift detection work
