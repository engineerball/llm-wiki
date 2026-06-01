---
title: "Ralph Wiggum Technique"
tags: [ai-coding, agentic-loop, vibe-coding, harness-engineering, claude-code]
sources: [ralph-wiggum-technique-ghuntley-2025]
date: 2026-06-01
---

# Ralph Wiggum Technique

Agentic coding methodology where a coding agent runs in an autonomous loop, performing one task per iteration using specifications and a prioritized fix plan as its context stack. Named after the Simpsons character; created by [[geoffrey-huntley|Geoffrey Huntley]] while building CURSED, an esoteric programming language.

## Core Idea

```bash
while :; do cat PROMPT.md | claude-code ; done
```

A monolithic single-process loop — deliberately not multi-agent. The technique is "deterministically bad in an undeterministic world," but compounding iterations with careful tuning produce reliable, production-grade output. The operator's role shifts from writing code to designing the environment (specs, stdlib, backpressure, prompt signs) that steers the agent — a direct expression of [[harness-engineering|Harness Engineering]].

## Principles

- **One item per loop** — conserves the ~170k context window; the LLM picks the most important item from the fix plan
- **Deterministic stack allocation** — specifications + fix_plan.md reloaded every loop (wasteful but consistent)
- **Specifications over prompts** — built through conversation, codified per-file; evolved through behavioral observation
- **Subagents extend context** — primary loop is a scheduler; expensive work delegated; 1 subagent max for validation, unlimited for search/I/O
- **Search before assuming** — ripgrep is non-deterministic; explicit instruction prevents duplicate implementations
- **Anti-placeholder enforcement** — models chase compilation reward; explicit countermeasures + audit loops needed

## Two-Phase Cycle

1. **Generate** — code is cheap; wrong patterns → fix stdlib; wrong features → fix specs
2. **Backpressure** — type systems, static analyzers, tests, security scanners reject invalid code; wheel must turn fast

## Test Documentation

Since each loop gets a fresh context window, tests must embed their own reasoning (why they exist, what they verify) as notes for future iterations.

## TODO Generation

Up to 500 parallel subagents audit codebase against specifications to produce a prioritized fix_plan.md, which Ralph then works through item by item.

## Significance

Ralph demonstrates that [[harness-engineering|Harness Engineering]] can replace most outsourcing for greenfield projects. The operator doesn't write code — they tune the environment. Outcomes reflect operator skill and specifications quality, not tool capability. The CURSED language was built entirely by Ralph without existing in any LLM training data.

## See Also
- [[harness-engineering|Harness Engineering]] — the broader discipline Ralph embodies
- [[one-shot-agent|One-Shot Agent]] — single-task agent pattern
- [[context-management-for-agents|Context Management for Agents]] — finite context window strategies
- [[guides-and-sensors|Guides and Sensors]] — feedforward + feedback control taxonomy
- [[stripe-minions-one-shot-coding-agents|Stripe Minions]] — production one-shot agent system
- [[geoffrey-huntley|Geoffrey Huntley]] — creator of Ralph
