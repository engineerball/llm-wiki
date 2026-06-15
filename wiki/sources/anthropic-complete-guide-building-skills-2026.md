---
title: "The Complete Guide to Building Skills for Claude (Anthropic, 2026)"
tags: [source, claude, skills, agent-engineering, prompt-engineering, mcp]
sources: ["raw/The Complete Guide to Building Skills for Claude.md"]
date: 2026-06-15
---

# The Complete Guide to Building Skills for Claude (Anthropic, 2026)

**Author/Publisher:** Anthropic
**Format:** PDF, 32 pages
**Source:** https://resources.anthropic.com/hubfs/The-Complete-Guide-to-Building-Skill-for-Claude.pdf

## Overview

Anthropic's official end-to-end guide for building [[skill-md-specification|Agent Skills]] for Claude — from fundamentals and planning through testing, distribution, and troubleshooting. Positioned as a companion to MCP: "MCP provides the professional kitchen (tools); skills provide the recipes (workflows)." Two reading paths are offered: standalone skill builders (Fundamentals → Planning and Design → Categories 1-2) and MCP integration builders (add the Skills + MCP section and Category 3).

## Structure

- **Chapter 1 — Fundamentals:** What a skill is, the three-level progressive disclosure system, composability, portability, and the MCP "kitchen and recipes" analogy.
- **Chapter 2 — Planning and Design:** Use-case definition, the three common use-case categories, success criteria (quantitative + qualitative), file structure, critical naming rules, full YAML frontmatter spec, description-writing guidance.
- **Chapter 3 — Testing and Iteration:** Three testing tiers (manual / scripted / API), the "iterate on one task first" tip, triggering/functional/performance test design, using the skill-creator skill, under/over-triggering feedback loops.
- **Chapter 4 — Distribution and Sharing:** Current (Jan 2026) distribution model, org-wide deployment, the open Agent Skills standard, API usage (`/v1/skills`, `container.skills`), GitHub-based distribution and positioning advice.
- **Chapter 5 — Patterns and Troubleshooting:** Problem-first vs. tool-first framing, five reusable workflow patterns, and a troubleshooting guide for upload errors, triggering issues, MCP connection problems, ignored instructions, and large-context degradation.
- **Reference A/B/C:** Pre/post-upload checklist, complete YAML frontmatter reference, links to example skill repositories.

## Key Claims

1. A skill = a folder with required `SKILL.md` (YAML frontmatter + Markdown body) plus optional `scripts/`, `references/`, `assets/`.
2. Progressive disclosure has three levels: frontmatter (always loaded) → SKILL.md body (loaded on trigger) → linked files (loaded on demand).
3. Skills are portable across Claude.ai, Claude Code, and the API "without modification," subject to environment dependencies.
4. Three common use-case categories: **Document & Asset Creation**, **Workflow Automation**, **MCP Enhancement** — each with a real-world example skill (frontend-design, skill-creator, sentry-code-review).
5. Success criteria mix quantitative metrics (90% trigger rate on relevant queries, tool-call/token counts, 0 failed API calls) with qualitative ones (no follow-up prompting needed, consistent output across runs).
6. YAML frontmatter has expanded optional fields beyond `name`/`description`: `license`, `compatibility`, `allowed-tools`, and a free-form `metadata` block (author, version, mcp-server, category, tags, documentation, support).
7. Security restrictions: no XML angle brackets (`< >`) anywhere in frontmatter, and skill names containing "claude" or "anthropic" are reserved.
8. Testing has three tiers: triggering tests, functional tests, and performance comparisons (with/without skill, measured in tool calls and tokens).
9. As of January 2026, individual distribution is via Claude.ai Settings > Capabilities > Skills (zip upload) or the Claude Code skills directory; org admins can deploy skills workspace-wide (shipped 2025-12-18) with automatic updates.
10. Anthropic has published **Agent Skills as an open standard** — intended to be portable across AI platforms the way MCP is, with ecosystem collaboration underway.
11. API access to skills requires the Code Execution Tool beta; skills can be attached to Messages API requests via `container.skills` and managed via `/v1/skills`.
12. Five reusable patterns: sequential workflow orchestration, multi-MCP coordination, iterative refinement, context-aware tool selection, and domain-specific intelligence (e.g., compliance-before-action).
13. Troubleshooting root causes: wrong SKILL.md filename/case, malformed YAML, vague `description` (under/over-triggering), broken MCP connections, verbose/buried instructions, and oversized SKILL.md (recommend <5,000 words, <500 lines per the related [[skill-md-specification|SKILL.md spec]]) or too many concurrently enabled skills (20-50 ceiling mentioned).

## Relation to Existing Wiki Content

This is the **official Anthropic counterpart** to [[claude-skill-creator-vibecodingthailand-2026|Claude Skill Creator — A Practical Handbook (2026)]] (a Thai community handbook covering similar ground via a "Prompt-First" lens, including a 7-field Skill Brief and Skill Pack concepts). Where the two overlap (folder structure, frontmatter, testing 3-case loop, packaging/security checks), this guide is the authoritative source.

It also significantly extends [[skill-md-specification|SKILL.md Specification]] — see that page for the reconciled frontmatter field list (the prior page, sourced from OpenClaw/Claude Code conventions, listed only `name`/`description` as valid; this guide adds `license`, `compatibility`, `allowed-tools`, and `metadata`, plus the reserved-name and no-angle-bracket security rules).

New material not previously covered in the wiki:
- [[skill-planning-and-use-cases|Skill Planning and Use Case Categories]] — the three use-case categories and success-criteria framework
- [[skill-testing-and-iteration|Skill Testing and Iteration]] — the three-tier testing approach and trigger-tuning feedback loop
- [[skills-and-mcp|Skills and MCP]] — the kitchen/recipes analogy and the five orchestration patterns
- [[skill-distribution|Skill Distribution]] — the Jan 2026 distribution model, org deployment, open standard, and API skills

## Related

- [[skill-md-specification|SKILL.md Specification]] — file format and structural spec, updated with this guide's frontmatter fields
- [[skills-as-markdown|Skills as Markdown]] — general pattern this guide formalizes as an open standard
- [[progressive-disclosure|Progressive Disclosure]] — the three-level loading system described in Chapter 1
- [[claude-skill-creator-vibecodingthailand-2026|Claude Skill Creator — A Practical Handbook (2026)]] — community handbook covering overlapping ground
- [[claude|Claude]] / [[anthropic|Anthropic]]
