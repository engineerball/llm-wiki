---
title: "UCP Interoperability with MCP / A2A / AP2"
tags: [source, ucp, mcp, a2a, agentic-protocols, agentic-commerce]
date: 2026-05-05
sources: ["https://www.linkedin.com/pulse/what-ucp-how-does-interoperate-mcpa2aa2p-agentic-ai-vijayaraghavan-zeyfc"]
---

# UCP Interoperability with MCP / A2A / AP2

> **Source:** LinkedIn — [[vijayaraghavan-v|V. Vijayaraghavan]]
> <https://www.linkedin.com/pulse/what-ucp-how-does-interoperate-mcpa2aa2p-agentic-ai-vijayaraghavan-zeyfc>
> **Cross-ref:** Google UCP blog → `ucp-universal-commerce-protocol.md` | Fountain City agentic protocols → `agentic-protocols-for-websites-2026.md`

---

## Thesis

UCP is an **orchestration layer** between consumer AI surfaces (Google AI Mode, Gemini, ChatGPT, Perplexity) and merchant backends. It doesn't operate in isolation — it sits within a **4-layer protocol stack** of complementary agentic AI protocols.

Market projection: **$500B annual agentic commerce sales by 2030**.

---

## The 4-Layer Protocol Stack

| Layer | Protocol | Purpose | Key Mechanism |
|---|---|---|---|
| **L1** | **A2A** (Agent2Agent) | Agent-to-agent coordination / multi-agent collaboration | Capability discovery, task delegation, OAuth 2.0 + PKCE |
| **L2** | **MCP** (Model Context Protocol) | Agent-to-tools/data connections | JSON-RPC tool invocation, resource access, least-privilege ACL |
| **L3** | **UCP** (Universal Commerce Protocol) | Commerce business logic, merchant interactions | Capability negotiation via `/.well-known/ucp`, checkout sessions |
| **L4** | **AP2** (Agent Payments Protocol) | Payment orchestration / authorization | Cryptographic payment tokens, multi-party settlement, PCI-DSS |

### How They Work Together

```
User Request
     │
     ▼
┌─────────────────────┐
│  L2: MCP            │  ← Gather context (calendar, email, budget)
│  (Context & Tools)  │
└────────┬────────────┘
         │
         ▼
┌─────────────────────┐
│  L1: A2A            │  ← Decompose tasks across specialized agents
│  (Agent Coord.)     │     (Travel, Hotel, Transport agents)
└────────┬────────────┘
         │
         ▼
┌─────────────────────┐
│  L3: UCP            │  ← Discover merchants, negotiate capabilities,
│  (Commerce Logic)   │     create checkout sessions, apply discounts
└────────┬────────────┘
         │
         ▼
┌─────────────────────┐
│  L4: AP2            │  ← Authorize payments with cryptographic tokens
│  (Payments)         │     split payments across merchants
└─────────────────────┘
```

---

## UCP Core Architecture

Three key principles:

1. **Capability negotiation** — Agents and merchants exchange JSON capability profiles via `/.well-known/ucp`, protocol computes intersection of mutually supported capabilities
2. **Merchant autonomy** — Merchants own their business logic, remain Merchant of Record
3. **Transport agnosticism** — UCP logic stays the same across different transport layers

### Transport Layer Options

UCP runs on: **REST API** (primary), **JSON-RPC**, **GraphQL**, **MCP**, **A2A** — all interchangeable.

### Initial Release Capabilities

- **Checkout** — Native in AI Mode + Gemini, embedded rendering in conversational interfaces
- **Identity linking** — Secure credential exchange without password exposure
- **Discount codes** — Standardized application patterns
- **Loyalty programs** — Credential entry for loyalty benefits
- **Subscriptions** — Frequency selection
- **Dynamic pricing** — Real-time negotiation (e.g., "under $200")
- **Tax & shipping** — Calculation and option presentation
- **Order management** — Post-purchase lifecycle tracking

---

## Integration Details

### A2A (Layer 1)

- Agents publish capabilities via standardized metadata (e.g., "Travel Booking Agent", "Payment Auth Agent")
- Coordinator agent delegates subtasks without hard-coded integrations
- JSON-based lifecycle model: task states, artifacts, multi-part messages
- Auth: OAuth 2.0 + PKCE

### MCP (Layer 2)

- Tool invocation via JSON-RPC (e.g., `search_flights(date, origin, destination)`)
- Resource access for structured data: catalogs, user records, policies
- Least-privilege access control enforced
- Stateful workflows across multi-step operations

### UCP (Layer 3)

- `GET /.well-known/ucp` → discover checkout flows
- Stateful checkout sessions: cart, discounts, loyalty, payment instruments
- Standardized discount/loyalty request/response patterns
- Real-time price negotiation with agent-provided constraints

### AP2 (Layer 4)

- Instrument negotiation: agents ↔ merchants exchange supported payment methods
- Cryptographic signatures authorize without exposing credentials
- Multi-party settlement (split payments across merchants)
- PCI-DSS compliance: keeps sensitive data in specialized processors

---

## End-to-End Use Case: Autonomous Business Trip Planner

**User request:** *"Plan my complete trip to San Francisco, Jan 20-25. Flights under $400, 4-star hotel, rental car, ground transportation. $5,000 budget. Update my calendar."*

| Step | Layer | Action |
|---|---|---|
| 1. Preference Gathering | MCP | Read calendar (constraints), email (travel history), budget tracker → build contextual profile |
| 2. Task Decomposition | A2A | Coordinator discovers agents via A2A registry, delegates to Travel/Hotel/Transport agents |
| 3. Merchant Discovery | UCP | Each agent queries `/.well-known/ucp` on Expedia, Booking.com, Hertz, Uber |
| 4. Shopping & Checkout | UCP | Create checkout sessions → Expedia returns `cb9c0fc5-...`, Booking.com offers loyalty pricing ($175 vs $210) |
| 5. Payment Auth | AP2 | Corporate card for flights, personal card for hotel → cryptographic tokens only (no raw payment data) |
| 6. Confirmation | MCP + UCP | Order confirmations via UCP → email + calendar entries via MCP → aggregate itinerary |
| 7. Real-time Updates | MCP + UCP | Flight delays → MCP notification → auto-update calendar; hotel upgrade → UCP notification → budget check → auto-accept |

**Result:** Entire workflow executed **without user opening any merchant website**.

---

## Strategic Timeline

### Near-Term (2026)
- UCP becomes de facto interchange standard for retail agentic commerce
- Google captures ad revenue from AI-driven discovery on Search/Gemini
- OpenAI/Perplexity/Anthropic expand shopping → fragmentation persists

### Medium-Term (2027-2028)
- $500B+ agentic commerce; UCP merchants see **20-40% conversion uplift**
- Merchant data → commodity; value shifts to agent platforms
- B2B procurement agents become standard
- Payment processors compete on AP2 features, not transaction fees

### Long-Term (2029+)
- UCP matures to global commerce infrastructure
- OpenAI/Stripe/Amazon standards coalesce or niche-compete
- Agent platforms own **customer intent data**; checkout = undifferentiated utility
- Merchants optimize for **"agent experience"**, not human UX
- Standalone shopping websites decline

---

## Key References

- Google UCP blog: [[ucp-universal-commerce-protocol]]
- Fountain City overview: [[agentic-protocols-for-websites-2026]]
- Google Developer Blog: <https://developers.googleblog.com/under-the-hood-universal-commerce-protocol-ucp/>
- AP2 Protocol: <https://ap2-protocol.org/>
- A2A Protocol: <https://a2a-protocol.org/>
- MCP: <https://modelcontextprotocol.io/>
