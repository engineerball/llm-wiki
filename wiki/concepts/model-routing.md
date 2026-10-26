---
title: "Model Routing with Jev"
tags: [concept, model-routing, jev, agent-engineering, inference-routing]
date: 2026-10-26
sources: ["sources/jev-model-routing-2026-10-26.md"]
---

# Model Routing with Jev

Model routing is the practice of selecting an LLM for a request according to task requirements rather than using one model for every turn.
Jev implements this as a small decision layer around Hermes Agent.

## Routing pipeline

```text
user turn
  -> Jev classification: difficulty, specialty, costly-mistake risk
  -> policy thresholds and privacy boundary
  -> ordered tier/specialty pool
  -> deterministic first-fit model selection
  -> optional model switch and effort setting
```

## Policy characteristics

- **Tiered:** small, medium, high, and escalation paths reflect increasing difficulty or risk.
- **Specialized:** coding, research, writing, vision, and general pools can differ.
- **Conservative:** risk floors the tier; uncertainty does not automatically become hard.
- **Cache-aware:** large context can prevent switching because rebuilding context may cost more than the saving.
- **Fail-open:** if Jev cannot decide reliably, the original model path remains active.
- **Observable:** shadow mode and decision logs support calibration before enabling live switching.

## What model routing does not prove

A route selection does not prove that the selected model will answer correctly.
A configured price is not an invoice.
A plugin installation does not prove that an already-running process loaded the new bytes.
These claims require runtime, billing, or provenance evidence respectively.

## Related pages

- [[jev]]
- [[jev-model-routing-2026-10-26]]
- [[llm-gateway]]
- [[harness-engineering]]
- [[skills-as-markdown]]
