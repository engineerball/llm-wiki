---
title: Wiki Index
description: Catalog of all pages in TK's personal LLM wiki on agentic AI, semantic layers, recommendation systems, LLM architecture, and FinOps
updated: 2026-05-12
total_pages: 134
---

# LLM Wiki — Personal Knowledge Base

An LLM-generated knowledge base covering **agentic AI engineering**, **semantic layers**, **recommendation systems**, **LLM architecture**, **agent security**, and **FinOps**. Built incrementally with Claude Code using the [[llm-wiki-pattern|LLM-Wiki Pattern]] — sourced from articles, papers, docs, and specs; cross-linked and maintained as a persistent, compounding artifact rather than a retrieval index.

Start with the [[overview]] for the big picture, or pick any topic below. Everything is cross-linked — follow the graph.

---

## Concepts

### Agentic AI & Harness Engineering

- [[harness-engineering|Harness Engineering]] — Software engineering discipline shifted from writing code to designing environments, feedback loops, and scaffolding that make AI coding agents do reliable work
- [[harnessability|Harnessability]] — Degree to which a codebase enables effective harness controls; increases with strong typings, clear boundaries, defined service topologies
- [[guides-and-sensors|Guides and Sensors]] — Harness control taxonomy: Guides (feedforward) steer before action; Sensors (feedback) observe after and enable self-correction
- [[agentic-ai-system|Agentic AI System]] — 9-layer reference architecture for goal-driven, multi-agent, orchestrated, observable, reliable AI systems
- [[one-shot-agent|One-Shot Agent]] — Coding agent pattern: agent receives a single task and autonomously completes the full dev cycle when harness and harnessability are sufficient
- [[initializer-coding-agent-architecture|Initializer + Coding Agent Architecture]] — Anthropic's two-role split for cross-session continuity: one-time environment setup + incremental per-session progress
- [[generator-evaluator-architecture|Generator–Evaluator Architecture]] — Multi-agent pattern with clean role separation; addresses LLM self-evaluation blindness
- [[context-management-for-agents|Context Management for Agents]] — How long-running tasks handle finite context windows; two failure modes (degradation, anxiety) and two mitigation strategies
- [[sprint-contracts|Sprint Contracts]] — Pre-negotiated explicit success criteria between Generator and Evaluator agents; defines "done" before implementation begins
- [[feature-list-pattern|Feature List Pattern]] — JSON enumeration of all project features with pass/fail status; prevents premature task completion in long-running agents
- [[blueprints|Blueprints]] — Stripe's structured documentation encoding service contracts and interface specs; primary feedforward guides for Minions agents
- [[llm-gateway|LLM Gateway]] — Unified API proxy for routing LLM requests across multiple providers; handles translation, load balancing, inference routing, and cost optimization

### Agentic Commerce & Protocols

- [[agentic-commerce|Agentic Commerce]] — Commercial transactions executed autonomously by AI agents: product discovery, negotiation, checkout, payment — without the user opening a shopping app
- [[agentic-protocol-stack|Agentic Protocol Stack]] — 4-layer architecture: MCP (tools), A2A (agents), UCP (commerce), AP2 (payments); each layer composes to enable end-to-end agentic workflows
- [[ucp|UCP — Universal Commerce Protocol]] — Open-source standard for agentic commerce; common language for AI agents to discover merchant capabilities, negotiate checkout flows, and complete purchases
- [[ucp-negotiation-protocol|UCP Negotiation Protocol]] — Dynamic capability negotiation between UCP platforms and businesses; intersection algorithm replaces static API contracts with version-aware matching
- [[ucp-payment-handlers|UCP Payment Handlers]] — UCP payment architecture decoupling credential acquisition from commerce logic; handlers are specs defining how platforms acquire payment tokens
- [[ap2-agent-payments-protocol|AP2 — Agent Payments Protocol]] — Google's open protocol for agent payments with cryptographic proof of user intent; 3 VCs, role architecture, secure authorization without credential sharing
- [[customer-data-platform|Customer Data Platform (CDP)]] — Data platform unifying customer data across all touchpoints; system of intelligence for identity resolution, segmentation, and omnichannel activation

