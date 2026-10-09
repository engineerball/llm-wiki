---
title: "Agent Gateway - Official Research Snapshot"
tags: [source, agent-gateway, agentgateway, mcp, a2a, llm-gateway, kubernetes, infrastructure]
sources: ["raw/articles/agentgateway-official-2026-10-09.md"]
date: 2026-10-09
---

# Agent Gateway - Official Research Snapshot

**Primary sources**:
[agentgateway GitHub repository](https://github.com/agentgateway/agentgateway),
[official documentation index](https://agentgateway.dev/docs/llms.txt),
[Kubernetes documentation](https://agentgateway.dev/docs/kubernetes/latest/),
and [standalone documentation](https://agentgateway.dev/docs/standalone/latest/).

**Research date**: 2026-10-09 (Asia/Bangkok).

**Version snapshot**: GitHub latest release observed as `v1.6.0`, with the official Kubernetes documentation on the `1.6.x` track.

## Summary

`agentgateway` is an open-source, Rust-based proxy and gateway for AI-native traffic.
The official README describes security, observability, and governance for agent-to-LLM, agent-to-tool, and agent-to-agent communication.
The official documentation index describes it as an AI-first data plane that can unify HTTP, gRPC, LLM, MCP, and A2A traffic.

The repository README states that the project is a Linux Foundation project and is licensed under Apache-2.0 according to the repository metadata.

## Main capabilities

- **LLM Gateway**: unified OpenAI-compatible access to multiple providers, with load balancing, failover, prompt enrichment, and budget/spend controls.
- **MCP Gateway**: static, dynamic, and virtual MCP routing, tool federation, multiple transports, OpenAPI integration, OAuth, session routing, and tool access controls.
- **A2A Gateway**: agent-to-agent routing, capability discovery, modality negotiation, and task collaboration.
- **Inference routing**: Kubernetes Inference Gateway extension integration for self-hosted model routing using signals such as GPU utilization, KV cache, LoRA adapters, and queue depth.
- **Traditional traffic**: current documentation also covers HTTP and gRPC, so the project is broader than an AI-only gateway.

## Deployment models

### Kubernetes

The Kubernetes track uses an agentgateway control plane and proxy data plane with the Kubernetes Gateway API.
The official documentation covers Helm, Argo CD, Flux, Gateway resources, listeners, policies, and Kubernetes-specific configuration.

### Standalone

The standalone track is intended for deployments without the full Kubernetes controller.
The documentation describes configuration through flat YAML or JSON files.

## Security and operations

Documented capabilities include JWT, API keys, OAuth, CEL-based RBAC, rate limiting, TLS, external authorization, OpenTelemetry metrics/logs/traces, MCP authentication, tool access policy, guardrails, and LLM cost controls.

These are documented product capabilities, not proof that every installation is secure by default, certified, or compliant with a specific law or standard.
Production configuration still requires threat modeling, identity design, secret management, policy review, observability, and operational testing.

## Current documentation surface

The official documentation index lists:

- LLM provider configuration, aliases, load balancing, failover, streaming, function calling, prompt enrichment, request transformations, cost attribution, virtual keys, budgets, and guardrails.
- MCP connectivity through static, dynamic, and virtual routing, stateful/stateless sessions, MCP Apps, OAuth integrations, JWT access controls, rate limits, and external MCP processing.
- A2A routing and an integration path for Amazon Bedrock AgentCore.
- Gateway API listeners, TLS, mTLS, traffic management, policies, and observability.

## Architecture interpretation

A conservative architecture model from the primary sources is:

1. A proxy data plane handles live HTTP, gRPC, LLM, MCP, and A2A traffic.
2. In Kubernetes, a control plane configures proxy behavior through Kubernetes resources and Gateway API concepts.
3. Protocol-aware routing and policies are applied at the gateway boundary.
4. LLM providers, MCP servers, and A2A agents remain behind a common connectivity and policy surface.

The sources do not establish a performance SLA, security certification, regulatory compliance, or equal maturity for every listed integration.

## Do not confuse with Google Cloud Agent Gateway

This open-source `agentgateway` project is different from Google Cloud Agent Gateway.
Google Cloud Agent Gateway is a managed networking component of the Gemini Enterprise Agent Platform.
`agentgateway` is an open-source proxy and gateway data-plane/control-plane system.
They address related agent traffic governance concerns at different product and deployment layers.
See [[google-cloud-agent-gateway]] for the Google Cloud product.

## Related pages

- [[agentgateway]]
- [[agentgateway-kubernetes-docs]]
- [[model-context-protocol]]
- [[agentic-protocol-stack]]
- [[llm-gateway]]
- [[google-cloud-agent-gateway]]
