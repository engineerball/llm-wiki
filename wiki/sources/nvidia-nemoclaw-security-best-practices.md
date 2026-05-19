---
title: "NVIDIA NemoClaw — Security Best Practices"
tags: [source, nvidia, nemoclaw, security, sandboxing, agent-security, landlock, seccomp]
sources: [raw/articles/nvidia-nemoclaw-security-best-practices.md]
url: https://docs.nvidia.com/nemoclaw/latest/security/best-practices.html
date: 2026-05-19
---

# NVIDIA NemoClaw — Security Best Practices

Official NVIDIA security guidance for NemoClaw. The most detailed of the four NemoClaw docs ingested — covers every layer of the four-layer security model with specific risks, recommendations, posture profiles, common mistakes, and known limitations.

## Key Takeaways

1. **Deny-by-default across four layers.** Network (egress), Filesystem (read-only system paths), Process (capability drops, non-root), Inference (routed through `inference.local`). Weakening any layer has explicit, documented blast-radius implications.

2. **Binary-scoped + path-scoped endpoint rules are the most sophisticated network control.** The system identifies calling executables via `/proc/<pid>/exe` + SHA256 hash, then enforces per-endpoint HTTP method and path restrictions. Hash mismatch = immediate denial. This prevents binary substitution attacks and curl-based exfiltration workarounds.

3. **L4 vs L7 inspection is a key policy decision.** L4-only = check host/port/binary, relay TCP stream without payload inspection. L7 (`protocol: rest`) = terminate TLS, inspect HTTP method and path per request. L4-only cannot prevent an approved endpoint from being misused at the HTTP level. Always use `protocol: rest` for REST APIs.

4. **The gateway user / sandbox user split prevents a specific attack.** If agent and gateway ran as same user, the agent could kill the gateway and restart it with tampered config ("fake-HOME" attack). Separate users block this. Disabled in non-root mode — a documented tradeoff.

5. **Three known limitations with explicit mitigations.** `--local` flag bypasses gateway (avoid in production), direct filesystem writes bypass secret scanner (Landlock limits writable paths), base64/hex-encoded secrets evade content scanning (use env vars or credential stores instead).

6. **Six common mistakes, each with a specific fix.** Most critical: adding inference provider hosts to network policy (bypasses credential isolation — use OpenShell routing instead) and leaving `/sandbox/.openclaw` writable on sensitive workloads (agent can disable CORS or redirect inference).

7. **Three posture profiles: locked-down, development, integration testing.** Locked-down = no presets, operator approval only. Development = `pypi`/`npm` presets with binary restrictions. Integration = custom endpoints with tight path/method, clean policy after test.

## Layer-by-Layer Security Reference

### Network
- Egress deny-by-default
- Binary-scoped rules: `/proc/<pid>/exe` + SHA256
- Path-scoped HTTP rules: method + path per endpoint
- L7 (`protocol: rest`) preferred over L4-only for REST APIs
- Operator approval: session-scoped, resets on sandbox recreation
- Presets: `pypi`, `npm`, `github`, `huggingface`, `discord`, `slack` — each with documented risk

### Filesystem
- Read-only: `/usr`, `/lib`, `/proc`, `/etc`, etc.
- Writable: `/sandbox`, `/tmp` only
- Landlock LSM (`best_effort`): requires kernel 5.13+
- `/sandbox/.openclaw` writable by default — lock for production

### Process
- `capsh` drops: `CAP_SYS_ADMIN`, `CAP_SYS_PTRACE`, `CAP_NET_RAW`, `CAP_DAC_OVERRIDE`, and 7+ others
- Defense-in-depth: `--cap-drop=ALL` at container runtime
- `PR_SET_NO_NEW_PRIVS` flag
- `ulimit -u 512` (increase to 1024 for parallel workloads)
- Separate `gateway` / `sandbox` users
- PATH locked to system paths at startup
- Build toolchains (`gcc`, `netcat`) purged from image
- Image pinned by `@sha256:` digest

### Inference
- Always routed through `inference.local` → OpenShell gateway
- Do not add provider hosts to network policy
- Memory secret scanner: intercepts Write/Edit tool calls before disk
- Provider trust: local Ollama for sensitive workloads

## Related Wiki Pages

- [[agent-sandbox-security]] — concept page synthesizing this doc's four-layer model
- [[nemoclaw]] — entity page
- [[openShell]] — the enforcement runtime
- [[harness-engineering]] — security layers as harness controls
- [[nebius-openclaw-security]] — community hardening guide; compare approaches
- [[nvidia-nemoclaw-how-it-works]] — protection layer architecture
