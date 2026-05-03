---
title: "Wiki Log"
tags: [meta, log]
date: 2026-05-02
---

# Wiki Log

Chronological record of ingests, queries, and maintenance.

---

## 2026-05-02 | lint | fix warnings W1–W5

**Issues fixed:**
- W1: Added `sources:` and `type: person` to `entities/birgitta-bockeler.md` frontmatter
- W2: Added `type: organization` to `entities/openai.md` and `entities/anthropic.md`
- W3: Promoted `### Organizations/People/Tools` to H2 in `index.md`; removed redundant `## Entities`
- W4: Created `entities/prithvi-rajasekaran.md`; wikilinked his name in `harness-design-long-running-apps.md`, `generator-evaluator-architecture.md`, `anthropic.md`; added to index
- W5: Added `aliases: ["Self-Evaluation Blindness"]` to `generator-evaluator-architecture.md`; wikilinked "self-evaluation blindness" in `harness-design-long-running-apps.md`

---

## 2026-05-02 | ingest | fowler-harness-engineering

**Source:** https://martinfowler.com/articles/harness-engineering.html
**Author:** Birgitta Böckeler (ThoughtWorks), published on martinfowler.com
**Pages created:**
- `sources/fowler-harness-engineering.md` — full source summary
- `concepts/guides-and-sensors.md` — new concept: feedforward guides vs feedback sensors in harness design
- `concepts/harnessability.md` — new concept: codebase property enabling effective harness controls
- `entities/birgitta-bockeler.md` — entity: Böckeler (author, ThoughtWorks)

**Pages updated:**
- `concepts/harness-engineering.md` — added Böckeler's framework (guides/sensors, three harness categories, harnessability, human implicit harness)
- `index.md` — added 4 new entries (1 source, 2 concepts, 1 person entity; added People section)

**Key topics ingested:** guides vs sensors (feedforward/feedback), computational vs inferential execution, maintainability/architecture-fitness/behaviour harness categories, harnessability, ambient affordances (Ned Letcher), Ashby's Law applied to harness coverage, harness templates, human implicit harness

---

## 2026-05-02 | ingest | harness-design-long-running-apps

**Source:** https://www.anthropic.com/engineering/harness-design-long-running-apps
**Author:** Prithvi Rajasekaran (Anthropic)
**Pages created:**
- `sources/harness-design-long-running-apps.md` — full source summary
- `concepts/generator-evaluator-architecture.md` — new concept: GAN-inspired gen/eval loop
- `concepts/sprint-contracts.md` — new concept: pre-negotiated agent success criteria
- `concepts/context-management-for-agents.md` — new concept: context degradation, anxiety, resets
- `entities/anthropic.md` — entity: Anthropic
- `entities/claude.md` — entity: Claude (Sonnet 4.5, Opus 4.6)

**Pages updated:**
- `concepts/harness-engineering.md` — added Anthropic perspective + links to new concept pages
- `index.md` — added 6 new entries

**Key topics ingested:** generator-evaluator architecture, sprint contracts, context anxiety, context resets vs compaction, self-evaluation blindness, multi-agent harness design, model-aware harness assumptions

---

## 2026-05-02 | ingest | harness-engineering

**Source:** https://openai.com/index/harness-engineering/
**Pages created:**
- `sources/openai-harness-engineering.md` — full source summary
- `concepts/harness-engineering.md` — concept: harness engineering methodology
- `entities/openai.md` — entity: OpenAI
- `entities/codex.md` — entity: Codex (OpenAI coding agent)
- `index.md` — initial index created
- `log.md` — this file

**Key topics ingested:** agent-first development, harness engineering, repository legibility, architectural constraints for agents, merge philosophy at high throughput, entropy management

---

## 2026-05-02 | ingest | stripe-minions-one-shot-coding-agents

**Source:** https://stripe.dev/blog/minions-stripes-one-shot-end-to-end-coding-agents

**Pages created:**
- `sources/stripe-minions-one-shot-coding-agents.md` — full source summary
- `entities/Stripe.md` — entity: Stripe (company)

**Pages updated:**
- `index.md` — added source and Stripe entity entries

