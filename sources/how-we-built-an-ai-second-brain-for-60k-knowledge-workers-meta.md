# How We Built an AI Second Brain for 60K Knowledge Workers

**Source:** https://medium.com/@AnalyticsAtMeta/how-we-built-an-ai-second-brain-for-60k-knowledge-workers-78c507dd795b
**Author:** Analytics at Meta
**Ingested:** 2026-05-18

---

## Summary

Meta's analytics team built an "AI Second Brain" — an AI agent with persistent, structured access to everything a person is working on. It started as a personal productivity experiment and grew organically to 63,000+ installs across all of Meta's org pillars in 3 months, with ~10,000 daily active users.

## How It Works — Four Main Pieces

### 1. PARA Workspace (Folder Structure for Agents)

Based on Tiago Forte's PARA method (Projects, Areas, Resources, Archives), adapted for AI agents:
- Tells the agent what's **active**, what's **important**, and where new info should go
- Root **CLAUDE.md** = identity + active portfolio, loaded every session
- Per-project **CLAUDE.md** = detailed context, loaded on demand
- **Progressive disclosure** is key: lean context up front, deeper detail only when needed. Dumping everything degrades output quality.
- Solves the finite context window problem without token waste

### 2. Infrastructure Layer (Bridge to Internal Tools)

- **MCP servers** (Model Context Protocol) + **CLIs** give agents authenticated, scoped access to internal systems
- Without this layer → agent can only read local files
- With it → agent can pull meeting transcripts, check task status, read discussions, write documents within user's permissions
- Key insight: infrastructure investment must come **before** building agent workflows

### 3. The Agent (Execution Engine)

- Model + harness (execution env, tools, orchestration logic)
- Provides: agentic loop (reason → act → observe → repeat), filesystem access, tool calling, MCP integration, error recovery
- Deploys on **Claude Code with latest Anthropic model**, but harness-agnostic

### 4. Skills (Workflows as Markdown)

Reusable instructions in plain markdown + scripts. No compiled code, no servers, no deployment pipeline. Key built-in skills:

- **/para-init** — Bootstrap workspace from scratch: scans recent posts, docs, tasks, wikis, code reviews; infers active projects; proposes folder structure; generates context files. Zero → structured workspace in one session.
- **/start-project** — Create project from brain dump: user describes goals, stakeholders, open questions, links; agent runs deep research across internal tools; proposes structure; creates everything after confirmation.
- **/read-meeting-notes** — Process AI-generated meeting transcripts: extracts action items & decisions; routes to relevant projects via weighted scoring (keywords, stakeholder overlap, project mentions).
- **/debrief:team** — Manager-level team report: resolves org tree; runs parallel work digests per member; synthesizes bottom-up into portfolio report sorted by project (not person); outputs shareable HTML. 10-person team = minutes, replacing hours of status-gathering.

Community built 3,000+ more skills. 9 discipline-specific packages (PMs, data scientists, engineers, designers, etc.).

## Growth: 0 → 63,000 in 3 Months

- Slow burn until a non-technical PM published an install guide + concrete use case examples
- Growth outpaced infrastructure: plugin tripped API rate limits, required 10x capacity increase
- Today: 63,000+ installs, ~10,000 DAU, every org pillar at Meta
- **Key lesson:** /para-init removed the biggest adoption barrier — users saw value in their first session without hours of organizing

## Key Lessons

1. **Infrastructure comes first** — The agent is only as useful as the systems it can reach. Invest in authenticated access to internal tools before anything else.
2. **Progressive disclosure > context dumping** — Feeding everything at once degrades quality. Evidence shows too many context files can be detrimental to agent performance root context first, project detail on demand.
3. **Low-friction onboarding drives viral adoption** — Remove the entry cost, people share it same day.
4. **Your users are your best builders** — Every major feature after launch was built by community members, not the original author.
5. **Composability > features** — Skills as public markdown + workspace as filesystem = extensible platform, not just a tool.

## What's Next

- **"Third Brain"** — Team-level shared context: individual workspaces feed into a shared knowledge layer, piloting across dozens of teams
- **Proactive agents** — Run on schedules: morning briefings, automated meeting note processing, end-of-day digests
- Converging with Meta's broader AI platforms for structured context and persistent memory

## Related People & Concepts

- **Tiago Forte** — PARA Method
- **Anthropic** — Claude Code deployment
- **MCP (Model Context Protocol)** — Infrastructure pattern
- **CLAUDE.md** — Context file pattern for agents

## Tags

#second-brain #meta #enterprise-ai #knowledge-management #agent-workflow #claude-code #para-method #mcp #progressive-disclosure #community-driven #skills-as-markdown
