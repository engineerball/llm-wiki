---
title: "Agent Gateway"
tags: [entity, tool, agent-gateway, mcp, a2a, llm-gateway, kubernetes, infrastructure, open-source]
type: tool
date: 2026-05-05
sources: ["sources/agentgateway-kubernetes-docs.md"]
---

# Agent Gateway

Open-source gateway control plane + proxy data plane, hosted by the [[linux-foundation]]. Built in Rust for performance and memory safety with stateful, long-lived agentic connections.

## What It Does

Unified gateway for three traffic types:

| Gateway | Purpose |
|---|---|
| **LLM Gateway** | Unified OpenAI-compatible API across all major LLM providers |
| **MCP Gateway** | Aggregates multiple MCP servers; tool federation with auth |
| **A2A Gateway** | Inter-agent communication per [[agentic-protocol-stack]] L1 |

Also handles traditional API/microservice traffic — eliminates need for separate gateway infrastructure.

## Why Rust

Stateful JSON-RPC sessions with long-lived connections require performance and memory safety that Rust provides. Traditional gateways optimize for stateless REST; Agent Gateway is built for session fan-out, SSE push, and per-session authorization.

## LLM Provider Support

Native passthrough: OpenAI, Azure, Anthropic (Messages API)
Translation: Amazon Bedrock, Google Gemini, Google Vertex AI
OpenAI-compatible: Cohere, Mistral, Groq, Together AI, Fireworks, Ollama, vLLM, llama.cpp

For GPU self-hosting: Kubernetes Inference Gateway extensions for routing by GPU utilization, KV cache, LoRA adapters, queue depth.

## Security

- Auth: JWT, API keys, basic auth, MCP auth spec
- RBAC: CEL policy engine
- Traffic: rate limiting, CORS, TLS, external authz
- Observability: OpenTelemetry (metrics, logs, traces)

## Deployment

Kubernetes-native via Helm/ArgoCD/FluxCD, conformant to Kubernetes Gateway API. Also available as standalone binary. Control plane manages config; data plane proxies process traffic.

## Links

- Docs: https://agentgateway.dev/docs/kubernetes/latest/
- Full docs index: https://agentgateway.dev/docs/llms.txt