### Semantic Layers & Data Architecture

- [[semantic-layer|Semantic Layer]] — Virtual translation layer between physical data warehouse and data consumers; unified business metric definitions prevent metric drift across systems
- [[headless-bi|Headless BI]] — BI architecture where semantic metric definitions are decoupled from visualization; metrics exposed via APIs to any downstream consumer (BI tools, LLMs, apps)
- [[graph-rag|Graph-RAG]] — Graph-enhanced RAG using explicit business relationships and entity links instead of pure vector similarity; reduces hallucination via structured context
- [[data-products|Data Products]] — Model-first data management treating data as a product with SLOs; foundation layer of the Reliable Semantic Stack
- [[reliable-semantic-stack|Reliable Semantic Stack]] — Three-layer framework (data products, catalog, data APIs) ensuring semantic layer credibility and trust (Animesh Kumar)
- [[semantic-mistrust|Semantic Mistrust]] — State where semantic layer loses credibility by inheriting data quality issues from the physical layer; prevented by model-first data products
- [[rag|RAG — Retrieval-Augmented Generation]] — Technique where an LLM retrieves relevant document chunks from a vector store at query time; contrast with the LLM-wiki pattern
- [[generative-ai|Generative AI]] — AI systems generating novel content (text, code, images); semantic layers and harness engineering exist to make generative AI reliable and grounded
- [[llm-wiki-pattern|LLM-Wiki Pattern]] — LLM incrementally builds a persistent wiki from raw sources instead of retrieving at query time; a compounding knowledge artifact vs RAG

### Transformer Architecture & Attention

- [[transformer-architecture|Transformer Architecture]] — Sequence model built entirely on attention (Vaswani et al., 2017); eliminated recurrence; foundation of all modern LLMs
- [[attention-mechanism|Attention Mechanism]] — Neural mechanism allowing models to dynamically focus on relevant input parts; the core innovation of modern deep learning
- [[self-attention|Self-Attention]] — Attention within a single sequence; each token attends to all others, creating direct connections regardless of distance
- [[multi-head-attention|Multi-Head Attention]] — Multiple self-attention operations in parallel with different learned projections; each head captures a different relational view
- [[positional-encoding|Positional Encoding]] — Injects order information into Transformers since attention is permutation-invariant; sinusoidal, learned, rotary (RoPE) variants

### Recommendation Systems

- [[recommendation-systems|Recommendation Systems]] — ML systems predicting relevant items for users at a given moment; multi-stage retrieval/ranking pipeline powering e-commerce, streaming, search, feeds
- [[two-tower-architecture|Two-Tower Architecture]] — Neural retrieval pattern: queries and candidates mapped to shared embedding space via separate towers; dot product similarity serves as relevance ranking
- [[negative-sampling|Negative Sampling]] — Training technique constructing negative examples to teach retrieval models to distinguish relevant from irrelevant items; includes hard negative mining
- [[multi-task-learning-recsys|Multi-Task Learning (RecSys)]] — Joint optimization of competing recsys objectives (engagement, satisfaction, revenue); MMoE as dominant architecture for multi-objective ranking
- [[mixture-of-experts|Mixture of Experts (MoE)]] — Ensemble combining specialized sub-networks via learned gating; HME, DMoE, Sparsely-Gated, MMoE enable multi-objective ranking at scale
- [[cold-start-problem|Cold-Start Problem]] — Difficulty recommending to new users/items with no interaction history; ID-based collaborative filtering fails; feature-based representation solves this
- [[approximate-nearest-neighbors|Approximate Nearest Neighbors (ANN)]] — Algorithm class for fast vector similarity search at scale; Tree-AH, HNSW, PQ trade exactness for speed; essential for two-tower retrieval serving

### FinOps

- [[finops|FinOps]] — Financial Operations for cloud; practice and operating model bringing financial accountability to variable cloud spend; not about reducing cost but maximizing value per dollar
- [[finops-lifecycle|FinOps Lifecycle]] — Three-stage iterative process: Inform (visibility) → Optimize (cost reduction) → Operate (automation)

