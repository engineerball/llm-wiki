---
title: "Harness Engineering"
tags: [concept, agent-engineering, software-development, codex, openai]
sources: [https://openai.com/index/harness-engineering/]
date: 2026-02-11
---

# Harness Engineering

A software engineering discipline where the primary job is no longer writing code, but designing the **environments, feedback loops, and scaffolding** that allow AI coding agents to do reliable, consistent work.

Coined/used by [[openai]] to describe the methodology behind their agent-first [[codex]] experiment (Feb 2026).

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

From [[harness-engineering-leveraging-codex]] (2026):
- 1M LOC, 1,500 PRs, 3→7 engineers, 5 months
- Zero manually-written code
- ~3.5 PRs per engineer per day
- Estimated 10x throughput vs traditional development

## Anthropic's Perspective (2026)

### Multi-agent orchestration for long-running tasks (early 2026)

[[anthropic]] extended the harness concept to multi-agent orchestration for long-running tasks. Their harness = specialized agent roles + feedback loops:

- **Planner** → expands intent into spec
- **Generator** → implements iteratively
- **Evaluator** → tests against [[sprint-contracts]]

Key insight from [[harness-design-long-running-apps]]: "Every component in a harness encodes an assumption about what the model can't do on its own, and those assumptions are worth stress testing." The harness must be redesigned as models improve.

### Effective harnesses for long-running agents (mid 2026)

Anthropic's follow-up research focused specifically on enabling the Claude Agent SDK to work across many context windows. [[anthropic-effective-harnesses]] identified four failure modes and a two-role architecture:

- **[[initializer-coding-agent-architecture]]** — split between one-time environment setup (initializer) and incremental per-session progress (coding agent)
- **[[feature-list-pattern]]** — comprehensive JSON enumeration of all features, initially all "failing", to defeat one-shotting and premature completion
- Session continuity artifacts: `init.sh`, `claude-progress.txt`, git commits with descriptive messages
- Browser automation (Puppeteer MCP) for end-to-end testing — dramatically improved bug detection vs code-level testing alone
- Key failure modes: one-shotting, premature completion, buggy/undocumented state, premature test passing

This work complements the earlier [[generator-evaluator-architecture]] and [[sprint-contracts]] patterns, but focuses specifically on the cross-context-window problem rather than quality-assurance within a single session.

## Stripe's Production Implementation (2026)

[[stripe]] built **Minions** — a one-shot end-to-end coding agent system operating at production scale in a large monorepo. Key harness elements:

- **Blueprints** — service-level feedforward guides encoding architectural rules and conventions; described in [[stripe-minions-one-shot-coding-agents]]
- **Pre-push hooks** — sensor controls that run linting, type checking, and tests; agent self-corrects on failures before any human sees the output
- **One-shot execution** — engineers submit one task description and review one PR; all iteration is internal to the agent loop

The Minions system demonstrates that one-shot autonomous coding is viable at scale when the codebase has sufficient [[harnessability]] (typed, topologically defined, rule-enforced).

See [[one-shot-agent]] and [[blueprints]].

## Böckeler's Framework (ThoughtWorks, 2026)

[[birgitta-bockeler]] extended harness engineering into a structured taxonomy in [[harness-engineering-coding-agent-users]] (martinfowler.com, 2026):

**Control types by timing:**
- **Guides (feedforward)** — steer agents before action (AGENTS.md, rules, templates)
- **Sensors (feedback)** — observe after action and enable self-correction (tests, linters, AI review)

See [[guides-and-sensors]].

**Three harness domains:**
1. **Maintainability** — internal code quality; most mature
2. **Architecture Fitness** — structural rules, performance, dependency validation
3. **Behaviour** — functional correctness; currently underdeveloped

**Key property:** Not all codebases support harnesses equally. See [[harnessability]].

**Critical limit:** High-impact problems (misdiagnosis, overengineering) remain hard to automate. Human engineers carry implicit harnesses — experience, accountability, organizational awareness — that are currently irreplaceable.

## Trae's Framework (2026)

Trae's [[trae-definitive-guide-harness-engineering]] extends harness engineering beyond coding agents into a general agent engineering philosophy:

**Horse and Reins metaphor:**
- AI Agent = SOTA Model (Wild Horse) + Harness (Control System)
- The harness is every piece of infrastructure *other than the LLM*
- Not about better prompts — it's about engineering the environment

**R.E.S.T. framework:** Reliability (fault recovery, idempotency), Efficiency (resource budgets), Security (least privilege, sandboxing), Traceability (end-to-end, auditable state)

**PPAF cognitive loop:** Perception → Planning → Action → Feedback/Reflection

**Agent maturity matrix:** Cognitive Loop (Reactive → Proactive) × Context Efficiency (Manual → Automated)

**REPL container architecture:** Deterministic shell wrapping non-deterministic LLM — Read, Eval, Print, Loop

**Six design principles:** Design for Failure, Contract-First, Secure by Default, Separation of Concerns, Everything Measurable, Data-Driven Evolution

**Sandboxing levels:** Process → Container → MicroVM → Full VM

**Core philosophy:** When a model hits a wall, implement an engineered mechanism so the same class of failure never happens again.

## Related Concepts

- [[trae-definitive-guide-harness-engineering]] — Trae's definitive guide (horse & reins, R.E.S.T., PPAF loop, REPL container, sandboxing)
- [[generator-evaluator-architecture]] — multi-agent pattern for quality via separation of roles
- [[sprint-contracts]] — pre-negotiated success criteria between generator and evaluator
- [[context-management-for-agents]] — handling context degradation in long-running agent tasks
- [[initializer-coding-agent-architecture]] — two-role split for cross-context continuity (Anthropic, 2026)
- [[feature-list-pattern]] — JSON feature enumeration to prevent one-shotting and premature completion
- [[guides-and-sensors]] — feedforward/feedback control framework for harness design
- [[harnessability]] — codebase property determining how effective harness controls can be
- [[one-shot-agent]] — contrasted with Anthropic's incremental agent architecture
- [[finops]] — shared patterns: centralized enablement + decentralized execution; cost as a first-class metric is a harness constraint
- Repository legibility (making codebases navigable by agents)
- Progressive disclosure (knowledge architecture for agents)
