---
title: "OpenSearch"
tags: [entity, opensearch, search, retrieval, vector-search, open-source, aws]
sources: ["sources/nextgen-search-ai-opensearch-mcp.md"]
date: 2026-08-04
---

# OpenSearch

OpenSearch is an open-source search and analytics suite used for log analytics, real-time application monitoring, website search, lexical search, semantic search, and vector use cases.

In the article's architecture, OpenSearch is the data layer that stores and indexes information while exposing operations through an MCP server.

## Role in Agentic Search

OpenSearch supports the progression from keyword search to semantic, hybrid, conversational, and agentic search.

The article describes MCP tools for listing indexes, reading mappings, searching indexes, checking shards and cluster health, counting matches, explaining matches, and running multi-search operations.

The source describes OpenSearch 3.0 or later as providing an MCP server option and mentions agentic memory from OpenSearch 3.3 onward.

## Source Caveat

Quantitative claims about downloads, membership, and rankings are source-dated claims from the article and should be independently rechecked before being used in current architecture decisions.

## Relationships

- [[agentic-search]] - uses OpenSearch as a search and analytics layer.
- [[model-context-protocol]] - connects agents to OpenSearch tools.
- [[agentic-ai-system]] - provides a broader architecture context.
- [[rag]] - uses retrieval systems such as OpenSearch for grounding.
