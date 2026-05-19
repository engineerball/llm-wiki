---
title: "NemoClaw"
tags: [entity, tool, nvidia, openclaw, openShell, agent-security, sandboxing, inference-routing, open-source]
type: tool
date: 2026-05-19
updated: 2026-05-19
---

# NemoClaw

NVIDIA's open-source reference stack for deploying [[openclaw]] always-on assistants inside hardened [[openShell]] containers. Not a new agent system — the orchestration and blueprint layer that standardizes how OpenClaw is deployed safely.

## Stack Position

```
NemoClaw (orchestration: CLI + Plugin + Blueprint)
  └── OpenShell (isolation: gateway + policy enforcement)
        └── OpenClaw (agent: tools + memory + behavior)
```

NemoClaw drives [[openShell]] APIs. OpenShell does the actual enforcement. OpenClaw runs inside with no direct access to host credentials or network.

## Three Integration Components

| Component | Where it runs | Function |
|---|---|---|
| **CLI** (`nemoclaw`) | Host | Onboarding, provider validation, config storage, OpenShell command execution |
| **Plugin** (TypeScript) | Inside sandbox | Registers inference provider metadata, `/nemoclaw` slash command, runtime context hooks |
| **Blueprint** (versioned YAML) | Resolved at setup | Sandbox image + policy + inference profile + supporting assets; digest-verified |

The thin-plugin design keeps the sandbox contract stable while blueprints evolve independently.

## Design Principles

1. **Thin plugin, versioned blueprint** — plugin stays minimal; blueprints have independent release cycles
2. **Respect CLI boundaries** — `nemoclaw` CLI is the primary interface for all sandbox operations
3. **Supply chain safety** — blueprint artifacts immutable, versioned, digest-verified before use
4. **OpenShell-backed lifecycle** — NemoClaw orchestrates OpenShell; `nemoclaw onboard` is the entry point
5. **Reproducible setup** — recreates sandbox from identical blueprint and policy definitions

## Sandbox Creation Workflow (`nemoclaw onboard`)

1. **Resolution + verification** — blueprint resolved, version compatibility checked, SHA256 digest verified
2. **Resource determination** — identifies which OpenShell resources to create/update (gateway, inference providers, sandbox, network policy)
3. **OpenShell CLI execution** — creates sandbox and configures each resource

## Four-Layer Security Model

| Layer | Mechanism | Reload |
|---|---|---|
| **Network** | Egress deny-by-default; binary-scoped + path-scoped rules; L4/L7 inspection | Hot-reloadable |
| **Filesystem** | Read-only system mounts; Landlock LSM; `/sandbox` + `/tmp` writable only | Fixed at creation |
| **Process** | Capability drops (`CAP_SYS_ADMIN`, `CAP_NET_RAW`, etc.); `PR_SET_NO_NEW_PRIVS`; user separation | Fixed at creation |
| **Inference** | All calls routed through `inference.local`; credentials never in container | Hot-reloadable |

See [[agent-sandbox-security]] for full detail, common mistakes, and posture profiles.

## Inference Routing

Agents call `inference.local`. [[openShell]] gateway intercepts, routes to configured provider. Credentials stay on host.

Supported providers: NVIDIA Endpoints, OpenAI, Anthropic, Gemini, Ollama, vLLM (experimental).

## NemoClaw vs OpenShell-Direct

**Use NemoClaw** for OpenClaw with minimal setup and NVIDIA defaults (always-on assistants, reference stack).

**Use OpenShell directly** for custom images, divergent workload layouts, or building internal platform abstractions on top of OpenShell.

## Deployment Context

- Clouds (multi-cloud)
- On-premises systems
- RTX PCs
- DGX Spark environments

## Status

Alpha as of 2026-05-19. APIs and behavior may change without notice. Not for production use.

## Related Pages

- [[openShell]] — the execution environment NemoClaw orchestrates
- [[openclaw]] — the agent runtime running inside the sandbox
- [[agent-sandbox-security]] — four-layer security model detail
- [[nvidia-nemoclaw-overview]] — overview doc (source)
- [[nvidia-nemoclaw-how-it-works]] — architecture doc (source)
- [[nvidia-nemoclaw-ecosystem]] — ecosystem/deployment paths doc (source)
- [[nvidia-nemoclaw-security-best-practices]] — security best practices (source)
- [[nebius-openclaw-security]] — community hardening guide (compare)
- [[llm-gateway]] — inference routing is structurally analogous
- [[harness-engineering]] — OS-level isolation as harness control
