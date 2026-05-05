---
title: "Universal Commerce Protocol (UCP)"
tags: [source, ucp, agentic-commerce, agentic-protocols]
date: 2026-05-05
sources: ["https://developers.googleblog.com/under-the-hood-universal-commerce-protocol-ucp/"]
---

# Universal Commerce Protocol (UCP)

> **Source:** Google Developers Blog, Jan 11, 2026 — Amit Handa & Ashish Gupta
> **URL:** <https://developers.googleblog.com/under-the-hood-universal-commerce-protocol-ucp/>
> **Website:** <http://ucp.dev/>
> **GitHub:** <https://github.com/universal-commerce-protocol/ucp>

---

## 1. What is UCP?

UCP is an **open-source standard** designed to power the next generation of **agentic commerce** — enabling seamless commerce journeys between consumer surfaces, businesses, and payment providers through a common language and functional primitives.

**Compatible with:**
- Agent Payments Protocol (AP2) for secure agentic payments
- Agent2Agent (A2A) protocol
- Model Context Protocol (MCP)
- Traditional REST APIs

**Key partners (endorsed by 20+):** Google, Shopify, Etsy, Wayfair, Target, Walmart, Adyen, American Express, Best Buy, Flipkart, Macy's Inc, Mastercard, Stripe, The Home Depot, Visa, Zalando

### Beneficiaries

| Stakeholder | Benefit |
|---|---|
| **Businesses** | Showcase products on AI surfaces (Google AI Mode, Gemini), keep own business logic, remain Merchant of Record, customizable embedded checkout |
| **AI platforms** | Enable agentic shopping, standardized onboarding via APIs, flexible MCP/A2A support |
| **Developers** | Community-driven open-source standard |
| **Payment providers** | Open modular payment handler design, cryptographic proof of user consent |
| **Consumers** | Frictionless product discovery → decision → purchase across brands |

### The Problem UCP Solves

Traditional commerce infrastructure suffers from an **N × N integration bottleneck** — businesses must build bespoke connections for every surface/channel.

UCP collapses this to a **single integration point** via:

- **Unified integration** — one integration for all consumer surfaces
- **Shared language** — standardized discovery, capability schema, transport bindings
- **Extensible architecture** — capabilities + extensions framework scales with new experiences and verticals
- **Security-first** — tokenized payments, verifiable credentials

## 2. Architecture Overview

UCP creates a standard language for **consumer surfaces** (AI Mode on Search, Gemini, etc.) to connect to **business backends** (product discovery, cart checkout).

- **Services** — verticals (e.g., Shopping) that businesses choose to support
- **Capabilities** — core commerce building blocks (checkout, product discovery) with optional **extensions** (e.g., discounts)
- **Discovery** — agents dynamically discover capabilities & payment options via profiles at `/.well-known/ucp`
- **Payments** — separates payment *instruments* from payment *handlers*, scales across diverse providers
- **Transports** — supports A2A, MCP, and REST APIs

## 3. How It Works (Walkthrough)

Sample flow using a demo flower shop:

### 3.1 Setup Business Server
```bash
mkdir sdk
git clone https://github.com/Universal-Commerce-Protocol/python-sdk.git sdk/python
pushd sdk/python && uv sync && popd
git clone https://github.com/Universal-Commerce-Protocol/samples.git
cd samples/rest/python/server && uv sync
uv run import_csv.py --products_db_path=/tmp/ucp_test/products.db --transactions_db_path=/tmp/ucp_test/transactions.db --data_dir=../test_data/flower_shop
```

### 3.2 Start Server
```bash
uv run server.py --products_db_path=/tmp/ucp_test/products.db --transactions_db_path=/tmp/ucp_test/transactions.db --port=8182 &
```

### 3.3 Capability Discovery
Agents query `GET /.well-known/ucp` to get a JSON manifest with services, capabilities, and payment handlers — no hard-coded integrations needed.

### 3.4 Checkout Invocation
Agent POSTs to `/checkout-sessions` with line items, buyer info, currency, and selected payment handlers. Gets back a checkout session with status `ready_for_complete`.

### 3.5 Apply Discounts
Agent PUTs to `/checkout-sessions/{id}` with discount codes → server returns updated totals with discount applied.

## 4. Google Integration

Google built the **first reference implementation** of UCP for its conversational experiences:
- **AI Mode in Search** and **Gemini** — consumers can purchase directly
- **Google Pay** integration using stored Google Wallet info
- **Merchant Center** integration required for businesses

### Integration steps for businesses
1. Active **Merchant Center account** with eligible products
2. Follow [Google integration guide](https://developers.google.com/merchant/ucp)
3. Complete [checkout integration instructions](https://developers.google.com/merchant/ucp/guides/checkout)

## 5. Key APIs Endpoints Summary

| Method | Endpoint | Purpose |
|---|---|---|
| GET | `/.well-known/ucp` | Discover services, capabilities, payment handlers |
| POST | `/checkout-sessions` | Create checkout session |
| PUT | `/checkout-sessions/{id}` | Update session (e.g., apply discounts) |

## 6. UCP Capabilities

- `dev.ucp.shopping.checkout` — Core checkout
- `dev.ucp.shopping.discount` — Discount extension (extends checkout)
- `dev.ucp.shopping.fulfillment` — Fulfillment extension (extends checkout)
- Plus: identity linking, order management (and expanding)

## 7. Sample Response (Capability Discovery)

```json
{
  "ucp": {
    "version": "2026-01-11",
    "services": { "dev.ucp.shopping": { ... } },
    "capabilities": [
      { "name": "dev.ucp.shopping.checkout", ... },
      { "name": "dev.ucp.shopping.discount", ... },
      { "name": "dev.ucp.shopping.fulfillment", ... }
    ]
  },
  "payment": {
    "handlers": [
      { "id": "shop_pay", ... },
      { "id": "google_pay", ... },
      { "id": "mock_payment_handler", ... }
    ]
  }
}
```

## 8. Links

- Spec: <https://ucp.dev/>
- GitHub: <https://github.com/universal-commerce-protocol/ucp>
- Samples: <https://github.com/Universal-Commerce-Protocol/samples>
- Python SDK: <https://github.com/Universal-Commerce-Protocol/python-sdk>
- Google Integration: <https://developers.google.com/merchant/ucp>
- AP2 Protocol: <https://ap2-protocol.org/>
- A2A Protocol: <https://a2a-protocol.org/>
- MCP: <https://modelcontextprotocol.io/>
