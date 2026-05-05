---
title: "Wiki Log"
tags: [meta, log]
date: 2026-05-02
---

# Wiki Log

Chronological record of ingests, queries, and maintenance.

---

## 2026-05-05 | ingest | Scaling Deep Retrieval — Two Towers (Google Cloud)

- Source: `.raw/articles/scaling-deep-retrieval-tensorflow-two-towers-architecture-2026-05-05.md`
- Summary: [[two-towers-deep-retrieval-google-cloud]]
- Pages created: [[two-towers-deep-retrieval-google-cloud]], [[two-tower-architecture]], [[approximate-nearest-neighbors]], [[recommendation-systems]], [[tensorflow-recommenders]], [[vertex-ai-matching-engine]]
- Pages updated: [[google]], `index.md`
- Key insight: Two-tower's core advantage is decoupled inference — candidate embeddings precomputed offline, serving = query embedding + ANN lookup; training data feature choice directly determines the geometry of the embedding space (title pairs → title similarity, audio pairs → audio similarity).

---

## 2026-05-05 | ingest | Agent Gateway — Kubernetes Docs

- Source: `.raw/articles/agentgateway-kubernetes-latest-2026-05-05.md`
- Summary: [[agentgateway-kubernetes-docs]]
- Pages created: [[agentgateway-kubernetes-docs]], [[agentgateway]], [[linux-foundation]], [[llm-gateway]]
- Pages updated: [[agentic-protocol-stack]], `index.md`
- Key insight: Agent Gateway is the missing network-layer implementation of the agentic protocol stack — a single Rust proxy that handles MCP/A2A/LLM routing with enterprise security, answering "how do you actually run MCP+A2A at scale in Kubernetes."

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

---

## 2026-05-03 | ingest | cdp-comparison-2026

**Source:** https://medium.com/@community_md101/9-best-customer-data-platforms-cdps-in-2026-in-depth-look-3983adabf759
**Author:** Swami Achari (Modern Data 101)

**Pages created:**
- `concepts/customer-data-platform.md` — CDP concept page: what is a CDP, 3 core functions (unification, IDR, activation), CDP vs CRM vs DMP comparison, packaged vs composable, 5 selection criteria, 9 platforms reviewed, pitfalls, ROI measurement, future trends
- `sources/cdp-comparison-2026.md` — source summary of 9 best CDPs in 2026
- `wiki/index.md` — added source and concept entries

**Key topics ingested:** CDP definition (unification + identity resolution + activation), CDP vs CRM vs DMP, packaged vs composable (warehouse-native), 5 selection criteria (IDR strength, real-time <300ms, silo test, governance, AI readiness), 9 platforms (Twilio Segment, DataOS, Salesforce Data Cloud, Adobe Real-Time CDP, Tealium, ActionIQ, Amperity, Treasure Data, Insider), pitfalls (vendor lock-in, GIGO, compliance risk), ROI measurement (incremental revenue, not "profiles created"), trends (AI copilot, embedded activation, composability, zero-party data)

---

## 2026-05-04 | rebuild entities | 8 new entity pages

**Organizations created:**
- `entities/google.md` — UCP/A2A creator, Google AI Mode/Gemini, GCP FinOps author
- `entities/thoughtworks.md` — Böckeler's employer; harness engineering + FinOps blog
- `entities/finops-foundation.md` — defines FinOps framework, lifecycle, FOCUS standard
- `entities/microsoft.md` — Microsoft Fabric gold-layer naming, MCP co-governance, WebMCP
- `entities/dbt-labs.md` — creator of dbt and dbt Semantic Layer; hub-and-spoke model
- `entities/fountain-city.md` — agentic protocol readiness guidance, AEO/GEO data

**People created:**
- `entities/vijayaraghavan-v.md` — UCP interoperability article (LinkedIn, Jan 2026); 4-layer stack diagram
- `entities/swami-achari.md` — CDP comparison article (Modern Data 101, 2026)

**Index updated:** added 6 org entries + 2 people entries

---

## 2026-05-04 | rebuild concept | UCP + agentic commerce

**3 concept pages created:**
- `concepts/ucp.md` — Universal Commerce Protocol: N×N problem, capability negotiation, `/.well-known/ucp`, checkout flow, transport agnosticism, strategic timeline
- `concepts/agentic-commerce.md` — AI agents executing purchases autonomously; the shift from human UX to agent experience; $500B projection; UCP vs ACP competition; 5-point readiness checklist
- `concepts/agentic-protocol-stack.md` — 4-layer architecture (L1 A2A / L2 MCP / L3 UCP / L4 AP2); layer composition diagram; end-to-end business trip example; governance table

**Index updated:** added 3 new concept entries

## 2026-05-04 | ingest | ap2-protocol.net

**Source:** https://ap2-protocol.net/en/ (Google Agentic Commerce)
**Cross-ref:** [[ucp-interoperability-mcp-a2a-ap2]], [[agentic-commerce]], [[agentic-protocol-stack]]

**Pages created:**
- `sources/ap2-agent-payments-protocol-2026.md` — full source: what is AP2, core principles, 3 VC types (Intent Mandate, Cart Mandate, Payment Mandate), role-based architecture, L4 in protocol stack, samples (cards/x402/Android), key URLs
- `concepts/ap2-agent-payments-protocol.md` — concept page distilled from source + existing UCP/AP2 interop page: why AP2 exists, VC types, role architecture diagram, payment methods (current vs roadmap), AP2 vs ACP comparison

**Key topics ingested:** Verifiable Intent vs Inferred Action, non-repudiable cryptographic signatures, 3 VC types with distinct scenarios/contents, 6 roles (User/UA/CP/ME/MPP/Network+Issuer), human-present vs human-not-present flows, pull vs push payments, AP2 vs ACP strategic comparison, Google samples (cards/x402/Android DPC)

---

## 2026-05-03 | ingest + lint | UCP + agentic protocols

**3 new pages added:**
- `ucp-universal-commerce-protocol.md` — Google UCP overview (source: Google Developers Blog, Jan 2026)
- `ucp-interoperability-mcp-a2a-ap2.md` — 4-layer protocol stack (A2A/MCP/UCP/AP2), end-to-end travel use case (source: LinkedIn/Vijayaraghavan)
- `agentic-protocols-for-websites-2026.md` — protocol readiness guide for websites, 5-point checklist (source: Fountain City Tech)

**Lint actions:**
- Updated `index.md` — added all 3 UCP pages, added missing `[[one-shot-agent]]` concept, updated date
- Fixed cross-references in `ucp-interoperability-mcp-a2a-ap2.md` — raw paths → wikilinks
- Verified: no broken wikilinks (only false positives from code blocks), no orphan pages in wiki/ directory
