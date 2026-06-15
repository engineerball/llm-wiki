---
title: "Skills as Markdown"
tags: [concept, agent-engineering, composability, knowledge-management, harness]
sources: [https://medium.com/@AnalyticsAtMeta/how-we-built-an-ai-second-brain-for-60k-knowledge-workers-78c507dd795b, https://resources.anthropic.com/hubfs/The-Complete-Guide-to-Building-Skill-for-Claude.pdf]
date: 2026-05-18
updated: 2026-06-15
---

# Skills as Markdown

A harness design pattern where reusable agent workflows are encoded as **plain markdown files + optional shell scripts** rather than compiled code, deployed services, or API endpoints.

First documented at scale in [[meta|Meta]]'s AI Second Brain system (2026), where the pattern enabled 3,000+ community-built skills in a few months.

## Core Idea

Instead of writing a program that calls an LLM, write a markdown document that **is** the workflow — instructions, steps, decision trees, and embedded scripts in one readable file. The agent reads and executes the skill at runtime.

```
skill.md
  ├── Intent and preconditions (read by LLM)
  ├── Step-by-step workflow (LLM follows)
  ├── Decision criteria (LLM applies)
  └── Embedded scripts (LLM calls as tools)
```

## Properties

**No deployment pipeline** — a skill is just a file in the filesystem. Sharing = git commit. Distribution = copy.

**Human-readable** — anyone who can write markdown can write or modify a skill. No compilation, no type checking, no servers.

**Composable** — skills call other skills. A complex workflow is a chain of simpler skills.

**Harness-agnostic** — skills don't encode which model runs them. The harness (Claude Code, OpenAI Codex, custom agent) can change without rewriting skills.

> **Update (2026-06-15):** Anthropic has since published [[skill-distribution|Agent Skills as an open standard]], explicitly formalizing this "harness-agnostic" property — the stated goal is that the same skill works across Claude and other AI platforms, mirroring how MCP standardized connectivity. See [[anthropic-complete-guide-building-skills-2026]].

## Examples from Meta

| Skill | What it does |
|-------|-------------|
| `/para-init` | Scans recent docs, posts, tasks, code reviews; infers active projects; proposes PARA workspace; generates CLAUDE.md files. Zero → organized workspace in one session. |
| `/start-project` | Takes a brain dump (goals, stakeholders, open questions, links); runs deep research across internal tools; proposes folder structure; creates everything on confirmation. |
| `/read-meeting-notes` | Processes AI-generated meeting transcripts; extracts action items and decisions; routes to relevant projects via weighted scoring (keywords, stakeholder overlap, mentions). |
| `/debrief:team` | Manager-level team report: resolves org tree, runs parallel work digests per member, synthesizes bottom-up into shareable HTML by project (not person). 10-person team = minutes. |

## Relationship to Harness Engineering

In [[harness-engineering|harness engineering]] terms, skills are **[[guides-and-sensors|guides]]** — feedforward instructions that steer agent behavior before action occurs. They encode:

- What the agent should do (workflow steps)
- How it should decide (decision criteria, routing logic)
- What tools it should call (embedded scripts, MCP tool invocations)

This is the same role as AGENTS.md / CLAUDE.md at the repo level, but operating at the task level.

## Contrast with Traditional Automation

| Traditional | Skills as Markdown |
|---|---|
| Compiled code | Plain markdown + scripts |
| Deployment required | File copy = deploy |
| Requires developer | Anyone can author |
| Hard to modify | Edit the markdown |
| Black box to agent | Agent reads the instructions |

## Network Effects

Because skills are readable markdown, they can be:
- Shared via git
- Discovered by browsing the filesystem
- Composed into discipline-specific packages
- Reviewed and improved by communities without needing the original author

At Meta: 9 discipline-specific packages (PMs, data scientists, engineers, designers, etc.), 3,000+ community-built skills in 3 months.

This mirrors the [[llm-wiki-pattern|LLM-wiki pattern]]: the value compounds because every new skill enriches the platform for everyone.

## Related

- [[harness-engineering]] — skills are a form of feedforward guide in the harness
- [[guides-and-sensors]] — skills are guides; execution logs and task outputs are sensors
- [[para-method]] — skills typically operate within a PARA workspace context
- [[progressive-disclosure]] — skills can implement progressive disclosure (load root context, then project context)
- [[llm-wiki-pattern]] — parallel composability pattern: wiki pages compound like skills compound
- [[how-we-built-an-ai-second-brain-for-60k-knowledge-workers-meta]] — Meta case study
- [[skill-md-specification]] — concrete file format for this pattern
- [[skill-distribution]] — the open Agent Skills standard that formalizes harness-agnosticism
- [[anthropic-complete-guide-building-skills-2026]] — official Anthropic guide
