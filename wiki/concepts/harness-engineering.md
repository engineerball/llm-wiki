---
title: "Harness Engineering"
tags: [concept, agent-engineering, software-development, codex, openai]
sources: [https://openai.com/index/harness-engineering/]
date: 2026-02-11
---

# Harness Engineering

A software engineering discipline where the primary job is no longer writing code, but designing the **environments, feedback loops, and scaffolding** that allow AI coding agents to do reliable, consistent work.

Coined/used by [[OpenAI]] to describe the methodology behind their agent-first [[Codex]] experiment (Feb 2026).

## Definition

A **harness** is the full environment surrounding an AI agent:
- Repository structure
- CI/CD configuration
- Formatting rules and linters
- Package manager setup
- Application framework
- Project instructions (AGENTS.md / CLAUDE.md)
- External tool integrations
- Feedback mechanisms (tests, observability, review loops)

## Core Principle

> "The discipline shows up more in the scaffolding rather than the code."

The engineer's role shifts from author to architect:
- **Before:** write code
- **After:** design environments, specify intent, build feedback loops

## Key Practices

### Repository as Knowledge System
- AGENTS.md serves as a lightweight table of contents (~100 lines)
- Deep knowledge lives in a structured `docs/` directory
- "If the agent can't see it, it doesn't exist" — all conventions must be in the repo as readable markdown
- Mechanical linting enforces freshness

### Architectural Constraints as Prerequisites
- Strict dependency layers enforced mechanically: Types → Config → Repo → Service → Runtime → UI
- Custom linters validate dependency direction
- "Taste invariants" encode consistency rules (naming, logging structure, file sizes)
- Architectural boundaries enable speed — without them, high-throughput agents create entropy

### Agent Visibility
- Agents need runtime access to see what they produce: logs, metrics, traces, UI screenshots
- Chrome DevTools Protocol for visual validation
- Per-worktree isolated instances so agents don't interfere with each other
- Observable = correctable

### Merge Philosophy
- High agent throughput makes blocking merge gates counterproductive
- Short PR lifespans; corrections cheaper than indefinite blocking
- Test flakes resolved by follow-up runs, not blocking merges

### Entropy Management
- "Golden principles" encoded in the repo, enforced by linters
- Background cleanup agents continuously scan for drift
- Targeted auto-generated refactoring PRs (mostly auto-mergeable)
- Technical debt compounded like interest if not addressed continuously

## Relationship to Traditional Engineering

| Traditional | Harness Engineering |
|---|---|
| Write code | Design environment |
| Review PRs line-by-line | Review agent outcomes |
| Fix bugs | Encode bug-prevention constraints |
| Document for humans | Document for agents (legibility) |
| Code quality = discipline | Scaffolding quality = discipline |

## Evidence

From [[Harness Engineering - Leveraging Codex in an Agent-First World]] (2026):
- 1M LOC, 1,500 PRs, 3→7 engineers, 5 months
- Zero manually-written code
- ~3.5 PRs per engineer per day
- Estimated 10x throughput vs traditional development

## Anthropic's Perspective (2026)

[[Anthropic]] extended the harness concept to multi-agent orchestration for long-running tasks. Their harness = specialized agent roles + feedback loops:

- **Planner** → expands intent into spec
- **Generator** → implements iteratively
- **Evaluator** → tests against [[Sprint Contracts]]

Key insight from [[Harness Design for Long-Running Application Development]]: "Every component in a harness encodes an assumption about what the model can't do on its own, and those assumptions are worth stress testing." The harness must be redesigned as models improve.

## Stripe's Production Implementation (2026)

[[Stripe]] built **Minions** — a one-shot end-to-end coding agent system operating at production scale in a large monorepo. Key harness elements:

- **Blueprints** — service-level feedforward guides encoding architectural rules and conventions; described in [[Minions: Stripe's One-Shot End-to-End Coding Agents]]
- **Pre-push hooks** — sensor controls that run linting, type checking, and tests; agent self-corrects on failures before any human sees the output
- **One-shot execution** — engineers submit one task description and review one PR; all iteration is internal to the agent loop

The Minions system demonstrates that one-shot autonomous coding is viable at scale when the codebase has sufficient [[Harnessability]] (typed, topologically defined, rule-enforced).

See [[One-Shot Agent]] and [[Blueprints]].

## Böckeler's Framework (ThoughtWorks, 2026)

[[Birgitta Böckeler]] extended harness engineering into a structured taxonomy in [[Harness Engineering for Coding Agent Users]] (martinfowler.com, 2026):

**Control types by timing:**
- **Guides (feedforward)** — steer agents before action (AGENTS.md, rules, templates)
- **Sensors (feedback)** — observe after action and enable self-correction (tests, linters, AI review)

See [[Guides and Sensors]].

**Three harness domains:**
1. **Maintainability** — internal code quality; most mature
2. **Architecture Fitness** — structural rules, performance, dependency validation
3. **Behaviour** — functional correctness; currently underdeveloped

**Key property:** Not all codebases support harnesses equally. See [[Harnessability]].

**Critical limit:** High-impact problems (misdiagnosis, overengineering) remain hard to automate. Human engineers carry implicit harnesses — experience, accountability, organizational awareness — that are currently irreplaceable.

## Related Concepts

- [[Generator-Evaluator Architecture]] — multi-agent pattern for quality via separation of roles
- [[Sprint Contracts]] — pre-negotiated success criteria between generator and evaluator
- [[Context Management for Agents]] — handling context degradation in long-running agent tasks
- [[Guides and Sensors]] — feedforward/feedback control framework for harness design
- [[Harnessability]] — codebase property determining how effective harness controls can be
- Repository legibility (making codebases navigable by agents)
- Progressive disclosure (knowledge architecture for agents)
