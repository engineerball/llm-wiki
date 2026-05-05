---
title: "UCP Negotiation Protocol"
tags: [concept, ucp, protocol, agentic-commerce]
sources: [".raw/articles/ucp-specification-overview-2026-05-05.md"]
date: 2026-05-05
---

# UCP Negotiation Protocol

The mechanism by which UCP platforms and businesses determine the **active set of capabilities** for a session. Replaces static API contracts with dynamic, version-aware intersection.

## The Intersection Algorithm

Given a platform profile and a business profile, the negotiation engine runs:

1. **Mutual support** — find capabilities both parties declare
2. **Version resolution** — from the overlapping versions, select the highest compatible version
3. **Extension pruning** — remove any extension whose parent capability is not in the intersection
4. **Iterate** — repeat steps 3–4 until no orphaned extensions remain (convergence is guaranteed since the set only shrinks)

Result: a minimal, fully-consistent active capability set. Neither party is forced to support a capability the other doesn't advertise.

## Profile Structure

Both platform and business publish a **profile** — a structured document containing:

| Field | Content |
|-------|---------|
| Protocol metadata | UCP version, `supported_versions` map |
| Service declarations | Which verticals are active (e.g., `dev.ucp.shopping`) |
| Transport bindings | REST, MCP, A2A, or Embedded per service |
| Capability registrations | Name, version, schema, `extends` pointer |
| Payment handler configs | Handler IDs, provider references |
| Public signing keys | For RFC 9421 HTTP Message Signature verification |

## Discovery Mechanism

- **Business**: publishes profile at `GET /.well-known/ucp`
- **Platform**: advertises profile via `UCP-Agent` HTTP request header
- Bidirectional — both parties can inspect each other's profile before negotiation begins
- **Permissionless** — no prior registration or out-of-band agreement needed; public-key cryptography in profiles enables trust without a central registry

## Capability Extensions

Extensions use the `extends` field to declare dependency on a parent capability:

```json
{
  "name": "dev.ucp.shopping.discount",
  "extends": "dev.ucp.shopping.checkout",
  "version": "2026-01-11"
}
```

An extension is only valid if its parent survives the intersection. The pruning step guarantees no dangling extensions reach the active set.

## Namespace Convention

Capability names follow **reverse-domain notation**:

```
[reverse-domain] . {service} . {capability}
```

- `dev.ucp.*` — reserved for UCP-sanctioned standard capabilities
- `com.example.*` — vendor-specific extensions (no registration needed)

This decentralized naming lets vendors ship proprietary extensions without coordinating with a central authority.

## Versioning

Format: `YYYY-MM-DD` — enables simple chronological comparison. `supported_versions` lets a business declare support for multiple protocol vintages simultaneously, enabling gradual platform migration without hard cutoffs.

Extension schemas declare `requires` constraints:
```json
"requires": {
  "protocol": { "min": "2025-06-01", "max": "2026-12-31" },
  "capability": { "min": "2026-01-11" }
}
```

## Negotiation Failure Handling

When the intersection is empty or versions are incompatible:
- REST: HTTP 200 with error payload in `ucp.status` field
- JSON-RPC: HTTP 200 with error in response body
- Response includes optional `continue_url` for graceful fallback to standard web checkout

See also: [[ucp]], [[ucp-payment-handlers]], [[agentic-protocol-stack]]
