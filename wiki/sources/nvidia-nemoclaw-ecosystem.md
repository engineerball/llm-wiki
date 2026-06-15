---
title: "NVIDIA NemoClaw — Ecosystem"
tags: [source, nvidia, nemoclaw, openShell, openclaw, ecosystem, deployment]
sources: [raw/articles/nvidia-nemoclaw-ecosystem.md]
url: https://docs.nvidia.com/nemoclaw/latest/about/ecosystem.html
date: 2026-05-19
---

# NVIDIA NemoClaw — Ecosystem

Official NVIDIA doc describing the three-layer NemoClaw stack, two deployment paths (NemoClaw vs OpenShell-direct), and the value-add NemoClaw provides over a bare community sandbox.

## Key Takeaways

1. **Three-layer stack with clear boundaries.** NemoClaw (orchestration) → OpenShell (isolation + routing) → OpenClaw (agent behavior). Each layer has a distinct responsibility and can be used independently — you can run OpenShell without NemoClaw, and OpenClaw without OpenShell.

2. **Two deployment paths with a deliberate tradeoff.** NemoClaw path = minimum setup, NVIDIA defaults, reference stack. OpenShell-direct path = maximum flexibility, build your own container and policy. The choice is opinionated defaults vs. custom control.

3. **NemoClaw's key value-adds over community sandbox.** Automated credential handling, image hardening (build toolchains removed), targeted filesystem policy, automated inference setup, automated channel messaging, blueprint versioning with digest verification, state migration with credential stripping, enforced process limits (`ulimit -u 512`).

4. **OpenShell-direct is for platform builders.** Teams building internal platform abstractions over OpenShell should skip NemoClaw and use OpenShell APIs directly — NemoClaw's opinionated blueprint would constrain their design space.

## Stack Summary

| Layer | Product | What It Does |
|---|---|---|
| Orchestration | NemoClaw | CLI + Plugin + Blueprint |
| Isolation | OpenShell | Gateway + policy + inference routing |
| Agent | OpenClaw | Tools + memory + assistant behavior |

## Related Wiki Pages

- [[nemoclaw]] — NemoClaw entity page
- [[openshell|OpenShell]] — middle isolation layer
- [[openclaw]] — innermost agent runtime
- [[nvidia-nemoclaw-how-it-works]] — architecture details
- [[nvidia-nemoclaw-overview]] — capabilities and use cases
