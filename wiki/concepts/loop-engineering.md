---
title: "Loop Engineering"
tags: [concept, agent-engineering, ai, software-development, orchestration]
sources: ["sources/loop-engineering-addy-osmani-2026.md", "sources/art-of-loop-engineering-langchain-2026.md"]
date: 2026-07-27
---

# Loop Engineering

Loop Engineering is the practice of designing recurring agent control cycles instead of manually prompting an agent one turn at a time.
The core shift is from directly operating the model to engineering the system that repeatedly prompts, checks, schedules, and improves agent behavior.

## Core Idea

A loop is an iterative process with a goal, a stopping condition, and a mechanism for checking whether the work should continue.
In agent systems, loop engineering treats that process as the main unit of design.

## Why It Emerged

As coding and task agents became more capable, the bottleneck moved away from single prompts and toward repeatability, verification, and unattended execution.
Builders needed ways to:

- run the same kind of work on a schedule,
- separate making from checking,
- persist state outside one chat session,
- and improve the system by learning from prior runs.

Loop engineering is the name for that shift.

## Common Loop Stack

A mature loop often contains several layers:

1. **Agent loop** - the model calls tools until a task is complete.
2. **Verification loop** - a grader, test suite, or evaluator checks whether output is acceptable.
3. **Event-driven loop** - cron jobs, webhooks, or other triggers run the loop automatically.
4. **Improvement loop** - traces and failures are analyzed so prompts, tools, or harness configuration improve over time.

This is one reason loop engineering often feels like a bridge between application logic and operations.

## Building Blocks

Across sources, the practical ingredients are consistent:

- automation and scheduling,
- work isolation for parallel runs,
- codified project knowledge such as skills,
- connectors to external systems,
- sub-agents or checker roles,
- and persistent state outside the transient context window.

## Relationship to Harness Engineering

[[harness-engineering]] focuses on the environment and control mechanisms that make a single agent run reliable.
Loop engineering sits above that layer.
It uses harnessed runs as building blocks in a recurring process with cadence, memory, and explicit stop conditions.

## Relationship to Graph Engineering

[[graph-engineering]] is the broader topology layer.
A loop can be understood as a simple cyclic graph.
Graph engineering becomes useful when the system contains many nodes, routes, and checkpoints rather than one dominant loop.

## Main Risks

The sources surface several recurring failure modes:

- verification becomes weak or self-referential,
- token costs expand unpredictably,
- persistent state becomes stale or incomplete,
- and humans accumulate comprehension debt by accepting outputs they no longer deeply understand.

Loop engineering therefore increases leverage, but also raises the importance of strong stop conditions and operator judgment.

## Relationships

- [[harness-engineering]] - reliability discipline for the environment underneath each looped run
- [[graph-engineering]] - larger topology that may contain many loops
- [[context-management-for-agents]] - loop continuity depends on external state rather than model memory
- [[guides-and-sensors]] - verification and observability are core sensor mechanisms inside loops
- [[skills-as-markdown]] - a common way to codify repeatable project knowledge for looped execution
