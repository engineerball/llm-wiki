---
title: "Google Cloud Agent Gateway Overview"
url: "https://docs.cloud.google.com/gemini-enterprise-agent-platform/govern/gateways/agent-gateway-overview"
date: 2026-05-06
tags: [source, google-cloud, agent-gateway, gemini-enterprise, governance, mcp, security]
---

# Google Cloud Agent Gateway Overview

> Official docs: https://docs.cloud.google.com/gemini-enterprise-agent-platform/govern/gateways/agent-gateway-overview

## Summary

Agent Gateway is the **networking component** of the Gemini Enterprise Agent Platform ecosystem. It secures and governs connectivity for all agentic interactions — user↔agent, agent↔tool, agent↔agent — acting as the network entry and exit point for all agent traffic on Google Cloud.

## Key Points Covered

### Integration with Agent Platform
- **Agent Registry**: Central library of approved agents/tools (incl. third-party MCP servers); gateway looks up metadata to enforce granular access policies
- **Agent Identity**: Unique persona per agent, secured with **mTLS + DPoP** cryptographic authentication; used as principal for authorization decisions
- **Managed Agent Runtimes**: Agent Runtime and Gemini Enterprise automatically route traffic through Agent Gateway
- **Agent Platform Policies**: Gateway delegates to IAM, Semantic Governance Policies, and Model Armor
- **Agent Observability**: Gateway exports network-layer telemetry for comprehensive visibility

### Deployment Modes

| Mode | Direction | Description |
|---|---|---|
| **Client-to-Agent (Ingress)** | External → Agent | Secures comms between clients (Cursor, Claude Code, Gemini CLI) and agents/tools on GCP; gateway acts as frontend |
| **Agent-to-Anywhere (Egress)** | Agent → External | Secures comms between agents on GCP and any server/tool/API anywhere; enforces permissions + guardrails (e.g. for MCP servers) |

### Runtimes Supported

| Runtime | Ingress | Egress | Notes |
|---|---|---|---|
| **Agent Runtime** | ✅ | ✅ | Same project + region required |
| **Gemini Enterprise** | ❌ | ✅ | Gateway region must match multi-region setup |

### Access Control

| Policy | Egress | Ingress |
|---|---|---|
| IAM (SPIFFE ID-based) | ✅ | ❌ (not enforced by gateway) |
| IAP (default enforcement) | ✅ (default, can audit-only) | ❌ (not supported) |
| Model Armor | ✅ data leak + prompt injection | ✅ inbound prompt injection |
| Service Extensions | ✅ custom/third-party authz | ✅ custom/third-party authz |

Default deny: gateway blocks access to any resource not explicitly authorized via IAM. Remote MCP servers/tools not registered in local Agent Registry are **blocked by default**.

### Limitations
- Agentic protocol attribute conditions only supported for MCP
- Gemini Enterprise does NOT support Client-to-Agent mode
- Does NOT support VPC Service Controls (use custom org policy constraints instead)

### Developer Benefits
- Simplified innovation (no networking/security overhead)
- Protocol mediation (MCP, A2A, REST, gRPC)
- Framework agnostic
- Automatic mTLS handling + Agent Identity Auth Manager for OAuth 2.0

### Admin Benefits
- Centralized governance across all agent runtimes
- AI security guardrails (Model Armor for prompt injection)
- Comprehensive observability (Cloud Logging + Cloud Trace)
