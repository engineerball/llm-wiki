---
title: "NemoClaw"
tags: [entity, tool, nvidia, openclaw, agent-security, sandboxing, inference-routing, open-source]
type: tool
date: 2026-05-19
---

# NemoClaw

NVIDIA's open-source reference stack for deploying [[openclaw]] always-on assistants inside hardened [[OpenShell]] containers. Not a new agent system — a security and deployment wrapper that standardizes how OpenClaw is run safely.

## Role

NemoClaw sits between the host environment and the OpenClaw agent process. It provides:

- A **hardened Dockerfile blueprint** (capability drops, least-privilege rules)
- A **CLI** (`nemoclaw`) for onboarding, lifecycle management, and policy control
- **Inference routing** — agents call `inference.local`; credentials never enter the container
- **Declarative egress policies** in YAML with hot-reload
- **Blueprint lifecycle management** with digest verification

## Isolation Model

Three Linux kernel primitives used in layers:

| Primitive | What it controls |
|---|---|
| **Landlock** | Filesystem access — allow-list at kernel level |
| **seccomp** | System call filtering — blocks unnecessary syscalls |
| **Network namespaces** | Agent sees only a virtual network; real egress defined in YAML |

## Inference Routing

Agents inside the sandbox call `inference.local`. NemoClaw proxies the request to the configured provider:

- NVIDIA Endpoints
- OpenAI, Anthropic, Gemini
- Ollama, vLLM (local)

Credentials remain on the host; the container never sees them.

## Deployment Context

- Clouds (multi-cloud)
- On-premises systems
- RTX PCs
- DGX Spark environments

## Status

Alpha as of 2026-05-19. APIs and behavior may change without notice. Not for production use.

## Relationship to OpenClaw

[[openclaw]] is the agent gateway. NemoClaw is the NVIDIA-sanctioned way to deploy it securely. The Nebius security guide ([[nebius-openclaw-security]]) covers similar hardening but from a community perspective.

## Related Pages

- [[openclaw]] — the agent gateway NemoClaw wraps
- [[nvidia-nemoclaw-overview]] — official NVIDIA overview doc (source)
- [[nebius-openclaw-security]] — community-authored security hardening guide for OpenClaw
- [[llm-gateway]] — NemoClaw's inference routing is structurally analogous
- [[harness-engineering]] — OS-level isolation as a harness control pattern
