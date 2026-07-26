---
title: "Agentic Software Factory"
aliases: ["Dark Software Factory"]
tags: [concept, software-engineering, agentic-ai, harness-engineering, enterprise-ai]
date: 2026-07-26
sources: ["sources/agentic-software-factory-bcg-platinion-2026.md"]
---

# Agentic Software Factory

The **Agentic Software Factory** is an enterprise software-delivery model in which autonomous agents build, test, and ship software continuously while humans focus on **defining intent, supervising stage gates, and reviewing outcomes**.

BCG Platinion's March 2026 article also calls this the **Dark Software Factory**, borrowing the manufacturing metaphor of a fully automated factory that can run "with the lights off." In software, the phrase means not that humans disappear, but that their effort moves away from manual coding and toward factory design.

## Core Idea

The key claim is that the real transformation does **not** come from adding coding assistants to a conventional SDLC. It comes from redesigning software delivery as a factory with:

- dedicated agent assembly lines for different delivery archetypes
- codified machine-readable knowledge
- harnesses that encode organizational rules and quality gates
- automated verification and traceability at every stage
- humans acting as intent definers and accountable approvers

## What Changes in Practice

### Human role shifts
Humans move from "write and review every line" to:
- define business goals precisely
- specify what correctness means
- review architecture, intent artifacts, and outcomes
- own approval at stage gates

### Delivery structure shifts
Traditional sprint-era work gives way to faster **bolts**: compressed delivery cycles where agents do the implementation work between human checkpoints.

### Trust model shifts
Trust no longer comes primarily from human inspection of code. It comes from layered controls:
- scenario-based testing
- architecture conformance checks
- static analysis and security scans
- observability and full action traceability
- rollback-friendly DevOps

## Five Pillars

### 1. Intent-driven operating model
The bottleneck becomes clarity of intent rather than coding throughput.

### 2. Codified knowledge and technical readiness
Agents need structured access to business rules, architecture decisions, API docs, test infrastructure, and telemetry.

### 3. Workforce upskilling and role evolution
Teams need new skills in [[intent-thinking]], agent supervision, QA design, and compliance review.

### 4. Harness-architected delivery lines
Each delivery archetype — for example greenfield, brownfield, and legacy modernization — should have a tailored [[harness-engineering|harness]].

### 5. Governance, quality, and trust
The factory must produce evidence, audit trails, and explicit approval points by design.

## Why It Matters Strategically

The concept is broader than engineering productivity. It reframes enterprise strategy in four ways:

1. legacy modernization becomes economically viable again
2. the build-vs-buy threshold moves toward more custom software
3. competitive advantage shifts upstream to domain knowledge, proprietary data, and intent quality
4. competitive cycles compress because software can ship much faster

## Relationship to Existing Wiki Concepts

### Relationship to [[harness-engineering]]
Harness engineering explains **how** to make agents reliable. The Agentic Software Factory applies that logic at the **enterprise operating-model** level: not just harnessing one coding agent, but architecting multiple delivery lines, governance rules, and feedback systems around autonomous software delivery.

### Relationship to [[ai-engineering-shift]]
The [[ai-engineering-shift]] describes what happens when code generation accelerates 10–100x and bottlenecks move elsewhere. The Agentic Software Factory is one organizational response to that shift.

### Relationship to [[institutional-ai]]
Both concepts argue that the real gains come from redesigning institutions around AI rather than layering AI tools onto old workflows.

### Relationship to [[harnessability]]
A factory only works if the underlying repositories, tests, and operating environment are clean enough to support strong agent controls.

## Key Tension

The concept is optimistic about autonomy but conservative about control. It is **not** "let the agents code freely." It is closer to: let agents move fast inside a deliberately engineered system of constraints, evidence, and accountability.

## Source

- [[agentic-software-factory-bcg-platinion-2026|The Agentic Software Factory (BCG Platinion, 2026)]]
