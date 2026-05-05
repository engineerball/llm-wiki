---
title: "Guides and Sensors"
tags: [concept, agent-engineering, harness-engineering, feedforward, feedback]
sources: [https://martinfowler.com/articles/harness-engineering.html]
date: 2026-05-02
---

# Guides and Sensors

A framework for categorizing harness controls by *when* they act relative to agent execution.

Introduced by [[birgitta-bockeler]] in *Harness Engineering for Coding Agent Users* (martinfowler.com, 2026).

## Definition

**Guides (feedforward)**: Anticipate and steer agent behavior *before* action. Increase first-attempt quality.

**Sensors (feedback)**: Observe post-action results and enable *self-correction* after the agent acts.

## Why Both Are Required

| Only Guides | Only Sensors |
|-------------|-------------|
| Rules never validated | Agents repeat same mistakes |
| Feedback loop missing | No prevention, only correction |

The combination creates a closed-loop system: guides reduce error rate, sensors catch remaining errors and can improve future agent behavior.

## Execution Types

Controls can be **computational** or **inferential**:

| Type | Examples | Speed | Cost |
|------|---------|-------|------|
| Computational | Tests, linters, type checkers | ms–s | Low |
| Inferential | AI code review, semantic analysis | s–min | High |

Prefer computational controls for reliability and cost. Use inferential where semantic judgment is required.

## Timing Across the Lifecycle

Guides and sensors operate at different delivery phases:

| Phase | Controls |
|-------|---------|
| Pre-commit | Fast computational guides/sensors (linters, formatters) |
| Pre-integration | Quick sensors |
| Post-integration | Expensive sensors (mutation testing, deep review) |
| Continuous | Drift detection, runtime feedback |

## Relation to Other Concepts

- [[harness-engineering]] — the broader discipline these controls belong to
- [[trae-definitive-guide-harness-engineering]] — Trae's six design principles and R.E.S.T. framework map closely to guides (Design for Failure, Contract-First, Secure by Default = Guides) and sensors (Traceability, Measurable = Sensors)
- [[harnessability]] — how amenable a codebase is to effective guides/sensors
- [[generator-evaluator-architecture]] — the evaluator role is a sensor in a multi-agent context; the sprint contract acts as a guide
