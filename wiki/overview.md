---
title: "Overview"
tags: [meta, overview, synthesis]
date: 2026-05-25
---

# Wiki Overview

High-level synthesis of this wiki's seven knowledge domains. Each domain has its own concept pages, source summaries, and entity pages — linked throughout. This page is the map.

---

## 1. Agentic AI & Harness Engineering

The central thread of this wiki. **Harness Engineering** — coined by OpenAI and extended by Böckeler, Anthropic, and Trae — is the discipline of designing the scaffolding, environments, and feedback loops that make AI agents reliable. The engineer's job shifts from writing code to designing constraints.

Key ideas:
- A **harness** is everything surrounding an agent: AGENTS.md, CI/CD, linters, tests, repo structure, observability. "If the agent can't see it, it doesn't exist."
- **[[guides-and-sensors]]** — the core control taxonomy: Guides (feedforward, steer before action) vs Sensors (feedback, observe after action). Both required for closed-loop reliability.
- **[[harnessability]]** — the codebase property determining how effective harness controls can be; increases with strong typing, clear boundaries, and defined service topologies.
- **[[generator-evaluator-architecture]]** — the dominant multi-agent pattern: one agent generates, another evaluates; separates concerns and avoids LLM self-evaluation blindness.
- **[[context-management-for-agents]]** — long-running agents face context degradation and context anxiety; the wiki pattern (external persistent knowledge) is one mitigation.
- **[[agentic-ai-system]]** — a 9-layer reference architecture spanning User, Orchestration, Agent, Tools, Memory, Knowledge, Gateway, Security, and Observability layers.

**Agent sandbox security** has become a distinct sub-domain. The reference implementation is the NemoClaw / OpenShell / OpenClaw stack (NVIDIA, alpha 2026):

```
NemoClaw (orchestration: CLI + Plugin + Blueprint)
  └── OpenShell (isolation: gateway + policy enforcement)
        └── OpenClaw (agent: tools + memory + behavior)
```

**[[agent-sandbox-security]]** synthesizes the full threat model and mitigation pattern across four deny-by-default layers:

| Layer | Key Mechanism | Insight |
|---|---|---|
| **Network** | Binary-scoped + L7 rules | SHA256 hash of `/proc/<pid>/exe`; L7 terminates TLS and inspects HTTP method/path per request |
| **Filesystem** | Landlock LSM | Kernel allow-list; read-only system paths; only `/sandbox` and `/tmp` writable |
| **Process** | Capability drops + user separation | `CAP_SYS_ADMIN`, `CAP_NET_RAW`, etc. dropped; gateway/sandbox user split blocks "fake-HOME" attack |
| **Inference** | Credential isolation via `inference.local` | Provider keys never enter container; adding provider hosts to network policy bypasses this |

The Nebius community guide ([[nebius-openclaw-security]]) and Microsoft analysis ([[running-openclaw-safely]]) frame the same threat from the operator perspective — supply chain attacks, memory poisoning via `MEMORY.md`, API key harvesting. Both sources agree: treat agents as **untrusted code execution with persistent credentials**.

→ Start with [[harness-engineering]], then [[guides-and-sensors]], then [[harnessability]].
→ For the security sub-domain: [[agent-sandbox-security]] → [[nemoclaw]] → [[openShell]] → [[openclaw]].

---

## 2. Agentic Commerce & Protocols

Agentic commerce is the execution of commercial transactions — discovery, negotiation, checkout, payment — by AI agents, without the user touching a merchant website. The infrastructure for this is a **4-layer protocol stack**:

| Layer | Protocol | Role |
|-------|----------|------|
| Tools | MCP | Agent ↔ tool/data access |
| Agents | A2A | Agent ↔ agent communication |
| Commerce | [[ucp\|UCP]] | Agent ↔ merchant checkout |
| Payments | [[ap2-agent-payments-protocol\|AP2]] | Agent ↔ payment network |

