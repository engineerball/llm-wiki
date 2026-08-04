---
title: "Model Context Protocol"
tags: [concept, model-context-protocol, agentic-ai, architecture, infrastructure]
sources: ["sources/nextgen-search-ai-opensearch-mcp.md"]
date: 2026-08-04
---

# Model Context Protocol

Model Context Protocol, or MCP, is described in the source as an open-source standardized protocol based on JSON-RPC 2.0 for communication between MCP clients and MCP servers.

An MCP server acts as a bridge between an AI model or agent and an external service, exposing tools that the agent can invoke.

## OpenSearch Integration

The OpenSearch MCP server translates MCP tool requests into OpenSearch REST API calls and formats the results for LLM consumption.

The article lists tools for index discovery, mapping inspection, index search, shard inspection, cluster health, counting, explaining matches, and multi-search.

## Deployment Patterns

- **Local** - runs beside the agent application and is suitable for development and testing.
- **Remote** - an external service exposes a controlled MCP interface.
- **Managed hybrid** - a centralized MCP hub provides governed access to multiple data sources.
- **Cloud-native** - a cloud provider exposes or manages MCP services.

## Important Boundary

A common protocol can replace bespoke connectors, but MCP alone does not solve authorization, tool governance, isolation, auditability, prompt injection, or correctness.

Those controls remain responsibilities of the deployment architecture and operating model.

## Relationships

- [[agentic-search]] - uses MCP to orchestrate search and analysis tools.
- [[opensearch]] - is the data service demonstrated behind the MCP server.
- [[agentic-ai-system]] - places protocol integrations within a broader agentic architecture.
- [[context-management-for-agents]] - covers persistent context for long-running agent interactions.
