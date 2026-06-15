---
title: "Agentic Protocol Stack"
tags: [concept, agentic-ai, protocol, mcp, a2a, ucp, ap2, architecture]
date: 2026-05-04
sources: ["sources/ucp-interoperability-mcp-a2a-ap2.md", "sources/agentic-protocols-for-websites-2026.md", "sources/ucp-universal-commerce-protocol.md"]
---

# Agentic Protocol Stack

A 4-layer protocol architecture that defines how AI agents interact with tools, other agents, commerce backends, and payment systems. Each layer solves a distinct coordination problem; they compose into end-to-end agentic workflows.

## Layer Overview

| Layer | Protocol | Problem Solved | Key Mechanism |
|---|---|---|---|
| **L1** | **A2A** (Agent2Agent) | Agent ↔ agent coordination | Capability discovery, task delegation, OAuth 2.0 + PKCE |
| **L2** | **MCP** (Model Context Protocol) | Agent ↔ tools/data | JSON-RPC tool invocation, resource access, least-privilege ACL |
| **L3** | **UCP** (Universal Commerce Protocol) | Agent ↔ commerce backend | Capability negotiation via `/.well-known/ucp`, checkout sessions |
| **L4** | **AP2** (Agent Payments Protocol) | Payment authorization | Cryptographic payment tokens, multi-party settlement, PCI-DSS |

## How the Layers Compose

```
User Request
     │
     ▼
[ L2: MCP ] — Gather context (calendar, email, budget, preferences)
     │
     ▼
[ L1: A2A ] — Decompose tasks; delegate to specialized agents
     │
     ▼
[ L3: UCP ] — Discover merchants, negotiate capabilities, create checkout sessions
     │
     ▼
[ L4: AP2 ] — Authorize payments with cryptographic tokens
```

The layers are independent but complementary. A single agent workflow may use all four in sequence; simpler workflows may only use one or two.

## Layer Detail

### L1: A2A (Agent2Agent)

- Agents publish capabilities via standardized metadata
- Coordinator agent discovers and delegates to specialized agents without hard-coded integrations
- JSON-based lifecycle model: task states, artifacts, multi-part messages
- Auth: OAuth 2.0 + PKCE
- **Relevant when:** 3+ agents need to coordinate; multi-step tasks span domain boundaries

### L2: MCP (Model Context Protocol)

- Tool invocation via JSON-RPC (e.g., `search_flights(date, origin, destination)`)
- Resource access for structured data: catalogs, user records, policies
- Least-privilege access control; stateful workflows across multi-step operations
- Launched by Anthropic Nov 2024; now Linux Foundation governed; adopted by OpenAI, Google, Microsoft
- **97M downloads**, 10,000+ servers live (March 2026)
- **Relevant when:** Agent needs to query tools, databases, or structured APIs

### L3: UCP (Universal Commerce Protocol)

- Merchant capability discovery via `GET /.well-known/ucp`
- Stateful checkout sessions: cart, discounts, loyalty, payment instruments
- Transport-agnostic: runs over REST, JSON-RPC, GraphQL, MCP, A2A
- Google, Shopify, Walmart, Visa, Mastercard, Stripe coalition (NRF 2026)
- **Relevant when:** Agent needs to purchase goods/services on behalf of user

See [[ucp]] for full protocol detail.

### L4: AP2 (Agent Payments Protocol)

- Instrument negotiation: agents ↔ merchants exchange supported payment methods
- Cryptographic signatures authorize without exposing raw credentials
- Multi-party settlement (split payments across merchants)
- PCI-DSS compliant: sensitive data stays in specialized processors
- **Relevant when:** Any L3 (UCP) checkout needs actual payment execution

## Protocol Governance

| Protocol | Governing Body | License |
|---|---|---|
| MCP | Linux Foundation | Apache 2.0 |
| A2A | Linux Foundation | Apache 2.0 |
| UCP | Open-source, Google-led coalition | Open-source |
| AP2 | ap2-protocol.org | — |

## End-to-End Example (Business Trip)

A user says: *"Plan my trip to San Francisco, Jan 20-25. Flights under $400, 4-star hotel, $5K budget. Update calendar."*

| Step | Layer | Action |
|---|---|---|
| 1. Context | MCP | Read calendar, email, budget tracker |
| 2. Decompose | A2A | Coordinator delegates to Travel, Hotel, Transport agents |
| 3. Discover | UCP | Each agent queries `/.well-known/ucp` on Expedia, Booking.com, Hertz |
| 4. Checkout | UCP | Create checkout sessions; apply loyalty pricing |
| 5. Payment | AP2 | Corporate card for flights, personal for hotel — cryptographic tokens only |
| 6. Confirm | MCP + UCP | Order confirmations → email + calendar updates |
| 7. Updates | MCP + UCP | Flight delay → auto-update calendar; hotel upgrade → budget check → auto-accept |

User never opens any merchant website.

## What Most Websites Need

From [[agentic-protocols-for-websites-2026|Agentic Protocols for Your Website in 2026]]:

- **Content sites** → MCP server (if you have internal data worth exposing) + content recency
- **E-commerce sites** → `/.well-known/ucp` + structured data baseline
- **Multi-service platforms** → A2A when you orchestrate 3+ agents
- **Brochure sites with <50 pages** → skip protocols entirely; fix structured data first

See [[agentic-commerce]] for the commerce-specific context. See [[agentic-ai-system]] for how this fits the broader 9-layer system architecture.

## Gateway Infrastructure

Running this protocol stack in production requires a gateway that understands stateful JSON-RPC, SSE push, session fan-out, and per-session authorization — capabilities traditional API gateways lack.

- [[agentgateway]]: Reference open-source implementation — a single Rust proxy that handles MCP (L2), A2A (L1), and LLM routing under unified security and observability policies.
- [[openclaw]]: Self-hosted, agent-first gateway providing multi-platform integration and tiered sandboxing for tool execution.

See [[llm-gateway]] for the LLM routing layer that sits beneath this stack.

## Links

- MCP spec: <https://modelcontextprotocol.io/>
- A2A spec: <https://a2a-protocol.org/>
- UCP spec: <https://ucp.dev/>
- AP2 spec: <https://ap2-protocol.org/>
- Agent Gateway: <https://agentgateway.dev/>