**[[ucp]]** (Universal Commerce Protocol, Google/Shopify/Walmart coalition, NRF 2026) handles merchant capability discovery, negotiation via the intersection algorithm, and session management. **[[ap2-agent-payments-protocol]]** adds cryptographic proof of user intent via Verifiable Credentials — agents pay without sharing raw card data.

**[[ucp-negotiation-protocol]]** and **[[ucp-payment-handlers]]** detail how UCP's two main flows work mechanically. The spec's killer feature: the intersection algorithm replaces static API contracts with version-aware capability matching.

Market projection: $500B annual agentic commerce by 2030. AI referral traffic already at ~1% of total website traffic and growing.

→ Start with [[agentic-commerce]], then [[agentic-protocol-stack]], then [[ucp]].

---

## 3. Semantic Layers & Data Architecture

A **[[semantic-layer]]** is a virtual translation layer between physical data warehouses and consumers (BI tools, LLMs, apps). It defines business metrics once — Revenue, Churn, DAU — and serves them consistently across every surface. The core problem it solves: without it, LLMs generate "dangerously plausible" answers from raw SQL that silently violate business logic.

Three modern semantic layer types:
1. **Metrics-as-code** (dbt Semantic Layer / MetricFlow) — version-controlled, code-first
2. **Headless API layer** ([[headless-bi]] — Cube, AtScale) — API-first; decoupled from visualization
3. **Platform-native** (Databricks Unity Catalog) — semantics co-located with governance and lineage

The **[[reliable-semantic-stack]]** framework (Animesh Kumar) prevents **[[semantic-mistrust]]** — where a semantic layer inherits and masks data quality problems from the physical layer. The antidote is **[[data-products]]**: model-first, SLO-governed data assets that establish quality before any semantic layer sits on top.

**[[graph-rag]]** extends RAG with explicit graph relationships — a semantic layer enhanced with ontological definitions becomes a "knowledge-enabled data fabric" that grounds LLM queries in structured business context rather than statistical word associations.

→ Start with [[semantic-layer]], then [[reliable-semantic-stack]], then [[headless-bi]].

---

## 4. Recommendation Systems

Large-scale recommenders use a multi-stage pipeline: **Retrieval** (billions → ~1000 candidates, fast) → **Ranking** (expensive model, score 1000) → **Re-ranking** (business rules, diversity).

**[[two-tower-architecture]]** dominates retrieval: two neural networks (query tower + candidate tower) map to a shared embedding space; serving reduces to nearest-neighbor search. Key design decisions:
- Loss functions: BPR, InfoNCE, in-batch negatives (trade-off: false negatives)
- **[[negative-sampling]]**: random negatives are easy; hard negatives (semantically similar but irrelevant) improve model discrimination
- Serving: **[[approximate-nearest-neighbors]]** (Tree-AH, HNSW, PQ) makes billion-scale retrieval sub-millisecond

**[[mixture-of-experts]]** (MoE) solves the multi-objective ranking problem: separate expert networks specialize (engagement vs satisfaction vs revenue) with a gating network routing each item to relevant experts. MMoE (Multi-gate MoE) is the dominant architecture, used at YouTube, Gmail, Kuaishou.

**[[cold-start-problem]]**: new users/items have no interaction history — ID-based collaborative filtering fails completely. Feature-based representations (content, context, demographics) bridge the gap.

→ Start with [[recommendation-systems]], then [[two-tower-architecture]], then [[mixture-of-experts]].

---

## 5. FinOps

**[[finops]]** (Financial Operations) brings financial accountability to cloud's variable cost model. The core insight: FinOps is not about cutting spend — it's about maximizing business value per dollar. The operating model is **centralized enablement + decentralized execution**: a central FinOps team enables best practices and rate optimization; engineering teams own their own usage decisions.

The **[[finops-lifecycle]]** runs in three stages — Inform (visibility, cost allocation, tagging) → Optimize (rightsizing, reserved capacity, scheduling) → Operate (automation, policy enforcement, anomaly detection) — iterated continuously.

