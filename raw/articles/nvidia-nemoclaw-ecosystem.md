# NVIDIA NemoClaw — Ecosystem

**Source:** https://docs.nvidia.com/nemoclaw/latest/about/ecosystem.html
**Fetched:** 2026-05-19

---

## Three-Layer Stack

| Layer | Component | Role |
|---|---|---|
| Top | NemoClaw | CLI, plugin, blueprint orchestration |
| Middle | OpenShell | Gateway, policy enforcement, inference routing |
| Inner | OpenClaw | Assistant runtime — tools, memory, behavior |

## Two Deployment Paths

**NemoClaw path:**
- Adopts reference stack with hardened image defaults
- `nemoclaw onboard` for automated setup
- Includes versioned blueprint verification

**OpenShell path (direct):**
- Custom container, manual installation, custom policy config
- No dependency on NemoClaw blueprint or CLI
- Maximum flexibility for custom images and divergent workload layouts

## NemoClaw vs Community Sandbox

| Feature | Community Sandbox | NemoClaw |
|---|---|---|
| Credential Handling | Manual provider creation | Automatic during onboarding |
| Image Hardening | Standard tools included | Build toolchains and network probes removed |
| Filesystem Policy | Generic OpenClaw policy | Targeted read-only/read-write layout |
| Inference Setup | Manual configuration | Automated provider selection and routing |
| Channel Messaging | Manual provider setup | Automated bot token registration |
| Blueprint Versioning | N/A | Version checking and digest verification |
| State Migration | Not included | Supported with credential stripping |
| Process Limits | Manual configuration | Enforced via `ulimit -u 512` |

## When to Choose

**Use NemoClaw when:**
- Wanting OpenClaw with minimal assembly and NVIDIA defaults
- Standardizing on reference stack for always-on assistants

**Use OpenShell directly when:**
- Maximum flexibility needed for custom images
- Workload layout diverges from NemoClaw blueprint
- Building internal platform abstractions
