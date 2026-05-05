---
title: "Running OpenClaw safely: identity, isolation, and runtime risk"
tags: [source, security, openclaw, agent-runtime]
sources: ["raw/text/running-openclaw-safely.md"]
date: 2026-05-05
authors: [Microsoft Defender Security Research Team]
---

# Running OpenClaw safely: identity, isolation, and runtime risk

**Source:** [Microsoft Security Blog](https://www.microsoft.com/en-us/security/blog/2026/02/19/running-openclaw-safely-identity-isolation-runtime-risk/)
**Authors:** Microsoft Defender Security Research Team
**Date:** February 19, 2026

## Overview

Microsoft's security analysis of [[openclaw]], a self-hosted agent runtime. The report highlights that self-hosted agents shift the security boundary from static code to dynamically supplied content and third-party "skills," necessitating strict isolation and identity controls.

## Key Takeaways

### The Three Primary Risks
1. **Credential Exposure:** Tokens and data exfiltration.
2. **Memory Manipulation:** Persistent state changes inducing malicious behavior.
3. **Host Compromise:** Execution of malicious code via untrusted skills.

### Shift in Security Boundary
The runtime environment becomes the new boundary, encompassing:
- **Identity:** SaaS tokens, repo access, cloud control planes.
- **Execution:** Tools that change state (shell, infrastructure).
- **Persistence:** Durable changes across runs (tasks, config).

### Minimum Safe Operating Posture
- **Isolation:** Run only in dedicated VMs or separate physical devices.
- **Dedicated Credentials:** Use accounts/tokens solely for the agent; rotate regularly.
- **Monitor State:** Review saved instructions for unexpected changes.
- **Disposable Infrastructure:** Treat rebuilds as an expected control; regular reinstalls.

### Runtime vs. Platform
- **[[openclaw]] (Runtime):** Self-hosted execution layer; inherits host trust/risk.
- **[[moltbook]] (Platform):** Agent-focused identity layer; potential source of attacker-influenced content.

## Related Pages

- [[openclaw]] — the self-hosted agent gateway/runtime
- [[moltbook]] — the platform mentioned in the report
- [[harness-engineering]] — security controls as part of the agent harness
- [[agentic-protocol-stack]] — the security layer of the stack
- [[microsoft]] — the authoring organization
