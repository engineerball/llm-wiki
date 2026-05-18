---
title: "Progressive Disclosure"
tags: [concept, context-management, agent-engineering, knowledge-management]
sources: [https://medium.com/@AnalyticsAtMeta/how-we-built-an-ai-second-brain-for-60k-knowledge-workers-78c507dd795b]
date: 2026-05-18
---

# Progressive Disclosure

A context loading strategy for AI agents where **minimal, high-level context is always in scope** and **detailed, task-specific context is loaded on demand**. The opposite of context dumping.

Surfaced as a key insight in [[meta|Meta]]'s AI Second Brain deployment (2026): too many context files actively degrades agent output quality.

## The Problem: Context Dumping

Naive agent harness design often loads everything available into the context window:

- All project notes
- All relevant documents
- All previous conversations
- All available tools

This degrades quality because:
1. **Attention dilution** — the model attends over a large noisy context; signal-to-noise ratio drops
2. **Irrelevance** — most of what's loaded has nothing to do with the current task
3. **Context window waste** — tokens spent on irrelevant content are tokens unavailable for reasoning
4. **Coherence degradation** — as context fills with unrelated material, the model's ability to stay on-task deteriorates

## The Solution: Progressive Disclosure

Load context in layers, from least-specific to most-specific, loading each layer only when needed:

```
Layer 1: Root identity + active portfolio (always loaded)
         ↓ (when working on a specific project)
Layer 2: Project-level context (loaded on demand)
         ↓ (when diving into a specific task)
Layer 3: Task-specific files and history (loaded on demand)
```

## Implementation in Meta's PARA Workspace

In [[meta|Meta]]'s [[para-method|PARA workspace]]:

- **Root `CLAUDE.md`** — identity + portfolio overview; loaded automatically every session
- **Per-project `CLAUDE.md`** — detailed project context; loaded when the agent enters that project
- **Task files** — loaded when actually executing the task

The structure tells the agent **what's active and what matters** without overloading it with the entire knowledge graph.

## Relationship to Context Management

Progressive disclosure is a **preventative** [[context-management-for-agents|context management]] strategy. Rather than:
- Waiting for context to fill, then compacting (reactive)
- Resetting context at sprint boundaries (scheduled)

Progressive disclosure keeps context lean from the start by being selective about what enters the context in the first place.

| Strategy | When | Mechanism |
|----------|------|-----------|
| Context compaction | After context fills | Compress existing history |
| Context reset | At session boundaries | Clear and hand off via document |
| **Progressive disclosure** | From the start | Load only what the current task needs |

## Generalizations

The same principle appears across levels of granularity:

- **Harness level**: AGENTS.md ~100 lines (lean) + `docs/` for details (on demand) — see [[harness-engineering]]
- **Workspace level**: Root CLAUDE.md (portfolio) + per-project CLAUDE.md (detail) — see [[para-method]]
- **Wiki level**: `index.md` as entry point + individual pages as depth — see [[llm-wiki-pattern]]

In each case: a lightweight index or summary always in scope; deep content fetched only when relevant.

## Related

- [[context-management-for-agents]] — complementary strategies: compaction, reset, and disclosure
- [[para-method]] — PARA workspace implements progressive disclosure structurally
- [[harness-engineering]] — AGENTS.md is lean index; docs/ is progressive depth
- [[llm-wiki-pattern]] — index.md + page-by-page depth is the same pattern
- [[skills-as-markdown]] — skills can implement progressive loading within a task
- [[how-we-built-an-ai-second-brain-for-60k-knowledge-workers-meta]] — Meta case study
