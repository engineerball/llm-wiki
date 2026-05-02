---
title: "One-Shot Agent"
tags: [concept, agent-engineering, coding-agent, harness-engineering]
sources: [https://stripe.dev/blog/minions-stripes-one-shot-end-to-end-coding-agents]
date: 2026-05-02
---

# One-Shot Agent

A coding agent design pattern where the agent receives a single task description and autonomously completes the full development cycle — planning, implementation, verification, and pull request creation — with no human intervention during execution.

Introduced as a production design principle by [[Stripe]] in their Minions system.

## What "One-Shot" Means

The term refers to the *human interaction model*, not the model's internal iteration count:

- **One human input**: engineer provides a task description
- **One human output**: engineer reviews a completed pull request
- **Everything in between**: handled autonomously by the agent loop

The agent may iterate many times internally (writing code, running checks, correcting errors from pre-push hooks), but these cycles are hidden from the engineer.

## Contrast with Iterative Approaches

| Pattern | Human touchpoints |
|---------|------------------|
| Traditional development | Many (write, review, debug, test, repeat) |
| Assisted development (Copilot-style) | Many (accept/reject every suggestion) |
| Supervised agent | Several (review plans, approve steps) |
| **One-shot agent** | Two (task specification + PR review) |

## Required Infrastructure

One-shot execution requires a harness that replaces human checkpoints with automated equivalents:

- **[[Guides and Sensors|Guides]]** (feedforward): blueprints, AGENTS.md, architectural rules — give the agent correct initial orientation
- **[[Guides and Sensors|Sensors]]** (feedback): pre-push hooks, linters, tests, type checkers — catch errors and enable self-correction without human involvement

Without both, the agent either produces low-quality output (no sensors) or fails to understand the codebase's conventions (no guides).

## Relationship to [[Harness Engineering]]

One-shot agents represent a high-trust point on the human-oversight spectrum. They are only viable when:
1. The harness provides sufficient guides and sensors to substitute for human checkpoints
2. The codebase has adequate [[Harnessability]] (types, topology, structure)
3. The task scope is well-bounded (one-shot is harder for large, ambiguous tasks)

## See Also

- [[Minions: Stripe's One-Shot End-to-End Coding Agents]] — source and reference implementation
- [[Harness Engineering]] — the design discipline that makes one-shot viable
- [[Guides and Sensors]] — the control framework underpinning one-shot verification
- [[Generator-Evaluator Architecture]] — alternative multi-agent pattern; involves more internal steps but also minimal human checkpoints during execution
