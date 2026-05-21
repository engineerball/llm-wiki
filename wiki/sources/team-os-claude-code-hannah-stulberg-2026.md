---
title: "Build a Team OS with Claude Code — Hannah Stulberg"
tags: [source, harness-engineering, claude-code, team-os, context-management, plan-mode, parallel-agents, knowledge-repo]
sources: ["raw/articles/team-os-claude-code-hannah-stulberg-2026.md"]
date: 2026-05-21
author: Hannah Stulberg (guest), Aakash Gupta (host)
published: 2026-04-06
url: https://www.aakashg.com/hannah-stulberg-podcast/
---

# Build a Team OS with Claude Code — Hannah Stulberg

**Format:** Podcast (~90 min), transcript at aakashg.com  
**Key framing:** Claude Code is not a coding tool — it is the IDE for team knowledge work. The terminal is the interface; the repo is the team's operating system.

## Core Thesis

As roles merge (PMs shipping code, engineers making product decisions, non-technical partners contributing context), the central challenge is **scaling shared context** across the whole organisation. The answer is a **Team OS** — a structured, version-controlled knowledge repository where every team member reads and writes shared context, and where Claude (and other AI agents) use that context to produce work at dramatically higher quality and lower token cost.

This is a concrete, practitioner-level instantiation of [[harness-engineering]] and [[progressive-disclosure]] applied at team scale.

## The Team OS Architecture

Three top-level sections:
- **`.claude/`** — shared agents, commands, and skills available to the whole team
- **`product-development/`** — functional subfolders (customers, analytics, engineering, strategy, design)
- **`team/`** — team-level docs (onboarding, retros)

**Root `CLAUDE.md`** contains exactly three things:
1. **Doc index** — how to navigate the repo (which subfolder contains what)
2. **Team roster** — names + handles in key tools (Slack, GitHub, etc.)
3. **Key Slack channels / DM groups**

Everything else is *not* in the root `CLAUDE.md`. It's loaded progressively via nested `CLAUDE.md` files acting as doc indexes within each subfolder.

## Context Management Theory

Four concepts that underpin the entire architecture:

| Concept | Definition | Implication |
|---------|-----------|-------------|
| **Context** | Information loaded into an LLM session at a given moment | Only load what's needed for this query |
| **Context window** | Total capacity (~1M tokens ≈ 7–8 novels) | Sounds large; team docs exceed it quickly |
| **Compaction** | Compression when window fills — lossy, degrades quality | Avoid by loading less, not more |
| **Thinking room** | Gap between loaded content and window size — where reasoning happens | More loaded = less room to think |

The architecture's goal: maximise thinking room by loading only the context relevant to the current query.

## Nested CLAUDE.md Files and Doc Indexes

Every subfolder has its own `CLAUDE.md` acting as a doc index. These files are lean — they just describe what's in the folder so Claude can navigate without exploring. With this structure, a query like "who are my top customers?" uses only 3% of the context window. Without doc indexes, Claude would run explore agents over the entire repo.

**The principle:** *minimise the context consumed, not just the total context stored.*

This is a direct implementation of [[progressive-disclosure]] — root context always loaded, detailed content loaded on demand.

## Structured Summaries and Skills

For recurring artefacts (customer calls, bug investigations, experiment results), teams define **shared skills** that enforce a consistent format. Benefits:
- Every account manager's call summary has the same structure, enabling cross-customer analysis
- Cross-functional team members contribute without introducing format drift
- Claude can synthesise across hundreds of artefacts reliably

**Skill auto-invoke caveat:** skills only auto-invoke ~70% of the time. For long-running plans, *always explicitly specify* which skills to call — don't leave it to chance.

## Analytics Folder Pattern

Separate files for:
1. **Metric definitions** — what does "generation success rate" mean?
2. **SQL queries** — how do you compute it?
3. **Table schemas** — what tables back it?

The separation is intentional: if you query "what metrics track billing?", you don't want Claude to also load all the SQL and schemas. Retrieval granularity matches query granularity.

With a Snowflake MCP or similar analytics MCP hooked up, a PM can trigger actual analysis without a data scientist in the loop.

## Feature Launch Rule

**"The feature is not rolled out until the repository is updated."**

This is a process gate — analogous to a deployment checklist — that ensures context currency is treated as a first-class launch requirement, not an afterthought.

