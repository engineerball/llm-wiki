---
title: "AP2 — Agent Payments Protocol"
tags: [concept, ap2, payments, agent-payments, protocol, google, vc, verifiable-credentials]
date: 2026-05-04
sources: ["sources/ap2-agent-payments-protocol-2026.md", "sources/ucp-interoperability-mcp-a2a-ap2.md"]
---

# AP2 — Agent Payments Protocol

**AP2 (Agent Payments Protocol)** is Google's open protocol enabling AI agents to make payments securely, with cryptographic proof of user intent at every step.

## Why AP2 Exists

Payment systems were built assuming humans click "buy." Autonomous agents break this model:

| Problem | AP2 Solution |
|---|---|
| Did the user actually authorize this? | **Verifiable Credentials** with user signature |
| What if the agent hallucinated the price? | **Cart Mandate** binds exact items + price |
| Who's liable for fraud? | **Cryptographic audit trail** per transaction |
| Proprietary payment silos | **Open extension for A2A** — works with any compliant system |

## Position in the Stack

See [[agentic-protocol-stack]] for the full picture.

AP2 is **Layer 4** — the payment authorization layer:

```
MCP (L2) → A2A (L1) → UCP (L3) → AP2 (L4)
context     coordination  commerce     payments
```

## Three Verifiable Credentials

### 1. Intent Mandate (Human NOT Present)
- "When tickets go on sale, buy 2 under $200"
- Shopping Agent signs this constraint
- Agent executes within bounds; TTL limits exposure

### 2. Cart Mandate (Human Present)
- User reviews final cart: items, price, destination
- User cryptographically signs → **non-repudiable**
- This is the gold standard for agent payment consent

### 3. Payment Mandate
- Signals to payment network: "AI agent involved"
- Distinguishes human-present vs. not-present
- Helps issuers assess risk appropriately

## Role Architecture

```
User → Shopping Agent (UA) → Merchant Endpoint (ME)
              ↓                         ↓
         Credentials Provider      Merchant Payment Processor
                                         ↓
                                  Network + Issuer
```

Each role has defined responsibilities and data boundaries. No single actor has all the information — the VC system connects them cryptographically.

## Payment Methods

| Current | Roadmap |
|---|---|
| Credit/debit cards ("pull") | UPI (India) — real-time bank transfers |
| | PIX (Brazil) — instant payments |
| | Digital currencies |

## Samples

Google publishes working implementations:

- **Python + Cards** — human-present card flow
- **Python + x402** — agent micropayments
- **Android + Digital Payment Credentials** — device-native flow

→ <https://github.com/google-agentic-commerce/AP2>

## AP2 vs ACP

AP2 competes with Stripe's **Agent Checkout Protocol (ACP)**:

| | AP2 (Google) | ACP (Stripe/OpenAI) |
|---|---|---|
| Base protocol | A2A extension | Stripe-native |
| Distribution | Google ecosystem + open | 900M ChatGPT users |
| Consent model | Verifiable Credentials | Stripe-verified tokens |
| Openness | Open, interoperable | More proprietary |

**Strategic choice:** AP2 for portability and multi-platform reach; ACP for ChatGPT distribution advantage.

See [[agentic-commerce]] for competitive landscape.

## Source

- [[ap2-agent-payments-protocol-2026]] — official AP2 Protocol website documentation
