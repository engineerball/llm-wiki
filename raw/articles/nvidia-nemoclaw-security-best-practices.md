# NVIDIA NemoClaw — Security Best Practices

**Source:** https://docs.nvidia.com/nemoclaw/latest/security/best-practices.html
**Fetched:** 2026-05-19

---

## Four-Layer Security Model

Deny-by-default across four layers:

1. **Network** — egress controls, binary-scoped endpoint rules, L7 inspection
2. **Filesystem** — read-only system paths, Landlock LSM
3. **Process** — capability drops, no-new-privileges, process limits, non-root users
4. **Inference** — routed via `inference.local`, credentials never inside sandbox

Layers 1 and 4 support hot-reload. Layers 2 and 3 are fixed at sandbox creation.

---

## Network Controls

### Egress: deny-by-default
All egress denied. Only endpoints in baseline policy receive traffic.

### Binary-scoped rules
Identifies calling executable via `/proc/<pid>/exe`, computes SHA256 hash. Hash mismatch → immediate denial if binary replaced at runtime.

### Path-scoped HTTP rules
Restricts allowed HTTP methods and URL paths per endpoint. Example: GET-only for read endpoints, explicit write methods only when needed.

### L4 vs L7
- **L4-only** (no `protocol` field): checks host, port, binary identity; relays TCP stream without payload inspection
- **L7** (`protocol: rest`): auto-detects/terminates TLS; evaluates HTTP method and path per-request

Recommendation: use `protocol: rest` with specific `rules` for REST APIs.

### Operator approval flow
Blocked requests surface in TUI. Approved endpoints persist within sandbox instance only; reset on sandbox recreation.

### Policy presets

| Preset | Key Risk |
|---|---|
| `pypi` / `npm` | Installing arbitrary packages with potential malicious code |
| `github` | Read/write repository and issue access |
| `huggingface` | Downloading arbitrary models and datasets |
| `local-inference` | Host-side local inference port access |
| `discord` / `slack` | WebSocket with full access; CDN allows GET to any path |

---

## Filesystem Controls

- `/usr`, `/lib`, `/proc`, `/dev/urandom`, `/app`, `/etc`, `/var/log` — read-only
- `/sandbox`, `/tmp`, `/dev/null` — writable
- Landlock LSM: `compatibility: best_effort` (requires kernel 5.13+; Ubuntu 22.04 LTS)

**Agent config dir** (`/sandbox/.openclaw`): writable by default. For always-on assistants with sensitive workloads, lock config after setup — writable config allows agent to disable CORS or redirect inference.

---

## Process Controls

**Capability drops** (via `capsh`): `CAP_SYS_ADMIN`, `CAP_SYS_PTRACE`, `CAP_NET_RAW`, `CAP_DAC_OVERRIDE`, `CAP_SYS_CHROOT`, `CAP_FSETID`, `CAP_SETFCAP`, `CAP_MKNOD`, `CAP_AUDIT_WRITE`, `CAP_NET_BIND_SERVICE`, and others.

**Defense-in-depth**: pass `--cap-drop=ALL --cap-add=NET_BIND_SERVICE` at container runtime (entrypoint best-effort may lack `capsh`).

**Gateway isolation**: OpenClaw gateway runs as `gateway` user, agent as `sandbox` user. Prevents "fake-HOME" attack (agent kills gateway and restarts with tampered config). Disabled in non-root mode.

**No new privileges**: `PR_SET_NO_NEW_PRIVS` flag set.

**Process limit**: `ulimit -u 512` (increase to 1024 for parallel workloads).

**PATH hardening**: locked to standard system paths at startup.

**Build toolchain removal**: `gcc`, `g++`, `cpp`, `make`, `netcat-openbsd`, `netcat-traditional`, `ncat` purged from runtime image.

**Image digest pinning**: blueprint references image by `@sha256:` digest, not mutable tag.

---

## Inference Controls

**Routed inference**: agent never receives provider API key; all calls go through `inference.local` → OpenShell gateway → provider.

**Do not** add provider hosts (`api.openai.com`, `api.anthropic.com`, etc.) to network policy — that bypasses credential isolation.

### Provider trust tiers

| Provider | Trust | Data Handling |
|---|---|---|
| NVIDIA Endpoints | High | NVIDIA infrastructure |
| OpenAI, Anthropic, Gemini | High | Subject to provider policies |
| Local Ollama | Self-hosted | On-premise only |
| Local NIM / vLLM | Experimental | Gate behind `NEMOCLAW_EXPERIMENTAL=1` |

Recommendation: use local Ollama for sensitive workloads.

---

## Gateway Auth Controls

- **Device auth**: required before Control UI connection. Disable only for headless local dev (`NEMOCLAW_DISABLE_DEVICE_AUTH=1`)
- **Bind address**: `127.0.0.1` default; binding `0.0.0.0` makes gateway network-accessible
- **Memory secret scanner**: plugin blocks agent writes of API keys, bearer tokens, private keys into persistent memory files. Intercepted before Write/Edit tool calls reach disk.
- **CLI secret redaction**: API keys and credentials auto-redacted from CLI output

---

## Posture Profiles

**Locked-down** (default, always-on assistants):
- Keep all defaults; no presets
- Operator approval for requested endpoints

**Development**:
- Apply `pypi` and `npm` presets with binary restrictions
- Review agent network activity periodically

**Integration testing**:
- Custom endpoints with tight path/method restrictions
- `protocol: rest` on all HTTP APIs
- Clean baseline policy after testing

---

## Common Mistakes

| Mistake | Fix |
|---|---|
| Omitting `protocol: rest` on REST APIs | Add `protocol: rest` with explicit rules |
| Adding endpoints to baseline for one-off requests | Use operator approval instead |
| Relying solely on entrypoint capability drops | Pass `--cap-drop=ALL` at container runtime |
| Leaving `/sandbox/.openclaw` writable on sensitive workloads | Lock config for always-on assistants |
| Adding inference provider hosts to network policy | Use OpenShell inference routing |
| Disabling device auth for remote deployments | Keep enabled; disable only for local headless |

---

## Known Limitations

| Limitation | Mitigation |
|---|---|
| `openclaw agent --local` bypasses gateway | Avoid for production; future hook will close gap |
| Direct filesystem writes bypass secret scanner | Landlock restricts writable paths |
| Base64/hex-encoded secrets undetected | Use env vars or credential stores |