---

## Sources

### Agentic Commerce & Protocols

- [[ucp-universal-commerce-protocol|Universal Commerce Protocol (UCP)]] — Google's open-source standard for agentic commerce; architecture, trust triangle, and functional primitives (Google Developers Blog, Jan 2026)
- [[ucp-interoperability-mcp-a2a-ap2|UCP Interoperability with MCP / A2A / AP2]] — 4-layer protocol stack analysis, end-to-end travel commerce use case, $500B 2030 projection (LinkedIn / V. Vijayaraghavan)
- [[shopify-universal-commerce-protocol-ucp-2026|Shopify Universal Commerce Protocol (UCP)]] — Shopify engineering deep-dive: layered capabilities+extensions architecture, reverse-domain namespace, graceful handoff via ECP, two-sided payment negotiation (Ilya Grigorik, 2026)
- [[ucp-specification-overview|UCP Official Specification Overview]] — Namespace governance, intersection algorithm, payment handler model, trust triangle, transport bindings, security, versioning
- [[ap2-agent-payments-protocol-2026|AP2 — Agent Payments Protocol]] — Official AP2 website: verifiable credentials, role architecture, cart/payment mandates, Python + Android samples (Google Agentic Commerce)
- [[agentic-protocols-for-websites-2026|Agentic Protocols for Your Website in 2026]] — Protocol readiness guide: MCP, A2A, UCP — what to build now vs watch; 97M MCP downloads, 10k+ servers live (Fountain City Tech)

### Agent Engineering & Harness Engineering

- [[harness-engineering-leveraging-codex|Harness Engineering: Leveraging Codex in an Agent-First World]] — OpenAI's foundational article introducing the Harness Engineering concept and Codex-based agent-first development (Feb 2026)
- [[harness-engineering-coding-agent-users|Harness Engineering for Coding Agent Users]] — Guides/sensors framework, harnessability taxonomy, three harness domains, Ashby's Law applied to coverage (Böckeler / martinfowler.com)
- [[trae-definitive-guide-harness-engineering|The Definitive Guide to Harness Engineering (Trae)]] — Horse & Reins metaphor, R.E.S.T. framework, PPAF loop, REPL container, six design principles, sandboxing levels (Trae / ByteDance, Apr 2026)
- [[stripe-minions-one-shot-coding-agents|Stripe Minions: One-Shot Coding Agents]] — Stripe's production one-shot coding agents; blueprints as feedforward guides, pre-push hooks as sensors
- [[anthropic-effective-harnesses|Effective Harnesses for Long-Running Agents]] — Anthropic's two-role architecture: initializer (one-time setup) + coding agent (incremental execution); context anxiety and reset strategies (Justin Young)
- [[harness-design-long-running-apps|Harness Design for Long-Running Apps]] — Multi-agent generator–evaluator harness for long-running app development with Claude (Prithvi Rajasekaran / Anthropic)
- [[harness-engineering-claude-code-book|Harness Engineering: The Claude Code Book]] — Comprehensive design analysis of Claude Code as a harness specimen
- [[agentgateway-kubernetes-docs|Agent Gateway: Kubernetes Docs]] — Official Kubernetes deployment docs: LLM/MCP/A2A gateway, Rust, Linux Foundation, Helm/ArgoCD, RBAC, OpenTelemetry
- [[agentic-ai-reference-architecture|Agentic AI Reference Architecture]] — 9-layer reference architecture for goal-driven multi-agent AI systems

### Agent Security

- [[running-openclaw-safely|Running OpenClaw Safely]] — Microsoft security analysis: identity isolation, three primary risks, runtime vs platform (Moltbook), end-to-end attack scenario, minimum safe operating posture
- [[nebius-openclaw-security|OpenClaw Security: Architecture and Hardening Guide]] — Nebius security deep-dive, updated 2026-05-08 with multi-user focus: Gateway as single boundary, sandboxing hierarchy (Off/Non-main/All), per-agent tool allowlists, ClawHavoc campaign (Jan 2026), memory poisoning via MEMORY.md/SOUL.md, access control best practices, hardening checklist (OpenClaw = untrusted code execution with persistent credentials)

