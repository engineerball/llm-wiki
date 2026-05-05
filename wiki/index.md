---
title: "Wiki Index"
tags: [meta, index]
date: 2026-05-05
---

# Wiki Index

Catalog of all wiki pages, organized by category. Concepts sorted newest-first.

---

## Concepts

| Page | Summary | Since | Sources |
|------|---------|-------|---------|
| [[llm-wiki-pattern]] | LLM incrementally builds and maintains a persistent wiki from raw sources instead of retrieving from documents at query time — wiki is a persistent, compounding artifact vs RAG | 2026-05-05 | 1 |
| [[rag]] | Retrieval-Augmented Generation — technique where LLM retrieves relevant document chunks at query time; contrast with LLM-wiki pattern | 2026-05-05 | 0 |
| [[generative-ai]] | AI systems generating novel content (text, code, images); semantic layers and harness engineering exist to make generative AI reliable and grounded | 2026-05-05 | 0 |
| [[graph-rag]] | Graph-enhanced RAG using explicit business relationships and entity links instead of pure vector similarity; reduces hallucination via structured context | 2026-05-05 | 1 |
| [[headless-bi]] | BI architecture where semantic metric definitions are decoupled from visualization layer; exposed via APIs to any downstream consumer | 2026-05-05 | 1 |
| [[data-products]] | Model-first data management treating data as a product with SLOs; foundation layer of the Reliable Semantic Stack | 2026-05-05 | 1 |
| [[reliable-semantic-stack]] | Three-layer framework (data products, catalog, data APIs) ensuring semantic layer credibility and trust (Animesh Kumar) | 2026-05-05 | 1 |
| [[semantic-mistrust]] | State where semantic layer loses credibility by inheriting data quality issues from physical layer; prevented by model-first data products | 2026-05-05 | 1 |
| [[two-tower-architecture]] | Neural retrieval pattern: queries and candidates mapped to shared embedding space via separate towers; dot product similarity serves as candidate relevance ranking | 2026-05-05 | 8 |
| [[ucp-payment-handlers]] | UCP payment architecture decouples credential acquisition from commerce logic; handlers are specs (not entities) defining how platforms acquire payment tokens | 2026-05-05 | 2 |
| [[ucp-negotiation-protocol]] | Dynamic capability negotiation between UCP platforms and businesses; intersection algorithm replaces static API contracts with version-aware matching | 2026-05-05 | 2 |
| [[semantic-layer]] | Virtual translation layer between physical data warehouse and data consumers; unified business metric definitions prevent metric drift across systems | 2026-05-05 | 7 |
| [[recommendation-systems]] | ML systems predicting relevant items for users at a given moment; multi-stage retrieval/ranking pipeline powering e-commerce, streaming, search, feeds | 2026-05-05 | 5 |
| [[negative-sampling]] | Training technique for retrieval models: construct negative examples to teach the model to distinguish relevant from irrelevant items; includes hard negative mining | 2026-05-05 | 4 |
| [[multi-task-learning-recsys]] | Joint optimization of competing recsys objectives (engagement, satisfaction, revenue); MMoE as dominant architecture for multi-objective ranking | 2026-05-05 | 1 |
| [[mixture-of-experts]] | Ensemble technique combining specialized sub-networks via learned gating; HME, DMoE, Sparsely-Gated, MMoE enable multi-objective ranking at scale | 2026-05-05 | 1 |
| [[llm-gateway]] | Unified API proxy for routing LLM requests across multiple providers; handles translation, load balancing, inference routing, and cost optimization | 2026-05-05 | 1 |
| [[cold-start-problem]] | Difficulty recommending to new users/items with no interaction history; ID-based collaborative filtering fails; feature-based representation solves this | 2026-05-05 | 6 |
| [[approximate-nearest-neighbors]] | Algorithm class for fast vector similarity search at scale; Tree-AH, HNSW, PQ trade exactness for speed; essential for two-tower retrieval serving | 2026-05-05 | 4 |
| [[ucp]] | Open-source standard for agentic commerce; common language for AI agents to discover merchant capabilities, negotiate checkout flows, and complete purchases | 2026-05-04 | 2 |
| [[ap2-agent-payments-protocol]] | Google's open protocol for agent payments with cryptographic proof of user intent; 3 VCs, role architecture, secure authorization without credential sharing | 2026-05-04 | 1 |
| [[agentic-protocol-stack]] | 4-layer architecture: MCP (tools), A2A (agents), UCP (commerce), AP2 (payments); each layer composes to enable end-to-end agentic workflows | 2026-05-04 | 1 |
| [[agentic-commerce]] | Commercial transactions executed autonomously by AI agents; product discovery, negotiation, checkout, payment without user opening a shopping app | 2026-05-04 | 1 |
| [[customer-data-platform]] | Data platform unifying customer data across all touchpoints; system of intelligence for identity resolution, segmentation, and omnichannel activation | 2026-05-03 | 0 |
| [[one-shot-agent]] | Coding agent pattern: agent receives a single task description and autonomously completes full dev cycle; viable when harness and harnessability are sufficient | 2026-05-02 | 4 |
| [[initializer-coding-agent-architecture]] | Anthropic's two-role split for cross-session continuity: one-time environment setup (initializer) + incremental per-session progress (coding agent) | 2026-05-02 | 2 |
| [[harnessability]] | Degree to which a codebase enables effective harness controls; increases with strong typings, clear module boundaries, defined service topologies | 2026-05-02 | 4 |
| [[guides-and-sensors]] | Harness control taxonomy: Guides (feedforward) steer before action; Sensors (feedback) observe after and enable self-correction; both required for closed-loop reliability | 2026-05-02 | 10 |
| [[harness-engineering]] | Software engineering discipline shifted from writing code to designing environments, feedback loops, and scaffolding enabling AI coding agents to do reliable work | 2026-02-11 | 10 |
| [[finops-lifecycle]] | Three-stage iterative process for FinOps: Inform (visibility) → Optimize (cost reduction) → Operate (automation) | 2026-05-02 | 0 |
| [[finops]] | Financial Operations for cloud; practice and operating model bringing financial accountability to variable cloud spend | 2026-05-02 | 3 |
| [[feature-list-pattern]] | JSON enumeration of all project features with pass/fail status; prevents agent one-shotting and premature completion in long-running tasks | 2026-05-02 | 1 |
| [[blueprints]] | Stripe's structured documentation system encoding service contracts, architectural rules, and interface specs; primary feedforward guides for Minions agents | 2026-05-02 | 0 |
| [[agentic-ai-system]] | 9-layer reference architecture for goal-driven, multi-agent, orchestrated, observable, reliable AI systems (Orchestrator, Agents, Tools, Memory, etc.) | 2026-05-02 | 4 |
| [[sprint-contracts]] | Pre-negotiated explicit success criteria between Generator and Evaluator agents; defines measurably "done" before implementation begins | 2026-03-24 | 3 |
| [[context-management-for-agents]] | How long-running AI agent tasks handle finite context window; two failure modes (context degradation, context anxiety) and two mitigation strategies | 2026-03-24 | 3 |
| [[generator-evaluator-architecture]] | Multi-agent pattern: separate agent generates output, another evaluates it; addresses LLM self-evaluation blindness with clean role separation | 2026-03-24 | 2 |

