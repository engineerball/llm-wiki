---
title: "Hot Cache"
tags: [meta]
date: 2026-05-05
---

# Hot Cache

Last ingest context for fast session resumption.

---

## Last Ingest: OpenClaw Security: Architecture and Hardening Guide (Nebius)

**Source:** `.raw/articles/nebius-openclaw-security-2026-05-05.md`
**URL:** https://nebius.com/blog/posts/openclaw-security
**Pages created:**
- `wiki/sources/nebius-openclaw-security.md` — full source summary: architecture, sandboxing tiers, skill risk, memory poisoning, best practices
- `wiki/entities/openclaw.md` — entity page: overview, multi-platform support, skills system, tiered sandboxing

**Pages updated:**
- `wiki/concepts/llm-gateway.md` — added OpenClaw to Implementations
- `wiki/concepts/agentic-protocol-stack.md` — added OpenClaw to Gateway Infrastructure
- `wiki/index.md` — added Source and Tool entries
- `wiki/log.md` — prepended ingest entry

### Key Facts
- **OpenClaw** is an open-source, self-hosted agent gateway.
- **Security Boundary**: Being self-hosted, it inherits host trust; skills are equivalent to running 3rd-party code on the host.
- **Sandboxing**: Configurable isolation (Off, Non-main, All) using Docker/Podman.
- **Tool Policies**: Governed by `tools.allow` explicit allowlists; deny overrides allow.
- **Memory Poisoning**: Plain-text memory (`MEMORY.md`) is vulnerable to injection attacks that "poison" long-term knowledge.
- **Supply Chain**: Malicious skills (ClawHub) can harvest API keys and inject keyloggers.

### Prior Ingest: Karpathy LLM Wiki Pattern (2026-05-05)
- Wiki > RAG; 3 layers; 3 workflows; scale properties; persistent compounding artifact.
