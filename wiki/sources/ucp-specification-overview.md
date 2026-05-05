---
title: "UCP Specification Overview"
tags: [source, ucp, agentic-commerce, protocol, payments]
sources: [".raw/articles/ucp-specification-overview-2026-05-05.md"]
date: 2026-05-05
---

# UCP Specification Overview

> **Source:** Official UCP Specification — <https://ucp.dev/latest/specification/overview/>
> **Fetched:** 2026-05-05

The official specification overview for the Universal Commerce Protocol. Covers the full technical architecture: namespace governance, capability negotiation, payment handler model, transport bindings, security, and versioning.

---

## Key Concepts Covered

### Namespace Governance
Capabilities use **reverse-domain naming** — `[reverse-domain].{service}.{capability}`. No central registry needed. The `dev.ucp.*` namespace is reserved for UCP-sanctioned capabilities; vendors namespace under their own domain (`com.example.*`).

### Bidirectional Discovery
- Businesses: publish profile at `/.well-known/ucp`
- Platforms: advertise profile via `UCP-Agent` HTTP header
- Enables **permissionless onboarding** — no pre-established relationship required

### Profile Structure
Both parties maintain profiles with:
- Protocol metadata + version
- Service declarations with transport bindings (REST, MCP, A2A, Embedded)
- Capability registrations with schemas
- Payment handler configurations
- Public signing keys for message verification

### Capability Negotiation
See [[ucp-negotiation-protocol]] — intersection algorithm, version resolution, extension pruning.

### Payment Handlers
See [[ucp-payment-handlers]] — trust triangle, three implementation scenarios, PCI-DSS scope.

### Transport Bindings
| Transport | Details |
|-----------|---------|
| REST | HTTP/1.1+, standard verbs and status codes |
| MCP | JSON-RPC 2.0, `tools/call`, dual-output (structuredContent + content) |
| A2A | Agent-to-agent structured protocols |
| Embedded | Peer-to-peer between host and embedded context |

### Security
- **Authentication**: API keys, OAuth 2.0, mTLS, RFC 9421 HTTP Message Signatures
- **Signals**: env data (IP, user agent, attestations) with reverse-domain namespacing; `error` = required, `info` = advisory
- **AP2 Mandates**: `dev.ucp.shopping.ap2_mandate` — cryptographic proof of authorization for autonomous agents

### Error Handling
| Failure Type | REST | JSON-RPC |
|---|---|---|
| Discovery failure | HTTP 424 | -32001 |
| Signature error | HTTP 401 | -32000 |
| Negotiation failure | HTTP 200 + `ucp.status` error | HTTP 200 + `ucp.status` error |

Negotiation failures include optional `continue_url` for fallback to web.

### Versioning
Date-based (`YYYY-MM-DD`) — chronological ordering. `supported_versions` mapping lets businesses support multiple protocol versions simultaneously. Extension `requires` constraints specify min/max protocol and capability versions.

### Standard Capabilities
| Capability | Purpose |
|---|---|
| Cart | Basket building before purchase intent |
| Checkout | Session management, tax calculation, payment negotiation |
| Order | Async lifecycle updates (shipping, returns) |
| Identity Linking | OAuth 2.0 authorization delegation |
| Fulfillment | Delivery options extension |
| Discounts | Coupon/promo extension |
| Buyer Consent | User consent capture |
| AP2 Mandates | Cryptographic auth proof for autonomous agents |

---

## Related Pages

- [[ucp]] — concept overview
- [[ucp-negotiation-protocol]] — intersection algorithm detail
- [[ucp-payment-handlers]] — trust triangle, handler model, 3 scenarios
- [[agentic-protocol-stack]] — where UCP sits in the stack
- [[ap2-agent-payments-protocol]] — Layer 4 payment settlement