## Sources

| Page | Date | Topic |
|------|------|-------|
| [[the-semantic-movement-modern-data-101-2026-05-05]] | 2026-05-05 | The Semantic Layer Movement: Rise, workarounds (Cubes/BI-traps), semantic mistrust, and the Reliable Semantic Stack (Animesh Kumar) |
| [[rise-of-semantic-layer-airbyte-2026-05-05]] | 2026-05-05 | Airbyte's analysis: semantic layers as non-negotiable for AI, headless BI, Graph-RAG, real-time streaming, key tools (Cube, AtScale, Snowflake, dbt) |
| [[running-openclaw-safely]] | 2026-05-05 | Microsoft security analysis of OpenClaw — identity isolation, three primary risks, runtime vs platform (Moltbook), end-to-end attack scenario, minimum safe operating posture (Microsoft) |
| [[nebius-openclaw-security]] | 2026-05-05 | OpenClaw security: architecture, sandboxing tiers, skill supply chain risk, memory poisoning, hardening checklist (Nebius) |
| [[databricks-semantic-layer-architecture]] | 2026-05-05 | Semantic layer 5-era history, traditional vs platform-native, 3 modern types, AI agent grounding/execution pattern, core-edge architecture (Databricks) |
| [[best-open-source-semantic-layer-tools-2026]] | 2026-05-05 | 7 open-source semantic layer tools compared — Cube, dbt SL, MetriQL, Malloy, Lightdash, Evidence, DataForge; 3 architectural patterns; metric drift problem (Gromov) |
| [[ucp-specification-overview]] | 2026-05-05 | UCP official spec — namespace governance, intersection algorithm, payment handler model, trust triangle, transport bindings, security, versioning |
| [[moe-for-recsys-reachsumit]] | 2026-05-05 | MoE variants (HME/DMoE/Sparsely-Gated/MMoE), YouTube engagement vs satisfaction, Gmail MoSE, Kuaishou cold start (Sumit Kumar) |
| [[reachsumit-two-tower-model]] | 2026-05-05 | Two-tower DNN taxonomy, SDE vs ADE, DAT + IntTower research extensions, ColBERT late-interaction comparison (Sumit Kumar) |
| [[shaped-ai-two-tower-deep-dive]] | 2026-05-05 | Two-tower deep dive — loss functions taxonomy, negative sampling strategies, BPR, InfoNCE, in-batch negatives, ranker models (Shaped.ai) |
| [[two-tower-movie-recommender-pytorch]] | 2026-05-05 | Three-tower PyTorch movie recommender on MovieLens — feature-based users, debiased ratings, cold start solution (Greenquist blog) |
| [[two-towers-deep-retrieval-google-cloud]] | 2026-05-05 | Two-tower retrieval with TensorFlow Recommenders + Vertex AI Matching Engine — architecture, training, serving (Google Cloud blog) |
| [[agentgateway-kubernetes-docs]] | 2026-05-05 | Agent Gateway official Kubernetes docs — LLM/MCP/A2A gateway, Rust, Linux Foundation, unified agentic proxy |
| [[trae-definitive-guide-harness-engineering]] | 2026-04-30 | Definitive guide to Harness Engineering — horse & reins metaphor, R.E.S.T. framework, PPAF loop, REPL container, six design principles, sandboxing levels, policy gateway (Trae/ByteDance) |
| [[karpathy-llm-wiki-pattern]] | 2026-05-05 | A Pattern for Building Personal Knowledge Bases using LLMs — wiki vs RAG, 3 layers, ingest/query/lint workflows, human curates + LLM does bookkeeping (Karpathy gist) |
| [[ap2-agent-payments-protocol-2026]] | 2026-05-04 | AP2 Protocol official website — what is AP2, core principles, VCs, role architecture, samples, integration |
| [[agentic-protocols-for-websites-2026]] | 2026-05-03 | Agentic protocols readiness guide for websites — MCP, A2A, UCP, what to build for vs watch (Fountain City Tech) |
| [[cdp-comparison-2026]] | 2026-05-03 | 9 Best Customer Data Platforms (CDPs) in 2026 — market review and comparison (Medium / Modern Data 101) |
| [[harness-engineering-coding-agent-users]] | 2026-05-02 | Guides/sensors framework, harnessability, harness categories (Böckeler/Fowler/martinfowler.com) |
| [[stripe-minions-one-shot-coding-agents]] | 2026-05-02 | Stripe's production one-shot coding agents; blueprints as guides, pre-push hooks as sensors |
| [[anthropic-effective-harnesses]] | 2026-05-02 | Anthropic's two-role architecture for long-running agents (initializer + coding agent) |
| [[semantic-layer-duckdb-tutorial]] | 2026-05-02 | Why semantic layers matter and how to build one with DuckDB + Ibis |
| [[naming-conventions-for-semantic-layers]] | 2026-05-02 | Gold-layer design principles for AI Copilot consumption (Microsoft Fabric) |
| [[dbt-semantic-layer-introduction]] | 2026-05-02 | What a semantic layer is, five use cases, and the hub-and-spoke pattern (dbt blog) |
| [[thoughtworks-five-differences-cloud-cost-finops]] | 2026-05-02 | Five differences between cloud cost management and FinOps (ThoughtWorks) |
| [[finops-framework-principles]] | 2026-05-02 | Six principles of the FinOps Framework (FinOps Foundation) |
| [[finops-getting-started-gcp]] | 2026-05-02 | Google Cloud FinOps implementation framework (Inform/Optimize/Operate with GCP Epics) |
| [[agentic-ai-reference-architecture]] | 2026-05-02 | 9-layer reference architecture for goal-driven multi-agent AI systems |
| [[harness-engineering-leveraging-codex]] | 2026-02-11 | Agent-first software development with Codex |
| [[harness-engineering-claude-code-book]] | 2026-04-01 | Comprehensive design analysis of Claude Code as a harness specimen (book) |
| [[harness-design-long-running-apps]] | 2026-03-24 | Multi-agent harness for long-running app dev with Claude |
| [[ucp-universal-commerce-protocol]] | 2026-01-11 | Universal Commerce Protocol (UCP) — open-source standard for agentic commerce (Google blog) |
| [[ucp-interoperability-mcp-a2a-ap2]] | 2026-01-11 | Universal Commerce Protocol (UCP) interoperability with MCP/A2A/AP2 — 4-layer protocol stack, end-to-end use case (LinkedIn/Vijayaraghavan) |

