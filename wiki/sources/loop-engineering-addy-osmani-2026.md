---
title: "Loop Engineering"
tags: [source, loop-engineering, agent-engineering, ai, software-development]
sources: ["https://addyosmani.com/blog/loop-engineering/"]
date: 2026-07-27
---

# Loop Engineering

**Source:** Addy Osmani  
**URL:** https://addyosmani.com/blog/loop-engineering/

## Main Thesis

Loop engineering is the practice of replacing direct turn-by-turn prompting with a system that prompts, checks, schedules, and coordinates agents on the operator's behalf.
The human stops being the person manually driving each agent turn and instead designs the recurring system that does it.

## Key Definition

A loop is a recursive goal-oriented process where an agent or set of agents iterates until a stopping condition is met.
The important design shift is from "prompting the agent" to "designing the loop that prompts the agent."

## Core Building Blocks

The article identifies five practical pieces plus persistent memory:

1. **Automations** for recurring discovery and triage.
2. **Worktrees** for parallel isolation.
3. **Skills** for codified project knowledge.
4. **Plugins and connectors** for access to real tools and systems.
5. **Sub-agents** to split making from checking.
6. **External state** outside the chat context so long-running work can resume reliably.

## Important Operational Insight

Loop engineering sits above a single agent harness.
A harness shapes the environment of one agent run.
A loop adds cadence, memory, delegation, and recurrence.

## Risks and Warnings

The article stresses three human risks:

- verification still ultimately belongs to the human,
- comprehension debt grows when loops ship code the operator no longer understands,
- cognitive surrender happens when operators stop exercising judgment and simply accept whatever the loop returns.

## Practical Value

The practical promise is not just more automation.
It is the ability to turn recurring engineering work into an explicit, reusable control system.

## Relationships

- [[harness-engineering]] - loop engineering sits above the harness layer and composes multiple harnessed runs
- [[context-management-for-agents]] - persistent external state is essential because models do not remember between runs
- [[skills-as-markdown]] - skills are one of the main mechanisms for codifying project knowledge inside a loop
- [[graph-engineering]] - graph engineering generalizes beyond a single loop into a larger topology of nodes and transitions
