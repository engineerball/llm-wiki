---
title: "Ralph Wiggum Technique — Agentic Loop Coding"
tags: [ai-coding, harness-engineering, agentic-loop, claude-code, vibe-coding, subagents]
sources: [ralph-wiggum-technique-ghuntley-2025]
author: Geoffrey Huntley
url: https://ghuntley.com/ralph/
date: 2025-07
---

# Ralph Wiggum Technique

The Ralph Wiggum Technique (or simply "Ralph") is an agentic coding methodology where a coding agent (e.g., Claude Code) runs in an autonomous loop — performing one task per iteration, using specifications and a fix plan as its "stack" allocation each cycle. Named after the Simpsons character, it embodies the philosophy that LLM-driven coding works through eventual consistency: the technique is "deterministically bad in an undeterministic world," but compounding loops with careful tuning produce reliable outcomes.

Created and popularized by Geoffrey Huntley while building **CURSED**, a new esoteric programming language compiled via LLVM — a project where the language itself wasn't in the LLM's training data, proving Ralph's capacity for genuinely novel synthesis.

## Core Loop

```bash
while :; do cat PROMPT.md | claude-code ; done
```

A monolithic single-process loop in a single repository. Not multi-agent — deliberately monolithic, the opposite of microservices, because non-deterministic microservices would be chaos.

## Key Principles

### One Item Per Loop
Each iteration implements exactly one task. The LLM decides what's most important from the fix plan. As the project matures, this restriction can relax, but if things go off the rails, narrow back to one item. The ~170k context window is the limiting factor — using less yields better outcomes.

### Deterministic Stack Allocation
Every loop re-loads the same "stack": specifications and fix_plan.md. This is "wasteful" (burning allocation each loop) but ensures consistent context across iterations despite the fresh context window.

### Specifications Over Perfect Prompts
No "perfect prompt" exists. Instead, specs are built through early conversation with the LLM about requirements, then codified as per-file specification documents. The prompt evolves through continual observation of LLM behavior — tuning like tuning a guitar.

### Subagents as Context Extension
Primary context window operates as a scheduler. Expensive work (codebase search, file writes, test summarization) is delegated to subagents. Key rule: only **one** subagent for build/test/validation (to avoid back-pressure from parallel compilation), but unlimited subagents for search and file I/O.

### Don't Assume Unimplemented
Ripgrep-based code search is non-deterministic. A common failure is the LLM concluding code isn't implemented when it actually is. The fix: explicit instruction to search before assuming, using parallel subagents.

## Two-Phase Architecture

### Phase 1: Generate
Code generation is cheap. Wrong code patterns → update standard library. Wrong features → fix specifications. The operator's job is steering through specs and stdlib, not writing code.

### Phase 2: Backpressure
Ensuring correctness. The "wheel" (loop iteration speed) must turn fast. Type systems, static analyzers, security scanners, and test suites all serve as backpressure. For dynamically-typed languages, a static type checker is mandatory (e.g., Dialyzer for Erlang, Pyrefly for Python).

## Test Documentation as Future Context
Since each loop has a fresh context window, tests must carry their own reasoning. Tests should include documentation explaining *why* they exist and what they verify — serving as "notes for future iterations" that help the LLM decide whether to delete, modify, or fix a test.

## Anti-Placeholder Enforcement
Claude has an inherent bias toward minimal/placeholder implementations. Explicit "DO NOT IMPLEMENT PLACEHOLDER" prompts help, but models chase their reward function (compiling code). Countermeasure: run additional Ralph loops specifically to audit for placeholders and generate TODO items.

## TODO List Generation
Uses up to 500 parallel subagents per task to audit the entire codebase against specifications:
1. Study specs + fix_plan.md
2. Compare src/ against specs → update fix_plan.md
3. Compare examples/ against specs → update fix_plan.md
4. Compare stdlib/ against specs → update fix_plan.md
5. Compare tree-sitter/ against specs → update fix_plan.md

Produces a prioritized bullet-point fix_plan.md. Then hand it to Ralph to work through one item at a time.

## Relationship to [[harness-engineering|Harness Engineering]]
Ralph is a pure expression of [[harness-engineering|Harness Engineering]] philosophy: the operator doesn't write code — they design the environment (specs, stdlib, backpressure mechanisms, prompt "signs") that steers the agent. The operator tunes Ralph by observing behavior and adding constraints, not by writing implementation. The "signs next to the slide" metaphor directly maps to [[guides-and-sensors|Guides and Sensors]].

## Philosophy: Eventual Consistency & Operator Skill
Ralph requires faith in eventual consistency. When Ralph goes wrong, the operator looks inside — not at the tools. Each failure becomes a tuning opportunity. This mirrors Huntley's broader thesis on deliberate intentional practice: AI outcomes reflect operator skill, not tool quality.

## References
- Geoffrey Huntley, [ghuntley.com/ralph](https://ghuntley.com/ralph/) (2025)
- Venture Beat: [How Ralph Wiggum went from 'The Simpsons' to the biggest name in AI](https://venturebeat.com/technology/how-ralph-wiggum-went-from-the-simpsons-to-the-biggest-name-in-ai-right-now)
- Related: [[harness-engineering|Harness Engineering]], [[one-shot-agent|One-Shot Agent]], [[claude|Claude]], [[context-management-for-agents|Context Management for Agents]]
