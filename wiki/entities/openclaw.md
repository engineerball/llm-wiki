---
title: "OpenClaw"
tags: [entity, tool, agent-gateway, open-source]
type: tool
date: 2026-05-05
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

## Related Pages

- [[nebius-openclaw-security]] — security hardening guide
- [[llm-gateway]] — class of software OpenClaw belongs to
- [[agentic-protocol-stack]] — OpenClaw implements the gateway/orchestration layer
