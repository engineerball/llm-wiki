---
title: "Hot Cache"
tags: [meta]
date: 2026-05-05
---

# Hot Cache

Last ingest context for fast session resumption.

---

## Last Ingest: Best Open-Source Semantic Layer Tools in 2026 (2026-05-05)

**Source:** <https://levelup.gitconnected.com/best-open-source-semantic-layer-tools-in-2026-f99565169ccc>
**Raw file:** `.raw/articles/best-open-source-semantic-layer-tools-in-2026-2026-05-05.md`
**Author:** Sergey Gromov | Level Up Coding

### Pages Created
- `wiki/sources/best-open-source-semantic-layer-tools-2026.md` — survey of 7 tools + 3 patterns
- `wiki/entities/cube.md` — headless semantic layer entity page

### Pages Updated
- `wiki/concepts/semantic-layer.md` — added Metric Drift section, Architectural Patterns table, expanded tool landscape (8 tools)
- `wiki/index.md` — added 1 source entry, 1 entity entry
- `wiki/log.md` — prepended ingest entry

### Key Facts to Remember
- **Metric drift**: same metric → different values across systems; root cause = semantic logic embedded in individual BI tools
- **3 patterns**: metrics-as-code (dbt SL, MetriQL), headless API layer (Cube), semantic modeling language (Malloy)
- **Cube**: headless/API-first; best for AI agent consumption; REST/GraphQL/SQL; pre-aggregation engine
- **dbt SL**: metrics-as-code; Git-native; generates SQL only; no standalone API — weaker for agent access
- **Malloy**: Google DSL; positioned for AI-assisted query generation
- **Lightdash/Evidence**: NOT standalone semantic layers — BI tool and app framework respectively
- **AI direction**: semantic layers → "data interpretation contracts" for agents, not just BI; API-first wins

### Prior Ingest: UCP Official Specification (2026-05-05)
- Raw: `.raw/articles/ucp-specification-overview-2026-05-05.md`
- Pages: `ucp-specification-overview`, `ucp-negotiation-protocol`, `ucp-payment-handlers`; updated `ucp.md`
- Handler model: handlers are specs not entities; platform executes to acquire tokens
- Scenario C: AP2 mandate, signed VC as credential, no token needed