### Semantic Layers & Data Architecture

- [[the-semantic-movement-modern-data-101-2026-05-05|The Semantic Layer Movement: Rise & Current State]] — Semantic layer history, failure of workarounds (Cubes/BI-traps), semantic mistrust risk, Reliable Semantic Stack framework (Animesh Kumar / Modern Data 101)
- [[rise-of-semantic-layer-airbyte-2026-05-05|The Rise of the Semantic Layer: Metrics on the Fly]] — Semantic layers as non-negotiable for AI; headless BI, Graph-RAG, real-time streaming, key tools: Cube, AtScale, Snowflake, dbt (Airbyte)
- [[databricks-semantic-layer-architecture|Databricks: Semantic Layer Architecture]] — 5-era history, traditional vs platform-native types, AI agent grounding/execution pattern, core-edge architecture (Databricks)
- [[best-open-source-semantic-layer-tools-2026|Best Open-Source Semantic Layer Tools in 2026]] — 7 tools compared: Cube, dbt SL, MetriQL, Malloy, Lightdash, Evidence, DataForge; 3 architectural patterns; metric drift problem (Gromov)
- [[semantic-layer-duckdb-tutorial|Semantic Layers with DuckDB]] — Why semantic layers matter and how to build one with DuckDB + Ibis
- [[naming-conventions-for-semantic-layers|Naming Conventions for Semantic Layers]] — Gold-layer design principles for AI Copilot consumption (Microsoft Fabric)
- [[dbt-semantic-layer-introduction|Introduction to the dbt Semantic Layer]] — What a semantic layer is, five use cases, and the hub-and-spoke pattern (dbt Labs)

### Recommendation Systems

