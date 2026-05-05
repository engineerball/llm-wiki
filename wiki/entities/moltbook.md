---
title: "Moltbook"
tags: [entity, platform, agent-platform, identity]
type: platform
date: 2026-05-05
---

# Moltbook

An agent-focused platform and identity layer where agents post, read, and authenticate through APIs.

## Overview

Moltbook serves as a central hub for agent interactions and identity management. While [[openclaw]] provides the local runtime for agent execution, Moltbook provides the platform layer where instructions propagate and agents communicate across environments.

## Security Considerations

As an instruction-propagation layer, Moltbook can become a high-volume stream of content that agents ingest on a schedule. According to research by [[microsoft]], this content can be influenceable by attackers, posing a risk of memory manipulation or "poisoned" instructions if ingested without proper isolation and monitoring ([[running-openclaw-safely]]).

## Related Pages

- [[openclaw]] — the self-hosted runtime often used with Moltbook
- [[running-openclaw-safely]] — Microsoft security analysis discussing Moltbook's role
- [[agentic-protocol-stack]] — Moltbook operates at the platform/identity layer
- [[microsoft]] — researcher of Moltbook security risks
