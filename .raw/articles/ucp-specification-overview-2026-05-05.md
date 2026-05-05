---
source_url: https://ucp.dev/latest/specification/overview/
fetched: 2026-05-05
---

# Universal Commerce Protocol (UCP) - Complete Overview

## Core Purpose
The Universal Commerce Protocol establishes a standardized framework enabling platforms, businesses, and payment providers to negotiate capabilities and execute commerce transactions through a decoupled, security-first architecture.

## Key Organizational Principles

### Namespace Governance
UCP employs "reverse-domain naming" to eliminate centralized registry requirements. Capability identifiers follow the pattern: `[reverse-domain].{service}.{capability}`. The `dev.ucp.*` namespace is reserved for UCP-sanctioned capabilities, while vendors use their own domains (e.g., `com.example.*`).

### Discovery Architecture
Businesses publish capabilities at `/.well-known/ucp`, while platforms advertise their profile via the `UCP-Agent` HTTP header. This bidirectional discovery enables "permissionless onboarding" — platforms and businesses can interact without pre-established relationships.

## Fundamental Concepts

### Services and Capabilities
**Services** define API surfaces for vertical categories (shopping, common, etc.), while **capabilities** represent specific features within those services. Extensions augment capabilities through the `extends` field, enabling modular feature composition.

### Negotiation Protocol
The intersection algorithm determines active capabilities by:
1. Computing mutual capability support between parties
2. Selecting highest compatible version from overlapping versions
3. Pruning extensions whose parents aren't in the intersection
4. Repeating until no orphaned extensions remain

### Profile Structure
Both parties maintain profiles containing:
- Protocol metadata and version
- Service declarations with transport bindings (REST, MCP, A2A, Embedded)
- Capability registrations with schemas
- Payment handler configurations
- Public signing keys for message verification

## Payment Architecture

### The Trust Triangle
Payment security relies on three relationships:
- **Business ↔ Payment Provider**: Pre-existing legal/technical relationship
- **Platform ↔ Payment Provider**: Direct tokenization interface
- **Platform ↔ Business**: Opaque credential submission

### Handler Model
Payment handlers are specifications (not entities) authored by credential providers that define instrument processing. The business advertises handlers in checkout responses; platforms execute the handler logic to acquire tokens; tokens then route to business for settlement.

### Three Implementation Scenarios

**Scenario A (Digital Wallet)**: Platform acquires encrypted tokens from providers like Google Pay, submitting wrapped credentials to business.

**Scenario B (Direct Tokenization + SCA)**: Platform requests tokens from PSP; business may respond with `requires_escalation` status requesting challenge completion via `continue_url`.

**Scenario C (Autonomous Agent/AP2)**: Agent generates cryptographically signed mandates proving user authorization, eliminating token-based flows.

## Transport Layer Support

- **REST**: HTTP/1.1+ with standard verbs and status codes
- **MCP**: JSON-RPC 2.0 with `tools/call` method, dual-output pattern (structuredContent + content)
- **A2A**: Agent-to-agent via structured protocols
- **Embedded**: Peer-to-peer between host and embedded context

## Security Framework

### Authentication
Multiple mechanisms supported: API keys, OAuth 2.0, mTLS, and RFC 9421 HTTP Message Signatures. Permissionless onboarding uses public-key cryptography through profiles.

### Signals
Environment data (IP addresses, user agents, third-party attestations) flow as `signals` with reverse-domain namespacing. "Signal" message type requests additional data; businesses distinguish enforcement between required (`error`) and advisory (`info`) signals.

### Transaction Integrity
The optional **AP2 Mandates Extension** (`dev.ucp.shopping.ap2_mandate`) provides cryptographic proof of authorization, critical for autonomous commerce scenarios requiring non-repudiation.

## Error Handling Strategy

**Discovery Failures** (profile unreachable, malformed): HTTP 424 or JSON-RPC -32001
**Negotiation Failures** (incompatible versions, empty intersection): HTTP 200 with error messages in `ucp.status`
**Signature Errors**: HTTP 401 or JSON-RPC -32000

When negotiation fails, responses include optional `continue_url` for graceful fallback to web experiences.

## Versioning Approach

Date-based format (`YYYY-MM-DD`) enables chronological ordering. Businesses support multiple protocol versions through `supported_versions` mapping. Extension schemas declare `requires` constraints (minimum/maximum protocol and capability versions) for compatibility verification during resolution.

## Standard Capabilities

- **Cart**: Basket building before purchase intent
- **Checkout**: Session management, tax calculation, payment negotiation
- **Order**: Asynchronous lifecycle updates (shipping, returns)
- **Identity Linking**: OAuth 2.0 authorization delegation
- Extensions: Fulfillment, discounts, buyer consent, AP2 mandates

## PCI-DSS Scope Management

Platforms minimize scope through tokenization handlers. Businesses reduce liability by using provider-hosted tokenization. Payment providers (PSPs) maintain Level 1 certification for credential handling. The architecture ensures raw financial data never touches platform frontends or non-certified systems.
