# NVIDIA NemoClaw — Overview

**Source:** https://docs.nvidia.com/nemoclaw/latest/about/overview.html
**Fetched:** 2026-05-19
**Status:** Alpha (do not use in production)

---

## About

NVIDIA NemoClaw is an open-source reference stack that simplifies running OpenClaw always-on assistants more safely. It provides onboarding, lifecycle management, and OpenClaw operations within OpenShell containers. Combines policy-based privacy controls with security guardrails to regulate agent behavior and data handling across clouds, on-premises, RTX PCs, and DGX Spark environments.

## Core Architecture

NemoClaw pairs hosted models from inference providers (or local endpoints) with:
- A hardened sandbox environment
- Routed inference capabilities
- Declarative egress policies

The sandbox runtime derives from NVIDIA OpenShell. NemoClaw provides the blueprint, CLI tooling, and onboarding workflow as the standard approach for deploying OpenClaw.

## Key Capabilities

| Capability | Function |
|---|---|
| Sandbox OpenClaw | Pre-configured OpenShell sandbox with filesystem and network policies applied at startup |
| Route inference | Directs agent traffic to selected providers; agents use `inference.local` internally while credentials remain on the host |
| Manage lifecycle | Blueprint versioning, digest verification, sandbox initialization |

## Core Features

- **Guided onboarding**: Credential validation and provider selection in a single command
- **Hardened blueprint**: Security-focused Dockerfile with capability drops and least-privilege rules
- **State management**: Secure agent migration with credential stripping and integrity checks
- **Messaging channels**: Integration with Telegram, Discord, Slack via OpenShell
- **Routed inference**: NVIDIA Endpoints, OpenAI, Anthropic, Gemini, Ollama, vLLM
- **Layered protection**: Network, filesystem, process, and inference controls with hot-reload capability

## Isolation Primitives

- **Landlock** — Linux filesystem access control (allow-list at kernel level)
- **seccomp** — System call filtering (blocks unnecessary syscalls)
- **Network namespaces** — Agent sees only a virtual network; egress defined declaratively in YAML

## Use Cases

- Running always-on assistants with controlled network access
- Testing agent behavior in restricted environments before broader deployment
- Deploying sandboxed agents to remote GPU instances

## Alpha Warning

> NVIDIA NemoClaw is alpha software. APIs and behavior may change without notice. Do not use in production.
