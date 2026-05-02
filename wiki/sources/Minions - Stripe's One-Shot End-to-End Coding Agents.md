---
title: "Minions: Stripe's One-Shot End-to-End Coding Agents"
tags: [source, stripe, coding-agent, one-shot, harness-engineering, software-development]
sources: [https://stripe.dev/blog/minions-stripes-one-shot-end-to-end-coding-agents]
date: 2026-05-02
author: Stripe Engineering
---

# Minions: Stripe's One-Shot End-to-End Coding Agents

**Author:** Stripe Engineering
**URL:** https://stripe.dev/blog/minions-stripes-one-shot-end-to-end-coding-agents
**Publisher:** stripe.dev

## Summary

Stripe describes their production coding agent system called **Minions** — autonomous agents that take a task description and execute the full software development cycle (plan → implement → verify → pull request) with minimal human intervention. "One-shot" refers to completing the full cycle without iterative human checkpoints during execution.

## Core Architecture

A Minion runs a complete end-to-end coding task:

1. **Task intake** — engineer provides a natural-language task description
2. **Planning** — agent reads relevant context from the [[Stripe Blueprints|blueprint]] system and formulates a plan
3. **Implementation** — agent writes code across files, using repo conventions
4. **Verification** — pre-push hooks run linting, type checking, and tests; agent self-corrects on failures
5. **Pull request** — agent opens a PR with changes and description; engineer reviews output, not steps

This aligns with the [[Harness Engineering]] pattern: engineers design the environment rather than write the code.

## Blueprint System

Stripe uses **blueprints** — structured documentation files that describe service contracts, expected patterns, architectural rules, and interface specifications for subsystems. Blueprints serve as [[Guides and Sensors|guides]]: feedforward controls that orient the agent before it starts writing code.

Key properties of blueprints:
- Describe *how* services are structured, not just what they do
- Enable agents to make correct architectural choices without constant human correction
- Reduce inference burden on the model — explicit conventions leave less to guess

The blueprint system is Stripe's operationalization of repository legibility for agents.

## Pre-Push Hooks as Sensors

Stripe's pre-push hooks function as [[Guides and Sensors|sensors]] in the [[Harness Engineering]] framework: they observe post-action results and enable self-correction before code enters review.

What the hooks run:
- Linters and formatters
- Type checkers
- Unit tests
- Integration tests (where applicable)

If a hook fails, the Minion receives the error output and iterates. The human engineer does not see the intermediate failures — only the final result. This is the closed-loop sensor pattern described in [[Guides and Sensors]].

## One-Shot Philosophy

"One-shot" is a design principle, not a technical constraint. The system is designed so that:
- Engineers provide a single task description and receive a reviewable PR
- All exploration, iteration, and error recovery happen inside the agent loop
- Human attention is focused at the beginning (task specification) and end (PR review)

This inverts the traditional model where humans are active in the middle (writing, debugging, testing).

## Parallel Execution

Minions run tasks in parallel across isolated worktrees, allowing multiple coding tasks to proceed simultaneously. This is the same isolation pattern described in the [[Harness Engineering - Leveraging Codex in an Agent-First World|OpenAI Codex harness experiment]]: per-worktree isolation prevents agents from interfering with each other.

## Codebase Context

Stripe operates a large monorepo with strict architectural rules. Properties that make Minions effective at Stripe:
- Strong typing (service contracts are explicit)
- Defined service topologies (blueprints encode the topology)
- Strict layering rules (enforced by the harness, not convention)
- Comprehensive test infrastructure (hooks have real signal to act on)

These are precisely the [[Harnessability]] properties identified by [[Birgitta Böckeler]]: the codebase structure makes comprehensive harness coverage tractable.

## Relationship to Harness Engineering Literature

The Stripe Minions system is cited in [[Harness Engineering for Coding Agent Users]] (Böckeler, martinfowler.com) as a real-world example of:
- Pre-push hooks as sensor controls
- Blueprint-integrated feedforward guidance

This makes Stripe one of three production-scale implementations referenced in the harness engineering literature alongside [[OpenAI]] (Codex experiment) and [[Anthropic]] (multi-agent harness).

## Key Entities

- [[Stripe]] — company that built and operates Minions
- [[Harness Engineering]] — methodology Minions instantiates
- [[Guides and Sensors]] — control framework that describes blueprints (guides) and pre-push hooks (sensors)
- [[Harnessability]] — codebase properties that make Minions work effectively at Stripe
