---
title: "Harness Design for Long-Running Application Development"
aliases: ["Harness Design for Long-Running Application Development"]
tags: [source, anthropic, claude, multi-agent, harness, frontend-engineering]
sources: [https://www.anthropic.com/engineering/harness-design-long-running-apps]
date: 2026-03-24
---

# Harness Design for Long-Running Application Development

**Author:** Prithvi Rajasekaran (Anthropic Labs)
**Published:** March 24, 2026
**URL:** https://www.anthropic.com/engineering/harness-design-long-running-apps

## Summary

Anthropic engineer describes building multi-agent harnesses to enable [[Claude]] to do extended frontend design and autonomous software engineering. Naive single-agent approaches fail at long tasks due to context degradation and self-evaluation blindness. The solution: specialize agents into Planner / Generator / Evaluator roles with explicit [[Sprint Contracts]] and [[Generator-Evaluator Architecture]] inspired by GANs.

## Core Failure Modes of Naive Single-Agent Approaches

### 1. Context Degradation
- Models lose coherence as context windows fill
- **"Context anxiety"**: Claude Sonnet 4.5 would prematurely conclude work near perceived token limits
- Later models (Opus 4.6) handled continuous sessions better — context management assumptions became stale with model improvement

### 2. Self-Evaluation Blindness
- Agents reliably praise their own outputs even when mediocre
- Especially severe on subjective tasks (design) where no binary pass/fail test exists
- Requires an independent evaluator to surface real quality gaps

## The Generator-Evaluator Loop (Frontend Design)

Inspired by GANs: one agent generates, another evaluates, they iterate.

Four grading criteria for design quality:
1. **Design quality** — coherent visual identity (colors, typography, layout)
2. **Originality** — deliberate choices vs generic AI patterns
3. **Craft** — technical execution (hierarchy, spacing, contrast)
4. **Functionality** — usability and task completion

Criteria explicitly penalized "AI slop" patterns. Weighting design and originality higher pushed the model toward aesthetic risk-taking.

## Three-Agent Architecture (Full-Stack Apps)

| Agent | Role |
|-------|------|
| **Planner** | Expands brief prompts → comprehensive product specs; focuses on scope not implementation |
| **Generator** | Implements features iteratively; stack: React, Vite, FastAPI, SQLite/PostgreSQL; uses version control |
| **Evaluator** | Uses Playwright to interact with running app; tests against [[Sprint Contracts]] |

## Sprint Contracts

Before implementation, Generator and Evaluator negotiate explicit agreements defining what "done" means — specific, measurable success criteria bridging high-level specs and testable details. See [[Sprint Contracts]].

## Context Management Strategy

Two approaches evaluated:
- **Context reset**: completely clear history, pass structured handoffs to fresh context
- **Context compaction**: summarize and compress context, continue same session

Context resets outperformed compaction for Claude Sonnet 4.5 (strong context anxiety). Opus 4.6 handled continuous sessions well — model-specific assumption. See [[Context Management for Agents]].

## Quantitative Results

### Retro Game Maker

| Approach | Duration | Cost | Quality |
|----------|----------|------|---------|
| Single-agent | 20 min | $9 | Non-functional (entities didn't respond to input) |
| Three-agent harness | 6 hours | $200 | Fully playable (sprite animation, behavior systems, AI design features) |

### Digital Audio Workstation (DAW)

Using simplified harness (Planner + Generator + single-pass Evaluator) with Opus 4.6:
- Duration: 3h 50min
- Cost: $124.70
- Output: Functional browser-based DAW with Web Audio API, autonomous agent composition

Evaluator caught gaps generator alone missed: "Clips can't be dragged/moved on the timeline, there are no instrument UI panels (synth knobs, drum pads), and no visual effect editors."

## Evaluation Tuning Challenges

- Out-of-the-box evaluators trend toward lenient approval and shallow testing
- Required iterative prompt refinement to get meaningful critique
- Final harness still had "small layout issues, interactions that felt unintuitive in places, and undiscovered bugs in more deeply nested features"

## Key Lessons

1. **Test against realistic problems** — examine detailed execution traces, not just final output
2. **Incremental simplification** — remove one component at a time to find load-bearing elements
3. **Model-aware design** — re-examine harness assumptions with each new model release
4. **Evaluator value is task-dependent** — valuable at model capability boundaries; overhead for routine tasks

## Central Thesis

> "Every component in a harness encodes an assumption about what the model can't do on its own, and those assumptions are worth stress testing."

> "The space of interesting harness combinations doesn't shrink as models improve. Instead, it moves, and the interesting work for AI engineers is to keep finding the next novel combination."
