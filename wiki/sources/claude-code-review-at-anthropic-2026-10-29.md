---
title: "Solving Code Review at Anthropic - Source Snapshot"
tags: [source, anthropic, claude, code-review, harness, software-engineering]
sources: [raw/articles/claude-code-review-at-anthropic-2026-10-29.md]
date: 2026-10-29
---

# Solving Code Review at Anthropic

**Source:** [Solving Code Review at Anthropic](https://claude.dev/blog/solving-code-review-at-anthropic/)

**Published by:** Anthropic / Claude blog.

**Ingested:** 2026-10-29.

## Executive summary

The Claude Code team treats code review as a risk-control system rather than a single human gate.
Automated verification, AI bug review, security review, required CI, risk-based human approval, merge queues, feature flags, gradual releases, and fast rollback form layered controls.
The target is lower human time per change without increasing reverts or incidents.

The source reports that merged pull requests to the Claude Code codebase more than doubled from June to September while the share requiring reverts fell by more than 40 percent.
This is an internal result, not a universal benchmark, and the article does not prove that AI review alone caused the change.

## Core operating model

### Before the pull request

The author or agent must run executable verification such as tests, builds, linters, browser checks, simulator checks, or screenshot comparisons.
A second agent reviews the diff in a fresh context.
Repeated findings should be moved into a durable control such as a skill, lint rule, `CLAUDE.md`, or `REVIEW.md`.

### On every pull request

Required CI checks lint, types, tests across platforms, build, and packaging.
Parallel AI reviewers inspect the diff against the repository and the stated intent.
Verifier agents filter false positives and rank surviving findings by severity.
A separate security pass blocks merge while findings remain open.

### Human approval by risk

Low-risk changes may need no human approval after automated checks pass.
Medium-risk changes need one person.
High-risk changes and selected sensitive paths need two people.
The change determines the tier, not the author's confidence.
An agent approval cannot replace a required human approval, and approvals are tied to a specific commit.

### Merge and release

The merge queue reruns checks against the latest main with the change applied.
New behavior is placed behind flags, used internally first, and released through a latest channel before stable.
Authors and on-call staff watch telemetry, incident dashboards, and revert signals.
Flags can be turned off without a deploy, and changes can be fixed forward or rolled back.

## Reviewer improvement loop

Past incidents, reverts, and fix-forwards become expert-confirmed evaluation cases.
The reviewer is run against the growing set daily when prompts, tools, or models change.
Noise is measured by how people respond to findings and by running the reviewer on known-clean pull requests.

The source emphasizes review convergence.
One pull request went through more than fifty review and fix rounds.
The team responded with a three-round cap, diff-only re-review after early rounds, class-level fixes, and suppression of repeated findings.
Reported internal results were an increase in first-round pass rate from 65 percent to 78 percent, a reduction in five-or-more-round PRs from 8.9 percent to 1.5 percent, and a reduction in mean reviews to pass from 2.08 to 1.32.

## Human responsibilities

Humans still decide whether to build something, set direction and scope, review risky code and architecture, read the evidence, and own the outcome.
The person directing an agent-written change remains accountable for it.

For team context, Anthropic suggests targeted explainers and visual artifacts instead of requiring everyone to read every trivial diff.
This complements the broader [[harness-engineering]] approach of combining feedforward guidance with feedback sensors.

## Relationships

- [[ai-code-review|AI code review as a layered control system]]
- [[anthropic]]
- [[claude]]
- [[harness-engineering]]
- [[harness-design-long-running-apps]]

## Evidence limits

The article reports Anthropic's own workflow and internal measurements.
It does not establish causal attribution among AI review, CI, merge queues, flags, gradual release, team practices, and other changes.
Revert-rate, incident-rate, and review-round results require local baselines before becoming organizational targets.
