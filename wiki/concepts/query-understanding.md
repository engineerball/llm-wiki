---
title: "Query Understanding"
tags: [concept, query-understanding, search, llm, semantic-search, personalization, opensearch]
sources: ["sources/query-understanding-llms-opensearch-2025.md"]
date: 2026-08-04
---

# Query Understanding

Query understanding is the process of interpreting a user's search input and enriching it before retrieval so that the search system can better represent intent, context, constraints, and desired results.

## Why It Matters

Short search inputs often underspecify the user's intent.

An embedding generated from only a few words can contain less useful context than an embedding generated from a complete, enriched description.

Poor candidate retrieval cannot be fully repaired by reranking because reranking only reorders the candidates that were already retrieved.

## Core Techniques

- **Query expansion** adds semantic context to sparse input.
- **Query rewriting** improves spelling, adds explicit metadata filters, and clarifies intent.
- **Query classification** routes specific, generic, navigational, or exploratory queries to suitable retrieval paths.
- **Result summarization** uses an LLM to synthesize information from large result sets.
- **LLM judging** evaluates retrieval or response quality offline and online.

## Context Enrichment

A useful enrichment model separates:

- **User context** - preferences, goals, behavior, and user-behavior-insight data.
- **Domain context** - industry trends and domain-specific facts.
- **Business context** - promotion rules, commercial priorities, and business constraints.

Keeping these contexts explicit helps prevent a single manually maintained search query from becoming an unmaintainable mix of user and business requirements.

## Personas

Personas represent groups of real users through goals, behavior, and mental models.

Proto-personas are unvalidated hypotheses that can be refined using observed user behavior.

A query-understanding system can map an actual user to a persona and use the persona to expand queries and select filters.

## Architecture Pattern

A decision gateway can route known personas, anonymous users, and new users through different paths.

An LLM can then expand the query, extract valid filters, choose lexical, vector, or hybrid retrieval, construct OpenSearch DSL, and execute the search.

Production systems should retain a deterministic default path and impose a timeout on the LLM path so that search latency remains within the business SLA.

## Engineering Guardrails

- Constrain generated filters to fields and values that exist in the index or catalog.
- Use soft boosts when hard filters would create brittle exclusions.
- Cache repeated query expansions and responses.
- Reindex when the embedding model changes.
- Measure relevance, latency, cost, and zero-result rates continuously.
- Observe the full pipeline with logs, traces, and metrics.

## Relationships

- [[agentic-search]] - query understanding can be an agentic planning and retrieval step.
- [[opensearch]] - provides the lexical, sparse, vector, hybrid, and analytics layers.
- [[rag]] - query enrichment improves retrieval grounding for generation.
- [[context-management-for-agents]] - supplies context management concepts for LLM workflows.
