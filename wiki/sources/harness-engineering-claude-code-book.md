---
title: "Harness Engineering: A Design Guide to Claude Code"
tags: [source, harness-engineering, claude-code, agent-design, book]
date: 2026-05-03
sources: ["https://harness-books.agentway.dev/en/book1-claude-code/"]
---

# Harness Engineering: A Design Guide to Claude Code

**Source:** Harness Books — Online Edition
**URL:** https://harness-books.agentway.dev/en/book1-claude-code/
**Author:** @wquguru
**Date:** 2026-04-01

## Overview

A design analysis of how Claude Code constrains an unstable model into a sustainable engineering order. Not a source walkthrough, but an analysis of **why** the runtime grew this shape across control plane, main loop, tool permissions, context governance, recovery paths, multi-agent verification, and team practices.

## Reading Assumptions

- Center of gravity is not model capability, but **how the harness organizes constraints and execution**
- Goal is not line-by-line narration, but **why the runtime had to grow this way**
- Value is not personal tricks, but **turning structure into reusable team practice**

## Book Structure

| Chapter | Title | Core Topic |
|---------|-------|------------|
| Preface | Harness, Terminals, and Engineering Constraints | Why models need constraints in engineering environments |
| Ch 1 | Why Harness Engineering Matters | The five harness layers of Claude Code |
| Ch 2 | Prompt Is Not Personality, Prompt Is the Control Plane | System prompt as layered behavioral protocol |
| Ch 3 | Query Loop: The Heartbeat of an Agent System | Stateful multi-turn execution as the agent's core |
| Ch 4 | Tools, Permissions, and Interrupts | Why agents cannot touch the world directly |
| Ch 5 | Context Governance: Memory, CLAUDE.md, and Compact | Context as a budgeting regime |
| Ch 6 | Errors and Recovery | An agent system that keeps working after failure |
| Ch 7 | Multi-Agent Work and Verification | Managing instability through division of labor |
| Ch 8 | Team Adoption | Turning a smart tool into a reusable institution |
| Ch 9 | Ten Principles of Harness Engineering | Consolidated judgments from all chapters |
| App A | Checklists | Turning principles into executable constraints |
| App B | Diagrams | Drawing the runtime skeleton |
| App C | Source Map | Which files ground each chapter |

## Five Harness Layers of Claude Code (from Chapter 1)

| Layer | Component | Principle |
|-------|-----------|-----------|
| 1 | **Constrained conversation system** | Prompt defines execution boundaries, failure behavior, reporting responsibility |
| 2 | **Continuous loop** | queryLoop() maintains cross-iteration state; unresolved issues from last turn enter next |
| 3 | **Tool scheduling discipline** | Parallel vs serial execution decided by tool safety, not model preference |
| 4 | **High-risk tools get strictest rules** | Bash requires high-density constraints (Git, filesystem, network) |
| 5 | **Errors are main path** | Recovery paths are structural, not afterthought |

## Prompt as Control Plane (from Chapter 2)

- System prompt is a **layered assembly of behavioral blocks** — not persona decoration
- `getSystemPrompt()` returns an array of sections, not one string
- Strict precedence: override → coordinator → agent → custom → default → append
- Memory and CLAUDE.md are merged into prompt-adjacent context
- Cache/compute cost considerations: cacheable vs cache-breaking sections
- User customization allowed, but must go through fixed layering — **customization without structure degenerates**

## Query Loop as Heartbeat (from Chapter 3)

- Agent = continuous, stateful execution loop, not one-shot API call
- State includes: messages, toolUseContext, autoCompactTracking, maxOutputTokensRecoveryCount, turnCount, etc.
- **Input governance comes BEFORE model invocation**: memory prefetch, skill discovery, message slicing, tool result budget, history snip, microcompact, context collapse, autocompact
- Model output is an **event stream** (for await), not synchronous response
- Interrupt handling: started actions need ledger closure even if interrupted
- Recovery is layered: prompt-too-long → context collapse → reactive compact; max-output-tokens → raise cap → meta message to continue

## Ten Principles (from Chapter 9)

| # | Principle | Summary |
|---|-----------|---------|
| 1 | Treat models as unstable components, not teammates | Models may speak like teammates but lack stability and accountability |
| 2 | Prompt is part of the control plane | Together with runtime, tool schema, memory, hooks — prompt is behavioral protocol |
| 3 | Query loop is the heartbeat | Real agents depend on continuous execution loops — not demos, but runtimes |
| 4 | Tools are managed execution interfaces | Scheduled, authorized, interruptible, ledger-closed |
| 5 | Context is working memory | Governed in layers; optimize for "governable," not "more" |
| 6 | Error paths are main paths | Recovery, circuit breaking, anti-loop guards exist at design time |
| 7 | Recovery optimizes for continuation | After truncation, continuation beats recap; restore breathing first |
| 8 | Multi-agent partitions uncertainty | Research, implementation, verification, synthesis in separate containers |
| 9 | Verification must be independent | Implementers overtrust their changes; dedicated verification is essential |
| 10 | Team institutions > personal tricks | Layered CLAUDE.md, approval boundaries, skills, lifecycle hooks, traceable transcripts |

## Final Judgment

> "Harness Engineering asks how systems can still behave like engineering systems when models themselves are not reliable."

The book's conclusion can be compressed to: **harness over excitement, institutions over cleverness, and verification over confidence**.

## Core Positioning

> "Prompt determines how it speaks. Harness determines how it acts."

Claude Code is studied as a **reference specimen** for how an AI agent facing real engineering conditions evolves toward stricter constraint structure.

## Relationship to [[harness-engineering]]

This book is the **most detailed existing analysis** of harness engineering in practice. It directly grounds the [[harness-engineering]] concept page with specific source-level evidence from Claude Code.

Cross-references:
- **[[initializer-coding-agent-architecture|Initializer pattern]]** — The five harness layers show how an initializer sets up constraints that coding agents work within
- **[[generator-evaluator-architecture|Generator-Evaluator]]** — Principle 9.8 (multi-agent partitions uncertainty) and Principle 9.9 (independent verification) directly support this pattern
- **[[guides-and-sensors]]** — Prompt + memory = guides (feedforward); query loop + tool results = sensors (feedback)
- **[[context-management-for-agents]]** — Chapter 5 (context governance) is the definitive reference on this topic
- **[[feature-list-pattern]]** — Team adoption patterns (Chapter 8) operationalize tracking what's done vs what's not
- **[[one-shot-agent]]** — Contrasted with query loop as heartbeat: one-shot is demo; loop is runtime
- **[[agentic-ai-system]]** — This book explains the implementation details of the 9-layer architecture at the Claude Code level