- [[moe-for-recsys-reachsumit|MoE for Recommendation Systems]] — MoE variants (HME/DMoE/Sparsely-Gated/MMoE), YouTube engagement vs satisfaction tradeoff, Gmail MoSE, Kuaishou cold start (Sumit Kumar)
- [[reachsumit-two-tower-model|Two-Tower Architecture Survey]] — Two-tower DNN taxonomy, SDE vs ADE, DAT + IntTower research extensions, ColBERT late-interaction comparison (Sumit Kumar)
- [[shaped-ai-two-tower-deep-dive|Two-Tower Deep Dive]] — Loss functions taxonomy, negative sampling strategies, BPR, InfoNCE, in-batch negatives, ranker models (Shaped.ai)
- [[two-tower-movie-recommender-pytorch|Two-Tower Movie Recommender in PyTorch]] — Three-tower PyTorch recommender on MovieLens: feature-based users, debiased ratings, cold start solution (Greenquist)
- [[two-towers-deep-retrieval-google-cloud|Scaling Deep Retrieval: Two Towers (Google Cloud)]] — Two-tower retrieval with TensorFlow Recommenders + Vertex AI Matching Engine: architecture, training, serving (Google Cloud)
- [[implement-two-tower-retrieval-gcp-2025|Implement Two-Tower Retrieval for Large-Scale Candidate Generation]] — Google Cloud Architecture Center reference architecture (Jan 2025): full Vertex AI pipeline, VPC security, performance profiling, recall-vs-latency ANN evaluation (Totten, Wortz, Sethu, Kaz Sato)
- [[redhat-two-tower-model-openshift-2026|Understanding the Recommender System's Two-Tower Model (Red Hat)]] — OpenShift AI + KFP pipeline: EntityTower dual encoder, MSE loss with interaction magnitude scoring, cold start strategy (Red Hat Developer, Jan 2026)
- [[recsysml-two-tower-models-retrieval|Two Tower Models for Retrieval (RecSysML)]] — Practical two-tower insights: user/item encoder design, dot product training objective, random vs negative impression sampling, matrix factorization → two tower evolution, StarSpace connection (Gaurav Chakravorty)

### FinOps

- [[gcp-align-cloud-spending-business-value|GCP: Align Cloud Spending with Business Value]] — Well-Architected Framework principle: TCO framework (4 cost factors), 5 recommendations (managed services, SRE/DORA, self-service, FinOps adoption, value-driven mindset)
- [[thoughtworks-five-differences-cloud-cost-finops|Five Differences: Cloud Cost Management vs FinOps]] — Why cloud cost management and FinOps are not the same; cultural and operational distinctions (ThoughtWorks)
- [[finops-framework-principles|FinOps Framework Principles]] — Six north-star principles of the FinOps Framework (FinOps Foundation)
- [[finops-getting-started-gcp|Getting Started with FinOps on GCP]] — Google Cloud FinOps implementation: organizational structure, epics, Inform/Optimize/Operate with GCP-specific tooling
- [[gcp-finops-hub|GCP FinOps Hub]] — Google Cloud Billing cost optimization dashboard: FinOps Score, peer benchmarking, 25+ recommenders, wasted usage detection, CUD optimization rate
- [[finops-atlassian-what-is-finops|What is FinOps (Atlassian)]] — Introductory guide: definition, 5 best practices, Inform/Optimize/Operate lifecycle (Atlassian Blog)
- [[finops-personas-finops-foundation|FinOps Personas (FinOps Foundation)]] — 6 Core personas (Engineering, Finance, Procurement, IT Ops, Product, Executive) + 5 Allied personas (ITAM, ITFM, Sustainability, ITSM/ITIL, Security); Intersecting Disciplines framework

### Data & Knowledge

- [[cdp-comparison-2026|9 Best Customer Data Platforms (CDPs) in 2026]] — Market review and comparison of 9 CDP platforms: identity resolution, segmentation, omnichannel activation (Modern Data 101 / Swami Achari)
- [[karpathy-llm-wiki-pattern|A Pattern for Building Personal Knowledge Bases Using LLMs]] — Wiki vs RAG distinction, 3 layers, ingest/query/lint workflows, human-curates + LLM-does-bookkeeping model (Andrej Karpathy gist)

### LLM Architecture

- [[attention-is-all-you-need-adnanmasood-2026-01-13|Attention Is All You Need — Adnan Masood (2026)]] — Distillation of Vaswani et al.'s 2017 Transformer paper for technical audiences; self-attention, multi-head attention, parallelism, encoder/decoder architecture (Medium, Jan 2026)

---

## Entities

### People

- [[andrej-karpathy|Andrej Karpathy]] — AI researcher; former OpenAI Director of AI, former Tesla AI Director; originator of the LLM-Wiki pattern
- [[animesh-kumar|Animesh Kumar]] — Data strategist; author of the "Semantic Movement" and Reliable Semantic Stack frameworks (Modern Data 101)
- [[birgitta-bockeler|Birgitta Böckeler]] — ThoughtWorks principal technologist; developed the Guides/Sensors taxonomy and harness engineering framework
- [[justin-young|Justin Young]] — Anthropic engineer; author of "Effective Harnesses for Long-Running Agents"
- [[mitchell-hashimoto|Mitchell Hashimoto]] — HashiCorp co-founder (Terraform, Vault); coined the term "Harness Engineering"
- [[prithvi-rajasekaran|Prithvi Rajasekaran]] — Anthropic engineer; multi-agent harness and long-running app architecture researcher
- [[swami-achari|Swami Achari]] — Modern Data 101 author; 2026 CDP comparison (9 platforms)
- [[vijayaraghavan-v|V. Vijayaraghavan]] — LinkedIn author; UCP 4-layer protocol stack analysis

### Organizations

- [[anthropic|Anthropic]] — AI safety research lab; creator of Claude model family and Effective Harnesses research
- [[bytedance|ByteDance]] — Chinese tech company; parent of Trae and TikTok; active in agent engineering research
- [[databricks|Databricks]] — Data + AI company; Lakehouse architecture, Unity Catalog, platform-native semantic layer
- [[dbt-labs|dbt Labs]] — Data transformation company; creator of dbt and the dbt Semantic Layer (MetricFlow)
- [[finops-foundation|FinOps Foundation]] — Vendor-neutral nonprofit; governs the FinOps Framework, principles, personas, and maturity model
- [[fountain-city|Fountain City]] — AI agents company; publishes agentic protocol readiness guidance for websites
- [[google|Google]] — Tech company; UCP + A2A creator, AP2 protocol, GCP FinOps, TensorFlow Recommenders, Vertex AI Matching Engine
- [[kuaishou|Kuaishou]] — Chinese short-video platform; MMoE-based personalized cold start modules at scale
- [[linux-foundation|Linux Foundation]] — Nonprofit governing MCP, A2A, and Agent Gateway (Apache 2.0)
- [[microsoft|Microsoft]] — Tech company; Microsoft Fabric semantic layers, MCP co-governance, WebMCP, OpenClaw security research
- [[modern-data-101|Modern Data 101]] — Substack publication; semantic layer evolution and data engineering best practices
- [[openai|OpenAI]] — AI research lab; creator of Codex, GPT series; published original Harness Engineering article
- [[stripe|Stripe]] — Payments infrastructure; runs Minions one-shot coding agent system at production scale
- [[thoughtworks|ThoughtWorks]] — Global tech consultancy; harness engineering and FinOps research; publisher of martinfowler.com
- [[youtube|YouTube]] — Google-owned video platform; pioneered MMoE for next-video recommendation at scale
- [[red-hat|Red Hat]] — Open source infrastructure and AI platform; OpenShift AI with KFP integration
- [[atscale|AtScale]] — Enterprise semantic layer platform; introduced the open-source Semantic Modeling Language (SML)
- [[snowflake|Snowflake]] — Cloud data platform; semantic views for AI-powered conversational interfaces
- [[airbyte|Airbyte]] — Open-source data integration (ELT + CDC); 600+ connectors; foundation for real-time semantic layers
- [[shopify|Shopify]] — Global e-commerce platform; UCP co-developer with Google; Checkout Kit → open ECP protocol; millions of merchants

### Tools & Models

- [[agentgateway|Agent Gateway]] — Open-source Rust gateway for MCP/A2A/LLM traffic; Linux Foundation; Kubernetes-native via Helm/ArgoCD
- [[claude|Claude]] — Anthropic's AI model family; Sonnet 4.5, Opus 4.6; used across agent and assistant tasks in this wiki
- [[codex|Codex]] — OpenAI's AI coding agent (GPT-5); autonomous software engineering; central to Harness Engineering research
- [[cube|Cube]] — Open-source headless semantic layer; API-first (REST/GraphQL/SQL); pre-aggregation engine; leader in headless BI
- [[moltbook|Moltbook]] — Agent-focused platform and identity layer; instruction propagation and authentication hub
- [[openclaw|OpenClaw]] — Open-source self-hosted agent gateway; messaging platform integration; transparent memory (MEMORY.md)
- [[tensorflow-recommenders|TensorFlow Recommenders]] — TensorFlow library (Google) for building two-tower retrieval models
- [[trae|Trae]] — AI coding agent by ByteDance; published the Definitive Guide to Harness Engineering; introduced R.E.S.T. framework
- [[vertex-ai-matching-engine|Vertex AI Matching Engine]] — Google Cloud managed ANN service; Tree-AH algorithm; up to 1B vectors with incremental updates
- [[jordan-totten|Jordan Totten]] — Customer Engineer at Google; co-author of two-tower retrieval reference architectures
- [[jeremy-wortz|Jeremy Wortz]] — Customer Engineer at Google; co-author of two-tower retrieval reference architectures
- [[hadar-cohen|Hadar Cohen]] — Red Hat author; two-tower recommender on OpenShift AI
- [[kubeflow-pipelines|KFP — Kubeflow Pipelines]] — Python-decorated ML workflow components on Kubernetes; S3-based data sharing
- [[feast|Feast]] — Feature store for ML training data and online recommendation caching
- [[openshift-ai|Red Hat OpenShift AI]] — Kubernetes-native AI/ML platform with KFP integration
- [[argo-workflows|Argo Workflows]] — Container-native workflow engine for Kubernetes orchestration
- [[kubernetes|Kubernetes]] — Container orchestration; pod isolation, eviction management
