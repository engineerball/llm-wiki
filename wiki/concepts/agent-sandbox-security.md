---
title: "Agent Sandbox Security"
tags: [concept, security, sandboxing, agent-security, landlock, seccomp, inference-routing, nvidia]
date: 2026-05-19
sources: [nvidia-nemoclaw-security-best-practices, nebius-openclaw-security, running-openclaw-safely]
---

# Agent Sandbox Security

Security model for running AI agents in isolated sandbox environments. Synthesizes the [[nemoclaw]] / [[openShell]] approach (official NVIDIA reference) with community hardening guides ([[nebius-openclaw-security]], [[running-openclaw-safely]]).

The core principle: **agents are untrusted code execution with persistent credentials**. The sandbox is not about trusting the agent — it's about limiting blast radius when the agent misbehaves, gets manipulated via prompt injection, or is used in ways outside its original design.

## Four-Layer Model (NemoClaw)

All four layers operate deny-by-default:

| Layer | Mechanism | Reload |
|---|---|---|
| **Network** | Egress allowlist; binary-scoped + path-scoped rules | Hot-reloadable |
| **Filesystem** | Read-only system mounts; Landlock LSM; writable `/sandbox` + `/tmp` only | Fixed at creation |
| **Process** | Capability drops; `PR_SET_NO_NEW_PRIVS`; non-root users; process limits | Fixed at creation |
| **Inference** | All calls routed through `inference.local`; credentials never enter sandbox | Hot-reloadable |

## Network Layer (Most Nuanced)

### Egress: deny-by-default
Every outbound connection denied unless explicitly listed in policy. Each permitted endpoint is a potential exfiltration vector.

### Binary-scoped rules
The system identifies calling executables via `/proc/<pid>/exe` and SHA256 hash. An approved endpoint for `python3` does not grant access to `curl`. Binary replacement at runtime triggers immediate denial.

### L4 vs L7 inspection
- **L4-only**: checks host, port, binary identity; relays TCP stream without payload inspection. Cannot prevent method/path abuse.
- **L7** (`protocol: rest`): terminates TLS, inspects HTTP method and path per request. Required for REST APIs.

### Operator approval
Blocked requests surface for real-time decision. Approved endpoints are session-scoped — reset on sandbox recreation. Use this for one-off requests; add recurring endpoints to baseline with restrictions.

## Filesystem Layer

- System paths (`/usr`, `/lib`, `/etc`, etc.) — read-only via container mounts
- **Landlock LSM** — kernel-level filesystem access control (allow-list at kernel level, requires kernel 5.13+); `best_effort` mode on older kernels
- Writable: `/sandbox`, `/tmp` only
- **Critical**: agent config dir (`/sandbox/.openclaw`) writable by default. A compromised agent can disable CORS or redirect inference. Lock for production.

## Process Layer

**Capability drops** remove dangerous Linux capabilities from the container:
- `CAP_SYS_ADMIN` — broad kernel access
- `CAP_SYS_PTRACE` — process inspection and control
- `CAP_NET_RAW` — network sniffing
- `CAP_DAC_OVERRIDE` — bypass filesystem permissions
- + 7 others

**Defense-in-depth**: entrypoint uses `capsh` (best-effort). Always pass `--cap-drop=ALL` at container runtime as defense-in-depth.

**User separation**: gateway runs as `gateway` user, agent as `sandbox` user. Prevents the fake-HOME attack (agent kills gateway, restarts with tampered config).

**Build toolchain removal**: `gcc`, `netcat` and related tools purged from runtime image. Prevents in-container compilation of exploits and bypass of HTTP-level policy via raw TCP.

**Image digest pinning**: reference images by `@sha256:` digest, not mutable `:latest` tag. Prevents supply-chain replacement.

## Inference Layer

- All model API calls intercepted by gateway; agent calls `inference.local` only
- Provider credentials (OpenAI, Anthropic, Gemini, etc.) live on host, never in container
- **Do not** add provider hosts to network policy — that routes credentials into sandbox
- Memory secret scanner intercepts Write/Edit tool calls before disk; blocks API keys, bearer tokens, private keys

## Posture Profiles

**Locked-down** (always-on production):
- No presets loaded
- Operator approval for all non-baseline endpoints
- Local Ollama or NVIDIA Endpoints for inference

**Development**:
- `pypi`/`npm` presets with binary restrictions
- Periodic review of network activity

**Integration testing**:
- Custom endpoints: tight path/method restrictions, `protocol: rest`
- Clean baseline policy after tests complete

## Common Mistakes

| Mistake | Risk | Fix |
|---|---|---|
| Omitting `protocol: rest` | L4-only cannot filter HTTP requests | Add `protocol: rest` with explicit rules |
| Baseline for one-off endpoints | Permanently reachable across instances | Use operator approval |
| Entrypoint capability drops only | `capsh` may be absent | `--cap-drop=ALL` at container runtime |
| Writable `.openclaw` in production | Agent can redirect inference | Lock config for sensitive workloads |
| Provider hosts in network policy | Bypasses credential isolation | Use OpenShell inference routing |
| Disabling device auth for remote | Unauthenticated dashboard access | Keep enabled; disable only local headless |

## Known Limitations

| Limitation | Mitigation |
|---|---|
| `--local` flag bypasses gateway entirely | Avoid in production |
| Direct filesystem writes bypass secret scanner | Landlock limits writable paths |
| Encoded secrets (base64/hex) evade content scanner | Use env vars or credential stores |

## Comparison: NemoClaw vs Community Hardening

[[nebius-openclaw-security]] (Nebius community guide) and [[running-openclaw-safely]] (Microsoft analysis) cover similar ground from the operator perspective — per-agent tool allowlists, sandboxing levels (Off/Non-main/All), memory poisoning via MEMORY.md. NemoClaw's NVIDIA docs are more precise at the OS-primitive level: binary-scoped rules, specific capabilities dropped, L4/L7 distinction.

Both sources agree: treat agents as untrusted code execution with persistent credentials. NemoClaw codifies this into reproducible defaults; the community guides show what happens when you don't.

## Related Pages

- [[nemoclaw]] — reference implementation of this security model
- [[openShell]] — enforcement runtime
- [[openclaw]] — agent runtime being sandboxed
- [[harness-engineering]] — sandboxing as a harness control pattern
- [[nebius-openclaw-security]] — community hardening guide
- [[running-openclaw-safely]] — Microsoft analysis
- [[nvidia-nemoclaw-security-best-practices]] — primary source
