---
title: "Jev Model and Model Routing - Research Snapshot"
tags: [source, jev, model-routing, agent-engineering, inference-routing, observability]
sources: ["raw/articles/jev-model-routing-2026-10-26.md"]
date: 2026-10-26
---

# Jev Model and Model Routing - Research Snapshot

**Research date:** 2026-10-26 (Asia/Bangkok).

**Primary sources:** [TypeSafe official introduction](https://docs.typesafe.ai/introduction.md), [TypeSafe guidance for coding agents](https://docs.typesafe.ai/introduction/coding-agents.md), and the [hermes-jev-skills repository](https://github.com/kerpopule/hermes-jev-skills).

**Observed local revision:** `02f0461cfda2dda7353e916e38d9e97ef87c68c2`, release text `0.25.1`.

## Summary

TypeSafe describes Jev as its flagship and first System One model.
It evaluates typed questions against a state and returns structured answers, probabilities, and confidence for some question types.
It is a decision model, not the main text-generation or code-completion model.
Hermes Agent uses Jev as a decision service for bounded routing and control decisions around an LLM agent.
The central model-routing path evaluates task difficulty, specialty, and costly-mistake risk, then lets deterministic code select a model from configured pools.

## Key observations

- A fresh Hermes turn is classified once for routing.
- The official TypeSafe primitives are `choice`, `score`, and `noul`.
- TypeSafe explicitly says Jev does not write code, stream chat, or call tools.
- `shadow` observes and logs a proposed route without switching.
- `on` allows model switching, while `off` disables it.
- Explicit `/model` selection takes precedence.
- Pools are ordered by tier and specialty, with `general` fallback and upward tier movement.
- Risk raises a minimum tier but does not automatically imply the hardest tier.
- Large contexts conservatively keep the current model to avoid cache-rebuild costs.
- Jev uses closed choices and validation rather than free-form commands.
- No key, network failure, slow or malformed response causes a fail-open fallback to the non-Jev path.
- Privacy-sensitive turns can send coarse features rather than prompt text.

## Evidence boundary

These findings describe the documented design and inspected local checkout.
They do not prove the configuration or plugin bytes of every running Hermes instance, and they do not establish realized savings without runtime measurement.
The project also distinguishes configured cost estimates from billing evidence.

## Related pages

- [[jev]]
- [[model-routing]]
- [[llm-gateway]]
- [[skills-as-markdown]]
- [[harness-engineering]]

## Sources

- [Jev model-routing skill](https://github.com/kerpopule/hermes-jev-skills/blob/main/skills/jev-model-routing/SKILL.md)
- [Measurement and installation provenance](https://github.com/kerpopule/hermes-jev-skills/blob/main/docs/measurement-and-provenance.md)
- [Running Jev across a Hermes fleet](https://github.com/kerpopule/hermes-jev-skills/blob/main/docs/using-jev-in-a-hermes-fleet.md)
- [[jev-model-routing-2026-10-26]]