**Key topics ingested:** one-shot coding agents, blueprint system as guides, pre-push hooks as sensors, parallel worktree isolation, monorepo harnessability, end-to-end agent loop (plan → implement → verify → PR)

## 2026-05-02 | ingest | anthropic-effective-harnesses

**Source:** https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents
**Authors:** Justin Young, Anthropic Engineering team

**Pages created:**
- `sources/anthropic-effective-harnesses.md` — full source summary
- `concepts/initializer-coding-agent-architecture.md` — new concept: two-role split (initializer + coding agent) for cross-session continuity
- `concepts/feature-list-pattern.md` — new concept: JSON feature enumeration to prevent one-shotting and premature completion

**Pages updated:**
- `concepts/harness-engineering.md` — added Anthropic's mid-2026 research on long-running agent harnesses (initializer-coding architecture, feature list pattern, browser automation testing)
- `concepts/One-Shot Agent.md` — added cross-reference to Initializer-Coding Agent Architecture
- `index.md` — added 3 new entries (1 source, 2 concepts)
- `raw/text/anthropic-effective-harnesses.md` — full article text source

**Key topics ingested:** two-part agent architecture (initializer + coding agent), four failure modes (one-shotting, premature completion, buggy state, premature test passing), feature list JSON pattern, claude-progress.txt, session continuity, browser automation testing (Puppeteer MCP), multi-agent future directions

---

## 2026-05-02 | ingest | finops-framework-principles

**Source:** https://www.finops.org/framework/principles/
**Org:** FinOps Foundation

**Pages created:**
- `sources/finops-framework-principles.md` — full source summary of six FinOps principles
- `concepts/finops.md` — new concept: FinOps as operating model for cloud financial accountability

**Pages updated:**
- `concepts/harness-engineering.md` — added cross-reference to FinOps (shared patterns: centralized enablement + decentralized execution)
- `index.md` — added 1 source + 1 concept entry
- `raw/text/finops-framework-principles.md` — full source text

**Key topics ingested:** six FinOps principles (collaboration, business value, ownership, data transparency, central enablement, variable cost model), centralized enablement + decentralized execution model, cost as first-class metric, FOCUS data normalization

---

## 2026-05-02 | ingest | finops-getting-started-gcp

**Source:** Google Cloud Technical Paper — "Getting Started with FinOps on GCP" (PDF)
**Authors:** Sam Moss, Kinjal Tanna, Tan-Minh Truong (Google Cloud)
**Date:** May 2021

**Pages created:**
- `sources/finops-getting-started-gcp.md` — full source summary of Google Cloud FinOps framework
- `raw/finops-getting-started-gcp.pdf` — original PDF source
- `raw/text/finops-getting-started-gcp.md` — extracted text from PDF

**Pages updated:**
- `sources/finops-getting-started-gcp.md` — updated with full content
- `concepts/finops.md` — added GCP FinOps lifecycle (inform, optimize, operate) with Epics and cultural principles
- `wiki/index.md` — added new source entry for FinOps GCP framework
- `wiki/log.md` — appended this ingest record

**Key topics ingested:** seven cultural principles (variable nature of cloud, business-value decisions, accountability, collaboration, blamelessness, data democratization, agility), FinOps Central Team structure (anti-pattern: becoming cost optimization team), three-phase lifecycle (inform → optimize → operate) with GCP-specific Epics, GCP tools (BigQuery billing export, Recommender API, budgets & alerts), unit economics for value measurement

---

## 2026-05-02 | ingest | agentic-ai-reference-architecture

**Source:** Architecture reference diagram (PNG image)
**Image:** `raw/agentic-ai-reference-architecture.jpg`

**Pages created:**
- `sources/agentic-ai-reference-architecture.md` — full source summary of 9-layer architecture
- `concepts/agentic-ai-system.md` — concept page: agentic AI system architecture with harness engineering relationships

**Pages updated:**
- `wiki/index.md` — added 1 source + 1 concept entry
- `wiki/log.md` — appended this ingest record

**Key topics ingested:** 9-layer architecture (user/client, orchestration, specialized agents, tools/integrations, memory/knowledge, monitoring/observability, reliability/failure management, governance/security, infrastructure), 5 agent roles (research, reasoning, action, data, communication), 5-step data flow, orchestrator pattern mirrors initializer-coding-agent architecture, specialized agents mirror generator-evaluator architecture, memory layer addresses context management for agents, observability + reliability layers mirror guides-and-sensors pattern

