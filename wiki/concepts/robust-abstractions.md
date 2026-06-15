---
tags: [software-engineering, ai-agents, data-engineering]
sources: [Software Engineering at the Tipping Point Navigating Second-Order Impacts of the AI "10x Moment".md]
created: 2026-06-01
updated: 2026-06-01
---

# Robust Abstractions

Architectural strategy: build opinionated internal libraries and server frameworks that constrain what AI agents can choose to do.

From [[adam-bender|Adam Bender]]: "Don't give them bad choices."

## Core Idea

Left unconstrained, AI agents will build from scratch — inventing their own solutions to solved problems, introducing errors and inconsistencies. Robust abstractions eliminate bad choices from the agent's option space.

Example: if an internal HTTP framework is the only available option, agents use it correctly rather than rolling a raw web server with security gaps.

## Relationship to [[agentic-chaos|Agentic Chaos]]

Robust abstractions are the primary defense against agentic chaos. When agents share the same standardized substrates, their outputs compose predictably. Without them, every agent produces unique, incompatible implementations.

## Implementation Patterns

- Internal CLI tools with opinionated defaults
- Shared client libraries for internal services (not raw API calls)
- Templated project scaffolding (agents start from known-good structure)
- Enforced linting / formatting that agents can't bypass

## Sources

- [[software-engineering-tipping-point-bender-gcp-2026|Software Engineering at the Tipping Point]]
