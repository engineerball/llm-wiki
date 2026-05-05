---
title: "OpenClaw Security: Architecture and Hardening Guide"
tags: [source, security, openclaw, agent-gateway]
sources: [.raw/articles/nebius-openclaw-security-2026-05-05.md]
date: 2026-05-05
---

# Source Summary: OpenClaw Security (Nebius)

Comprehensive guide to the security architecture and hardening strategies for **OpenClaw**, an open-source, self-hosted AI agent gateway.

## Key Takeaways

- **Gateway as Security Boundary**: OpenClaw runs as a self-hosted gateway orchestrating clients, nodes, and tools. It inherits the trust of the host machine, making it a critical security boundary.
- **Sandboxing Tiers**: Offers three sandbox modes for tool execution: `Off` (none), `Non-main` (containerized secondary threads), and `All` (all tools in Docker/Podman).
- **Supply Chain Risk (ClawHub)**: Skills (third-party code) represent a major risk; the "ClawHavoc" campaign highlighted malicious skills harvesting API keys and injecting keyloggers.
- **Memory Poisoning**: Transparent, file-based memory (`MEMORY.md`) is vulnerable to prompt injection attacks that "poison" long-term knowledge.
- **Hardening Best Practices**:
    - Bind to loopback (127.0.0.1).
    - Use SSH tunnels/VPNs for remote access.
    - Explicit tool allowlists (`tools.allow`).
    - Pairing-based DM policies.
    - Non-root execution.

## Related Pages

- [[openclaw]] — the self-hosted agent gateway entity
- [[llm-gateway]] — OpenClaw acts as a specialized agent-first LLM gateway
- [[agentic-protocol-stack]] — security considerations for the gateway layer of the stack
- [[harness-engineering]] — sandboxing and tool policies as harness controls