---

## Organizations

| Page | Type |
|------|------|
| [[animesh-kumar]] | Data strategist; author of the "Semantic Movement" and "Reliable Semantic Stack" frameworks |
| [[modern-data-101]] | Substack publication focused on semantic layer evolution and data engineering |
| [[airbyte]] | Open-source data integration (ELT + CDC); foundation for real-time semantic layers |
| [[snowflake]] | Cloud-based data platform; semantic views for AI-powered conversational interfaces |
| [[atscale]] | Enterprise semantic layer platform; Semantic Modeling Language (SML) |
| [[databricks]] | Data + AI company; Lakehouse architecture, Unity Catalog, platform-native semantic layer |
| [[openai]] | AI research lab; creator of GPT series, Codex, DALL-E |
| [[anthropic]] | AI safety research lab, creator of Claude model family |
| [[stripe]] | Payments infrastructure; Minions one-shot coding agent system at production scale |
| [[google]] | Tech company; UCP + A2A creator, AP2 protocol, GCP FinOps, TensorFlow Recommenders, Vertex AI Matching Engine |
| [[thoughtworks]] | Global tech consultancy; harness engineering, FinOps research, martinfowler.com |
| [[finops-foundation]] | Vendor-neutral nonprofit; defines FinOps framework and principles |
| [[microsoft]] | Tech company; Microsoft Fabric semantic layers, MCP co-governance, WebMCP |
| [[dbt-labs]] | Data transformation company; creator of dbt and dbt Semantic Layer |
| [[fountain-city]] | AI agents company; agentic protocol readiness guidance |
| [[linux-foundation]] | Nonprofit; governs MCP, A2A, Agent Gateway (Apache 2.0) |
| [[youtube]] | Google-owned video platform; MMoE for next-video recommendation pioneer |
| [[kuaishou]] | Chinese short-video platform; MMoE-based personalized cold start modules |
| [[trae]] | AI coding agent by ByteDance; published Harness Engineering definitive guide |
| [[bytedance]] | Parent company of Trae; TikTok, ByteDance AI research |

