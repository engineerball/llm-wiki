---
source_url: https://agentgateway.dev/docs/kubernetes/latest/
fetched: 2026-05-05
---

# Agent Gateway — Kubernetes Docs (Latest)

## What is Agent Gateway?

Agent Gateway is an open source gateway control plane and proxy data plane, hosted as part of the Linux Foundation. It functions as a unified, high-performance gateway built in Rust for managing traffic across APIs, microservices, LLM providers, and agent systems.

## Core Purpose

Unlike traditional API gateways optimized for stateless REST interactions, Agent Gateway is purpose-built for modern agentic workloads. It handles stateful JSON-RPC sessions with long-lived connections.

### Why Traditional Gateways Fall Short

| Traditional API Gateway | Agentgateway |
|---|---|
| Stateless request/response | Stateful JSON-RPC sessions with long-lived connections |
| One request → one backend | Session fan-out across multiple MCP servers |
| Client-initiated only | Bidirectional: servers can push events (SSE) to clients |
| Simple routing by path/header | Protocol-aware routing that understands JSON-RPC message bodies |
| Static backend mapping | Dynamic tool virtualization on a per-client basis |

### Challenges Traditional Gateways Cannot Solve

- **Multiplexing & fan-out**: Single client requests like "list available tools" must fan out across multiple backend MCP servers, with responses aggregated and unified.
- **Server-initiated events**: MCP servers push real-time updates via Server-Sent Events (SSE) requiring proper routing back through client sessions.
- **Protocol negotiation**: Handling protocol upgrades and fallbacks gracefully as MCP/A2A specifications evolve.
- **Per-session authorization**: Different clients access different tools, requiring dynamic exposure adjustment.
- **Tool poisoning protection**: Defense against direct tampering, shadowing, and rug-pull attacks on tools.

### Built for Performance

Agentgateway is constructed in Rust "because performance and memory safety are non-negotiable for stateful, long-lived connections and fan-out patterns. Every millisecond and megabyte counts when managing concurrent sessions across multiple backend servers."

## Features

### LLM Gateway

Route traffic through a unified OpenAI-compatible API, switching between providers without application code changes.

#### LLM Provider Support Table

| API | OpenAI | Anthropic | Amazon Bedrock | Azure | Google Gemini | Google Vertex AI |
|---|---|---|---|---|---|---|
| Completions `/v1/chat/completions` | Native | Translation | Translation | Native | Native* | Native† |
| Responses `/v1/responses` | Native | No | Translation | Native | No | No |
| Messages `/v1/messages` | Translation | Native | Translation | Translation | Translation | Native† |
| Embeddings `/v1/embeddings` | Native | No | Translation | Native | No | Translation |
| Realtime `/v1/realtime` | Native | No | No | No | No | No |
| Token Count `/v1/messages/count_tokens` | No | Native | Translation | No | No | Translation |

Also supports OpenAI-compatible providers: Cohere, Mistral, Groq, Together AI, Fireworks, Ollama, LM Studio, vLLM, llama.cpp.

For self-hosted GPU models, implements Kubernetes Inference Gateway extensions for intelligent routing based on:
- GPU & KV cache utilization
- Prompt criticality
- LoRA adapters
- Work queue depth

### MCP Gateway

- Tool federation: Aggregate multiple MCP servers behind a single endpoint
- Protocol support: stdio, HTTP/SSE, and Streamable HTTP transports
- OpenAPI integration: Expose existing REST APIs as MCP-native tools
- Authentication & authorization: Built-in MCP auth spec compliance with OAuth providers (Auth0, Keycloak)

### A2A Gateway

Enable secure communication between AI agents using the Agent-to-Agent (A2A) protocol. Agents can:
- Discover each other's capabilities
- Negotiate interaction modalities (text, forms, media)
- Collaborate on long-running tasks
- Operate without exposing internal state or tools

### Security & Observability

- Authentication: JWT, API keys, basic auth, MCP auth spec
- Authorization: Fine-grained RBAC with CEL policy engine
- Traffic policies: Rate limiting, CORS, TLS, external authz
- Observability: Built-in OpenTelemetry metrics, logs, and distributed tracing

## Architecture

**Control plane**: manages and distributes configuration and policies to the data plane
**Data plane**: proxies (agentgateway) that process live network traffic per configuration from control plane

Conformant to the Kubernetes Gateway API with support for HTTPRoute, GRPCRoute, TCPRoute, and TLSRoute.

## Deployment

- Prerequisites: Kubernetes cluster, kubectl, helm
- Quick test: `kind create cluster`
- Two paths: install control plane, or jump to quick start for specific backend type

## Documentation Structure

Main sections (from llms.txt):
- Getting started (install, LLM setup, MCP servers, HTTP traffic)
- Architecture and Gateway API concepts
- Installation (Helm, ArgoCD, FluxCD)
- Gateway setup, listeners, customization
- LLM consumption with multiple providers
- Guardrails and security
- MCP and agent connectivity
- Traffic management and transformations
- Resiliency patterns
- Security features
- Integrations
- Observability tools
- Operations and migration guides

Also available: standalone binary deployment (non-Kubernetes).

## Organizations

- Linux Foundation: hosting org
- Solo.io: referenced in architectural comparison blog post
