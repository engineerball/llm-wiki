# Index

Master catalog of all wiki pages. Updated on every ingest.

## Sources

### AI & Software Engineering

- [[Software Engineering at the Tipping Point]] — Adam Bender (Google I/O): second-order impacts of AI coding velocity on engineering teams
- [[software-engineering-tipping-point-bender-gcp-2026|Software Engineering at the Tipping Point (Google I/O 2026)]] — Adam Bender: AI increases code 10-100x; software ecology thinking, shared fate failure
- [[software-engineering-kab-harness-engineering-10x-technical-debt-odds-team-2026|Software Engineering กับ Harness Engineering: 10x หรือ Technical Debt (ODDS Team)]] — Thai synthesis of Bender + Harness Engineering; release cadence bottlenecks, Harness Decay examples
- [[ai-coding-agents-software-engineering-andrew-ng-aidev26|AI Coding Agents & Software Engineering (AI Dev 26)]] — Andrew Ng: software = building blocks; bottleneck shifts to product/design/legal; generalist era

### Agent Engineering & Harness Engineering

- [[harness-engineering-leveraging-codex|Harness Engineering: Leveraging Codex in an Agent-First World]] — OpenAI's foundational article introducing Harness Engineering and Codex-based agent-first development
- [[harness-engineering-coding-agent-users|Harness Engineering for Coding Agent Users]] — Guides/sensors framework, harnessability taxonomy, three harness domains (martinfowler.com)
- [[trae-definitive-guide-harness-engineering|The Definitive Guide to Harness Engineering (Trae)]] — Horse & Reins metaphor, R.E.S.T. framework, PPAF loop, six design principles
- [[stripe-minions-one-shot-coding-agents|Stripe Minions: One-Shot Coding Agents]] — Stripe's production one-shot agents; blueprints as feedforward guides, pre-push hooks as sensors
- [[anthropic-effective-harnesses|Effective Harnesses for Long-Running Agents]] — Anthropic's two-role architecture: initializer + coding agent; context anxiety and reset strategies
- [[harness-design-long-running-apps|Harness Design for Long-Running Apps]] — Multi-agent generator–evaluator harness for long-running app development with Claude
- [[harness-engineering-claude-code-book|Harness Engineering: The Claude Code Book]] — Comprehensive design analysis of Claude Code as a harness specimen
- [[agentgateway-kubernetes-docs|Agent Gateway: Kubernetes Docs]] — Official Kubernetes deployment docs: LLM/MCP/A2A gateway, Rust, Linux Foundation
- [[agentic-ai-reference-architecture|Agentic AI Reference Architecture]] — 9-layer reference architecture for goal-driven multi-agent AI systems
- [[institutional-ai-vs-individual-ai-sivulka-2026|Institutional AI vs Individual AI]] — George Sivulka: seven pillars of institutional intelligence, electrification analogy
- [[team-os-claude-code-hannah-stulberg-2026|Build a Team OS with Claude Code — Hannah Stulberg]] — Team OS architecture, context management theory, nested CLAUDE.md indexes, parallel agents

### Agent Security

- [[nvidia-nemoclaw-overview|NVIDIA NemoClaw Overview]] — Official NVIDIA reference stack for deploying OpenClaw safely; three-primitive isolation
- [[nvidia-nemoclaw-how-it-works|NVIDIA NemoClaw — How It Works]] — 7-component gateway-mediated design, three integration components, inference routing
- [[nvidia-nemoclaw-ecosystem|NVIDIA NemoClaw — Ecosystem]] — Three-layer stack (NemoClaw → OpenShell → OpenClaw), two deployment paths
- [[nvidia-nemoclaw-security-best-practices|NVIDIA NemoClaw — Security Best Practices]] — Four-layer deny-by-default model; binary-scoped + L7 network rules; 6 common mistakes
- [[running-openclaw-safely|Running OpenClaw Safely]] — Microsoft security analysis: identity isolation, three primary risks, end-to-end attack scenario
- [[nebius-openclaw-security|OpenClaw Security: Architecture and Hardening Guide]] — Nebius deep-dive: Gateway boundary, sandboxing hierarchy, ClawHavoc campaign, memory poisoning

### Agentic Commerce & Protocols

