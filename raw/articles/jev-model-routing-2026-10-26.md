---
source_url: https://github.com/kerpopule/hermes-jev-skills
ingested: 2026-10-26
sha256: 60ca687d84ac343f2872cae2f77036e0849400627f874b3473a4b9b2c6f9711f
---

# Jev Model and Routing Research

Research date: 2026-10-26 (Asia/Bangkok).

## Scope

This note records the observed design of Jev as used by Hermes Agent and the `hermes-jev-skills` project.
The term "Jev model" is used here for a decision service and routing policy, not for the text-generation model that ultimately answers the user.

## Official TypeSafe model definition

TypeSafe's official documentation describes Jev as its flagship and first System One model.
The model evaluates typed questions against a state and returns structured answers, probabilities, and confidence for some question types.
The documented primitives are `choice`, `score`, and `noul`.
TypeSafe explicitly distinguishes Jev from chat or code-completion LLMs: Jev does not write code, stream a conversation, or call tools.
It is intended to be used inside an application or agent for routing, classification, scoring, guardrails, and other structured decisions.

## Primary local evidence

- `/home/hermes/.hermes/skills/jev/jev-model-routing/SKILL.md`
- `/home/hermes/hermes-jev-skills/README.md`
- `/home/hermes/hermes-jev-skills/docs/using-jev-in-a-hermes-fleet.md`
- `/home/hermes/hermes-jev-skills/docs/measurement-and-provenance.md`
- `/home/hermes/hermes-jev-skills/docs/lanes.md`
- `/home/hermes/hermes-jev-skills/CONTRIBUTING.md`
- Repository observed at commit `02f0461cfda2dda7353e916e38d9e97ef87c68c2`, release text `0.25.1`.
- https://docs.typesafe.ai/introduction.md
- https://docs.typesafe.ai/introduction/coding-agents.md

## Observed mechanism

Jev makes bounded decisions for an agent, including model routing, skill selection, search-result selection, compaction selection, computer-use action selection, and lane progression.
The model-routing path classifies a turn by difficulty, work specialty, and costly-mistake risk, then code selects the first suitable model from configured pools.

For Hermes model routing, a fresh user turn is classified once.
The result can select a model and effort level when routing is enabled.
`shadow` records what would have happened without switching; `on` permits switching; `off` disables routing.
A user-selected `/model` choice takes precedence.

The routing tiers are small, medium, high, and escalate in the lane workflow.
Model pools are organized by tier and specialty such as `general`, `coding`, `writing`, `research`, and `vision`.
A missing specialty falls back to `general`, and a pool does not fall down to a cheaper tier when no fit exists; it moves upward.

The default routing behavior is conservative.
Hard decisions require substantial/expert probability mass rather than an average score.
Risk words create at least a medium floor but do not alone justify the hard tier.
Large context above the sticky-context threshold keeps the current model because cache reconstruction may cost more than the routing savings.

Jev's answer is not trusted as free-form executable text.
The implementation selects from closed sets built by code, validates responses, and has fail-open behavior for no key, network failure, timeout, malformed output, or contradictory probability data.
The fallback is the behavior the agent would have used without Jev.

## Effort routing

Reasoning effort is off by default.
When explicitly configured and supported by the exact provider/model capability map, routing may set the provider's reasoning-effort field.
Existing caller effort and exact-model capability checks win.
Shadow and off do not mutate requests.

## Privacy and provenance

Sensitive-looking turns and private profiles send only coarse features instead of prompt text.
The project documents a privacy boundary and provenance checks for the installed files, source checkout, and loaded runtime.
Decision logs are written without prompt text to the Hermes Jev decision log.
Configured cost estimates are not invoices, and unknown usage prevents complete-cost claims.

## Operational commands

- `jev route --prompt "..." --current "provider:model"` asks which model should handle a task.
- `jev lane classify --task "..."` chooses a work lane.
- `jev lane step --task "..." --lane <lane> --attempt <n> --run "..." --scope "..."` evaluates progress after checks.
- Hermes commands include `/jev routing shadow`, `/jev routing on`, `/jev routing off`, and `/jev notice on`.
- `jev models list` displays available models and `jev models suggest --write` drafts pools.

## Evidence boundary and limitations

The local materials establish the intended protocol, policy, privacy boundary, thresholds, and fail-open design.
They do not by themselves prove that every deployed Hermes process has reloaded the same plugin bytes, uses the same routing configuration, or realizes a particular cost saving.
A successful installation is not proof that a running gateway has reloaded the files.
A model's confidence is treated as calibrated by Jev's decision thresholds; substituting a different classifier silently changes that assumption.

## Source links

- https://github.com/kerpopule/hermes-jev-skills
- https://github.com/kerpopule/hermes-jev-skills/blob/main/skills/jev-model-routing/SKILL.md
- https://github.com/kerpopule/hermes-jev-skills/blob/main/docs/measurement-and-provenance.md
- https://github.com/kerpopule/hermes-jev-skills/blob/main/docs/using-jev-in-a-hermes-fleet.md
- https://docs.typesafe.ai/introduction.md
- https://docs.typesafe.ai/introduction/coding-agents.md
