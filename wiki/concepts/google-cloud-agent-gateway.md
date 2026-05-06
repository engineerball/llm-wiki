---
title: "Google Cloud Agent Gateway"
tags: [concept, agent-gateway, google-cloud, gemini-enterprise, governance, mcp, security, iap]
date: 2026-05-06
sources: ["sources/google-cloud-agent-gateway.md"]
---

# Google Cloud Agent Gateway

**Google Cloud Agent Gateway** is the **networking component** of the Gemini Enterprise Agent Platform. Unlike the open-source [[agentgateway]] (Rust, Kubernetes-native), this is Google Cloud's proprietary **managed gateway** — the network entry/exit point governing all agent interactions on GCP: user↔agent, agent↔tool, agent↔agent.

## How It Works

Agent Gateway gives enterprise security admins the ability to enforce security and governance policies as part of the GCP platform infrastructure. It integrates with:

| Component | Role |
|---|---|
| **Agent Registry** | Approved agents/tools library (incl. third-party MCP servers); gateway enforces granular access |
| **Agent Identity** | Per-agent persona secured with mTLS + DPoP; principal for authz decisions |
| **Managed Runtimes** | Agent Runtime + Gemini Enterprise auto-route through gateway |
| **Agent Platform Policies** | IAM, Semantic Governance, Model Armor delegation |
| **Agent Observability** | Network-layer telemetry export |

## Two Deployment Modes

| Mode | Flow | Description |
|---|---|---|
| **Ingress (Client-to-Agent)** | Client → Agent | Gateway as frontend for agents; controls which clients access which agents, enforces security policies |
| **Egress (Agent-to-Anywhere)** | Agent → External | Governs agent comms with any server/tool/API anywhere (e.g. MCP servers, internal/external APIs) |

### Egress Policies: the Core Control Plane

Agent Gateway's **egress mode** is its primary security enforcement layer:

| Policy | Mechanism |
|---|---|
| **IAM** | SPIFFE ID-based — restricts agents to specific tools/methods |
| **IAP** | Default enforcement (can switch to audit-only); validates identity + permissions |
| **Model Armor** | Runtime protection against prompt injection + data leakage |
| **Service Extensions** | Custom/third-party authorization engines |

**Default deny** — gateway blocks all traffic not explicitly authorized via IAM. Unregistered MCP servers/tools are blocked by default.

## Runtime Support

| Runtime | Ingress | Egress | Constraint |
|---|---|---|---|
| Agent Runtime | ✅ | ✅ | Same project + region |
| Gemini Enterprise | ❌ | ✅ | Gateway region must match multi-region setup |

## Limitations
- Protocol attribute conditions: MCP **only** — REST, gRPC not supported for conditional authz
- Gemini Enterprise: **no** Client-to-Agent mode
- **No VPC Service Controls** support — use custom org policy constraints to restrict agent↔gateway bindings

## Comparison: Google Cloud Agent Gateway vs [[agentgateway]]

| Dimension | Google Cloud Agent Gateway | [[agentgateway]] (Open Source) |
|---|---|---|
| **Owner** | Google Cloud (proprietary) | Linux Foundation / open source |
| **Language** | N/A (managed service) | Rust |
| **Primary Use** | Govern agent traffic on GCP | LLM/MCP/A2A gateway for Kubernetes or standalone |
| **Ingress** | Client-to-Agent | LLM Gateway + MCP + A2A traffic |
| **Egress** | Agent-to-Anywhere | N/A (acts as unified proxy) |
| **Protocols** | MCP, A2A, REST, gRPC | LLM (OpenAI-compat), MCP, A2A |
| **Security** | IAM, IAP, Model Armor, mTLS+DPoP | JWT, API keys, RBAC (CEL), TLS, OpenTelemetry |
| **Platform** | Google Cloud only | Kubernetes-native or binary |

Both serve as "gateway for agent traffic" but at different layers — Google Cloud Agent Gateway is **governance infrastructure** for GCP agent platforms; [[agentgateway]] is a **proxy implementation** that handles traffic routing and protocol translation.

## Key Takeaways
1. **Network entry/exit point** for all agent interactions on Google Cloud
2. **Default deny** — everything must be explicitly authorized via IAM
3. **IAP** is the default enforcement layer for egress; not used for ingress
4. **Model Armor** provides runtime safety (prompt injection, data leak prevention)
5. Regional scope — agents and gateways must share project + region (Agent Runtime)
6. **No VPC Service Controls** — use org policy constraints instead
7. Distinct from the open-source [[agentgateway]] — different layer, different purpose