## GitHub Workflow for Non-Technical Team Members

The PR workflow is not just for code:
- Write a doc in Claude → commit to branch → open PR → tag reviewer → merge
- With GitHub MCP/CLI, "put up a PR for Morgan to review this PRD" works in one command
- Shared commands post PR notifications to Slack with structured content

Non-technical partners (strategy ops, business ops) who had never opened GitHub are putting up PRs daily within weeks. The PR review cycle becomes the team's shared editorial process.

## Plan Mode

**How to enter:** Shift+Tab twice.

**What it does:** removes Claude's bias for action. Instead of diving into execution, Claude produces a structured plan — phases, scope, verifications — for human review before any tokens are burned on execution.

**Why it matters:** most users under-plan. The quality gap between a planned task and an unplanned one is large, especially for complex synthesis work.

**Planning principles:**
- **Read the plan** before approving — it's the prompt for everything that follows
- **Create phases** with explicit checkpoints for human review between phases
- **Explicitly request parallelisation** — Claude does not naturally parallelize
- **Include verification steps** — what does "done well" look like? (cite sources, run Playwright checks, etc.)
- **Invite Claude to push your thinking** — explicitly ask it to use the ask-user-question tool to interview you before writing

**Tailor planning depth to task complexity:** simple tasks need a quick alignment proposal; complex synthesis tasks need multi-hour planning investment.

## Parallel Agents for Long Documents

Writing is token-expensive. A single agent cannot read 40 context files and write a great long-form doc. Pattern:
1. Split the doc into sections, each assigned to a separate sub-agent
2. Each sub-agent receives explicit context: which sections, which files to read, the writing guide
3. Each sub-agent writes to a **temporary file** (not back to the parent)
4. Orchestrating agent compiles from temp files into final output

**Critical:** if sub-agents return simultaneously to the parent, the session crashes and all work is lost. Temp files are the recovery mechanism.

## Storing Plan Files

Natural plan files (in `.claude/`) are ephemeral — wiped every 24–72 hours. For complex, reusable plans, save them explicitly to the repo. Benefits:
- Future sessions can build on prior plans without starting from zero
- Historical context for similar future tasks
- Plan files are *not* summarised — they're kept verbatim so future sessions can build off them in full

This mirrors the recommendation in the [[harness-engineering-leveraging-codex]] article (OpenAI's harness engineering piece on plan files as first-class repo artefacts).

## Context Rot

**Context rot** = stale context in the repo that causes Claude to work from outdated information. Mitigation: the feature launch rule and the PR workflow ensure docs are updated alongside output delivery. Every PR that adds a deliverable should also update any related repo context.

## Connections to Existing Wiki

- **[[harness-engineering]]** — Team OS is the team-scale manifestation of harness engineering: the repo is the harness, CLAUDE.md files are guides, doc indexes are feedforward controls, and analytics queries are sensors
- **[[progressive-disclosure]]** — nested CLAUDE.md files and doc indexes are a direct implementation of progressive context loading
- **[[skills-as-markdown]]** — shared team skills are the same pattern described in the Meta/Anthropic skills-as-markdown work; the team extends it to enforce cross-member format consistency
- **[[context-management-for-agents]]** — the four concepts (context, context window, compaction, thinking room) align directly with and extend the existing wiki page
- **[[institutional-ai]]** — Team OS is a concrete implementation path for institutional AI Pillar 6 (process engineering + enablement); it solves the "how do you encode firm processes into agents" problem
- **[[generator-evaluator-architecture]]** — parallel agent pattern for long-form docs implements generator-evaluator at writing scale

## New Concepts Introduced

- **Team OS** — new concept page created: `wiki/concepts/team-os.md`
- **Context rot** — added to [[context-management-for-agents]]
- **Thinking room** — added to [[context-management-for-agents]]
- **Plan mode** — added to [[harness-engineering]] as a guide pattern

## Contradictions / Open Questions

- 70% skill auto-invoke rate is a significant reliability gap — no mitigation beyond explicit specification in plans; worth tracking whether this improves
- "Everyone contributes to the repo" is culturally ambitious — the article acknowledges non-technical people had to learn GitHub from scratch; change management cost not addressed
- Context rot risk increases with team size and velocity; no automated staleness detection mechanism described
