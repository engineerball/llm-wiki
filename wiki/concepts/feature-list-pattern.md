---
title: "Feature List Pattern"
tags: [concept, harness-pattern, testing]
date: 2026-05-02
sources: ["sources/anthropic-effective-harnesses.md", "raw/text/anthropic-effective-harnesses.md"]
---

# Feature List Pattern

A scaffolding pattern used in the [[Initializer-Coding Agent Architecture]] where a comprehensive JSON file enumerates all required features for a project, each with test criteria and a pass/fail status.

## Structure

```json
{
  "category": "functional",
  "description": "User can send a message and receive an AI response",
  "steps": [
    "Navigate to chat interface",
    "Type a query in the input field",
    "Press Enter or click Send",
    "Verify AI response appears",
    "Check response is relevant to query"
  ],
  "passes": false
}
```

## Design Decisions

### Why JSON, not Markdown?

Models are less likely to inappropriately change or overwrite JSON files compared to Markdown. This was found through experimentation — models treat JSON as a structured data format to be respected, while Markdown is seen as editable content.

### Granularity

In the claude.ai clone example, the feature list contained **200+ features** — extremely granular breakdowns like "user can open a new chat, type in a query, press enter, and see an AI response."

### Immutable Tests

Coding agents are instructed with strongly-worded rules:
- They can only change the `passes` field
- They **cannot** remove or edit test steps
- Rationale: removing tests could lead to missing or buggy functionality

## Role in the Harness

| Function | Acts As |
|----------|---------|
| Defines all required features | [[Guides and Sensors]] — feedforward guide |
| Test criteria for each feature | [[Sprint Contracts]] — success criteria |
| Pass/fail tracking | Progress meter for [[Initializer-Coding Agent Architecture\|coding agents]] |
| Prevents premature completion | Anti-one-shotting mechanism |

## Relationship to Other Concepts

- **[[Guides and Sensors]]** — the feature list is the definitive guide; test execution provides sensor feedback
- **[[Sprint Contracts]]** — each feature entry is a mini-contract between initializer and coding agent
- **[[One-Shot Agent]]** — the feature list is the primary mechanism to break one-shot behavior into incremental steps
- **[[Initializer-Coding Agent Architecture]]** — core component created by the initializer, consumed by coding agents

## Source

- Anthropic: "Effective harnesses for long-running agents" (2026)
