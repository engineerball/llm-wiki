---
title: "SKILL.md Specification"
tags: [concept, agent-engineering, composability, knowledge-management, harness, openclaw]
sources: [https://github.com/openclaw/openclaw, https://claude.ai/skills]
date: 2026-05-28
---

# SKILL.md Specification

File format and structural specification for [[skills-as-markdown|agent skills]] as implemented in OpenClaw and Claude Code. Defines how a reusable agent workflow is packaged as a markdown file with optional bundled resources.

## File Format

Every skill requires a `SKILL.md` file with two parts:

```yaml
---
name: skill-name          # Required. Lowercase + hyphens only.
description: |            # Required. Primary trigger mechanism.
  What the skill does AND when to use it.
  Include trigger phrases and "NOT for" exclusions.
---

# Skill body (markdown instructions)
```

### Frontmatter Fields

Only two fields are valid:

| Field | Required | Purpose |
|-------|----------|---------|
| `name` | Yes | Skill identifier. Lowercase letters, digits, hyphens. Max 64 chars. Prefer short, verb-led phrases (e.g. `gh-issues`, `plan-mode`). Namespace by tool when it improves clarity (e.g. `gh-address-comments`). |
| `description` | Yes | **Primary trigger mechanism.** The agent reads this to decide whether to load the skill. Must include: (1) what the skill does, (2) specific use cases and trigger phrases, (3) when NOT to use it. The body is only loaded AFTER triggering, so "when to use" information belongs here, not in the body. |

## Directory Structure

```
skill-name/
├── SKILL.md          # Required — metadata + instructions
├── scripts/          # Optional — executable code (Python, Bash, etc.)
├── references/       # Optional — documentation loaded into context on demand
└── assets/           # Optional — files used in output (templates, images, fonts)
```

### Scripts (`scripts/`)

Executable code for tasks requiring deterministic reliability or repeated rewriting.

- When to include: Same code rewritten repeatedly, or deterministic reliability needed
- Token efficient — scripts execute without being read into context
- May still be read for patching or environment-specific adjustments
- Must be tested by actually running them

### References (`references/`)

Documentation loaded into context as needed to inform the agent's process.

- When to include: Schemas, API docs, domain knowledge, workflow guides
- Keeps SKILL.md lean; loaded only when the agent determines relevance
- For large files (>10k words), include grep search patterns in SKILL.md
- Avoid duplication: information lives in SKILL.md OR references, never both
- Keep one level deep from SKILL.md — avoid nested references

### Assets (`assets/`)

Files used in output, never loaded into context.

- When to include: Templates, images, icons, boilerplate, fonts, sample documents
- Copied or modified by the agent, not read for reasoning

### Files NOT to Create

Do not create auxiliary documentation inside a skill:

- README.md, CHANGELOG.md, QUICK_REFERENCE.md, INSTALLATION_GUIDE.md, etc.

The skill contains only what the agent needs to execute.

## Writing Principles

### Concise is Key

Context window is a shared resource. Every token must justify its cost.

**Default assumption: the agent is already very smart.** Only add context the agent doesn't already have. Challenge each piece: "Does the agent really need this?" and "Does this paragraph justify its token cost?"

Prefer concise examples over verbose explanations.

### Imperative Form

Body instructions use imperative/infinitive form (commands, not descriptions):

```
Extract text with pdfplumber:
  python scripts/extract.py input.pdf
```

Not: "You should extract text using pdfplumber..."

### Degrees of Freedom

Match specificity to task fragility:

| Freedom Level | Form | When to Use |
|---------------|------|-------------|
| High | Text instructions | Multiple valid approaches, context-dependent decisions, heuristic guidance |
| Medium | Pseudocode or scripts with parameters | Preferred pattern exists, some variation acceptable |
| Low | Specific scripts, few parameters | Fragile operations, consistency is critical, exact sequence required |

Think of it as a path: a narrow bridge needs guardrails (low freedom); an open field allows many routes (high freedom).

### Progressive Disclosure

Three-level loading manages context efficiently:

```
Level 1: Metadata (name + description) → Always in context  (~100 words)
Level 2: SKILL.md body               → When skill triggers  (<5k words)
Level 3: Bundled resources            → As needed by agent  (unlimited)
```

**Keep SKILL.md under 500 lines.** Split into reference files when approaching this limit.

#### Progressive Disclosure Patterns

**Pattern 1: High-level guide with references**

```markdown
# PDF Processing
## Quick start
Extract text with pdfplumber: [code]

## Advanced features
- Form filling → See references/forms.md
- API reference → See references/api.md
```

**Pattern 2: Domain-specific organization**

```
cloud-deploy/
├── SKILL.md (workflow + provider selection)
└── references/
    ├── aws.md
    ├── gcp.md
    └── azure.md
```

When the user chooses AWS, only aws.md loads.

**Pattern 3: Conditional details**

```markdown
## Editing documents
For simple edits, modify XML directly.
For tracked changes → See references/redlining.md
```

## Skill Creation Process

1. **Understand** — Collect concrete usage examples. What would a user say to trigger this? What should it do?
2. **Plan** — Analyze examples to identify reusable resources (scripts, references, assets)
3. **Initialize** — Create the skill directory structure
4. **Implement** — Write scripts/references/assets, then SKILL.md
5. **Test** — Run scripts against real inputs to verify correctness
6. **Package** — Validate and package into a `.skill` distributable file
7. **Iterate** — Use on real tasks, notice struggles, update based on fresh context

## Naming Conventions

- Lowercase letters, digits, hyphens only
- Normalize to hyphen-case: "Plan Mode" → `plan-mode`
- Max 64 characters
- Prefer short, verb-led phrases: `rotate-pdf`, `deploy-service`
- Namespace by tool for clarity: `gh-issues`, `gh-address-comments`, `linear-create-task`
- Folder name = skill name exactly

## Packaging

Skills are distributed as `.skill` files (zip archives with .skill extension). Packaging validates:

- YAML frontmatter format and required fields
- Naming conventions and directory structure
- Description completeness and quality
- File organization and resource references
- No symlinks (rejected for security)

## Relationship to Other Concepts

[[skills-as-markdown|Skills as Markdown]] describes the general pattern. This specification covers the concrete file format and conventions used by OpenClaw and Claude Code implementations.

Within [[harness-engineering|harness engineering]], skills are [[guides-and-sensors|guides]] — feedforward instructions steering agent behavior before action occurs.

The [[progressive-disclosure|progressive disclosure]] principle is baked into the three-level loading system: metadata always present, body on trigger, resources on demand.

## Related

- [[skills-as-markdown]] — General pattern of markdown-based agent workflows
- [[harness-engineering]] — Skills as guides in the harness architecture
- [[guides-and-sensors]] — Skills are feedforward guides
- [[progressive-disclosure]] — Three-level loading manages context
- [[para-method]] — Skills operate within PARA workspace context
- [[claude-skill-creator-vibecodingthailand-2026]] — Thai-language practical handbook for Claude Skills