- [[ucp-universal-commerce-protocol|Universal Commerce Protocol (UCP)]] — Google's open-source standard for agentic commerce; architecture, trust triangle
- [[ucp-interoperability-mcp-a2a-ap2|UCP Interoperability with MCP / A2A / AP2]] — 4-layer protocol stack analysis, end-to-end travel commerce use case, $500B 2030 projection
- [[shopify-universal-commerce-protocol-ucp-2026|Shopify Universal Commerce Protocol (UCP)]] — Shopify engineering deep-dive: layered capabilities+extensions, graceful handoff via ECP
- [[ucp-specification-overview|UCP Official Specification Overview]] — Namespace governance, intersection algorithm, payment handler model, trust triangle
- [[ap2-agent-payments-protocol-2026|AP2 — Agent Payments Protocol]] — Verifiable credentials, role architecture, cart/payment mandates, Python + Android samples
- [[agentic-protocols-for-websites-2026|Agentic Protocols for Your Website in 2026]] — Protocol readiness guide: MCP, A2A, UCP — what to build now vs watch

### Semantic Layers & Data Architecture

- [[the-semantic-movement-modern-data-101-2026-05-05|The Semantic Layer Movement: Rise & Current State]] — Semantic layer history, semantic mistrust risk, Reliable Semantic Stack framework
- [[rise-of-semantic-layer-airbyte-2026-05-05|The Rise of the Semantic Layer: Metrics on the Fly]] — Semantic layers for AI; headless BI, Graph-RAG, real-time streaming, key tools
- [[databricks-semantic-layer-architecture|Databricks: Semantic Layer Architecture]] — 5-era history, AI agent grounding/execution pattern, core-edge architecture
- [[best-open-source-semantic-layer-tools-2026|Best Open-Source Semantic Layer Tools in 2026]] — 7 tools compared: Cube, dbt SL, MetriQL, Malloy, Lightdash, Evidence, DataForge
- [[semantic-layer-duckdb-tutorial|Semantic Layers with DuckDB]] — Why semantic layers matter and how to build one with DuckDB + Ibis
- [[naming-conventions-for-semantic-layers|Naming Conventions for Semantic Layers]] — Gold-layer design principles for AI Copilot consumption (Microsoft Fabric)
- [[dbt-semantic-layer-introduction|Introduction to the dbt Semantic Layer]] — What a semantic layer is, five use cases, and the hub-and-spoke pattern
- [[building-a-semantic-layer-lessons-learned|Building a Semantic Layer: Lessons Learned]] — Simplified Minerva 2.0 architecture for small teams; pre-computation trap, SQLGlot as semantic engine

### Recommendation Systems

