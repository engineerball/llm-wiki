---
title: "Team OS"
tags: [concept, harness-engineering, claude-code, team-os, context-management, knowledge-repo, shared-agents]
date: 2026-05-21
sources: ["sources/team-os-claude-code-hannah-stulberg-2026.md"]
---

# Team OS

**Team OS** (Team Operating System) is a shared, version-controlled knowledge repository used by an entire cross-functional team as the primary working environment for Claude (and other AI agents). Every team member — engineers, designers, PMs, data scientists, strategy ops, business ops — reads from and writes to the same repo. The repo becomes the team's collective memory, and Claude becomes the shared intelligence that navigates and acts on that memory.

The concept was articulated by Hannah Stulberg (April 2026) as a practitioner-level answer to the question: how do you scale shared context across a team where roles are merging and one PM is supporting 10–20+ people?

## The Problem It Solves

When everyone on a team makes product decisions, the context that used to be siloed within specialist roles (PM knows user research, data scientist knows the metrics, engineer knows the architecture) needs to be accessible to everyone. Without a Team OS:
- Each individual builds their own AI workflow, inconsistently
- Context lives in chat history, Notion pages, Slack threads — invisible to AI agents
- Cross-functional synthesis requires expensive human coordination
- New team members take months to build context

## Architecture

```
repo/
  .claude/                  # Shared agents, commands, skills (team-wide)
  product-development/      # Functional subfolders
    customers/              # Per-customer summary files + transcripts
    analytics/              # Metrics, SQL queries, table schemas
    engineering/            # Bug investigations, RFCs, tech design docs
    strategy/               # Strategy docs, competitive intel, vision
    design/                 # Design briefs, prototypes
  team/                     # Onboarding guides, retros, team-level docs
  CLAUDE.md                 # Root: doc index + team roster + key Slack channels
```

### Root CLAUDE.md — Three Things Only

The root CLAUDE.md is loaded on every session. It should contain exactly:
1. **Doc index** — which subfolder contains what (navigation map)
2. **Team roster** — names and handles in key tools (Slack IDs, GitHub handles)
3. **Key Slack channels / DM groups**

Nothing else. Everything else belongs in nested CLAUDE.md files within subfolders.

### Nested CLAUDE.md Files as Doc Indexes

Every subfolder has its own lean `CLAUDE.md` describing what's in that folder. These load progressively only when Claude navigates into the folder. Without them, Claude runs explore agents over the whole repo (expensive, slow, and context-burning).

This is a direct implementation of [[Progressive Disclosure]] at team scale.

## The Four Context Principles

The entire architecture is governed by these four principles (from Hannah Stulberg's context management theory):

| Principle | What It Means |
|-----------|--------------|
| **Context** | Only information currently loaded in the LLM session is usable |
| **Context window** | ~1M tokens sounds large; team docs quickly exceed it |
| **Compaction** | When the window fills, it's compressed — lossy and less useful |
| **Thinking room** | The gap between loaded content and window size is where reasoning happens |

**Goal:** maximise thinking room by loading only what is relevant to the current query. A well-structured Team OS query uses 3–5% of the context window. A poorly structured one uses 60–80% before doing any work.

## Structural Patterns

### Structured Summaries via Shared Skills
Every recurring artefact (customer call, bug investigation, experiment result, strategy doc) is created using a shared skill that enforces a consistent format. Benefits: cross-member synthesis is reliable; individual style differences don't create retrieval noise.

**Skill auto-invoke caveat:** skills only auto-invoke ~70% of the time. Always explicitly specify skills in long-running plans.

### Summary + Raw Separation
For high-volume data (e.g. customer call transcripts):
- **Summary file** — loaded on 80% of queries; contains key contacts, segment, doc index
- **Raw transcripts** — loaded only when the summary is insufficient

Claude never reads 50 hour-long transcripts in a single query. The two-tier structure makes cross-customer synthesis viable.

### Analytics: Metrics / Queries / Schemas Split
Separate files for metric definitions, SQL queries, and table schemas. Retrieval granularity matches query granularity: asking "what metrics track feature X?" should not force loading all related SQL.

### Feature Launch Gate
**"The feature is not rolled out until the repository is updated."** Context currency is treated as a first-class launch requirement. This prevents context rot — stale information in the repo that causes Claude to work from outdated context.

## The PR Workflow

Everyone works in Claude Code and checks all work into the repo via pull requests:
- Write the doc / artefact in Claude
- Commit to a branch; open a PR; tag reviewers
- Merge when reviewed

With GitHub CLI/MCP connected, "put up a PR for Morgan to review this PRD" executes in one natural-language command. Non-technical team members (strategy ops, business ops) who had never used GitHub learn the PR workflow within weeks.

## Plan Mode

Plan mode (Shift+Tab twice in Claude Code) removes Claude's bias for action. Instead of diving into execution, Claude produces a structured plan — phases, scope, parallelisation, verification steps — for human review.

Key planning principles:
- **Read the plan** before approving execution
- **Create phases with checkpoints** for human review between phases
- **Explicitly request parallelisation** — Claude does not parallelize by default
- **Verification steps** — tell Claude what "done well" looks like (cite sources, run Playwright checks)
- **Invite Claude to interview you** — "use the ask-user-question tool to push my thinking and surface angles I'm missing"
- **Tailor depth to complexity** — quick alignment proposal for simple tasks; multi-hour planning for complex synthesis

## Parallel Agents for Long-Form Documents

Writing is token-expensive. Single-agent long-form writing degrades when the agent must read 40+ context files. Pattern:
1. Split doc into sections, each assigned to a sub-agent
2. Each sub-agent receives explicit context (files to read, writing guide, section scope)
3. Each sub-agent writes to a **temporary file** — not back to the parent
4. Orchestrating agent compiles from temp files

**Critical:** simultaneous returns to the parent crash the session and lose all work. Temp files prevent this.

## Storing Plan Files

Natural Claude Code plan files are ephemeral (wiped every 24–72 hours). For complex, reusable plans, save them explicitly to the repo. Plan files are kept verbatim — not summarised — so future sessions can build on them in full. This is the "plan files as first-class repo artefacts" principle from OpenAI's harness engineering work (see [[Harness Engineering Leveraging Codex]]).

## Connections to Other Concepts

- [[Harness Engineering]] — Team OS is the team-scale harness: repo = harness environment, CLAUDE.md doc indexes = guides (feedforward), analytics queries = sensors (feedback)
- [[Progressive Disclosure]] — nested CLAUDE.md / doc index architecture is progressive disclosure applied to team knowledge
- [[Skills as Markdown]] — shared team skills are the same pattern; Team OS extends it to enforce format consistency across contributors
- [[Context Management for Agents]] — the four principles (context, context window, compaction, thinking room) and the context rot concept originate here
- [[Institutional AI]] — Team OS is a concrete implementation path for Institutional AI Pillar 6 (process engineering + change management) and Pillar 1 (coordination)
- [[Generator-Evaluator Architecture]] — the parallel agent writing pattern implements generator-evaluator at document-section granularity

## Open Questions

- What is the right change management path for organisations with high GitHub-resistance?
- How do you detect and remediate context rot automatically — are there tooling patterns beyond manual PR hygiene?
- Does the 70% skill auto-invoke rate improve with newer Claude versions, or is explicit specification always necessary?
- At what team size / repo complexity does a simple doc index approach break down and require more sophisticated retrieval?
