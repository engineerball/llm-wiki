---
title: "Wiki Index"
tags: [meta, index]
date: 2026-05-03
---

# Wiki Index

Catalog of all pages, organized by category.

---

## Sources

| Page | Date | Topic |
|------|------|-------|
| [[finops-getting-started-gcp]] | 2026-05-02 | Google Cloud FinOps implementation framework (Inform/Optimize/Operate with GCP Epics) |
| [[agentic-ai-reference-architecture]] | 2026-05-02 | 9-layer reference architecture for goal-driven multi-agent AI systems |
| [[finops-framework-principles]] | 2026-05-02 | Six principles of the FinOps Framework (FinOps Foundation) |
| [[harness-engineering-leveraging-codex]] | 2026-02-11 | Agent-first software development with Codex |
| [[harness-engineering-claude-code-book]] | 2026-04-01 | Comprehensive design analysis of Claude Code as a harness specimen (book) |
| [[harness-design-long-running-apps]] | 2026-03-24 | Multi-agent harness for long-running app dev with Claude |
| [[harness-engineering-coding-agent-users]] | 2026-05-02 | Guides/sensors framework, harnessability, harness categories (Böckeler/Fowler) |
| [[stripe-minions-one-shot-coding-agents]] | 2026-05-02 | Stripe's production one-shot coding agents; blueprints as guides, pre-push hooks as sensors |
| [[anthropic-effective-harnesses]] | 2026-05-02 | Anthropic's two-role architecture for long-running agents (initializer + coding agent) |
| [[semantic-layer-duckdb-tutorial]] | 2026-05-02 | Why semantic layers matter and how to build one with DuckDB + Ibis |
| [[naming-conventions-for-semantic-layers]] | 2026-05-02 | Gold-layer design principles for AI Copilot consumption (Microsoft Fabric) |
| [[dbt-semantic-layer-introduction]] | 2026-05-02 | What a semantic layer is, five use cases, and the hub-and-spoke pattern (dbt blog) |
| [[thoughtworks-five-differences-cloud-cost-finops]] | 2026-05-02 | Five differences between cloud cost management and FinOps (ThoughtWorks) |
| [[cdp-comparison-2026]] | 2026-05-03 | 9 Best Customer Data Platforms (CDPs) in 2026 — market review and comparison (Medium / Modern Data 101) |
| [[ucp-universal-commerce-protocol]] | 2026-01-11 | Universal Commerce Protocol (UCP) — open-source standard for agentic commerce (Google blog) |
| [[ucp-interoperability-mcp-a2a-ap2]] | 2026-01-11 | UCP interoperability with MCP/A2A/AP2 — 4-layer protocol stack, end-to-end use case (LinkedIn/Vijayaraghavan) |
| [[agentic-protocols-for-websites-2026]] | 2026-05-03 | Agentic protocols readiness guide for websites — MCP, A2A, UCP, what to build for vs watch (Fountain City Tech) |
| [[ap2-agent-payments-protocol-2026]] | 2026-05-04 | AP2 Protocol official website — what is AP2, core principles, VCs, role architecture, samples, integration |
| [[agentgateway-kubernetes-docs]] | 2026-05-05 | Agent Gateway official Kubernetes docs — LLM/MCP/A2A gateway, Rust, Linux Foundation, unified agentic proxy |
| [[two-towers-deep-retrieval-google-cloud]] | 2026-05-05 | Two-tower retrieval with TensorFlow Recommenders + Vertex AI Matching Engine — architecture, training, serving (Google Cloud blog) |
| [[two-tower-movie-recommender-pytorch]] | 2026-05-05 | Three-tower PyTorch movie recommender on MovieLens — feature-based users, debiased ratings, cold start solution (Greenquist blog) |

---

## Concepts

