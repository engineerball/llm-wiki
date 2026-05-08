# OpenClaw Security: Architecture & Hardening Guide

Source: https://nebius.com/blog/posts/openclaw-security
Publisher: Nebius
Date: March 5, 2026 (12 mins read)

---

Self-hosted AI agents offer control and flexibility, but they also introduce real security risks. Incidents involving malicious ClawHub skills, exposed default ports and prompt-injection attacks show that running OpenClaw is not just an installation task, but an infrastructure decision.

## What is OpenClaw

OpenClaw is an open-source, self-hosted agent gateway for running AI agents across messaging apps and tools.

### Core Components

- **Gateway:** Routes requests and manages orchestration
- **Clients:** User-facing interfaces (e.g., chat apps)
- **Nodes:** Execute agent workloads
- **Sessions:** Maintain conversational state
- **Tools and skills:** Extend agent capabilities
- **Memory:** Stores context across interactions

### Gateway & Runtime Internals

OpenClaw runs as a single Gateway process on your host. Clients, agent nodes, messaging channels and tools all connect through it.

Clients connect over WebSocket on port 18789 by default. Each connection identifies itself by role, device identity, and authentication token. The Gateway queues incoming messages, dispatches them to the agent runtime, and routes responses back.

Nothing is lost between restarts. Everything is written to `~/.openclaw/` — config, credentials, session histories, agent workspaces, tool caches, and memory snapshots. Each agent's conversation history lives under `agents/<agentId>/sessions/`.

The Gateway continuously watches the config file and applies valid changes immediately without requiring a restart.

### What OpenClaw Is Not

OpenClaw is not a managed cloud agent service or a simple chatbot library. It runs entirely on your infrastructure — you own the deployment, updates, and security.

**Key distinction:** Installing a ClawHub skill is effectively running third-party code on your host. OpenClaw "should be treated as **untrusted code execution with persistent credentials**."

| Aspect | OpenClaw (Self-hosted) | Managed Platforms | Agent Frameworks |
|---|---|---|---|
| Deployment | You run the Gateway on your host | Vendor runs everything | You embed a library in your app |
| Updates | You handle upgrades | Vendor handles updates | You manage dependencies |
| Tool control | Tool policy + Sandbox + optional Elevated mode | Vendor-defined controls | Depends on your runtime |
| Ecosystem | ClawHub skills | Built-in cloud connectors | NPM / PyPI packages |
| Security responsibility | Fully yours | Shared with vendor | Fully yours |

## Tool Policies, Sandbox & Elevated Modes

OpenClaw handles tool execution control through three sandbox levels:

| Mode | Behavior |
|---|---|
| **Off** | No sandboxing — tools run directly on the host |
| **Non-main** (default) | Group chats and secondary threads run in isolated Docker containers; primary session stays on host |
| **All** | Every tool call runs in a container |

### Container Scoping

- Containers can be scoped per session or per agent
- Workspace can be mounted as read-only or not mounted at all

### Elevated Mode (Escape Hatch)

- Tools flagged as `elevated` always run on the host, even when the agent is sandboxed
- This is intentional — some shell commands need direct host access
- Elevated mode does NOT bypass tool policy — it only lets specific commands escape the container

### Tool Allowlist

- Only tools explicitly permitted can run
- If a tool matches both allow AND deny rules → **deny wins**
- In multi-agent setups, each agent carries its own policy
  - One agent locked to `read` + `web_search`
  - Another gets full `exec` access
- `/exec` in chat adjusts per-session permissions but can't grant tools beyond the allowlist

## Skills & ClawHub Registry

Skills are versioned bundles containing a `SKILL.md` and supporting scripts/data, used to extend agent capabilities with new APIs, commands, or custom code.

- Install via `clawhub install <skill-name>` → lands in `./skills/`
- Every new session automatically loads all installed skills
- Public ClawHub registry for publishing and discovery
- Semantic versioning, changelog, tags per release
- Vector embeddings indexed for semantic search

**⚠️ Critical security note:** Skills can execute arbitrary code, including shell commands. A malicious or poorly written skill can meaningfully compromise agent behavior. Treat skill installs like installing a package from a public registry.

### The ClawHavoc Campaign (January 2026)

Hundreds of skills in the ClawHub registry were found to contain malware:

