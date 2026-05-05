---
title: "Hot Cache"
tags: [meta]
date: 2026-05-05
---

# Hot Cache

Last ingest context for fast session resumption.

---

## Last Ingest: UCP Official Specification (2026-05-05)

**Source:** <https://ucp.dev/latest/specification/overview/>
**Raw file:** `.raw/articles/ucp-specification-overview-2026-05-05.md`

### Pages Created
- `wiki/sources/ucp-specification-overview.md` — full spec summary
- `wiki/concepts/ucp-negotiation-protocol.md` — intersection algorithm, profile structure, permissionless discovery
- `wiki/concepts/ucp-payment-handlers.md` — trust triangle, 3 payment scenarios, PCI-DSS scope

### Pages Updated
- `wiki/concepts/ucp.md` — added Technical Specification section with namespace, negotiation, payment, security, error codes, versioning
- `wiki/index.md` — added 3 new entries (1 source, 2 concepts)
- `wiki/log.md` — prepended ingest entry

### Key Facts to Remember
- **Handler model**: handlers are specs not entities; platform executes handler logic to acquire tokens — raw credentials never touch platform
- **Intersection algorithm**: 4-step, convergent, handles version + extension dependencies
- **Scenario C (AP2 mandate)**: no token needed; agent presents signed VC as credential — enabled by `dev.ucp.shopping.ap2_mandate` extension
- **Permissionless onboarding**: business at `/.well-known/ucp`, platform via `UCP-Agent` header — no pre-registration
- **`continue_url`**: used for both SCA escalation (Scenario B) and negotiation failure fallback
- **Namespace**: `dev.ucp.*` reserved; vendors use own reverse-domain (`com.example.*`)
- **Error codes**: discovery=424/-32001, signature=401/-32000, negotiation=200+`ucp.status`

### UCP Concept Page Status
`wiki/concepts/ucp.md` now covers: architecture, capability model, transport agnosticism, technical spec (namespace/negotiation/payment/security/errors/versioning), relation to MCP/A2A/AP2/ACP, strategic context.
