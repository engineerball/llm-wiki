---
title: "LLM Gateway"
tags: [concept, llm-gateway, infrastructure, agent-gateway, routing]
date: 2026-05-05
sources: ["sources/agentgateway-kubernetes-docs.md"]
---

# LLM Gateway

Proxy layer that provides a unified API for routing LLM requests across multiple providers. Clients call one endpoint; the gateway translates and routes to the appropriate backend.

## Core Value

Applications switch LLM providers without code changes. The gateway handles:
- API format translation (e.g., OpenAI Completions ↔ Anthropic Messages)
- Provider-specific auth and headers
- Intelligent routing (load balancing, fallback, priority)

## Provider Strategies

**Native passthrough**: Full API compatibility — unknown fields pass through; new models work without gateway updates. Example: OpenAI, Azure.

**Translation**: Gateway maps known fields between formats. New models or fields may require gateway updates. Example: Amazon Bedrock, Google Gemini.

## Self-Hosted Inference Routing

For GPU infrastructure, advanced routing by:
- GPU & KV cache utilization (least-loaded model)
- Prompt criticality (prioritize high-priority requests)
- LoRA adapters (route to models with specific fine-tuning)
- Work queue depth (avoid overloaded servers)

Implemented via Kubernetes Inference Gateway extensions in [[agentgateway]].

## Relation to Agentic Protocols

LLM Gateway is the foundation layer that sits below [[agentic-protocol-stack]]. Agents using MCP/A2A still need an LLM backend; the gateway provides that with provider flexibility and operational controls (rate limiting, observability, auth).

## Implementations

- [[agentgateway]]: open-source, Rust, Kubernetes-native, covers LLM + MCP + A2A in one proxy