| Page | Summary |
|------|---------|
| [[harness-engineering]] | Designing environments/scaffolding for AI coding agents instead of writing code |
| [[harness-engineering-claude-code-book]] | Comprehensive design analysis of Claude Code as a harness specimen (book) |
| [[generator-evaluator-architecture]] | Multi-agent pattern: separate generator from evaluator to overcome self-evaluation blindness |
| [[sprint-contracts]] | Pre-negotiated success criteria between generator and evaluator agents |
| [[context-management-for-agents]] | Handling context degradation and anxiety in long-running agent tasks |
| [[initializer-coding-agent-architecture]] | Anthropic's two-role pattern for cross-session continuity (initializer + coding agent) |
| [[feature-list-pattern]] | JSON feature enumeration to prevent one-shotting and premature completion |
| [[guides-and-sensors]] | Feedforward (guides) vs feedback (sensors) controls in a harness; requires both for closed-loop reliability |
| [[harnessability]] | Codebase property: degree to which a codebase enables effective harness controls |
| [[finops]] | Financial Operations for cloud — getting maximum value from technology spend through collaboration and ownership |
| [[finops-lifecycle]] | Three-stage iterative process: Inform → Optimize → Operate |
| [[agentic-ai-system]] | 9-layer system: user/clients, orchestration, agents, tools, memory, monitoring, reliability, governance, infrastructure |
| [[semantic-layer]] | Virtual translation layer between physical data warehouse and data consumers — unified business metrics |
| [[customer-data-platform]] | Managed database that unifies customer data across touchpoints — system of intelligence for identity, segmentation, and activation |
| [[one-shot-agent]] | Agent pattern that completes a task in a single step without iteration or feedback loop |
| [[agentic-protocol-stack]] | 4-layer protocol architecture: MCP (tools), A2A (agents), UCP (commerce), AP2 (payments) |
| [[llm-gateway]] | Proxy layer for unified LLM provider routing — API translation, load balancing, inference routing |
| [[ucp]] | Universal Commerce Protocol — open-source standard for agentic commerce; merchant capability negotiation and checkout |
| [[agentic-commerce]] | AI agents executing purchases on behalf of users; $500B market projection by 2030 |
| [[ap2-agent-payments-protocol]] | Agent Payments Protocol (Google) — cryptographic proof of intent, 3 VCs, role architecture, payment methods |
| [[two-tower-architecture]] | Two-tower DNN retrieval: separate query + candidate towers, shared embedding space, dot product similarity, decoupled serving |
| [[approximate-nearest-neighbors]] | ANN indexing for fast vector similarity search; Tree-AH, HNSW, PQ; trade accuracy for speed at billion-vector scale |
| [[recommendation-systems]] | Multi-stage retrieval/ranking pipeline; collaborative vs content-based filtering; token → factorization → NDR evolution |
| [[cold-start-problem]] | New user/item has no interaction history; ID embeddings fail; feature-based representation solves user cold start |

---

## Organizations

| Page | Type |
|------|------|
| [[openai]] | AI research lab |
| [[anthropic]] | AI safety research lab, creator of Claude |
| [[stripe]] | Payments infrastructure company; operator of Minions coding agent system |
| [[google]] | Tech company; UCP + A2A creator, Google AI Mode/Gemini, GCP FinOps |
| [[thoughtworks]] | Global tech consultancy; Böckeler's employer; harness engineering + FinOps research |
| [[finops-foundation]] | Vendor-neutral non-profit; defines FinOps framework and principles |
| [[microsoft]] | Tech company; Microsoft Fabric semantic layers, MCP co-governance, WebMCP |
| [[dbt-labs]] | Data transformation company; creator of dbt and dbt Semantic Layer |
| [[fountain-city]] | AI agents company; agentic protocol readiness guidance |
| [[linux-foundation]] | Non-profit; governs MCP, A2A, Agent Gateway (Apache 2.0) |

---

## People

| Page | Role |
|------|------|
| [[birgitta-bockeler]] | ThoughtWorks principal technologist; harness engineering researcher |
| [[prithvi-rajasekaran]] | Anthropic engineer; multi-agent harness researcher |
| [[justin-young]] | Anthropic engineer; author of "Effective harnesses for long-running agents" (2026) |
| [[vijayaraghavan-v]] | Author; UCP 4-layer protocol stack analysis (LinkedIn, 2026) |
| [[swami-achari]] | Author (Modern Data 101); 9 best CDPs in 2026 comparison |

---

## Tools

| Page | Type |
|------|------|
| [[codex]] | AI coding agent (OpenAI, GPT-5) |
| [[claude]] | AI model family (Anthropic); Sonnet 4.5, Opus 4.6 |
| [[agentgateway]] | Open-source Rust gateway for MCP/A2A/LLM traffic; Linux Foundation; Kubernetes-native |
| [[tensorflow-recommenders]] | TensorFlow library (Google) for two-tower retrieval models — tfrs.tasks.Retrieval, FactorizedTopK, Keras integration |
| [[vertex-ai-matching-engine]] | Google Cloud managed ANN service — Tree-AH algorithm, up to 1B vectors, incremental updates, autoscaling |
