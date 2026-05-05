---
title: "Hot Cache"
tags: [meta]
date: 2026-05-05
---

# Hot Cache

Last ingest context for fast session resumption.

---

## Last Ingest: A Pattern for Building Personal Knowledge Bases using LLMs (Karpathy)

**Source:** https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f
**Pages created:**
- `wiki/sources/karpathy-llm-wiki-pattern.md` — the full gist summary: wiki > RAG, 3 layers, 3 workflows (ingest/query/lint), index.md + log.md pattern
- `wiki/concepts/llm-wiki-pattern.md` — concept page: wiki vs RAG comparison, design philosophy, harness engineering relationship, scale properties
- `wiki/entities/andrej-karpathy.md` — entity page for Andrej Karpathy

**Pages updated:**
- `wiki/concepts/harness-engineering.md` — added llm-wiki-pattern reference to Related Concepts
- `wiki/concepts/context-management-for-agents.md` — added llm-wiki-pattern reference (externalizing knowledge outside context window)
- `wiki/index.md` — added concept, source, entity, person entries
- `wiki/log.md` — prepended ingest entry

### Key Facts
- **Wiki > RAG**: persistent compounding artifact vs retrieval-from-scratch; cross-references, contradictions, synthesis are pre-computed
- **3 layers**: Raw sources (immutable), Wiki (LLM-owned), Schema (config for LLM conventions)
- **3 workflows**: Ingest (touch 10-15 pages), Query (synthesize answers, file back as wiki pages), Lint (health check)
- **Scale**: index.md works at ~100 sources; beyond that use qmd or similar local search
- **Division of labor**: Human = curate sources, direct analysis, ask questions, think. LLM = everything else (summarizing, cross-references, filing, bookkeeping)
- **Historical context**: Vannevar Bush's Memex (1945) — same vision but couldn't solve the maintenance problem
- **This wiki IS an instantiation of this pattern** — meta!

### Prior Ingest: Databricks Semantic Layer (2026-05-05)
- Platform-native as 4th semantic layer type; AI agent Grounding → Execution pattern; "dangerously plausible" framing

### Earlier Ingest: Best Open-Source Semantic Layer Tools (2026-05-05)
- 7 tools: Cube, dbt SL, MetriQL, Malloy, Lightdash, Evidence, DataForge
- 3 patterns: metrics-as-code, headless API, semantic modeling language