- **Atomic Stealer payload** — harvested API keys
- **Injected keyloggers**
- **Memory poisoning** — wrote malicious content directly into `MEMORY.md` and `SOUL.md` for persistent cross-session effect
- **Crypto wallet theft** — posed as a cryptocurrency trading tool and silently stole wallet credentials

**Lesson:** Treat unverified ClawHub skills like untrusted code. Audit every skill before installing. Run new skills in a sandbox with minimal permissions until confirmed safe.

## Memory Subsystem & RAG

Everything the agent knows is plain Markdown on disk. If it hasn't been written down, the agent doesn't remember it.

### Architecture

- **Daily log:** `memory/YYYY-MM-DD.md` — recent context
- **Long-term memory:** `MEMORY.md` — curated facts
- **Background indexer:** chunks both into local SQLite FTS + vector store (hybrid full-text + semantic search)
- When agent queries memory → semantic search over hybrid index

### Scalability

- Files are editable by humans directly — no hidden states
- When outgrowing local storage → point to external vector database (Pinecone, Milvus)
- Same Markdown files power full RAG pipeline at scale — nothing needs restructured

## Access Control & Network Security

### Gateway Binding

- Default: `gateway.bind: "loopback"` (only localhost)
- Auth token randomly generated during onboarding
- Non-loopback binds require `gateway.auth.token`
- **Never** run on public interface (`0.0.0.0`) without token + firewall

```json
{
  "gateway": {
    "bind": "loopback",
    "port": 18789,
    "auth": { "token": "YOUR_SECRET_TOKEN" }
  }
}
```

### Remote Access

- Use SSH tunneling or identity-aware VPN like Tailscale
- Tailscale "serve" mode for secure UI exposure

### Channel DM Policies

| Policy | Behavior |
|---|---|
| `pairing` (default) | Unknown contacts get one-time code to confirm before chatting |
| `allowlist` | Only explicitly whitelisted senders can DM |
| `open` ⚠️ | Anyone can message — avoid unless necessary |

Group chats: require explicit mention of bot.

## Operational Security Commands

| Command | Purpose |
|---|---|
| `openclaw doctor` | System health check + auto-fix |
| `openclaw doctor --repair / --deep` | Auto-heal known issues |
| `openclaw security audit` | Inspect config/env for common pitfalls |
| `openclaw security audit --fix` | Auto-correct some security issues |
| `openclaw sandbox explain` | Verify effective sandbox/policy for agent session |
| `openclaw sandbox explain --session` | Session-specific sandbox check |

**Routine:** Run audit after every config change or new skill install.

## Multi-User / Team Deployment

### Architecture

- Multiple agents under `agents.list`, each with own workspace, tool policy, model
- Gateway runs on private-cloud VM, binding to private interface or loopback behind VPN
- Each user's CLI/mobile client connects as operator
- Skills centrally managed via `clawhub` CLI
- Agents auto-load from shared workspace directory

### Security Requirements for Multi-User

- Sandboxing must be on: `sandbox.mode: "non-main"` or `"all"` for public-facing agents
- Tool allowlists (`tools.allow`) must be explicit
- **Principle:** "If an agent doesn't need exec, it shouldn't have it"
- Partition RAG agents (search + read only) from messaging agents (broader permissions, tighter Docker scope)

## Common Anti-Patterns

1. **Binding to `0.0.0.0`** on untrusted network — attackers get direct line to agents
2. **`dmPolicy: "open"`** — anyone can message the bot
3. **Full tool access for all agents** — breaks least privilege, especially `exec` + `apply_patch`
4. **Installing unaudited ClawHub skills** — supply-chain compromise (ClawHavoc proven)
5. **Running on public interface without token + firewall**

## Security Testing & Benchmarking

### Capability Metrics
- Latency (round-trip response time)
- Throughput (messages/sec per agent under load)
- LLM token usage (cost monitoring)
- Multi-agent concurrency (Gateway serializes per session, agents run parallel across sessions)

### Attack Simulations
- Direct prompt injection (hidden instructions in messages)
- Indirect injection (malicious content from web search, file read)
- Monitor whether prompts trigger unauthorized actions or memory changes
- OWASP GenAI Top 10 as test patterns
- Measure "infection rate" — % of malicious inputs bypassing filters
- Verify sensitive tools (exec, browser) are unreachable to attacker-controlled agent