- [[moe-for-recsys-reachsumit|MoE for Recommendation Systems]] — MoE variants (HME/DMoE/Sparsely-Gated/MMoE), YouTube engagement vs satisfaction tradeoff
- [[reachsumit-two-tower-model|Two-Tower Architecture Survey]] — Two-tower DNN taxonomy, SDE vs ADE, DAT + IntTower research extensions
- [[shaped-ai-two-tower-deep-dive|Two-Tower Deep Dive]] — Loss functions taxonomy, negative sampling strategies, BPR, InfoNCE, in-batch negatives
- [[two-tower-movie-recommender-pytorch|Two-Tower Movie Recommender in PyTorch]] — Three-tower PyTorch recommender on MovieLens: feature-based users, debiased ratings, cold start
- [[two-towers-deep-retrieval-google-cloud|Scaling Deep Retrieval: Two Towers (Google Cloud)]] — Two-tower retrieval with TensorFlow Recommenders + Vertex AI Matching Engine
- [[implement-two-tower-retrieval-gcp-2025|Implement Two-Tower Retrieval for Large-Scale Candidate Generation]] — Google Cloud Architecture Center reference architecture; full Vertex AI pipeline
- [[redhat-two-tower-model-openshift-2026|Understanding the Recommender System's Two-Tower Model (Red Hat)]] — OpenShift AI + KFP pipeline: EntityTower dual encoder, MSE loss, cold start strategy
- [[recsysml-two-tower-models-retrieval|Two Tower Models for Retrieval (RecSysML)]] — Practical insights: user/item encoder design, dot product training, negative sampling

### FinOps

- [[gcp-align-cloud-spending-business-value|GCP: Align Cloud Spending with Business Value]] — TCO framework (4 cost factors), 5 recommendations; Well-Architected Framework principle
- [[thoughtworks-five-differences-cloud-cost-finops|Five Differences: Cloud Cost Management vs FinOps]] — Why cloud cost management and FinOps are not the same; cultural and operational distinctions
- [[finops-framework-principles|FinOps Framework Principles]] — Six north-star principles of the FinOps Framework (FinOps Foundation)
- [[finops-getting-started-gcp|Getting Started with FinOps on GCP]] — Google Cloud FinOps implementation: organizational structure, Inform/Optimize/Operate with GCP tooling
- [[gcp-finops-hub|GCP FinOps Hub]] — Google Cloud Billing dashboard: FinOps Score, peer benchmarking, 25+ recommenders
- [[finops-atlassian-what-is-finops|What is FinOps (Atlassian)]] — Definition, 5 best practices, Inform/Optimize/Operate lifecycle
- [[finops-personas-finops-foundation|FinOps Personas (FinOps Foundation)]] — 6 Core personas + 5 Allied personas; Intersecting Disciplines framework
- [[cdv-government-cloud-usage-guideline|Thailand Digital Government Standard — Government Cloud Usage Guideline (DGS 9-2:2568)]] — Thai "Go Cloud First" policy; FinOps as mandated operating model, migration 6Rs
- [[vestbee-gcp-finops-tips-tools|Google Cloud FinOps: Tips and Tools (Vestbee)]] — Five success metrics: Accountability, Measurement, Cost Optimization, Planning, Active Assist

### Leadership & Business

- [[start-with-why-thai-summary|Start With Why — Thai Summary]] — Apiwat Tavesirivate's Thai summary of Simon Sinek's *Start With Why*; Golden Circle, WHY-first leadership, purpose decay
- [[start-with-why-panasm-summary|Start With Why — Panasm Thai Summary]] — Punksood's Thai summary; CDC framework, Celery Test, Langley vs Wright Brothers, WHY-HOW split

### Data & Knowledge

- [[cdp-comparison-2026|9 Best Customer Data Platforms (CDPs) in 2026]] — Market review of 9 CDP platforms: identity resolution, segmentation, omnichannel activation
- [[karpathy-llm-wiki-pattern|A Pattern for Building Personal Knowledge Bases Using LLMs]] — Wiki vs RAG distinction, 3 layers, ingest/query/lint workflows (Andrej Karpathy)
- [[how-we-built-an-ai-second-brain-for-60k-knowledge-workers-meta|How We Built an AI Second Brain for 60K Knowledge Workers (Meta)]] — PARA + MCP + skills-as-markdown; 0 → 63K installs in 3 months
- [[obsidian-ai-second-brain-nxcode-2026|Obsidian AI Second Brain: Complete Guide 2026 (nxcode.io)]] — Obsidian as AI knowledge platform; Smart Connections, Claude Code + MCP, 5 context-engineering principles

### Claude Skills & Prompt Engineering

- [[claude-skill-creator-vibecodingthailand-2026|Claude Skill Creator — A Practical Handbook (2026)]] — Vibe Coding Thailand: คู่มือ 97 หน้า สอนสร้าง Claude Skills ด้วย Prompt-First approach
- [[ralph-wiggum-technique-ghuntley-2025|Ralph Wiggum Technique — Agentic Loop Coding (Geoffrey Huntley)]] — Autonomous bash loop coding methodology; specs + fix_plan as deterministic stack

### LLM Architecture

- [[attention-is-all-you-need-adnanmasood-2026-01-13|Attention Is All You Need — Adnan Masood (2026)]] — Distillation of Vaswani et al.'s 2017 Transformer paper; self-attention, multi-head attention

---

## Entities

### People

- [[Adam Bender]] — Google engineer; software ecology framework; AI 10x moment thesis
- [[andrej-karpathy|Andrej Karpathy]] — AI researcher; former OpenAI Director of AI, former Tesla AI Director; LLM-Wiki pattern originator
- [[animesh-kumar|Animesh Kumar]] — Data strategist; author of the Semantic Movement and Reliable Semantic Stack frameworks
- [[birgitta-bockeler|Birgitta Böckeler]] — ThoughtWorks principal technologist; Guides/Sensors taxonomy and harness engineering framework
- [[justin-young|Justin Young]] — Anthropic engineer; author of "Effective Harnesses for Long-Running Agents"
- [[mitchell-hashimoto|Mitchell Hashimoto]] — HashiCorp co-founder (Terraform, Vault); coined the term "Harness Engineering"
- [[prithvi-rajasekaran|Prithvi Rajasekaran]] — Anthropic engineer; multi-agent harness and long-running app architecture researcher
- [[swami-achari|Swami Achari]] — Modern Data 101 author; 2026 CDP comparison (9 platforms)
- [[vijayaraghavan-v|V. Vijayaraghavan]] — LinkedIn author; UCP 4-layer protocol stack analysis
- [[jordan-totten|Jordan Totten]] — Customer Engineer at Google; co-author of two-tower retrieval reference architectures
- [[jeremy-wortz|Jeremy Wortz]] — Customer Engineer at Google; co-author of two-tower retrieval reference architectures
- [[geoffrey-huntley|Geoffrey Huntley]] — Australian software engineer; creator of the Ralph Wiggum Technique for agentic coding loops
- [[hadar-cohen|Hadar Cohen]] — Red Hat author; two-tower recommender on OpenShift AI
- [[christian-edensor-arbon|Christian Edensor Arbon]] — Data engineering practitioner; simplified Minerva 2.0 architecture; Building a Semantic Layer series

### Organizations

- [[anthropic|Anthropic]] — AI safety research lab; creator of Claude model family and Effective Harnesses research
- [[obsidian|Obsidian]] — Local-first Markdown PKM tool; 1.5M users (2026); primary platform for AI-augmented PKM
- [[meta|Meta]] — Built AI Second Brain harness (63K users, 3 months); PARA + MCP + skills-as-markdown
- [[tiago-forte|Tiago Forte]] — Productivity author; creator of the PARA Method; *Building a Second Brain* (2022)
- [[simon-sinek|Simon Sinek]] — Author of *Start With Why*; creator of the Golden Circle framework
- [[apiwat-tavesirivate|Apiwat Tavesirivate]] — Thai author/summarizer at lucid-trader.com
- [[punksood|Punksood]] — Thai author/summarizer at panasm.com
- [[steve-jobs|Steve Jobs]] — Apple co-founder; WHY visionary; ouster proved WHY ≠ product strategy
- [[walt-disney|Walt Disney]] — WHY visionary; relied on Roy Disney as HOW operator
- [[bytedance|ByteDance]] — Parent of Trae and TikTok; active in agent engineering research
- [[databricks|Databricks]] — Data + AI company; Lakehouse architecture, Unity Catalog, platform-native semantic layer
- [[dbt-labs|dbt Labs]] — Data transformation company; creator of dbt and the dbt Semantic Layer (MetricFlow)
- [[dga|DGA — Digital Government Development Agency (Thailand)]] — Thai government body; mandates FinOps under Go Cloud First policy
- [[finops-foundation|FinOps Foundation]] — Vendor-neutral nonprofit; governs the FinOps Framework, principles, personas
- [[fountain-city|Fountain City]] — AI agents company; publishes agentic protocol readiness guidance for websites
- [[google|Google]] — UCP + A2A creator, AP2 protocol, GCP FinOps, TensorFlow Recommenders, Vertex AI Matching Engine
- [[kuaishou|Kuaishou]] — Chinese short-video platform; MMoE-based personalized cold start modules at scale
- [[linux-foundation|Linux Foundation]] — Nonprofit governing MCP, A2A, and Agent Gateway (Apache 2.0)
- [[microsoft|Microsoft]] — Microsoft Fabric semantic layers, MCP co-governance, WebMCP, OpenClaw security research
- [[modern-data-101|Modern Data 101]] — Substack publication; semantic layer evolution and data engineering best practices
- [[openai|OpenAI]] — Creator of Codex, GPT series; published original Harness Engineering article
- [[stripe|Stripe]] — Payments infrastructure; runs Minions one-shot coding agent system at production scale
- [[thoughtworks|ThoughtWorks]] — Global tech consultancy; harness engineering and FinOps research; publisher of martinfowler.com
- [[youtube|YouTube]] — Google-owned video platform; pioneered MMoE for next-video recommendation at scale
- [[red-hat|Red Hat]] — Open source infrastructure and AI platform; OpenShift AI with KFP integration
- [[atscale|AtScale]] — Enterprise semantic layer platform; introduced the open-source Semantic Modeling Language (SML)
- [[snowflake|Snowflake]] — Cloud data platform; semantic views for AI-powered conversational interfaces
- [[airbyte|Airbyte]] — Open-source data integration (ELT + CDC); 600+ connectors; foundation for real-time semantic layers
- [[airbnb|Airbnb]] — Short-term rental marketplace; pioneered Metrics as Code via Minerva; canonical semantic layer reference
- [[shopify|Shopify]] — Global e-commerce platform; UCP co-developer with Google; Checkout Kit → open ECP protocol
- [[apple|Apple]] — WHY-first company; empowers individuals to challenge status quo; canonical Golden Circle example
- [[harley-davidson|Harley-Davidson]] — Motorcycle brand; logo tattooed by fans; symbol of shared belief beyond products
- [[walmart|Walmart]] — Retail giant; cautionary tale of purpose decay after Sam Walton's death
- [[southwest-airlines|Southwest Airlines]] — Low-cost carrier; CDC framework example; WHY: champion of ordinary people
- [[samuel-pierpont-langley|Samuel Pierpont Langley]] — Wright Brothers rival; WHAT-driven; quit when they won; contrast to WHY-driven leadership

### Tools & Models

- [[agentgateway|Agent Gateway]] — Open-source Rust gateway for MCP/A2A/LLM traffic; Linux Foundation; Kubernetes-native
- [[claude|Claude]] — Anthropic's AI model family; used across agent and assistant tasks in this wiki
- [[codex|Codex]] — OpenAI's AI coding agent (GPT-5); autonomous software engineering; central to Harness Engineering
- [[cube|Cube]] — Open-source headless semantic layer; API-first (REST/GraphQL/SQL); leader in headless BI
- [[moltbook|Moltbook]] — Agent-focused platform and identity layer; instruction propagation and authentication hub
- [[nemoclaw|NemoClaw]] — NVIDIA's hardened reference stack for deploying OpenClaw; four-layer security model
- [[openShell|OpenShell]] — NVIDIA's sandbox execution environment; enforces network egress, filesystem, process policies
- [[openclaw|OpenClaw]] — Open-source self-hosted agent gateway; messaging platform integration; transparent memory
- [[tensorflow-recommenders|TensorFlow Recommenders]] — TensorFlow library (Google) for building two-tower retrieval models
- [[trae|Trae]] — AI coding agent by ByteDance; published Definitive Guide to Harness Engineering; R.E.S.T. framework
- [[vertex-ai-matching-engine|Vertex AI Matching Engine]] — Google Cloud managed ANN service; Tree-AH algorithm; up to 1B vectors
- [[sqlglot|SQLGlot]] — Open-source Python SQL parser/transpiler; semantic engine layer; dialect translation for modern data stacks
- [[starrocks|StarRocks]] — High-performance OLAP database; sub-second on-the-fly joins; Airbnb Minerva execution engine
- [[kubeflow-pipelines|KFP — Kubeflow Pipelines]] — Python-decorated ML workflow components on Kubernetes; S3-based data sharing
- [[feast|Feast]] — Feature store for ML training data and online recommendation caching
- [[openshift-ai|Red Hat OpenShift AI]] — Kubernetes-native AI/ML platform with KFP integration
- [[argo-workflows|Argo Workflows]] — Container-native workflow engine for Kubernetes orchestration
- [[kubernetes|Kubernetes]] — Container orchestration; pod isolation, eviction management

---

## Concepts

### Agentic AI & Harness Engineering

- [[harness-engineering|Harness Engineering]] — Software engineering discipline shifted to designing environments, feedback loops, and scaffolding for reliable AI agents
- [[para-method|PARA Method]] — Folder taxonomy (Projects, Areas, Resources, Archives) adapted as context architecture for AI agents
- [[skills-as-markdown|Skills as Markdown]] — Reusable agent workflows as plain markdown + scripts; no compilation; 3,000+ skills built at Meta in 3 months
- [[skill-md-specification|SKILL.md Specification]] — File format and structural spec for agent skills: frontmatter, directory structure, progressive disclosure three-level loading
- [[progressive-disclosure|Progressive Disclosure]] — Context loading strategy: lean root context always in scope; detailed content loaded on demand
- [[harnessability|Harnessability]] — Degree to which a codebase enables effective harness controls; increases with strong typings, clear boundaries
- [[guides-and-sensors|Guides and Sensors]] — Harness control taxonomy: Guides (feedforward) steer before action; Sensors (feedback) observe after
- [[agentic-ai-system|Agentic AI System]] — 9-layer reference architecture for goal-driven, multi-agent, orchestrated, observable AI systems
- [[institutional-ai|Institutional AI]] — Seven-pillar framework for organisational AI: coordination, signal extraction, objectivity, domain edge, revenue outcomes, process engineering
- [[team-os|Team OS]] — Cross-functional shared knowledge repository as AI team operating system; nested CLAUDE.md doc indexes
- [[one-shot-agent|One-Shot Agent]] — Coding agent pattern: agent receives a single task and autonomously completes the full dev cycle
- [[initializer-coding-agent-architecture|Initializer + Coding Agent Architecture]] — Anthropic's two-role split for cross-session continuity: one-time setup + incremental progress
- [[generator-evaluator-architecture|Generator–Evaluator Architecture]] — Multi-agent pattern with clean role separation; addresses LLM self-evaluation blindness
- [[context-management-for-agents|Context Management for Agents]] — How long-running tasks handle finite context windows; degradation and anxiety failure modes
- [[sprint-contracts|Sprint Contracts]] — Pre-negotiated explicit success criteria between Generator and Evaluator agents
- [[feature-list-pattern|Feature List Pattern]] — JSON enumeration of all project features with pass/fail status; prevents premature task completion
- [[blueprints|Blueprints]] — Stripe's structured documentation encoding service contracts and interface specs
- [[llm-gateway|LLM Gateway]] — Unified API proxy for routing LLM requests across multiple providers; handles translation, load balancing
- [[agent-sandbox-security|Agent Sandbox Security]] — Four-layer deny-by-default security model for AI agent sandboxes: network, filesystem, process, inference
- [[software-ecology|Software Ecology]] — Systems-thinking framework treating software engineering as a holistic socio-technical ecosystem
- [[ai-engineering-shift|AI Engineering Shift]] — Structural transformation when coding velocity increases 10–100x: bottleneck migration, generalist engineer rise
- [[ralph-wiggum-technique|Ralph Wiggum Technique]] — Agentic coding loop: autonomous single-process loop, one task per iteration, specs + fix plan as context stack
- [[AI 10x Moment]] — coding velocity explosion and its second-order impacts on engineering pipelines
- [[Agentic Chaos]] — edit wars and unmaintainable code from unconstrained AI agents
- [[Architecture Diagram Test]] — diagnostic: ask all engineers to draw system independently; divergence = lost control
- [[Code As Liability]] — more code = more debt; AI-generated code bloat amplifies maintenance burden
- [[Robust Abstractions]] — opinionated internal frameworks that constrain agent choice space
- [[Statistical Integration Testing]] — risk-weighted test selection replacing all-or-nothing boolean CI gates

### Agentic Commerce & Protocols

- [[agentic-commerce|Agentic Commerce]] — Commercial transactions executed autonomously by AI agents: discovery, negotiation, checkout, payment
- [[agentic-protocol-stack|Agentic Protocol Stack]] — 4-layer architecture: MCP (tools), A2A (agents), UCP (commerce), AP2 (payments)
- [[ucp|UCP — Universal Commerce Protocol]] — Open-source standard for agentic commerce; common language for AI agents to discover merchant capabilities
- [[ucp-negotiation-protocol|UCP Negotiation Protocol]] — Dynamic capability negotiation between UCP platforms and businesses; intersection algorithm
- [[ucp-payment-handlers|UCP Payment Handlers]] — UCP payment architecture decoupling credential acquisition from commerce logic
- [[ap2-agent-payments-protocol|AP2 — Agent Payments Protocol]] — Google's open protocol for agent payments with cryptographic proof of user intent
- [[customer-data-platform|Customer Data Platform (CDP)]] — Data platform unifying customer data across touchpoints; system of intelligence for identity resolution

### Semantic Layers & Data Architecture

- [[semantic-layer|Semantic Layer]] — Virtual translation layer between physical data warehouse and data consumers; unified business metric definitions
- [[airbnb-minerva|Airbnb Minerva]] — Airbnb's internal metrics platform; canonical Metrics as Code implementation; 12K+ metrics, v2 uses SQLGlot + StarRocks
- [[metrics-as-code|Metrics as Code]] — Business logic standardized as version-controlled YAML/Python; foundational principle of modern semantic layers
- [[pre-computation-trap|Pre-computation Trap]] — Anti-pattern of pre-aggregating all dimension combos; breaks on ratios/distinct counts; escape via on-the-fly OLAP
- [[headless-bi|Headless BI]] — BI architecture where semantic metric definitions are decoupled from visualization; metrics exposed via APIs
- [[graph-rag|Graph-RAG]] — Graph-enhanced RAG using explicit business relationships and entity links instead of pure vector similarity
- [[data-products|Data Products]] — Model-first data management treating data as a product with SLOs; foundation of Reliable Semantic Stack
- [[reliable-semantic-stack|Reliable Semantic Stack]] — Three-layer framework (data products, catalog, data APIs) ensuring semantic layer credibility
- [[semantic-mistrust|Semantic Mistrust]] — State where semantic layer loses credibility by inheriting data quality issues from physical layer
- [[rag|RAG — Retrieval-Augmented Generation]] — LLM retrieves relevant document chunks from vector store at query time; contrast with LLM-wiki pattern
- [[generative-ai|Generative AI]] — AI systems generating novel content; semantic layers and harness engineering make it reliable
- [[llm-wiki-pattern|LLM-Wiki Pattern]] — LLM incrementally builds a persistent wiki from raw sources; compounding knowledge artifact vs RAG

### Transformer Architecture & Attention

- [[transformer-architecture|Transformer Architecture]] — Sequence model built entirely on attention (Vaswani et al., 2017); eliminated recurrence
- [[attention-mechanism|Attention Mechanism]] — Neural mechanism allowing models to dynamically focus on relevant input parts
- [[self-attention|Self-Attention]] — Attention within a single sequence; each token attends to all others, creating direct connections
- [[multi-head-attention|Multi-Head Attention]] — Multiple self-attention operations in parallel with different learned projections
- [[positional-encoding|Positional Encoding]] — Injects order information into Transformers; sinusoidal, learned, rotary (RoPE) variants

### Recommendation Systems

- [[recommendation-systems|Recommendation Systems]] — ML systems predicting relevant items for users; multi-stage retrieval/ranking pipeline
- [[two-tower-architecture|Two-Tower Architecture]] — Neural retrieval pattern: queries and candidates mapped to shared embedding space via separate towers
- [[negative-sampling|Negative Sampling]] — Training technique constructing negative examples to teach retrieval models to distinguish relevant from irrelevant
- [[multi-task-learning-recsys|Multi-Task Learning (RecSys)]] — Joint optimization of competing recsys objectives (engagement, satisfaction, revenue); MMoE as dominant architecture
- [[mixture-of-experts|Mixture of Experts (MoE)]] — Ensemble combining specialized sub-networks via learned gating; HME, DMoE, Sparsely-Gated, MMoE
- [[cold-start-problem|Cold-Start Problem]] — Difficulty recommending to new users/items with no interaction history; feature-based representation solves this
- [[approximate-nearest-neighbors|Approximate Nearest Neighbors (ANN)]] — Algorithm class for fast vector similarity search at scale; Tree-AH, HNSW, PQ trade exactness for speed

### FinOps

- [[finops|FinOps]] — Financial Operations for cloud; practice bringing financial accountability to variable cloud spend
- [[finops-lifecycle|FinOps Lifecycle]] — Three-stage iterative cycle: Inform → Optimize → Operate → repeat
- [[unit-economics-finops|Unit Economics in FinOps]] — Expressing cloud costs in business-meaningful units (cost per user, per transaction); TCO framework

---

### Leadership & Business

- [[golden-circle|Golden Circle]] — Sinek's three-ring framework: WHY → HOW → WHAT; CDC operating conditions; inside-out communication
- [[purpose-driven-leadership|Purpose-Driven Leadership]] — Leading from WHY; charisma vs power; WHY-HOW split; metric drift mechanism
- [[manipulation-vs-inspiration|Manipulation vs Inspiration]] — Two behavior-change modes; manipulation = transactions; inspiration = loyalty
- [[diffusion-of-innovation|Diffusion of Innovation]] — 5 adoption groups; Innovators+Early Adopters = 16%; tipping point to mass market
- [[celery-test|Celery Test]] — WHY clarity diagnostic; clear WHY makes decisions instant and consistent across team
- [[why-how-split|WHY-HOW Split]] — Structural pattern: WHY visionary needs HOW operator; Walt/Roy Disney, Jobs/Wozniak

## Synthesis
