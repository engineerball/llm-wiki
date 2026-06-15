# Source: Shopify Universal Commerce Protocol (UCP)

- **Title:** Building the Universal Commerce Protocol (UCP)
- **Source URL:** https://shopify.engineering/ucp
- **Author:** Ilya Grigorik, Distinguished Engineer at Shopify
- **Date Published:** 2026
- **Raw File:** raw/articles/shopify-universal-commerce-protocol-ucp-2026.md
- **Tags:** [protocol, commerce, AI-agents, Shopify, capability-negotiation, extensibility]

## Summary

Shopify co-developed the **Universal Commerce Protocol (UCP)** with Google — an open standard enabling AI agents to discover merchant capabilities, negotiate terms, and transact programmatically. UCP applies the **TCP/IP layered protocol pattern** to commerce, separating core transaction primitives from extensible capabilities.

## Key Takeaways

### 1. Layered Architecture (Capabilities + Extensions)

UCP avoids monolithic protocol design by separating responsibilities into layers:

- **Core shopping service** defines universal primitives: checkout session, line items, totals, messages, status
- **Capabilities** add functional areas: Checkout, Orders, Catalog — each independently versioned
- **Extensions** augment capabilities with domain-specific schemas via composition

Example: the `dev.ucp.shopping.fulfillment` extension handles shipping, pickup, local delivery, etc. Merchants can define their own extensions without needing central approval. Extensions version independently from the core schema.

### 2. Capability Discovery & Negotiation

Both merchants and agents publish **profiles** declaring what they support:

- Merchant profile published at `/.well-known/ucp` on the merchant's domain
- Agent declares its own capabilities in a profile
- When an agent connects, it passes its profile URL
- Merchant computes the **intersection** — shared capabilities, overlapping handlers, mutually understood extensions
- Pattern mirrors HTTP content negotiation (Accept headers, content types, encodings)

### 3. Reverse-Domain Namespace (No Committees Required)

UCP uses **reverse-domain naming** for extension namespaces:

- `dev.ucp.shopping.*` → hosted at ucp.dev
- `com.loyaltyprovider.*` → belongs to loyaltyprovider.com

Anyone can define extensions — no central registry, no approval committees. Own the domain, own the namespace. Security comes from namespace binding and provenance validation, not bureaucracy.

### 4. Graceful Handoff (Escalation Model)

Not all transactions can complete autonomously. UCP models this via a checkout state machine:

| State | Meaning |
|---|---|
| `incomplete` | Missing info; agent should attempt resolution via API |
| `requires_escalation` | Buyer input required; hand off via `continue_url` |
| `ready_for_complete` | All info collected; agent can finalize programmatically |

When escalation is needed, the merchant returns structured context + a `continue_url`. The buyer picks up exactly where the agent left off.

### 5. Embedded Checkout Protocol (ECP)

ECP makes handoffs seamless:

- Bi-directional JSON-RPC 2.0 channel between agent and merchant
- Checkout embedded in the agent's surface
- Payment collection surfaces the host's native payment sheet
- Address selection pulls from agent's wallet
- Built on Shopify's Checkout Kit, open-sourced as a protocol
- PCIv4 compliant sandboxing

### 6. Payments as Two-Sided Negotiation

Both merchant and buyer have payment preferences. UCP lets both express what they want:

- Agents declare supported credentials (cards, wallets, BNPL, crypto)
- Merchants advertise accepted handlers
- Dynamic negotiation varies by cart contents, buyer region, transaction amount
- Each payment provider (Google, Shopify, regional PSP) publishes their own handler spec

### 7. Supported By

- Co-developed with **Google**
- Supported by **Etsy, Target, Walmart, Wayfair**, and millions of Shopify merchants
- Spec: https://ucp.dev
- GitHub: https://github.com/Universal-Commerce-Protocol/ucp

## Connections to Existing Wiki Content

- Relates to [[Universal Commerce Protocol Interoperability]] (UCP with MCP, A2A, AP2 already covered in the wiki)
- Extends the [[Agentic AI]] capability negotiation theme — UCP brings commerce-specific application to the same pattern
- [[Google]] is a co-developer alongside Shopify
- Connects to [[Extensitivity]] and [[Open Protocol Design]] themes in the wiki
