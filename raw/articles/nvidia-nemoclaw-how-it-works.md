# NVIDIA NemoClaw — How It Works

**Source:** https://docs.nvidia.com/nemoclaw/latest/about/how-it-works.html
**Fetched:** 2026-05-19

---

## High-Level Flow

NemoClaw operates through a layered architecture. A gateway component mediates between NemoClaw control, the sandbox environment, inference providers, and external integrations.

| Component | Function |
|---|---|
| Users and operators | Initiate workflows via CLI, installer, dashboard, or user channels |
| NemoClaw control | Manages configuration, onboarding, blueprint preparation, and OpenShell resource creation |
| OpenShell gateway | Oversees sandbox lifecycle, networking, policy enforcement, inference routing, and integration access |
| NemoClaw sandbox | Runs OpenClaw with the NemoClaw plugin, blueprint contents, and supporting tools |
| Inference providers | Processes model requests through the gateway using NVIDIA endpoints, NIM, or compatible APIs |
| Integrations | Enables access to messaging services, MCP servers, GitHub, package indexes, and model hubs |
| State and artifacts | Stores configuration, credentials, logs, workspace files, policies, and transcripts outside the agent process |

## Design Principles

1. **Thin plugin, versioned blueprint** — Sandbox plugin remains minimal; host orchestration uses versioned blueprints with independent release cycles
2. **Respect CLI boundaries** — `nemoclaw` CLI is the primary interface for sandbox operations
3. **Supply chain safety** — Blueprint artifacts are immutable, versioned, and digest-verified before use
4. **OpenShell-backed lifecycle** — NemoClaw orchestrates OpenShell resources; `nemoclaw onboard` is the supported entry point
5. **Reproducible setup** — Running setup recreates the sandbox from identical blueprint and policy definitions

## Three Integration Components

**Host CLI**
- Runs onboarding and provider validation
- Stores configuration data
- Executes OpenShell commands for gateway, provider, sandbox, and policy operations

**Plugin** (TypeScript, runs inside sandbox)
- Registers inference provider metadata and `/nemoclaw` slash command
- Implements runtime context hooks

**Blueprint** (versioned YAML)
- Contains sandbox image, policy, inference profile, and supporting assets
- Runner resolves, verifies, and applies through OpenShell

## Sandbox Creation Workflow (`nemoclaw onboard`)

1. **Resolution and verification** — Blueprint resolved, version compatibility checked, digest verified
2. **Resource determination** — Identifies which OpenShell resources require creation or updates (gateway, inference providers, sandbox, network policy)
3. **OpenShell CLI execution** — Runner calls OpenShell CLI commands to create sandbox and configure each resource

## Inference Routing

- Agent calls `inference.local` inside sandbox
- OpenShell gateway intercepts every inference call, routes to configured provider
- Host maintains actual provider credentials and upstream endpoints
- When Model Router is selected, `inference.local` routes to a host-side router that selects from configured NVIDIA model pool per request

## Protection Layers

| Layer | Protection | Reload |
|---|---|---|
| Network | Blocks unauthorized outbound connections | Hot-reloadable |
| Filesystem | System paths read-only; `/sandbox` and `/tmp` writable | Fixed at creation |
| Process | Prevents privilege escalation and dangerous syscalls | Fixed at creation |
| Inference | Reroutes model API calls to controlled backends | Hot-reloadable |

When agent reaches unlisted host, OpenShell blocks and surfaces it in TUI for operator approval. Approved endpoints persist for current session only.
