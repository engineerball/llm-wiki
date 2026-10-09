---
title: "Agent Gateway"
tags: [entity, tool, agent-gateway, agentgateway, mcp, a2a, llm-gateway, kubernetes, infrastructure, open-source]
type: tool
date: 2026-10-09
sources: ["sources/agentgateway-official-2026-10-09.md", "sources/agentgateway-authn-authz-2026-10-09.md"]
---

# Agent Gateway

`agentgateway` is an open-source, Rust-based proxy and gateway for AI-native traffic.
The project provides a common policy and connectivity surface for LLM, MCP, A2A, HTTP, and gRPC traffic.
The official repository describes it as a next-generation agentic proxy for AI agents and MCP servers.

## Core capabilities

| Capability | Role |
|---|---|
| LLM Gateway | Unified provider access, routing, failover, prompt enrichment, and cost controls |
| MCP Gateway | Tool federation, static/dynamic/virtual routing, sessions, authentication, and access policy |
| A2A Gateway | Agent-to-agent routing, capability discovery, and task collaboration |
| Inference routing | Routing to self-hosted models using Kubernetes Inference Gateway signals |
| General proxy | HTTP and gRPC connectivity in addition to agentic protocols |

## Deployment

- **Kubernetes**: control plane plus proxy data plane, Kubernetes Gateway API, Helm, Argo CD, and Flux documentation.
- **Standalone**: proxy deployment without the full Kubernetes controller, configured through YAML or JSON.

## Security and observability

Documented capabilities include JWT, API keys, OAuth, CEL-based RBAC, rate limiting, TLS, external authorization, guardrails, and OpenTelemetry metrics, logs, and traces.
These capabilities should not be interpreted as automatic secure-by-default behavior, certification, or regulatory compliance.

## Current version snapshot

Research on 2026-10-09 observed GitHub release `v1.6.0` and Kubernetes documentation track `1.6.x`.
The project is active development, so feature behavior and configuration should be checked against the selected release documentation before production use.

## Distinction from Google Cloud Agent Gateway

[[google-cloud-agent-gateway]] is a separate managed Google Cloud product in the Gemini Enterprise Agent Platform.
`agentgateway` is the open-source proxy and gateway project.
They are related by problem space but are not the same implementation or deployment model.

## Authentication and authorization

[[agentgateway-authn-authz-2026-10-09]] documents the evidence boundary between user authentication in an agent runtime, gateway authentication, gateway authorization, MCP tool authorization, MCP server authorization, and backend token exchange.

The key design conclusion is that gateway authentication does not automatically authenticate the human user inside an agent or prove domain-level authorization inside an MCP server.

## Links

- Repository: https://github.com/agentgateway/agentgateway
- Website: https://agentgateway.dev/
- Documentation index: https://agentgateway.dev/docs/llms.txt
- Kubernetes docs: https://agentgateway.dev/docs/kubernetes/latest/
- Standalone docs: https://agentgateway.dev/docs/standalone/latest/
- Latest release observed: https://github.com/agentgateway/agentgateway/releases/tag/v1.6.0

## Source pages

- [[agentgateway-official-2026-10-09]]
- [[agentgateway-kubernetes-docs]]
