---
title: "OpenClaw Security: Architecture and Hardening Guide"
tags: [source, security, openclaw, agent-gateway, multi-user, sandboxing, skill-supply-chain, memory-poisoning]
sources: [".raw/articles/nebius-openclaw-security-2026-05-05.md", "raw/articles/nebius-openclaw-security-2026.md"]
date: 2026-05-05
updated: 2026-05-08
---

# Source Summary: OpenClaw Security (Nebius)

Comprehensive guide to the security architecture and hardening strategies for **OpenClaw**, an open-source, self-hosted AI agent gateway. Covers Gateway internals, sandboxing tiers, multi-user deployment patterns, the ClawHavoc supply-chain attack, memory subsystem design, and a practical hardening checklist.

## Key Takeaways

### 1. OpenClaw is a Full Application — Not a Chatbot

- Runs entirely on your infrastructure — you own deployment, updates, **and security**
- Security responsibility is **fully yours**, unlike managed platforms where it's shared
- Installing a ClawHub skill = running third-party code on your host with persistent credentials
- "Should be treated as **untrusted code execution with persistent credentials**"

| Aspect | OpenClaw (Self-hosted) | Managed Platforms | Agent Frameworks |
|---|---|---|---|
| Deployment | You run Gateway on your host | Vendor runs everything | You embed a library |
| Security responsibility | Fully yours | Shared with vendor | Fully yours |

### 2. Gateway as Single Security Boundary

- **Single Gateway process** on port 18789 — all channels, clients, nodes connect through one point
- Default binding: `loopback` (127.0.0.1) — safe for single-user
- Non-loopback binds require strong auth token
- Config **hot-reloaded** — invalid changes rejected automatically
- Session history persists to disk (`agents/<agentId>/sessions/`) — survives restarts

### 3. Sandboxing Hierarchy (3 Levels)

| Mode | Behavior | Risk Level |
|---|---|---|
| **Off** | All tools run on host | Highest — only trusted single-user |
| **Non-main** (default) | Group chats/secondary threads in Docker; primary on host | Balanced |
| **All** | Every tool call in container | Lowest — required for multi-user/production |

- Containers scoped **per session or per agent**
- Workspace mountable as **read-only** or **not mounted**
- **Elevated mode**: escape hatch for specific tools — still respects tool policy

### 4. Per-Agent Tool Policies (Least Privilege)

- Tool **allowlist** — only explicitly permitted tools run
- If tool matches allow AND deny → **deny wins**
- Multi-agent: each agent has its own policy
- `/exec` in chat adjusts per-session permissions **within** allowlist bounds
- Rule: "If an agent doesn't need exec, it shouldn't have it"

### 5. The ClawHavoc Campaign (January 2026)

Major supply-chain attack on ClawHub registry:

- **Hundreds of malicious skills** found in public registry
- **Atomic Stealer payload** — harvested API keys from agent environment
- **Injected keyloggers**
- **Memory poisoning** — wrote malicious content into `MEMORY.md` and `SOUL.md` for persistent cross-session effect
- **Crypto wallet theft** — posed as crypto trading tool, silently stole credentials
- **Lesson:** Treat unverified ClawHub skills like untrusted code. Audit every skill. Sandbox first.

### 6. Memory Subsystem — Transparent but Attackable

- All agent memory is **plain Markdown on disk** — no hidden states
- Two files: `memory/YYYY-MM-DD.md` (daily log) + `MEMORY.md` (long-term facts)
- Background indexer → **SQLite FTS + vector store** (hybrid search)
- Scales to Pinecone/Milvus without restructuring
- **Attack vector:** Malicious skills can poison MEMORY.md/SOUL.md → agent behavior corrupted across sessions

### 7. Access Control Best Practices

| Control | Config |
|---|---|
| Bind to loopback | `gateway.bind: "loopback"` |
| Strong auth token | `gateway.auth.token: "SECRET"` |
| Lock down DMs | `dmPolicy: "pairing"` or `"allowlist"` |
| Sandboxing on | `sandbox.mode: "non-main"` or `"all"` |

- Remote access: SSH tunnel or **Tailscale** (OpenClaw supports Tailscale "serve" mode)
- Group chats: require explicit mention of bot
- Channel `dmPolicy` options:
  - `"pairing"` (default) — unknown contacts confirm via one-time code
  - `"allowlist"` — explicit whitelist
  - `"open"` — **avoid** unless necessary

### 8. Operational Security Commands

| Command | Purpose |
|---|---|
| `openclaw doctor` | System health check |
| `openclaw doctor --repair --deep` | Auto-heal known issues |
| `openclaw security audit` | Inspect config for security pitfalls |
| `openclaw security audit --fix` | Auto-correct issues |
| `openclaw sandbox explain --session` | Verify effective sandbox for session |

### 9. Multi-User / Team Deployment

- Multiple agents under `agents.list`, each with own workspace, tool policy, model
- Gateway on private-cloud VM behind VPN
- Skills centrally managed via `clawhub` CLI
- **Sandboxing must be on** for public-facing agents
- Partition **RAG agents** (search + read only) from **messaging agents** (broader permissions, tighter Docker scope)

### 10. Anti-Patterns to Avoid

1. Binding to `0.0.0.0` on untrusted network
2. `dmPolicy: "open"` — anyone can message the bot
3. Full tool access for all agents — breaks least privilege, especially `exec` + `apply_patch`
4. Installing unaudited ClawHub skills — supply-chain compromise
5. Running on public interface without token + firewall

## Hardening Checklist

| Priority | Control | Config |
|---|---|---|
| 🔴 | Bind to loopback | `gateway.bind: "loopback"` |
| 🔴 | Strong auth token | `gateway.auth.token: "SECRET"` |
| 🔴 | Lock down DMs | `dmPolicy: "pairing"` or `"allowlist"` |
| 🔴 | Sandboxing on | `sandbox.mode: "non-main"` or `"all"` |
| 🟡 | Per-agent tool allowlists | `tools.allow` — most restrictive needed |
| 🟡 | Audit skills before install | Read SKILL.md, sandbox first |
| 🟡 | Run `openclaw security audit` | After every config change / skill install |
| 🟢 | Use Tailscale for remote | `gateway.bind: "tailnet"` |
| 🟢 | Run `openclaw doctor` | Regular health checks |

## Security Testing Recommendations

- **Adversarial testing:** inject malicious prompts directly and indirectly
- Use **OWASP GenAI Top 10** as test patterns
- Measure "infection rate" — % of malicious inputs bypassing controls
- Verify sensitive tools (exec, browser) are unreachable to attacker-controlled agent
- Performance: Gateway handles dozens of short chats/sec; LLM downstream is bottleneck

## Related Pages

- [[openclaw]] — the self-hosted agent gateway entity
- [[llm-gateway]] — OpenClaw acts as a specialized agent-first LLM gateway
- [[agentic-protocol-stack]] — security considerations for the gateway layer
- [[harness-engineering]] — sandboxing and tool policies as harness controls
- [[running-openclaw-safely]] — Microsoft security analysis (complementary perspective)
- [[agentic-ai-system]] — memory poisoning and security layers
