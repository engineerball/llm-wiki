---
title: "UCP Payment Handlers"
tags: [concept, ucp, payments, agentic-commerce, pci-dss]
sources: [".raw/articles/ucp-specification-overview-2026-05-05.md"]
date: 2026-05-05
---

# UCP Payment Handlers

The UCP payment architecture decouples credential acquisition from commerce logic. A **handler** is a specification (not an entity) that defines how a platform should acquire a payment token for a specific instrument type.

## The Trust Triangle

Three bilateral relationships form the security foundation:

```
Business ←—— legal/technical contract ——→ Payment Provider
   ↑                                              ↑
   |                                              |
opaque credential                     direct tokenization
submission                                   interface
   |                                              |
Platform ←————————————————————————————————→ Platform
```

| Relationship | Nature |
|---|---|
| Business ↔ Payment Provider | Pre-existing legal and technical agreement; settlement flows here |
| Platform ↔ Payment Provider | Direct interface for token acquisition (platform never sees raw credentials) |
| Platform ↔ Business | Platform submits opaque tokens; business doesn't see how platform acquired them |

The triangle ensures no single party holds both raw credentials and settlement access.

## Handler Model

- Handlers are **specifications authored by payment providers** (e.g., Google Pay publishes the Google Pay handler spec)
- Business advertises supported handlers in checkout responses
- Platform executes handler logic to acquire a token
- Token is submitted to business for settlement routing
- Business routes to its pre-established payment provider relationship

Key property: **platforms never touch raw card data**. The handler spec defines the tokenization interface; platforms implement it.

## Three Implementation Scenarios

### Scenario A — Digital Wallet
Platform acquires an encrypted payment bundle from a digital wallet provider (e.g., Google Pay, Apple Pay).

Flow:
1. Business advertises `google_pay` handler
2. Platform calls Google Pay API with line item context
3. Google Pay returns an encrypted token bundle
4. Platform submits bundle to business as opaque credential
5. Business passes bundle to its PSP for decryption and settlement

PCI-DSS implication: platform never sees card numbers; Google Pay's Level 1 certification covers the credential handling.

### Scenario B — Direct Tokenization + SCA
Platform requests a payment token directly from a PSP, with optional Strong Customer Authentication challenge.

Flow:
1. Business advertises PSP handler (e.g., Stripe, Adyen)
2. Platform calls PSP tokenization endpoint with instrument data
3. PSP may return `requires_escalation` status
4. Platform completes SCA challenge via `continue_url`
5. PSP issues token; platform submits to business

The `requires_escalation` → `continue_url` pattern is the spec's hook for 3DS, biometric, or other SCA flows without breaking the agentic UX.

### Scenario C — Autonomous Agent / AP2 Mandate
Agent generates a cryptographically signed mandate instead of acquiring a payment token.

Flow:
1. Agent holds user authorization via [[ap2-agent-payments-protocol]] Verifiable Credentials
2. Agent generates an AP2 mandate: signed proof of user intent + authorization scope
3. Mandate submitted to business as credential
4. Business verifies mandate cryptographically; no PSP tokenization step required

Enabled by the `dev.ucp.shopping.ap2_mandate` extension. Eliminates the token acquisition round-trip for fully autonomous agents. Critical for non-repudiation in unattended commerce.

## PCI-DSS Scope Management

| Party | Scope reduction mechanism |
|---|---|
| Platform | Uses tokenization handlers — never stores or processes raw card data |
| Business | Uses provider-hosted tokenization — raw credentials never reach business backend |
| Payment Provider | Maintains Level 1 PCI-DSS certification; handles all sensitive credential operations |

Raw financial data never touches platform frontends or non-certified business systems. The handler model is the architectural mechanism that enforces this separation.

## Signals

Alongside payment credentials, UCP defines a **signals** flow for fraud and risk context:
- Environment data: IP addresses, user agents, third-party attestations
- Named with reverse-domain namespacing (`dev.ucp.signals.*`, `com.provider.signals.*`)
- Business can request signals via `signal` message type
- Enforcement level: `error` (required) vs `info` (advisory)

See also: [[ucp]], [[ucp-negotiation-protocol]], [[ap2-agent-payments-protocol]], [[agentic-commerce]]
