---
title: "Sprint Contracts"
tags: [concept, multi-agent, evaluation, coordination]
sources: [https://www.anthropic.com/engineering/harness-design-long-running-apps]
date: 2026-03-24
---

# Sprint Contracts

A coordination mechanism in multi-agent [[generator-evaluator-architecture]] where the Generator and Evaluator pre-negotiate explicit, measurable definitions of "done" before implementation begins.

Introduced in [[harness-design-long-running-apps]] ([[anthropic]], 2026).

## Problem Solved

Without a sprint contract:
- Evaluator applies arbitrary or shifting standards
- Generator doesn't know what "passing" looks like
- High-level specs leave too much room for interpretation
- Evaluator and Generator optimize for different outcomes

## What a Sprint Contract Contains

- Specific, measurable success criteria derived from the product spec
- Testable behaviors (what Playwright should be able to do)
- Explicit scope boundaries (what is and isn't in this sprint)
- Agreed quality thresholds per criterion

Bridges the gap between high-level product specification and testable implementation details.

## Process

1. Planner produces product specification
2. Generator reviews spec and proposes success criteria
3. Evaluator reviews and negotiates criteria
4. Both agents commit to the contract before implementation starts
5. Evaluator tests against contract; Generator iterates toward it

## Why Pre-Negotiation Matters

Evaluating *after* generation without a pre-agreed standard creates adversarial dynamics and inconsistent feedback. Pre-negotiation aligns both agents to the same target before any work is done.

## Relation to Human Agile

Analogous to sprint planning in human agile teams: scope and acceptance criteria are agreed before the sprint begins, preventing scope creep and misaligned expectations during delivery.

## Related

- [[generator-evaluator-architecture]] — the multi-agent pattern that uses sprint contracts
- [[harness-engineering]] — broader context of agent scaffolding
