# Building the Universal Commerce Protocol (UCP) — 2026

Source: https://shopify.engineering/ucp
Author: Ilya Grigorik, Distinguished Engineer at Shopify

---

Commerce is humanity's longest-running trade. Universal, but not uniform. We've spent 20+ years at Shopify learning just how complex it is—billions of transactions, millions of merchants—and it continues to humble us: payment options and rules differ based on properties of the cart, buyer, and market; discounts have stacking and combination rules that can rival the tax code; fulfillment options explode with runaway permutations; and the list goes on. This complexity is not a bug, it's an emergent property of diverse retailers.

[Universal Commerce Protocol (UCP)](http://shopify.com/ucp) is designed to model this reality with flexibility in mind. [We co-developed UCP](https://www.shopify.com/news/ai-commerce-at-scale) with Google to create an open standard for AI agents to connect and transact with any merchant.

Merchants declare and define what capabilities they support, including their own bespoke functionality. Agents discover these capabilities, negotiate what they can handle, and proceed to complete transactions. UCP defines the discovery and negotiation mechanisms between agent and merchant, as well as the core capabilities that make commerce programmable for agents and humans alike.

## Capabilities and extensions

Monolithic protocols eventually collapse under complexity: too rigid to adapt, too slow to evolve. Thoughtfully layered protocols survive and thrive by separating responsibilities, defining clear APIs, and enabling composition. TCP/IP proved this and UCP applies this pattern to commerce, separating responsibilities into layers:

- Shopping service defines core transaction primitives: checkout session, line items, totals, messages, status

- Capabilities add major functional areas: Checkout, Orders, Catalog—each independently versioned

- Extensions augment capabilities with domain-specific schemas via composition

Take fulfillment, which comes in many shapes: shipping, pickup, local delivery, split shipments, pre-orders, delivery windows, subscription schedules… The dev.ucp.shopping.fulfillment extension covers common cases, but it can't and won't cover all possible cases—and that's fine. Merchants with specialized fulfillment requirements can define their own extensions, or the protocol itself can evolve new extensions as common patterns emerge and mature.

Extensions compose with the core schema. Here's a checkout response with the [fulfillment extension](https://ucp.dev/specification/fulfillment/) active:

The core checkout schema defines universal primitives—it knows nothing about fulfillment groups or shipping options. The fulfillment extension adds them by extending the core data model. And when it adds delivery windows tomorrow? It versions independently; core stays stable.

Merchants implement only what they need. Agents negotiate only what they can handle. The protocol evolves without breaking.

## Open bazaar of capabilities, no committees required

Both merchants and agents publish profiles declaring what they support. Discovery is the process of fetching these profiles; negotiation computes their intersection.

Example merchant profile, published at /.well-known/ucp on merchant's site:

Agent profile: agents also declare their capabilities:

When an agent makes a request, it passes its profile URL. The merchant computes the intersection—which capabilities both support, which handlers overlap, which extensions are mutually understood—and responds with the negotiated result. If this sounds familiar, it should. HTTP performs a similar negotiation on every request: accept headers, content types, encodings.

Notice com.loyaltyprovider.points in the merchant profile? It's an extension this merchant adopted from their loyalty vendor. Agents that don't support it simply won't get loyalty fields from the merchant. Agents that do can negotiate reward options, provide member credentials, or redeem points. Same merchant, same endpoint, capabilities shaped by negotiation. And when the merchant requires something the agent can't provide, the agent fills what it can; the buyer completes the rest. Seamless handoff is a built-in protocol mechanism (more on that below).

How did loyaltyprovider get approval to define com.loyaltyprovider.points? They didn't need to. No central registry, no approval committees. UCP uses reverse-domain naming: dev.ucp.shopping.* is hosted at [ucp.dev](http://ucp.dev); com.loyaltyprovider.* belongs to loyaltyprovider.com. Own the domain, own the namespace. Each side validates advertised capabilities and their provenance: security through namespace binding, not bureaucracy.

The result is an open bazaar of capabilities, evolving as freely as commerce itself.

Open protocols don't just let you read the spec—they allow you to extend it without permission. Commerce comes in many shapes and refuses to sit still. UCP is built for this reality, improving without integration meetings, ready to continue evolving as agentic commerce does.

## Commerce demands collaboration

UCP allows humans and agents to work together because some transactions demand it. Some checkouts complete entirely via API. Others require human involvement: regulatory constraints, merchant policies, or capabilities an agent doesn't yet support. That "yet" matters—today's escalation may become tomorrow's API call as an agent's capabilities mature. But some transactions will always require human participation.

UCP models this through a [simple checkout state machine](https://ucp.dev/specification/checkout/#overview:~:text=in%20the%20future.-,Checkout%20Status%20Lifecycle,-The%20checkout%20status). A checkout progresses through:

- incomplete: missing required information; agent should attempt to resolve via API

- requires_escalation: buyer input required; agent should attempt API resolution and, if unable, hand off via continue_url

- ready_for_complete: all information collected; agent can finalize programmatically

When a transaction cannot proceed autonomously, the merchant response includes structured context and a continuation URL:

The buyer follows continue_url and picks up exactly where the agent left off. No transaction is ever left behind: when an agent hits a capability gap, the protocol routes around it.

## Handoff is an invitation for collaboration

The Embedded Checkout Protocol (ECP) makes escalations feel seamless—bi-directional messaging between agent and merchant, checkout embedded in the agent's surface, secure credentials and context flowing both ways. Familiar UI keeps the buyer assisted, and the merchant gets structured data to finalize the transaction.

When a handoff is required, the agent renders embedded checkout by loading the provided continue_url. ECP establishes a JSON-RPC 2.0 channel (state updates from merchant, credentials and context from agent), enabling delegation to host service. Payment collection surfaces the host's native payment sheet. Address selection pulls from the agent's wallet.

All of this is born from [Shopify's Checkout Kit](https://www.shopify.com/checkout-kit), distilled into an open protocol and based on years of operating our embedded checkout at scale. Paired with advanced agent branding capabilities and [strong sandboxing for PCIv4 compliance](https://www.shopify.com/partners/blog/checkout-compliance), this is true agent and merchant collaboration. [Build against the protocol](http://ucp.dev), or grab the Checkout Kit to unlock this experience for any Shopify merchant with only a few lines of code.

## Payments are a two-sided negotiation

Merchants spend years optimizing their payment service provider (PSP) relationships: routing rules, fraud models, regional coverage. Buyers have their own preferences: saved cards, digital wallets, buy-now-pay-later. UCP lets both sides express what they want then dynamically negotiates per transaction. Handlers vary based on cart contents, buyer location, or transaction amount. The UCP profiles declare what each can support; the checkout response declares what is available.

Payment handlers, just like capabilities, invert the usual integration burden. Rather than the protocol defining every payment method, each provider—whether it's Google, Shopify, or a regional PSP—publishes their own handler specification. The merchant just advertises which handlers they accept; the agent picks one and follows its spec. New payment methods grow into the ecosystem without committee votes or core version bumps.

## Build with UCP

This isn't an exhaustive tour, it's the "why" behind UCP. These are the principles that shaped its design: discovery and negotiation, layered extensibility, graceful handoff, and payment flexibility. UCP models commerce right and makes it programmable.

Co-developed with Google. Supported by Etsy, Target, Walmart, Wayfair, and millions of Shopify merchants. The [UCP spec](https://ucp.dev/) is public and ready to build against. Go read it, [contribute](https://github.com/Universal-Commerce-Protocol/ucp), and build the future of commerce with us. The bazaar is open.
