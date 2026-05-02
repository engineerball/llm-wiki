---
title: "Generator-Evaluator Architecture"
aliases: ["Self-Evaluation Blindness"]
tags: [concept, multi-agent, harness, evaluation, gan-inspired]
sources: [https://www.anthropic.com/engineering/harness-design-long-running-apps]
date: 2026-03-24
---

# Generator-Evaluator Architecture

A multi-agent pattern where one agent generates output and a separate agent evaluates it, creating a feedback loop. Inspired by Generative Adversarial Networks (GANs). Addresses the fundamental problem of **self-evaluation blindness**: agents reliably praise their own outputs even when quality is mediocre.

Described in [[harness-design-long-running-apps]] by [[prithvi-rajasekaran]] ([[anthropic]], 2026).

## Why Separate Generation from Evaluation

A single agent cannot objectively assess its own output:
- No independent perspective on quality
- Especially broken for subjective tasks (design, UX) with no binary pass/fail
- Agent optimizes to feel complete, not to be complete

Separating roles breaks this loop: the evaluator has no sunk cost in the generated work and can surface real gaps.

## Basic Pattern

```
Prompt → Generator → Output → Evaluator → Score + Feedback
                       ↑__________________________________|
                                  (iterate)
```

## Extended: Three-Agent Pattern (Full-Stack Apps)

| Agent | Responsibility |
|-------|---------------|
| **Planner** | Expands brief → comprehensive spec; scope not implementation |
| **Generator** | Implements iteratively; owns version control |
| **Evaluator** | Tests running app (Playwright); judges against [[sprint-contracts]] |

The Planner decouples intent specification from implementation so the Generator works against a stable, detailed target.

## Sprint Contracts

Generator and Evaluator pre-negotiate [[sprint-contracts]]: explicit, measurable definitions of "done" before implementation begins. Prevents the evaluator from applying arbitrary or shifting standards.

## Evaluation Design

Effective evaluators require intentional prompt design:
- Out-of-the-box evaluators trend toward **lenient approval** and **shallow testing**
- Must specify grading criteria explicitly (e.g., design quality, originality, craft, functionality)
- Can penalize specific anti-patterns ("AI slop") by name
- Requires iterative tuning — trace execution logs, not just final scores

## Tradeoffs

| | Single Agent | Generator-Evaluator |
|---|---|---|
| Cost | Low ($9 for game example) | High ($200 for same) |
| Quality at limits | Often non-functional | Often fully functional |
| Overhead | Zero | Justified only near capability boundaries |
| Context use | Efficient | More complex to manage |

## When to Use

Valuable when:
- Task is at or near model capability boundary
- Quality is hard to verify programmatically (subjective, UI, design)
- Long-running tasks where context degradation is a risk
- Self-evaluation blindness is expected to be severe

Not worth the overhead for routine, well-defined, easily verifiable tasks.

## Model-Specific Notes

- Claude Sonnet 4.5: context anxiety required context resets between generator iterations
- Claude Opus 4.6: handled continuous sessions better; simplified harness (no mid-session resets) worked

Harness design encodes assumptions about model limitations — those assumptions go stale as models improve.

## Related

- [[harness-engineering]] — broader concept of building scaffolding/environments for agents
- [[sprint-contracts]] — the negotiation mechanism between Generator and Evaluator
- [[context-management-for-agents]] — how to handle context across long generator-evaluator loops
