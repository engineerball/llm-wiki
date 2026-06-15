---
title: "Skills and MCP"
tags: [concept, agent-engineering, claude, skills, mcp]
sources: [https://resources.anthropic.com/hubfs/The-Complete-Guide-to-Building-Skill-for-Claude.pdf]
date: 2026-06-15
---

# Skills and MCP

How [[skill-md-specification|Claude Skills]] and MCP (Model Context Protocol) servers complement each other, plus five reusable orchestration patterns for skills that coordinate MCP tool calls. From [[anthropic-complete-guide-building-skills-2026|Anthropic's skill-building guide]].

## The Kitchen Analogy

> MCP provides the professional kitchen: access to tools, ingredients, and equipment.
> Skills provide the recipes: step-by-step instructions on how to create something valuable.

| MCP (Connectivity) | Skills (Knowledge) |
|---|---|
| Connects Claude to your service (Notion, Asana, Linear, etc.) | Teaches Claude how to use your service effectively |
| Provides real-time data access and tool invocation | Captures workflows and best practices |
| **What** Claude can do | **How** Claude should do it |

## Why MCP Builders Need Skills

If an MCP server already exists, skills are the knowledge layer on top.

**Without skills:**
- Users connect the MCP but don't know what to do next
- Support tickets ask "how do I do X with your integration"
- Each conversation starts from scratch
- Inconsistent results because users prompt differently each time
- Users blame the connector when the real issue is missing workflow guidance

**With skills:**
- Pre-built workflows activate automatically when needed
- Consistent, reliable tool usage
- Best practices embedded in every interaction
- Lower learning curve for the integration

## Problem-First vs. Tool-First Framing

Like a Home Depot visit — you either arrive with a problem ("fix a kitchen cabinet") and get pointed to tools, or you arrive with a tool (a new drill) and ask how to use it.

- **Problem-first:** "I need to set up a project workspace" → the skill orchestrates the right MCP calls in the right sequence. Users describe outcomes; the skill handles the tools. This is the [[skill-planning-and-use-cases|MCP Enhancement]] category's typical framing.
- **Tool-first:** "I have Notion MCP connected" → the skill teaches Claude optimal workflows and best practices. Users already have access; the skill provides expertise.

Most skills lean one direction — identify which fits before choosing a pattern below.

## Five Orchestration Patterns

### Pattern 1: Sequential Workflow Orchestration

**Use when:** users need multi-step processes in a specific order.

```markdown
# Workflow: Onboard New Customer
## Step 1: Create Account
Call MCP tool: `create_customer` — Parameters: name, email, company
## Step 2: Setup Payment
Call MCP tool: `setup_payment_method` — Wait for: payment method verification
## Step 3: Create Subscription
Call MCP tool: `create_subscription` — Parameters: plan_id, customer_id (from Step 1)
## Step 4: Send Welcome Email
Call MCP tool: `send_email` — Template: welcome_email_template
```

Key techniques: explicit step ordering, dependencies between steps, validation at each stage, rollback instructions for failures.

### Pattern 2: Multi-MCP Coordination

**Use when:** workflows span multiple services.

Example — design-to-development handoff across four MCPs (Figma → Drive → Linear → Slack): export design assets and generate specs, create a Drive folder and upload assets with shareable links, create Linear development tasks with asset links attached, then post a handoff summary to Slack.

Key techniques: clear phase separation, data passing between MCPs, validation before moving to the next phase, centralized error handling.

### Pattern 3: Iterative Refinement

**Use when:** output quality improves with iteration (e.g., report generation).

Flow: generate an initial draft → run a validation script to identify issues (missing sections, formatting, data errors) → address each issue and regenerate affected sections → re-validate → repeat until a quality threshold is met → apply final formatting.

Key techniques: explicit quality criteria, iterative improvement, validation scripts, knowing when to stop.

### Pattern 4: Context-Aware Tool Selection

**Use when:** the same outcome can be reached via different tools depending on context (e.g., file storage routing: large files → cloud storage MCP, collaborative docs → Notion/Docs MCP, code → GitHub MCP, temp files → local storage).

Key techniques: clear decision criteria, fallback options, transparency with the user about why a tool was chosen.

### Pattern 5: Domain-Specific Intelligence

**Use when:** the skill adds specialized knowledge beyond tool access — e.g., financial compliance: run sanctions/jurisdiction/risk checks via MCP *before* calling the payment-processing tool; on failure, flag for review and open a compliance case; log a full audit trail.

Key techniques: domain expertise embedded in logic, compliance-before-action, comprehensive documentation, clear governance.

## MCP Connection Troubleshooting

When a skill loads correctly but MCP calls fail:

1. Verify the MCP server is connected (Claude.ai: Settings > Extensions > [Service] shows "Connected")
2. Check authentication — valid API keys, granted permissions/scopes, refreshed OAuth tokens
3. Test the MCP independently of the skill: "Use [Service] MCP to fetch my projects" — if this fails, the issue is the MCP, not the skill
4. Verify tool names are correct and case-sensitive per the MCP server's documentation

## Related

- [[anthropic-complete-guide-building-skills-2026]] — source guide
- [[skill-planning-and-use-cases]] — Category 3 (MCP Enhancement) is the planning-stage version of this page
- [[skill-md-specification]] — file format that implements these patterns
- [[skill-testing-and-iteration]] — testing MCP-coordinating skills
- [[harness-engineering]] — broader discipline of designing agent tool environments
