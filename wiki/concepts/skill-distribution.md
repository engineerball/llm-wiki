---
title: "Skill Distribution"
tags: [concept, agent-engineering, claude, skills, open-standard]
sources: [https://resources.anthropic.com/hubfs/The-Complete-Guide-to-Building-Skill-for-Claude.pdf]
date: 2026-06-15
---

# Skill Distribution

How [[skill-md-specification|Claude Skills]] move from a local folder to individual users, organizations, and programmatic API consumers — including Anthropic's open Agent Skills standard. From [[anthropic-complete-guide-building-skills-2026|Anthropic's skill-building guide]].

## Current Distribution Model (January 2026)

**Individual users:**
1. Download the skill folder
2. Zip the folder (if needed)
3. Upload to Claude.ai via Settings > Capabilities > Skills
4. Or place in the Claude Code skills directory

**Organization-level:**
- Admins can deploy skills workspace-wide (shipped 2025-12-18)
- Automatic updates
- Centralized management

## Agent Skills as an Open Standard

Anthropic has published **Agent Skills as an open standard** — the stated goal is portability across AI platforms and tools, the same positioning MCP has for connectivity: "the same skill should work whether you're using Claude or other AI platforms." Authors of platform-specific skills can document that in the [[skill-md-specification|`compatibility` frontmatter field]]. Anthropic describes active collaboration with ecosystem participants on the standard.

This directly extends [[skills-as-markdown|Skills as Markdown]]'s premise that skills are "harness-agnostic" — the open standard formalizes that property rather than leaving it as an emergent convention.

## Using Skills via the API

For applications, agents, or automated pipelines that consume skills programmatically:

- `/v1/skills` endpoint — list and manage skills
- `container.skills` parameter on Messages API requests — attach skills to a request
- Version control and management via the Claude Console
- Compatible with the Claude Agent SDK for custom agents
- **Requires the Code Execution Tool beta** — provides the secure environment skills need to run

### When to Use Which Surface

| Use Case | Best Surface |
|---|---|
| End users interacting with skills directly | Claude.ai / Claude Code |
| Manual testing and iteration during development | Claude.ai / Claude Code |
| Individual, ad-hoc workflows | Claude.ai / Claude Code |
| Applications using skills programmatically | API |
| Production deployments at scale | API |
| Automated pipelines and agent systems | API |

## Recommended Path for Skill Authors (GitHub-First)

1. **Host on GitHub** — public repo for open-source skills, clear repo-level README with installation instructions, example usage with screenshots. (Note: the repo README is *separate* from the skill folder, which per [[skill-md-specification|SKILL.md Specification]] must not contain its own README.md.)
2. **Document in the MCP repo** — link to the skill from MCP documentation, explain the value of using both together, provide a quick-start guide.
3. **Write an installation guide** covering: clone/download → upload via Claude.ai Settings > skills (or place in Claude Code skills directory) → enable the skill and confirm the MCP server is connected → test with a representative prompt.

## Positioning a Skill

Focus on **outcomes**, not file-format mechanics:

```
✅ "The ProjectHub skill enables teams to set up complete project
workspaces in seconds — including pages, databases, and templates —
instead of spending 30 minutes on manual setup."

❌ "The ProjectHub skill is a folder containing YAML frontmatter and
Markdown instructions that calls our MCP server tools."
```

Pair the MCP + skill story explicitly: "Our MCP server gives Claude access to your [service]. Our skill teaches Claude your team's [workflow]. Together, they enable [outcome]."

For users comparing connectors, a skill is described as giving an MCP "an edge over MCP-only alternatives" — it's the difference between *access* and *expertise*.

## Related

- [[anthropic-complete-guide-building-skills-2026]] — source guide
- [[skill-md-specification]] — packaging as `.skill` files, `compatibility` field
- [[skills-as-markdown]] — "harness-agnostic" premise that the open standard formalizes
- [[skills-and-mcp]] — the MCP + skills story this section recommends positioning around
- [[skill-testing-and-iteration]] — testing before distribution
