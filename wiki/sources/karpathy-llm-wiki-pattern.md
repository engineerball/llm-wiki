---
title: "A Pattern for Building Personal Knowledge Bases using LLMs (Karpathy)"
tags: [source, wiki-pattern, knowledge-management, agents, methodology]
sources: [https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f]
date: 2026-05-05
author: andrej-karpathy
---

# A Pattern for Building Personal Knowledge Bases using LLMs

Karpathy's foundational idea file describing the LLM-maintained wiki pattern. This gist outlines a structured approach to building a persistent, compounding knowledge base where the LLM writes and maintains a wiki rather than just retrieving from raw documents at query time.

**URL:** https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f

## Core Idea: Wiki > RAG

> Instead of retrieving from raw documents at query time, the LLM incrementally builds and maintains a persistent wiki — a structured, interlinked collection of markdown files.

Standard RAG: upload files → retrieve chunks at query time → generate answer. The LLM rediscovers knowledge from scratch every time.

Wiki pattern: raw sources → LLM reads, extracts, synthesizes → writes structured, interlinked wiki pages. Knowledge is compiled once and kept current, not re-derived on every query.

> The wiki is a persistent, compounding artifact. Cross-references are already there. Contradictions are already flagged. Synthesis reflects everything you've read.

## Three Layers

### 1. Raw Sources
- Curated collection of documents: articles, papers, images, data
- **Immutable** — LLM reads but never modifies
- Source of truth

### 2. The Wiki
- Directory of LLM-generated markdown files
- Summaries, entity pages, concept pages, comparisons, synthesis
- **LLM owns this layer entirely** — creates, updates, maintains cross-references
- Human reads; LLM writes

### 3. The Schema
- Configuration document (CLAUDE.md, AGENTS.md) telling the LLM how the wiki is structured
- Conventions, workflows, ingest procedures
- Co-evolved by human and LLM over time

## Three Core Workflows

### Ingest
- Drop a new source into the raw collection
- LLM reads source, discusses takeaways, writes summary page, updates index, updates entity/concept pages, appends to log
- A single source might touch 10-15 wiki pages
- Can be done one-at-a-time (guided) or batch (autonomous)

### Query
- Ask questions against the wiki
- LLM searches, reads, synthesizes with citations
- Answers can be filed back into the wiki as new pages — explorations compound

### Lint
- Periodic health check: contradictions, stale claims, orphan pages, missing cross-references, data gaps
- LLM suggests new questions and sources to investigate

## Special Files

### index.md (Content-Oriented)
- Catalog of everything in the wiki
- Link + one-line summary per page, optional metadata
- Organized by category
- LLM updates on every ingest
- **Avoids need for embedding-based RAG at moderate scale** (~100 sources, hundreds of pages)

### log.md (Chronological)
- Append-only record of what happened and when
- Consistent prefixes make it parseable with unix tools
- `grep "^## \[" log.md | tail -5` → last 5 entries
- Timeline of wiki evolution

## Tooling Recommendations
- **qmd** — local search for markdown (BM25 + vector + LLM re-ranking, CLI + MCP server)
- **Obsidian** — Web Clipper, graph view, download attachments
- **Marp** — markdown-based slide decks
- **Dataview** — queries over page frontmatter for dynamic tables
- **Git** — version history, branching, collaboration for free

## Design Philosophy

> The tedious part of maintaining a knowledge base is not the reading or the thinking — it's the bookkeeping. LLMs don't get bored, don't forget to update a cross-reference, and can touch 15 files in one pass. The wiki stays maintained because the cost of maintenance is near zero.

> The human's job is to curate sources, direct the analysis, ask good questions, and think about what it all means. The LLM's job is everything else.

## Historical Context

Related to **Vannevar Bush's Memex (1945)** — personal, curated knowledge store with associative trails between documents. The key unsolved problem Bush couldn't address: who does the maintenance. The LLM solves that.

## Connections to Other Sources

- [[llm-wiki-pattern]] — concept page distilled from this gist
- This gist IS the foundational document of the llm-wiki pattern; this wiki itself is an instantiation of it

## Key Entities

- [[andrej-karpathy]] — AI researcher, former OpenAI/Tesla AI Director; author of this pattern document
