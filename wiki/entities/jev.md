---
title: "Jev"
tags: [entity, tool, jev, agent-engineering, model-routing, open-source]
type: tool
date: 2026-10-26
sources: ["sources/jev-model-routing-2026-10-26.md"]
---

# Jev

Jev is TypeSafe's flagship and first System One model, used as a decision layer by Hermes Agent and the `hermes-jev-skills` project.
It makes small, bounded decisions around an LLM agent so the main model does not spend frontier-model tokens on routine routing, skill selection, retrieval screening, compaction, or action choice.

Jev is not a chat or code-completion LLM.
TypeSafe documents it as a model that evaluates typed questions against a state and returns structured answers that software can branch on, sort, and route with.

## Model-routing role

Jev classifies a turn by three dimensions:

1. **Difficulty** - from trivial/routine to substantial/expert work.
2. **Specialty** - such as general, coding, writing, research, or vision.
3. **Costly-mistake risk** - whether an error would have meaningful consequences.

Code then chooses the first matching model from an ordered pool.
The classifier does not emit a command or arbitrary model action for direct execution.

## TypeSafe primitives

The official primitives are:

- `choice` - choose an option from a list, with probabilities and confidence.
- `score` - score the state on a defined rubric, with probabilities and confidence.
- `noul` - return a 0-1 truth likelihood for a statement.

TypeSafe's documentation states that Jev does not write code, stream a conversation, or call tools.

## Routing modes

| Mode | Behavior |
|---|---|
| `shadow` | Decide and log, but keep the current model. Recommended starting mode. |
| `on` | Permit Jev to switch models within configured provider/pool constraints. |
| `off` | Do not route; retain the configured model. |

An explicit `/model` choice wins over Jev.
A plugin can swap the model but not the provider connection.

## Safety and failure behavior

Jev uses closed sets, schema validation, probability-consistency checks, time budgets, and fail-open behavior.
If the service is unavailable, slow, malformed, or contradictory, the agent continues as it would without Jev.
Sensitive-looking turns and private profiles can use coarse features instead of prompt text.

These mechanisms reduce routing risk but do not make a downstream model response safe or correct by themselves.

## Operations

- `jev route --prompt "..." --current "provider:model"`
- `jev models list`
- `jev models suggest --write`
- `/jev routing shadow`
- `/jev routing on`
- `/jev routing off`
- `/jev notice on`

## Evidence boundary

The project documents the routing design and installation/runtime provenance checks.
Those documents do not prove that every live process has reloaded the inspected files or that estimated savings equal a billing statement.

## Related pages

- [[model-routing]]
- [[jev-model-routing-2026-10-26]]
- [[llm-gateway]]
- [[harness-engineering]]
- [[skills-as-markdown]]

## Links

- Repository: https://github.com/kerpopule/hermes-jev-skills
