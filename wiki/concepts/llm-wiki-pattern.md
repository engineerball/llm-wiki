---
title: "LLM-Wiki Pattern"
tags: [concept, knowledge-management, wiki-pattern, agents]
sources: [https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f]
date: 2026-05-05
---

# LLM-Wiki Pattern

A knowledge management pattern where an LLM incrementally builds and maintains a persistent wiki from raw sources, rather than retrieving from documents at query time like RAG.

Originated by [[andrej-karpathy]] in his gist "A Pattern for Building Personal Knowledge Bases using LLMs".

## Core Distinction: Wiki vs RAG

| RAG | LLM-Wiki |
|-----|----------|
| Upload files → retrieve chunks at query time | LLM reads sources → writes persistent wiki pages |
| Knowledge rediscovered from scratch every query | Knowledge compiled once, kept current |
| No accumulation | Compounding artifact |
| Raw documents as retrieval corpus | Synthesized wiki as query target |

> "The wiki is a persistent, compounding artifact. The cross-references are already there. The contradictions have already been flagged. The synthesis already reflects everything you've read."

## Three Layers

1. **Raw Sources** — Immutable curated collection of documents. LLM reads, never modifies.
2. **The Wiki** — LLM-generated markdown files (summaries, entities, concepts, comparisons). LLM owns this layer entirely.
3. **The Schema** — Configuration document (AGENTS.md, CLAUDE.md) telling the LLM structure, conventions, workflows. Co-evolved by human and LLM.

## Three Core Workflows

- **Ingest**: New source → LLM reads → writes summary, updates entity/concept pages, updates index, appends to log. A single source might touch 10-15 wiki pages.
- **Query**: Ask questions → LLM searches wiki → synthesizes answer → good answers filed back as wiki pages. Explorations compound.
- **Lint**: Periodic health check → contradictions, stale claims, orphan pages, missing cross-references, data gaps.

## Design Philosophy

> The tedious part of maintaining a knowledge base is not the reading or the thinking — it's the bookkeeping. LLMs don't get bored, don't forget to update a cross-reference, and can touch 15 files in one pass.

**Division of labor:**
- Human: curate sources, direct analysis, ask good questions, think about meaning
- LLM: summarizing, cross-referencing, filing, bookkeeping, maintenance

## Historical Context

Related to Vannevar Bush's **Memex (1945)** — personal, curated knowledge store with associative trails between documents. The key problem Bush couldn't solve: who does the maintenance. The LLM solves that.

## Scale

The `index.md` approach works surprisingly well at moderate scale (~100 sources, hundreds of pages) and avoids the need for embedding-based RAG infrastructure. Beyond that, local search tools like `qmd` (BM25 + vector + LLM re-ranking) become useful.

## Relationship to Harness Engineering

The LLM-wiki pattern is itself a **harness**: the schema (AGENTS.md, CLAUDE.md) acts as the [[guides-and-sensors|guides]] constraining the LLM's wiki-writing behavior; the index, log, and page structure act as [[guides-and-sensors|sensors]] providing feedback on completeness and consistency.

## Relationship to Personal Agent Harnesses

[[meta|Meta]]'s "AI Second Brain" (2026) is a close sibling pattern:

| LLM-Wiki | Meta Second Brain |
|----------|-------------------|
| LLM writes persistent wiki pages from raw sources | LLM writes structured workspace from work history |
| Schema (CLAUDE.md) as guides | PARA workspace (CLAUDE.md per project) as guides |
| Index + log as sensors | Meeting notes, task status as sensors |
| Humans curate sources | Agent scans internal tools for sources |
| Knowledge compounds via cross-links | Knowledge compounds via skills + shared layers |

Both patterns externalize knowledge outside the LLM's finite context window; both use [[progressive-disclosure]] to keep context lean; both compound over time rather than re-deriving knowledge from scratch on each query.

See [[how-we-built-an-ai-second-brain-for-60k-knowledge-workers-meta]] and [[para-method]].

## Related Concepts

- [[harness-engineering]] — the LLM-wiki pattern is a harness that constrains and directs LLM behavior for knowledge management
- [[guides-and-sensors]] — the schema = guides; index/log = sensors for wiki health
- [[agentic-ai-system]] — the wiki is the knowledge layer in an agentic system; the LLM is the planning/execution layer
- [[context-management-for-agents]] — the wiki solves context degradation: instead of stuffing raw documents into a limited context window, the LLM maintains external knowledge
- [[karpathy-llm-wiki-pattern]] — original Karpathy gist introducing the pattern
- [[progressive-disclosure]] — the index.md + individual pages structure is a form of progressive disclosure
- [[para-method]] — PARA workspace is a parallel compounding-knowledge structure for active work
- [[skills-as-markdown]] — skills compound like wiki pages: community-built, reusable, composable
