# agentgateway - official research snapshot

- Retrieved: 2026-10-09 (Asia/Bangkok)
- Project: https://github.com/agentgateway/agentgateway
- Website: https://agentgateway.dev/
- Documentation index: https://agentgateway.dev/docs/llms.txt
- Latest GitHub release observed: `v1.6.0`
- License observed in repository metadata: Apache-2.0
- Primary implementation language observed in repository metadata: Rust

## Scope and identity

The official README describes agentgateway as an open-source proxy for AI-native protocols, including MCP and A2A, providing security, observability, and governance for agent-to-LLM, agent-to-tool, and agent-to-agent communication.
The repository metadata describes it as a next-generation agentic proxy for AI agents and MCP servers, with topics covering agents, AI gateways, Kubernetes, MCP, reverse proxy, Rust, and service mesh.
The project README states that it is a Linux Foundation project.

## Traffic capabilities

The README identifies four major capabilities:

- LLM Gateway: a unified OpenAI-compatible API for multiple LLM providers, with budget and spend controls, prompt enrichment, load balancing, and failover.
- MCP Gateway: federation of MCP tools and data sources over stdio, HTTP/SSE, and Streamable HTTP, with OpenAPI integration and OAuth authentication.
- A2A Gateway: agent-to-agent communication with capability discovery, modality negotiation, and task collaboration.
- Inference routing: routing to self-hosted models using Kubernetes Inference Gateway extensions, with signals such as GPU utilization, KV cache, LoRA adapters, and queue depth.

The current documentation index also lists support for ordinary HTTP and gRPC traffic, so the safer description is an AI-first data plane that can unify HTTP, gRPC, LLM, MCP, and A2A traffic, rather than an AI-only gateway.

## Deployment models

The official documentation exposes two product documentation tracks:

- Kubernetes: a control plane and proxy setup based on the Kubernetes Gateway API, installed through Helm and also documented for Argo CD and Flux.
- Standalone: a deployment without the full Kubernetes controller, configured through flat YAML or JSON configuration.

The Kubernetes documentation identifies version `1.6.x` as the latest documentation track observed on 2026-10-09.

## Policy, security, and observability

The README lists JWT, API keys, OAuth, fine-grained RBAC with a CEL policy engine, rate limiting, TLS, and OpenTelemetry metrics, logs, and traces.
The documentation index additionally exposes policy targeting and merging, conditional policies, LLM API-key management, token/request rate limits, CEL-based RBAC, LLM cost controls, guardrails, MCP authentication, tool access controls, MCP sessions, and external MCP processing.
These are documented capabilities, not evidence that a deployment is secure by default or compliant with a particular regulation.

## LLM features documented in the current index

The Kubernetes documentation index lists model aliases, provider configuration, load balancing, failover, content-based routing, streaming, function calling, prompt enrichment, prompt templates, request transformations, observability, virtual models, inference routing, virtual keys, cost attribution, model cost calculation, dashboards, budget limits, and multiple guardrail integrations.

## MCP and agent features documented in the current index

The index lists static, dynamic, and virtual MCP routing, HTTPS connections, MCP Apps, JWT-based service access, tool access policy, rate limiting, stateful or stateless MCP sessions, MCP specification compatibility, external MCP guardrails, and OAuth integrations with providers including Auth0, Keycloak, Microsoft Entra ID, Okta, Descope, and authentik.
It also documents A2A routing and an integration path for Amazon Bedrock AgentCore.

## Architecture interpretation

The source material supports the following architecture interpretation:

1. A proxy data plane handles live HTTP, gRPC, LLM, MCP, and A2A traffic.
2. In Kubernetes, a control plane configures the proxy through Kubernetes resources and Gateway API concepts.
3. Policies and protocol-aware routing are applied at the gateway boundary.
4. Provider, tool, and agent integrations remain behind a common network and policy surface.

The source material does not by itself establish a performance SLA, security certification, regulatory compliance, or a guarantee that all listed integrations have identical feature maturity.

## Important distinction

This open-source `agentgateway` project is distinct from Google Cloud Agent Gateway.
The Google product is a managed networking component of the Gemini Enterprise Agent Platform, while this project is an open-source proxy and gateway data plane/control-plane system.
They address related governance and connectivity concerns at different product and deployment layers.

## Sources

- https://github.com/agentgateway/agentgateway
- https://github.com/agentgateway/agentgateway/releases/tag/v1.6.0
- https://agentgateway.dev/docs/llms.txt
- https://agentgateway.dev/docs/kubernetes/latest/
- https://agentgateway.dev/docs/standalone/latest/
