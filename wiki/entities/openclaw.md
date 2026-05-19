---
title: "OpenClaw"
tags: [entity, tool, agent-gateway, open-source, multi-user]
type: tool
date: 2026-05-05
updated: 2026-05-08
---

# OpenClaw

An open-source, self-hosted AI agent gateway designed to manage agents across multiple messaging platforms (WhatsApp, Slack, Discord, etc.).

## Overview

OpenClaw acts as an orchestration layer between users, specialized AI agents, and their toolsets. It prioritizes data sovereignty and transparency by running on user-owned infrastructure and using human-readable, file-based memory systems.

## Key Features

- **Multi-Platform Support**: Connects agents to various messaging clients.
- **Skill System (ClawHub)**: Modular architecture for extending agent capabilities through "skills."
- **Transparent Memory**: Uses plain-text Markdown files (`MEMORY.md`) for long-term agent memory.
- **Tiered Sandboxing**: Provides configurable isolation for tool execution (Off, Non-main, All).
- **Security Audit Tools**: Built-in commands (`openclaw security audit`, `openclaw doctor`) for system hardening.

## Security Architecture

OpenClaw is designed as a single gateway process with a WebSocket API. Its security model is based on:
- Token-based authentication for all component connections.
- Explicit tool allowlists.
- Pairing-based access control for direct messages.
- Containerized tool execution via Docker/Podman.

Recent security analysis by [[microsoft]] highlights that OpenClaw should be treated as **untrusted code execution with persistent credentials** and recommends strict isolation in dedicated VMs or separate physical devices ([[running-openclaw-safely]]).

## Multi-User & Team Deployment

- Multiple agents under `agents.list`, each with own workspace, tool policy, model
- Gateway on private-cloud VM behind VPN, binding to private interface
- Skills centrally managed via `clawhub` CLI; agents auto-load from shared workspace
- **Sandboxing must be on** (`non-main` or `all`) for public-facing agents
- Partition **RAG agents** (search + read only) from **messaging agents** (broader permissions, tighter Docker scope)
- Each agent carries its own tool policy — least privilege per role

## Anti-Patterns to Avoid

1. Binding Gateway to `0.0.0.0` on untrusted network — direct attack vector
2. `dmPolicy: "open"` — anyone can message the bot
3. Full tool access for all agents — breaks least privilege
4. Installing unaudited ClawHub skills — supply-chain compromise
5. Running on public interface without token + firewall

## Related Pages

- [[nemoclaw]] — NVIDIA's official reference stack for deploying OpenClaw safely (hardened blueprint, inference routing, OS-level isolation)
- [[nebius-openclaw-security]] — comprehensive security hardening guide (Nebius)
- [[running-openclaw-safely]] — Microsoft security analysis (2026)
- [[llm-gateway]] — class of software OpenClaw belongs to
- [[agentic-protocol-stack]] — OpenClaw implements the gateway/orchestration layer
- [[harness-engineering]] — sandboxing and tool policies as harness controls
