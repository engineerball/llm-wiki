---
title: "Query Understanding With Large Language Models: Techniques and Optimizations in OpenSearch"
tags: [source, query-understanding, search, opensearch, llm, semantic-search, personalization]
sources: ["https://www.youtube.com/watch?v=oF-LYeTTjfE"]
date: 2026-08-04
---

# Query Understanding With Large Language Models: Techniques and Optimizations in OpenSearch

**Source:** OpenSearch YouTube channel
**URL:** https://www.youtube.com/watch?v=oF-LYeTTjfE
**Published:** 2025-09-13
**Speakers:** Hajer Bouafif and Cédric Pelvet, Amazon Web Services
**Duration:** 50:40

## Main Thesis

Semantic search is not a silver bullet.

Search quality depends heavily on the quality and completeness of the input sent to retrieval systems.

LLMs can improve query understanding by expanding sparse user input, rewriting queries, extracting filters, classifying intent, and adding user, domain, and business context before search execution.

## Search Technology Layers

The talk compares several OpenSearch retrieval foundations:

- Lexical search with BM25, tokenizers, analyzers, synonyms, and exact matching.
- Sparse neural search, which adds semantic weights to terms while retaining a lexical-like execution pattern.
- Dense vector search, which represents documents and queries as embeddings.
- Hybrid search, which combines lexical precision with semantic retrieval.
- Multimodal search, which applies embeddings to text, images, audio, video, or other modalities.

The speakers emphasize that hybrid search is often a practical production default because exact references benefit from lexical matching while meaning-based queries benefit from vector retrieval.

## LLM Query Understanding Techniques

The talk covers:

- Query expansion to add semantic context and improve short inputs.
- Query rewriting to correct spelling, add filters, and make intent explicit.
- Query classification to route specific, generic, navigational, or exploratory queries to suitable retrieval methods.
- LLM-based judging for offline and online evaluation.
- Result summarization for large result sets and log analytics.

Reranking can reorder retrieved results, but it cannot recover relevant documents that were absent from the initial candidate set.

## Context Model

The proposed query enrichment model separates three contexts:

1. **User context** - goals, interests, behavior, preferences, and user-behavior-insight data.
2. **Domain context** - industry trends, product knowledge, and domain-specific information.
3. **Business context** - promoted products, marketing priorities, commercial rules, and other business constraints.

The talk warns that business context can create complex and conflicting search rules if it is mixed into manually maintained lexical queries without a clear architecture.

## Personas and Proto-Personas

A persona is described as a fictional representative of a group of real users.

It captures goals, behavior, and mental models rather than merely a demographic or job role.

Proto-personas are initial hypotheses that should be validated or invalidated using observed user behavior.

User Behavior Insights can refine personas over time and provide better inputs for query enrichment.

## Reference Flow

The reference architecture routes a user query through a decision gateway.

Known personas can use stored context and behavior data.

New or anonymous users can use a default path or a proto-persona path.

An LLM then expands the query, extracts filters, determines whether lexical, vector, or hybrid search is appropriate, constructs an OpenSearch DSL query, and invokes OpenSearch.

## Production Guidance

The speakers recommend:

- Keep a fast default path for predictable latency.
- Define an explicit timeout for the LLM-first path and fall back when it exceeds the business SLA.
- Use caching to reduce repeated LLM latency and inference cost.
- Apply filters and optimize vector deployment where possible.
- Reindex when the embedding model changes.
- Evaluate search and agent outputs continuously.
- Use OpenTelemetry and OpenSearch for logs, traces, metrics, and observability.
- Benchmark the cluster at the target data scale.
- Keep filter values constrained to fields and values that actually exist in the catalog or index.
- Prefer soft boosting instead of hard filtering when strict exclusion would be too brittle.

## Demo

The live e-commerce demo compares no persona, an anonymous user, and three personas named Sarah, Alex, and Michael.

The same query, such as “black shoes,” receives different expansions, filters, and results depending on the selected persona.

The demo also shows multilingual semantic search and exact-match caching for repeated requests.

## Caveat

The raw transcript is auto-generated and contains recognition errors and speaker-name ambiguity.
This summary follows the video description and the coherent technical claims in the transcript rather than treating every transcript token as authoritative.

## Related Pages

- [[query-understanding]]
- [[agentic-search]]
- [[opensearch]]
- [[rag]]
- [[context-management-for-agents]]
