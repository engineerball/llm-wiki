---
title: "OpenShell"
tags: [entity, tool, nvidia, sandboxing, inference-routing, policy-enforcement, open-source]
type: tool
date: 2026-05-19
---

# OpenShell

NVIDIA's sandbox execution environment and gateway runtime. Middle layer in the [[nemoclaw]] stack. Provides lifecycle management, policy enforcement (network, filesystem, process), and inference routing for containerized [[openclaw]] agents.

## Role in the Stack

```
NemoClaw (orchestration)
  └── OpenShell (isolation + enforcement)
        └── OpenClaw (agent behavior)
```

NemoClaw drives OpenShell via CLI APIs. OpenShell is what actually enforces security policy at runtime — NemoClaw is the blueprint and orchestration layer on top of it.

## Core Functions

- **Sandbox lifecycle** — create, start, stop, migrate sandbox instances
- **Network policy enforcement** — egress deny-by-default; binary-scoped + path-scoped rules; L4/L7 inspection
- **Filesystem enforcement** — Landlock LSM; read-only system mounts; writable `/sandbox`, `/tmp`
- **Process isolation** — capability drops, `PR_SET_NO_NEW_PRIVS`, user separation (gateway/sandbox)
- **Inference routing** — intercepts all `inference.local` calls; routes to configured provider; credentials stay on host
- **Operator approval TUI** — blocks unlisted egress, surfaces for real-time operator decision
- **Policy hot-reload** — network and inference controls updatable without restart

## Direct vs. NemoClaw-Mediated Deployment

OpenShell can be used directly (without NemoClaw) for teams building custom platform abstractions. The NemoClaw path adds opinionated defaults (hardened image, blueprint versioning, automated credential handling) on top.

| | OpenShell-direct | Via NemoClaw |
|---|---|---|
| Image | Custom | Hardened blueprint (toolchains removed) |
| Policy | Manual YAML | NemoClaw blueprint defaults |
| Credentials | Manual | Automated onboarding |
| Versioning | None | Digest-verified blueprints |
| Setup | Custom | `nemoclaw onboard` |

## Related Pages

- [[nemoclaw]] — orchestration layer that drives OpenShell
- [[openclaw]] — agent runtime running inside OpenShell containers
- [[nvidia-nemoclaw-how-it-works]] — full architecture with OpenShell gateway detail
- [[nvidia-nemoclaw-ecosystem]] — deployment path comparison
- [[agent-sandbox-security]] — four-layer security model OpenShell enforces
