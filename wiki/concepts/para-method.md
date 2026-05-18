---
title: "PARA Method"
tags: [concept, knowledge-management, productivity, agent-context, second-brain]
sources: [https://medium.com/@AnalyticsAtMeta/how-we-built-an-ai-second-brain-for-60k-knowledge-workers-78c507dd795b]
date: 2026-05-18
---

# PARA Method

A hierarchical folder taxonomy for organizing personal knowledge, originally designed for humans and later adapted as a **context architecture for AI agents**.

Coined by [[tiago-forte|Tiago Forte]] in his book *Building a Second Brain*.

## Original Definition (Human Knowledge Management)

PARA stands for four universal categories that span all types of projects and information:

| Category | Definition | Examples |
|----------|-----------|---------|
| **Projects** | Short-term efforts with a defined goal and deadline | Launch Q3 campaign, write blog post, fix production bug |
| **Areas** | Long-term responsibilities without an end date | Career development, team management, health |
| **Resources** | Topics of ongoing interest that may become useful | Research on LLM architectures, reading notes, reference material |
| **Archives** | Inactive items from the other three categories | Completed projects, outdated areas, old resources |

## Adaptation for AI Agents (Meta's "Second Brain")

[[meta|Meta]]'s analytics team adapted PARA into a **context architecture** for their [[agentic-ai-system|AI agent]]. The key insight: the folder structure tells the agent what's active, what's important, and where new information should be stored.

Implementation in Meta's system:

- **Root `CLAUDE.md`** — identity + active portfolio; loaded every session automatically
- **Per-project `CLAUDE.md`** — detailed project context; loaded on demand when the agent works within that project
- **[[progressive-disclosure|Progressive disclosure]]** governs loading: lean top-level context always in scope, deep detail only fetched when the task requires it

This solves the **finite context window problem** without wasting tokens on irrelevant information.

## PARA as Harness Infrastructure

In the [[harness-engineering|harness engineering]] framing, a PARA workspace is a **feedforward guide** structure:

- The root CLAUDE.md acts as a lightweight table of contents (analogous to AGENTS.md in engineering harnesses)
- Per-project CLAUDE.md files act as deep knowledge accessed progressively
- The LLM is constrained by the structure to know what's active vs archived

This mirrors the [[llm-wiki-pattern|LLM-wiki pattern]]'s schema (CLAUDE.md/AGENTS.md) — both are forms of structured context management for agents.

## Contrast with Alternatives

| Approach | Context loading | Problem |
|----------|----------------|---------|
| **Flat files** | Load everything | Context pollution; quality degrades |
| **RAG** | Retrieve chunks at query time | No persistent structure; no compilation |
| **PARA workspace** | Root always + project on demand | Structured progressive loading |

## Related

- [[progressive-disclosure]] — the loading strategy that makes PARA work for agents
- [[context-management-for-agents]] — PARA as a solution to context degradation
- [[llm-wiki-pattern]] — parallel pattern: structured external knowledge for LLM queries
- [[harness-engineering]] — PARA workspace is a feedforward guide harness
- [[skills-as-markdown]] — the agent workflows that operate within the PARA workspace
- [[tiago-forte]] — originator of the PARA method
- [[how-we-built-an-ai-second-brain-for-60k-knowledge-workers-meta]] — Meta's production deployment case study
