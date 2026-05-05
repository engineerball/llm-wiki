---
title: "Agent Gateway — Kubernetes Docs"
tags: [source, agent-gateway, mcp, a2a, llm-gateway, kubernetes, infrastructure]
sources: [".raw/articles/agentgateway-kubernetes-latest-2026-05-05.md"]
date: 2026-05-05
---

# Agent Gateway — Kubernetes Docs

**Source**: https://agentgateway.dev/docs/kubernetes/latest/
**Type**: Official product documentation
**Organization**: [[linux-foundation]] (hosted)

---

## Summary

[[agentgateway]] is an open-source gateway control plane + proxy data plane built in Rust and hosted by the [[linux-foundation]]. It addresses a fundamental gap: traditional API gateways are optimized for stateless REST interactions, but MCP and A2A protocols require stateful, long-lived connections with session fan-out, bidirectional push (SSE), and per-session authorization. Agent Gateway is purpose-built for this agentic workload pattern.

## Why Not a Traditional Gateway

| Traditional API Gateway | Agentgateway |
|---|---|
| Stateless request/response | Stateful JSON-RPC sessions |
| One request → one backend | Session fan-out across multiple MCP servers |
| Client-initiated only | Bidirectional (SSE push) |
| Path/header routing | Protocol-aware JSON-RPC routing |
| Static backend mapping | Dynamic tool virtualization per client |

Traditional gateways cannot solve: multiplexing/fan-out, server-initiated events, protocol negotiation, per-session authorization, or tool poisoning protection.

## Three Core Gateways

### LLM Gateway

Unified OpenAI-compatible API across providers. Clients call one endpoint; Agent Gateway routes and translates to the right provider.

Supported providers:
- **Native passthrough**: OpenAI, Azure (Completions/Responses), Anthropic (Messages)
- **Translation**: Amazon Bedrock, Google Gemini, Google Vertex AI
- **OpenAI-compatible**: Cohere, Mistral, Groq, Together AI, Fireworks, Ollama, vLLM, llama.cpp

For self-hosted GPU inference, implements Kubernetes Inference Gateway extensions — routes by GPU utilization, KV cache, LoRA adapters, queue depth.

See [[llm-gateway]] for the concept.

### MCP Gateway

Aggregates multiple MCP servers behind a single endpoint. Supports all three transports: stdio, HTTP/SSE, Streamable HTTP. Can expose existing REST APIs as MCP tools via OpenAPI integration. Auth via OAuth (Auth0, Keycloak).

### A2A Gateway

Enables inter-agent communication per [[agentic-protocol-stack]] L1. Agents discover capabilities, negotiate interaction modalities, collaborate without exposing internal state.

## Security & Observability

- Auth: JWT, API keys, basic auth, MCP auth spec
- RBAC: fine-grained via CEL policy engine
- Traffic: rate limiting, CORS, TLS, external authz
- Tracing: OpenTelemetry (metrics, logs, distributed traces)

## Architecture

**Control plane** — distributes config and policies to data plane
**Data plane** — proxies that process live traffic

Kubernetes-native: conforms to Kubernetes Gateway API (HTTPRoute, GRPCRoute, TCPRoute, TLSRoute).

Deployment: Helm, ArgoCD, FluxCD. Also runs as standalone binary (non-Kubernetes).

## Key Insight

Agent Gateway is what [[agentic-protocol-stack]] infrastructure actually needs at the network layer — a single proxy that speaks MCP, A2A, and routes to any LLM provider, with enterprise security and observability baked in. Eliminates the need for separate gateway infrastructure for APIs vs. agentic traffic.
