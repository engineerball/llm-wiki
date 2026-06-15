---
title: "Skill Planning and Use Case Categories"
tags: [concept, agent-engineering, claude, skills, planning]
sources: [https://resources.anthropic.com/hubfs/The-Complete-Guide-to-Building-Skill-for-Claude.pdf]
date: 2026-06-15
---

# Skill Planning and Use Case Categories

A framework from [[anthropic-complete-guide-building-skills-2026|Anthropic's skill-building guide]] for deciding **what to build before writing a [[skill-md-specification|SKILL.md]]**: define 2-3 concrete use cases, classify the skill into one of three categories, and set success criteria up front.

## Start With Use Cases

Before writing any code, identify 2-3 concrete use cases. A good use case definition specifies:

```
Use Case: Project Sprint Planning
Trigger: User says "help me plan this sprint" or "create sprint tasks"
Steps:
1. Fetch current project status from Linear (via MCP)
2. Analyze team velocity and capacity
3. Suggest task prioritization
4. Create tasks in Linear with proper labels and estimates
Result: Fully planned sprint with tasks created
```

Guiding questions:
- What does a user want to accomplish?
- What multi-step workflows does this require?
- Which tools are needed (built-in or [[skills-and-mcp|MCP]])?
- What domain knowledge or best practices should be embedded?

## The Three Use Case Categories

Anthropic observes that most skills fall into one of three categories. Knowing which one a skill targets shapes its structure.

### Category 1: Document & Asset Creation

**Used for:** Creating consistent, high-quality output — documents, presentations, apps, designs, code.

**Real example:** `frontend-design` skill — "Create distinctive, production-grade frontend interfaces with high design quality. Use when building web components, pages, artifacts, posters, or applications."

**Key techniques:**
- Embedded style guides and brand standards
- Template structures for consistent output
- Quality checklists before finalizing
- No external tools required — uses Claude's built-in capabilities

### Category 2: Workflow Automation

**Used for:** Multi-step processes that benefit from consistent methodology, including coordination across multiple MCP servers.

**Real example:** `skill-creator` skill — "Interactive guide for creating new skills. Walks the user through use case definition, frontmatter generation, instruction writing, and validation."

**Key techniques:**
- Step-by-step workflow with validation gates
- Templates for common structures
- Built-in review and improvement suggestions
- Iterative refinement loops

### Category 3: MCP Enhancement

**Used for:** Workflow guidance that enhances the tool access an MCP server already provides.

**Real example:** `sentry-code-review` skill (Sentry) — "Automatically analyzes and fixes detected bugs in GitHub Pull Requests using Sentry's error monitoring data via their MCP server."

**Key techniques:**
- Coordinates multiple MCP calls in sequence
- Embeds domain expertise
- Provides context users would otherwise need to specify
- Error handling for common MCP issues

This category is the planning-stage counterpart to [[skills-and-mcp|Skills and MCP]], which covers the implementation patterns.

## Define Success Criteria

These are aspirational targets — "rigor with an element of vibes-based assessment," per Anthropic. Defining them at planning time gives [[skill-testing-and-iteration|testing]] something concrete to check against.

**Quantitative metrics:**

| Metric | How to measure |
|---|---|
| Skill triggers on ~90% of relevant queries | Run 10-20 test queries that should trigger the skill; track auto-load vs. explicit invocation |
| Completes workflow in X tool calls | Compare same task with/without the skill; count tool calls and tokens |
| 0 failed API calls per workflow | Monitor MCP server logs during test runs; track retry rates and error codes |

**Qualitative metrics:**

| Metric | How to assess |
|---|---|
| Users don't need to prompt Claude about next steps | Note how often you redirect/clarify during testing; ask beta users |
| Workflows complete without user correction | Run the same request 3-5 times; compare structural consistency |
| Consistent results across sessions | Can a new user succeed on the first try with minimal guidance? |

## Related

- [[anthropic-complete-guide-building-skills-2026]] — source guide
- [[skill-md-specification]] — file format these planned skills are implemented in
- [[skills-and-mcp]] — implementation patterns for Category 3 (MCP Enhancement) skills
- [[skill-testing-and-iteration]] — how to validate against the success criteria defined here
- [[skill-distribution]] — what happens after a skill is built
