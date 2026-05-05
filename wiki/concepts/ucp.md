---
title: "Universal Commerce Protocol (UCP)"
tags: [concept, agentic-commerce, protocol, e-commerce, ucp]
date: 2026-05-04
sources: ["sources/ucp-universal-commerce-protocol.md", "sources/ucp-interoperability-mcp-a2a-ap2.md", "sources/agentic-protocols-for-websites-2026.md", "sources/ucp-specification-overview.md"]
---

# Universal Commerce Protocol (UCP)

An **open-source standard** for agentic commerce — a common language that lets AI agents discover merchant capabilities, negotiate checkout flows, and complete purchases without bespoke per-merchant integrations.

Sits at Layer 3 of the [[agentic-protocol-stack]]: above MCP (tools/data) and A2A (agent coordination), below AP2 (payment settlement).

## Core Problem

Traditional commerce suffers an **N × N integration bottleneck** — each business must build bespoke connections to every AI surface (Google AI Mode, Gemini, ChatGPT, etc.). UCP collapses this to a single integration point: businesses expose one UCP endpoint; any compliant AI surface can transact through it.

## How It Works

### Discovery
Agents query `GET /.well-known/ucp` — a JSON manifest listing services, capabilities, and payment handlers. No hard-coded integrations. Dynamic capability negotiation between agent and merchant.

### Checkout Flow
1. Agent discovers capabilities from manifest
2. Agent POSTs to `/checkout-sessions` with line items, buyer info, payment handler
3. Agent PUTs updates to apply discounts, loyalty codes, etc.
4. Session moves from `ready_for_complete` to confirmed

### Transport Agnosticism
UCP business logic runs unchanged over REST, JSON-RPC, GraphQL, MCP, or A2A. The protocol is transport-independent.

## Capability Model

| Capability | Purpose |
|---|---|
| `dev.ucp.shopping.checkout` | Core checkout |
| `dev.ucp.shopping.discount` | Discount codes (extends checkout) |
| `dev.ucp.shopping.fulfillment` | Fulfillment options (extends checkout) |
| Identity linking | Secure credential exchange |
| Loyalty programs | Credential entry for loyalty benefits |
| Dynamic pricing | Real-time price negotiation |
| Subscriptions | Frequency selection |
| Order management | Post-purchase lifecycle |

## Key Properties

| Property | Detail |
|---|---|
| **Merchant autonomy** | Businesses keep own business logic, remain Merchant of Record |
| **Security** | Tokenized payments, verifiable credentials, OAuth 2.0 + PCI-DSS |
| **Extensible** | Capabilities + extensions framework; new verticals can add capabilities |
| **Backed by** | Google, Shopify, Walmart, Target, Visa, Mastercard, Stripe, 20+ partners (NRF 2026) |

## Relation to Other Protocols

- **MCP** — agents use MCP to gather context (calendar, email, budget) *before* invoking UCP for commerce
- **A2A** — coordinator agents delegate to specialized merchant agents via A2A, each using UCP for checkout
- **AP2** — UCP creates checkout sessions; AP2 handles the actual payment authorization with cryptographic tokens
- **ACP (OpenAI/Stripe)** — competing commerce protocol; live in ChatGPT since Sep 2025; narrower coalition but larger distribution

## Strategic Context

> Market projection: $500B annual agentic commerce sales by 2030.

Near term, UCP becomes the standard for Google/Shopify-ecosystem agentic retail. Medium term (2027-28), value shifts from merchant data (commoditized) to agent platforms owning customer intent. Long term, standalone shopping websites decline as checkout becomes an undifferentiated utility inside AI interfaces.

## Technical Specification

### Namespace Governance
Capabilities use **reverse-domain naming**: `[reverse-domain].{service}.{capability}`. No central registry. `dev.ucp.*` is reserved for sanctioned capabilities; vendors use their own domain (`com.example.*`).

### Capability Negotiation
The **intersection algorithm** produces the active capability set from two profiles:
1. Find mutual capability support
2. Select highest compatible shared version
3. Prune extensions whose parent capability isn't in the intersection
4. Repeat until convergence

See [[ucp-negotiation-protocol]] for full detail.

### Payment Handlers
Handlers are **specifications** (not entities) authored by payment providers. Business advertises them; platform executes them to acquire tokens; tokens route to business for settlement. Three scenarios:
- **Scenario A** — Digital Wallet (Google Pay, Apple Pay encrypted bundle)
- **Scenario B** — Direct tokenization + optional SCA via `requires_escalation` / `continue_url`
- **Scenario C** — AP2 mandate (signed VC, no token needed)

See [[ucp-payment-handlers]] for trust triangle, PCI-DSS scope, and scenario details.

### Security
- Auth: API keys, OAuth 2.0, mTLS, RFC 9421 HTTP Message Signatures
- Signals: env data (IP, user agent, attestations) with reverse-domain namespacing; `error` = required, `info` = advisory
- AP2 Mandates extension (`dev.ucp.shopping.ap2_mandate`) for cryptographic non-repudiation

### Error Codes
| Failure | REST | JSON-RPC |
|---|---|---|
| Discovery | 424 | -32001 |
| Signature | 401 | -32000 |
| Negotiation | 200 + `ucp.status` | 200 + `ucp.status` |

### Versioning
Date-based (`YYYY-MM-DD`). `supported_versions` map lets businesses support multiple vintages. Extension `requires` constraints declare min/max version compatibility.

See [[agentic-commerce]] for the broader concept. See [[agentic-protocol-stack]] for full protocol layer context.

## Links

- Spec: <https://ucp.dev/>
- GitHub: <https://github.com/universal-commerce-protocol/ucp>
- Google integration: <https://developers.google.com/merchant/ucp>
