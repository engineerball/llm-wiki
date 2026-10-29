---
title: "AI Code Review as a Layered Control System"
tags: [concept, code-review, software-engineering, agentic-ai, harness]
sources: [raw/articles/claude-code-review-at-anthropic-2026-10-29.md]
date: 2026-10-29
---

# AI Code Review as a Layered Control System

AI-assisted code review is more reliable when designed as multiple controls across the software delivery lifecycle rather than as one model that approves or rejects a pull request.
The control stack combines deterministic checks, inferential review, risk-based human judgment, merge-time integration checks, staged exposure, monitoring, and rollback.

## Layers

1. **Pre-PR verification** — tests, builds, linters, browser or simulator checks, screenshots, and a fresh-context agent review.
2. **AI bug review** — parallel agents inspect the diff against repository context and intent.
3. **Finding verification** — separate agents filter false positives, duplicate findings, style-only comments, and pre-existing issues.
4. **Security review** — a separate blocking pass for security findings.
5. **Required CI** — deterministic lint, type, test, build, packaging, and platform checks.
6. **Risk-based human approval** — zero, one, or two human approvals depending on the change and sensitive paths.
7. **Merge queue** — checks rerun on latest main with the change applied.
8. **Flags and gradual release** — new behavior is exposed internally and then through staged channels.
9. **Detection and rollback** — telemetry, on-call ownership, flags, revert, and fix-forward paths limit blast radius.

## Optimize for convergence, not finding volume

A reviewer that reports more findings is not automatically better.
False positives consume human and agent time, create extra commits, and can produce an endless author-reviewer loop.
Useful measures include:

- review recall on confirmed bugs,
- false-positive and harmful-suggestion rate,
- rounds-to-pass,
- repeated-finding rate,
- revert rate,
- incident rate,
- escaped defects,
- rollback time.

The Anthropic source describes a three-round cap, diff-only re-review after early passes, class-level fixes, and suppression of repeated findings.
This is a convergence control: it limits iterative noise while preserving deeper review for changes where the risk justifies it.

## Deterministic versus inferential controls

Use deterministic controls first when the property can be expressed as a test, type rule, linter, policy, or build check.
Use AI review for semantic questions such as root-cause correctness, unintended interactions, repository fit, and missing behavior.
Use humans for product direction, architecture, high-risk decisions, and accountability.

## Incident-driven improvement

Incidents and reverts should become expert-confirmed evaluation cases for the reviewer.
When prompts, tools, models, or review policies change, rerun the full evaluation set.
Repeated findings should be converted into a durable control when possible, such as a lint rule, test, skill, or repository instruction.

## Practical adoption pattern

Start with one repository and a small risk policy.
Add runnable verification and a short `CLAUDE.md`.
Add `REVIEW.md` for local failure modes.
Require CI and a PR template with Testing, Risk, and How to revert.
Add AI and security review with all threads resolved.
Introduce merge queue, feature flags, internal release, staged rollout, and one-step rollback.
Use local incident and revert evidence to loosen or tighten human approval.

## Caveats

The Anthropic numbers are internal observations and not universal targets.
A lower review burden can hide displaced work if incident and revert rates are not tracked.
AI review cannot replace architectural judgment or required human approval.
Feature flags and staged release add operational complexity and require ownership and cleanup.

## Related pages

- [[claude-code-review-at-anthropic-2026-10-29]]
- [[harness-engineering]]
- [[harness-design-long-running-apps]]
- [[guides-and-sensors]]
- [[generator-evaluator-architecture]]
