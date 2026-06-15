---
title: "NVIDIA NemoClaw — How It Works"
tags: [source, nvidia, nemoclaw, openShell, architecture, inference-routing, sandboxing]
sources: [raw/articles/nvidia-nemoclaw-how-it-works.md]
url: https://docs.nvidia.com/nemoclaw/latest/about/how-it-works.html
date: 2026-05-19
---

# NVIDIA NemoClaw — How It Works

Official NVIDIA architecture doc for NemoClaw. Describes the gateway-mediated layered architecture, three integration components (CLI / Plugin / Blueprint), sandbox creation workflow, inference routing mechanism, and the four protection layers.

## Key Takeaways

1. **Seven-component architecture with a central gateway.** NemoClaw control prepares configuration; the [[openshell|OpenShell]] gateway is the policy enforcer between the sandbox, inference providers, and external integrations. State and artifacts (credentials, logs, workspace) live entirely outside the agent process.

2. **Three integration components with independent release cycles.** CLI (host-side orchestration), Plugin (thin TypeScript inside sandbox — registers slash commands and context hooks), Blueprint (versioned YAML with image + policy + inference profile). The thin-plugin design means the sandbox contract stays stable while blueprints evolve.

3. **`nemoclaw onboard` does three things in sequence.** Blueprint resolution + digest verification → resource determination (what OpenShell resources to create/update) → OpenShell CLI execution (creates gateway, inference provider, sandbox, network policy).

4. **Inference routing is a transparency layer, not a proxy.** The agent calls `inference.local`; OpenShell intercepts at the gateway level and routes upstream. Credentials stay on host. The Model Router variant adds per-request model selection from the NVIDIA pool.

5. **Two layers are hot-reloadable, two are fixed.** Network and inference controls can be updated at runtime without restart. Filesystem and process controls are baked in at sandbox creation — changing them requires a rebuild.

6. **Operator approval creates session-scoped exceptions.** When an unlisted endpoint is blocked and operator approves it, it persists within that sandbox instance only — resets on recreation. Not a permanent policy change.

## Architecture Diagram (textual)

```
Users/Operators
  └── nemoclaw CLI
        └── NemoClaw control (config, onboarding, blueprint prep)
              └── OpenShell gateway (lifecycle, network, filesystem, process, inference)
                    ├── NemoClaw sandbox → OpenClaw + Plugin + Blueprint contents
                    ├── Inference providers (via inference.local routing)
                    └── Integrations (messaging, MCP, GitHub, package indexes)
```

## Related Wiki Pages

- [[nemoclaw]] — entity page (expanded with architecture details)
- [[openshell|OpenShell]] — the execution environment NemoClaw orchestrates
- [[openclaw]] — the agent runtime running inside the sandbox
- [[llm-gateway]] — inference routing is structurally analogous
- [[harness-engineering]] — protection layers as harness controls
- [[nvidia-nemoclaw-overview]] — companion overview doc
- [[nvidia-nemoclaw-ecosystem]] — companion ecosystem doc
- [[nvidia-nemoclaw-security-best-practices]] — security layer details
