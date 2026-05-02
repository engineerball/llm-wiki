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
