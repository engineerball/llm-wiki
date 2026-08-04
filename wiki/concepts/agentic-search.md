---
title: "Agentic Search"
tags: [concept, agentic-ai, search, opensearch, model-context-protocol, rag, architecture]
sources: ["sources/nextgen-search-ai-opensearch-mcp.md"]
date: 2026-08-04
---

# Agentic Search

Agentic search is a search pattern in which an AI agent interprets a natural-language request, plans a workflow, invokes tools, searches or analyzes data, correlates findings, and iterates when needed.

It is presented as a superset of conversational search because it can orchestrate multiple data sources and tasks rather than retrieve a response from a single source in one step.

## Search Evolution

- Keyword search is fast and deterministic but does not adequately model user intent or context.
- Semantic search uses embeddings to retrieve results by meaning.
- Hybrid or multimodal search combines lexical and semantic retrieval and may use several modalities.
- Conversational search uses an LLM to translate natural-language questions into retrieval interactions.
- Agentic search adds planning, tool orchestration, correlation, execution, and iterative reasoning.

## Reference Architecture

The article groups the system into three layers:

1. **Agentic layer** - conversational interface, LLM reasoning, and planning.
2. **Protocol layer** - MCP client and server that translate tool calls into service operations.
3. **Data layer** - OpenSearch indexes, searches, analytics, and results.

## Use Cases

The examples cover executive sales analysis, product and revenue aggregation, dashboard generation, application-latency investigation, CPU-to-latency correlation, and anomaly detection over observability data.

## Engineering Considerations

Agentic search can reduce the need for users to write domain-specific query language.

It also introduces requirements for tool permissions, authorization, data boundaries, query validation, result interpretation, auditability, and cost control.

## Relationships

- [[model-context-protocol]] - standardizes agent-to-service communication.
- [[opensearch]] - provides the search and analytics data layer.
- [[agentic-ai-system]] - provides a broader system architecture context.
- [[rag]] - supplies external knowledge to an LLM response.
- [[context-management-for-agents]] - explains how persistent context addresses cross-session limitations.