---

## 2026-05-02 | ingest | semantic-layer-duckdb-tutorial

**Source:** https://motherduck.com/blog/semantic-layer-duckdb-tutorial/
**Author:** Stefan Späti (MotherDuck Blog)
**Topic:** Why Semantic Layers Matter — and How to Build One with DuckDB

**Pages created:**
- `sources/semantic-layer-duckdb-tutorial.md` — full source summary
- `concepts/semantic-layer.md` — new concept: semantic layer as virtual translation layer

**Pages updated:**
- `wiki/index.md` — added 1 source + 1 concept entry
- `log.md` — appended this ingest record
- `concepts/finops.md` — added cross-reference to semantic-layer

**Key topics ingested:** semantic layer definition (virtual translation layer between DB and consumers), 5 use cases (unified metrics, caching/federation, unified security, dynamic query rewriting, LLM context), when NOT to use one, Boring Semantic Layer (BSL) + Ibis + DuckDB example, NYC Taxi dataset (20M records), YAML metric definitions, physical vs logical distinction, enterprise tools (Cube, dbt SL, GoodData, AtScale)

---

## 2026-05-02 | ingest | dbt-semantic-layer-introduction

**Source:** https://www.getdbt.com/blog/semantic-layer-introduction
**Author:** dbt Labs blog

**Pages created:**
- `sources/dbt-semantic-layer-introduction.md` — source summary of semantic layer overview and use cases
- `sources/naming-conventions-for-semantic-layers.md` — source summary of gold-layer design for AI (Microsoft Fabric)

**Pages updated:**
- `wiki/index.md` — added 2 source entries
- `wiki/log.md` — appended this ingest record

**Key topics (dbt blog):** hub-and-spoke architecture, five use cases (BI reporting, embedded analytics, AI/LLMs, self-serve analytics, exploratory analytics), data explosion problem (61% orgs use 4+ BI tools), DRY principle for metrics, dbt Semantic Layer codifying metrics alongside models
**Key topics (Microsoft gold layers):** entity-oriented table design, star schema, business-friendly naming, AI documentation (descriptions truncated at 200 chars), hiding technical columns, linguistic modeling (synonyms + relationships)

---

## 2026-05-02 | ingest | thoughtworks-five-differences-cloud-cost-finops

**Source:** https://www.thoughtworks.com/en-us/insights/blog/cloud/5_cloud_cost_management_finops
**Author:** ThoughtWorks Blog

**Pages created:**
- `sources/thoughtworks-five-differences-cloud-cost-finops.md` — source summary of 5 differences between cost management and FinOps
- `wiki/index.md` — added source entry
- `wiki/log.md` — appended ingest record

**Key topics ingested:** 5 differences (goals, scope, approach, focus, breadth of optimization), cloud cost management = reactive/siloed/financial-only, FinOps = proactive/collaborative/financial + non-financial, cultural difference (everyone collectively owns cost management), metrics comparison (cost reduction vs. optimization for business value)

---

## 2026-05-03 | ingest | harness-engineering-claude-code-book

**Source:** https://harness-books.agentway.dev/en/book1-claude-code/
**Published:** 2026-04-01
**Format:** Online book — 9 chapters + 3 appendices

**Pages created:**
- `sources/harness-engineering-claude-code-book.md` — full book summary with chapter analysis, five harness layers, prompt control plane, query loop skeleton, ten principles
- `wiki/index.md` — added source entry
- `wiki/log.md` — appended ingest record

**Key topics ingested:** models as unstable components, prompt as control plane/constitution not persona, query loop as heartbeat with stateful execution, tool scheduling discipline, context governance (memory/CLAUDE.md/compact), recovery as main path (not afterthought), multi-agent for partitioning uncertainty, independent verification, team institutions over personal tricks. Five harness layers: constrained conversation, continuous loop, tool scheduling, high-risk rules, errors as main path. Three distilled conclusions: harness over excitement, institutions over cleverness, verification over confidence.
