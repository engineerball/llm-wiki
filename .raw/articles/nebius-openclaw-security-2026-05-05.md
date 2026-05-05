---
title: "OpenClaw Security: Architecture and Hardening Guide"
source: https://nebius.com/blog/posts/openclaw-security
date: 2026-05-05
author: Nebius
---

# OpenClaw Security: Architecture and Hardening Guide

OpenClaw is a self-hosted gateway that manages AI agents across messaging platforms (WhatsApp, Slack, Discord, etc.). Because it runs on your own infrastructure and handles persistent credentials and third-party code (skills), it must be treated as a critical security boundary.

## 1. Core Architecture & Security Boundaries

OpenClaw operates as a single **Gateway** process that orchestrates clients, nodes, and tools.

*   **Gateway WebSocket API:** All components connect via a single port (default `18789`). Connections must identify their role (operator, node, etc.) and provide an authentication token.
*   **State Management:** Configuration and session history are stored locally in `~/.openclaw`. This directory contains sensitive data, including credentials and memory snapshots.
*   **Trust Model:** Unlike SaaS platforms, OpenClaw inherits the trust of its host machine. Installing a "ClawHub skill" is equivalent to running third-party code on your host.

## 2. Sandboxing and Tool Policies

OpenClaw manages tool execution through a tiered sandboxing system:

*   **Sandbox Modes:**
    *   `Off`: No isolation.
    *   `Non-main` (Default): Secondary threads/group chats are containerized; primary sessions remain on the host.
    *   `All`: Every tool call runs in a Docker/Podman container.
*   **Elevated Mode:** Specific tools can be flagged to run on the host even when sandboxing is active (e.g., for shell commands requiring direct hardware access).
*   **Allowlists:** Tool availability is governed by an explicit allowlist (`tools.allow`). Deny rules always take precedence over allow rules.

## 3. Skill Security (ClawHub)

Skills are bundles of code and metadata that extend agent capabilities.
*   **Supply Chain Risk:** The "ClawHavoc" campaign (Jan 2026) demonstrated that malicious skills can harvest API keys, inject keyloggers, and manipulate agent memory (`MEMORY.md`).
*   **Hardening:** Treat unverified skills as untrusted code. Audit skill source code before installation and run them with minimal permissions.

## 4. Memory Subsystem

OpenClaw uses a transparent, file-based memory system.
*   **Storage:** Memory is stored as Markdown files (`memory/YYYY-MM-DD.md` and `MEMORY.md`).
*   **RAG Pipeline:** A background indexer creates a local SQLite FTS + vector store for semantic search.
*   **Security Implication:** Because memory is plain text, prompt injection attacks can "poison" the agent's long-term knowledge by writing malicious instructions into these files.

## 5. Hardening Checklist & Best Practices

### Network Security
*   **Bind to Loopback:** Keep `gateway.bind` set to `loopback` (127.0.0.1).
*   **Remote Access:** Use SSH tunneling or an identity-aware VPN (like Tailscale) instead of exposing the port to the LAN/Internet.
*   **Auth Tokens:** Always use a strong `gateway.auth.token`. Non-loopback binds require token auth by default.

### Access Control
*   **DM Policies:** Use `dmPolicy: "pairing"` (requires a one-time code) or an explicit allowlist. Avoid `dmPolicy: "open"`.
*   **Least Privilege:** Only grant agents the specific tools they need (e.g., a RAG agent should not have `exec` permissions).

### Operational Security
*   **Audit Tools:** Regularly run `openclaw security audit` to check for misconfigurations.
*   **Health Checks:** Use `openclaw doctor` to verify system integrity and repair known issues.
*   **File Permissions:** Ensure the `~/.openclaw` directory has `700` permissions (restricted to the OpenClaw user).

## 6. Production Deployment Patterns

*   **Split Compute:** Run the Gateway on a lightweight CPU node while offloading LLM inference and embeddings to dedicated GPU clusters or external APIs.
*   **Isolation:** Run the Gateway as a non-root user. In multi-agent environments, consider separate OS users or containers for each agent to prevent cross-session memory access.
*   **Secret Management:** Use OpenClaw’s built-in secret store or external vaults. Never store plaintext secrets in `AGENTS.md` or `SOUL.md`.