Structural parallel to harness engineering: budgets and policies are **guides** (feedforward constraints); cost dashboards and alerts are **sensors** (feedback signals). The discipline shows up in the scaffolding.

→ Start with [[finops]], then [[finops-lifecycle]].

---

## 6. AI & Software Engineering

AI coding tools are increasing code production velocity by **10–100x**. This is not just faster code — it restructures the entire engineering discipline.

Two perspectives (2026) converge on the same premise and disagree only in emphasis:

- **[[software-ecology]] (Adam Bender, Google I/O 2026):** systemic risk lens. Writing code is one step in a long pipeline: code → test → review → deploy → monitor → maintain. When only the first step accelerates, bottlenecks migrate downstream. Google's **Shared Fate** principle — the author is accountable for their code's consequences — breaks structurally when AI generates volumes of code that no single engineer fully understands. Engineering must be measured by **system health**, not coding velocity.

- **[[ai-engineering-shift]] (Andrew Ng, AI Dev 26):** opportunity lens. Bottlenecks migrate from coding to **product management, design, legal, and marketing**. The new high-value engineer is a **generalist**: orchestrates AI agents, assembles building blocks, switches roles fluidly. Demand for engineers stays high; the skill set changes.

**Shared thesis:** Both dismiss the "AI job apocalypse" for engineers. Both agree that engineers who treat hand-written code as their core identity will fall behind — not because AI replaces them, but because that skill has been commoditized.

**Connection to harness engineering:** Software ecology explains *why* harness engineering exists. The shift creates the need for [[guides-and-sensors]] (feedforward constraints + feedback loops that govern agents when the human author isn't present) and [[harnessability]] (codebases structured so agents can be reliably controlled).

→ Start with [[software-ecology]], then [[ai-engineering-shift]].

---

## 7. Knowledge Management (Meta)

This wiki is itself an instance of the **[[llm-wiki-pattern]]** — originated in an Andrej Karpathy gist and extended here. Rather than re-deriving knowledge from raw documents at query time (RAG), an LLM reads sources and writes persistent, cross-linked wiki pages. Knowledge accumulates: contradictions get flagged once, cross-references are pre-computed, synthesis persists across sessions.

The three operations that keep the wiki healthy:
- **Ingest** — read a source, write/update pages, update index and log
- **Query** — read the index, pull relevant pages, synthesize an answer
- **Lint** — find orphan pages, dead links, missing frontmatter, stale log entries

→ See [[llm-wiki-pattern]] and [[karpathy-llm-wiki-pattern]] for the full pattern description.

---

## Domain Map

```
Agentic AI & Harness Eng.
  ├── harness-engineering        ├── guides-and-sensors
  ├── harnessability             ├── agentic-ai-system
  ├── generator-evaluator        ├── context-management-for-agents
  ├── (security) agent-sandbox-security → nemoclaw → openShell → openclaw
  └── (security) nebius-openclaw-security, running-openclaw-safely, moltbook, agentgateway

Agentic Commerce
  ├── agentic-protocol-stack     ├── ucp → ucp-negotiation-protocol
  ├── ap2-agent-payments         └── ucp-payment-handlers

Semantic Layers
  ├── semantic-layer             ├── headless-bi
  ├── data-products              ├── reliable-semantic-stack
  ├── semantic-mistrust          └── graph-rag

Recommendation Systems
  ├── two-tower-architecture     ├── negative-sampling
  ├── mixture-of-experts         ├── approximate-nearest-neighbors
  └── cold-start-problem

FinOps
  └── finops → finops-lifecycle

AI & Software Engineering
  ├── software-ecology (Bender: Shared Fate, system health)
  └── ai-engineering-shift (Bender + Ng: bottleneck migration, generalist engineer)

Knowledge Management (meta)
  └── llm-wiki-pattern → rag (contrast)
```
