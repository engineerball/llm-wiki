---
title: "NVIDIA NemoClaw Overview"
tags: [source, nvidia, openclaw, agent-security, sandboxing, inference-routing]
sources: [raw/articles/nvidia-nemoclaw-overview.md]
url: https://docs.nvidia.com/nemoclaw/latest/about/overview.html
date: 2026-05-19
---

# NVIDIA NemoClaw Overview

Official NVIDIA documentation introducing NemoClaw — an open-source reference stack for deploying [[openclaw]] always-on assistants safely inside hardened OpenShell containers.

## Key Takeaways

1. **NemoClaw = OpenClaw + security wrapper.** NemoClaw is not a new agent system — it's a hardening layer around OpenClaw. It standardizes the deployment pattern via CLI tooling, a hardened Dockerfile blueprint, and declarative YAML policies.

2. **Three-primitive isolation model.** Agents are isolated with Landlock (filesystem allow-listing), seccomp (syscall filtering), and network namespaces — all Linux kernel mechanisms, no additional runtime required.

3. **Credential separation via inference routing.** The agent sees only `inference.local`; real provider credentials (OpenAI, Anthropic, Gemini, etc.) never leave the host. NemoClaw proxies inference requests transparently.

4. **Declarative egress policies.** Network access for agents is defined in YAML, not code. Hot-reload means policy changes take effect without container restart.

5. **Blueprint lifecycle management.** Digest verification and versioning prevent supply-chain drift — the running container is guaranteed to match the pinned blueprint.

6. **Alpha warning.** As of 2026-05-19, NemoClaw is alpha. APIs unstable. Not production-ready.

## Architecture Summary

```
Host (credentials live here)
  └── NemoClaw CLI
        └── OpenShell container (hardened sandbox)
              └── OpenClaw agent
                    └── inference.local → NemoClaw proxy → actual provider
```

Agents are isolated at the filesystem, network, and syscall level. Egress is policy-driven. Inference is transparently routed with no credential exposure inside the container.

## Supported Inference Providers

NVIDIA Endpoints, OpenAI, Anthropic, Gemini, Ollama, vLLM

## Supported Messaging Channels

Telegram, Discord, Slack (via OpenShell integrations)

## Relationship to Existing Wiki Content

- [[openclaw]] — NemoClaw is the official NVIDIA deployment wrapper for OpenClaw
- [[nebius-openclaw-security]] — Nebius security hardening guide covers similar isolation goals but from a community perspective; NemoClaw is the official NVIDIA reference stack
- [[llm-gateway]] — NemoClaw's inference routing function is structurally similar to an LLM gateway (credential isolation, provider abstraction)
- [[harness-engineering]] — Landlock + seccomp + network namespaces are OS-level harness controls; NemoClaw makes these declarative and reproducible
- [[nemoclaw]] — Entity page