---

## People

| Page | Role |
|------|------|
| [[birgitta-bockeler]] | ThoughtWorks principal technologist; harness engineering researcher |
| [[prithvi-rajasekaran]] | Anthropic engineer; multi-agent harness researcher |
| [[justin-young]] | Anthropic engineer; "Effective harnesses for long-running agents" author |
| [[vijayaraghavan-v]] | LinkedIn author; UCP 4-layer protocol stack analysis |
| [[swami-achari]] | Modern Data 101 author; 2026 CDP comparison (9 platforms) |
| [[mitchell-hashimoto]] | HashiCorp co-founder; coined "Harness Engineering" term |
| [[andrej-karpathy]] | AI researcher; former OpenAI Director of AI, former Tesla AI Director; creator of the llm-wiki pattern |

---

## Tools

| Page | Type |
|------|------|
| [[agentgateway]] | Open-source Rust gateway for MCP/A2A/LLM traffic; Linux Foundation; Kubernetes-native |
| [[openclaw]] | Open-source self-hosted agent gateway; messaging platform integration; transparent memory |
| [[moltbook]] | Agent-focused platform and identity layer; instruction propagation and authentication hub |
| [[codex]] | AI coding agent (OpenAI, GPT-5); autonomous software engineering |
| [[claude]] | AI model family (Anthropic); Sonnet 4.5, Opus 4.6 |
| [[tensorflow-recommenders]] | TensorFlow library (Google) for building two-tower retrieval models |
| [[vertex-ai-matching-engine]] | Google Cloud managed ANN service — Tree-AH, up to 1B vectors, incremental updates |
| [[cube]] | Open-source headless semantic layer; API-first (REST/GraphQL/SQL); pre-aggregation engine |
| [[airbyte]] | Open-source data integration; 600+ connectors; CDC for real-time semantic layers |
