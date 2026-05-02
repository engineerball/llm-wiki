---
title: "Context Management for Agents"
tags: [concept, context, long-running-tasks, agents]
sources: [https://www.anthropic.com/engineering/harness-design-long-running-apps]
date: 2026-03-24
---

# Context Management for Agents

How long-running AI agent tasks handle the finite context window. Two primary failure modes and two primary mitigation strategies.

Evidence from [[harness-design-long-running-apps]] ([[anthropic]], 2026).

## Failure Modes

### Context Degradation
As context fills, model coherence degrades. The model must increasingly attend across a long, noisy history to find relevant information, reducing effective reasoning quality.

### Context Anxiety
Specific to some models (observed in Claude Sonnet 4.5): the agent prematurely concludes work as it perceives approaching token limits, even when the task is incomplete. A behavioral artifact of the training distribution — the model has learned that long contexts often end — not a hard technical limit.

## Mitigation Strategies

### Context Reset
- Completely clear the conversation history
- Produce a structured **handoff document** summarizing: work done, current state, what remains
- Start a fresh context with only the handoff + new task
- Discards irrelevant history; fresh start prevents degradation accumulation

**Tradeoff:** Information loss. The handoff must capture everything the next context needs. Poorly designed handoffs lose critical state.

### Context Compaction
- Summarize and compress the existing context
- Continue in the same session with a shorter history
- Preserves more continuity than a reset

**Tradeoff:** Compression artifacts. Important details may be lost or distorted. Compaction quality depends on the model's ability to summarize its own history accurately.

## Model-Specific Behavior (as of 2026)

| Model | Context Anxiety | Recommended Strategy |
|-------|----------------|---------------------|
| Claude Sonnet 4.5 | Severe | Context resets with structured handoffs |
| Claude Opus 4.6 | Mild / manageable | Continuous sessions; compaction or no intervention |

Key insight: **harness designs encode model-specific assumptions**. When a new model releases, context management assumptions should be retested.

## Handoff Document Design

Effective handoffs for context resets include:
- Current state of all persistent artifacts (files, DB schema, deployed components)
- Decisions made and why
- Outstanding tasks from the previous sprint
- Constraints discovered during implementation
- Known bugs or issues deferred

## Related

- [[generator-evaluator-architecture]] — context management is critical within long generator-evaluator loops
- [[harness-engineering]] — context management is a key harness design concern
- [[sprint-contracts]] — sprint boundaries are natural reset points
