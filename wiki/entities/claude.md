---
title: "Claude"
tags: [entity, tool, llm, anthropic]
sources: [https://www.anthropic.com/engineering/harness-design-long-running-apps]
date: 2026-03-24
---

# Claude

[[Anthropic]]'s family of large language models. Used across a range of agent and assistant tasks. Key models referenced in this wiki:

## Models

### Claude Sonnet 4.5
- Exhibited **context anxiety**: premature task conclusion near perceived token limits
- Required context resets (not compaction) for reliable long-running agent tasks
- Lower cost than Opus variants

### Claude Opus 4.6
- Handled continuous sessions without context anxiety
- Compatible with simplified harness designs (fewer resets needed)
- Used for the DAW experiment: 3h 50min, $124.70 for a functional browser-based DAW

## Agent Capabilities (from harness experiments)

When embedded in a [[Generator-Evaluator Architecture]] with [[Sprint Contracts]] and [[Context Management for Agents]]:
- End-to-end autonomous software engineering
- Frontend design with graded aesthetic criteria
- UI validation via Playwright
- Iterative code implementation with version control

## See Also

- [[Harness Design for Long-Running Application Development]] — source article on harness design for long-running Claude tasks
- [[Harness Engineering]] — broader agent scaffolding methodology
