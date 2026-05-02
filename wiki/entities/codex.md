---
title: "Codex"
tags: [entity, tool, coding-agent, openai]
sources: [https://openai.com/index/harness-engineering/]
date: 2026-02-11
---

# Codex

[[openai]]'s AI-powered coding agent, powered by GPT-5. Executes software engineering tasks autonomously inside a repository environment.

## Capabilities (as of Feb 2026)

- End-to-end feature implementation from a single prompt
- Bug reproduction with diagnostic video generation
- UI validation via Chrome DevTools Protocol
- Access to observability stacks (logs, metrics, traces via LogQL/PromQL)
- Pull request creation and response to review feedback
- Build failure detection and remediation
- Merge execution
- Continuous task execution for 6+ hours per session

## Codex CLI

A CLI interface for Codex. Used by [[openai]] to generate the initial repository scaffold for the harness engineering experiment, using GPT-5 as the backend.

## Usage in Harness Engineering Experiment

- Generated ~1M lines of code over 5 months
- ~1,500 PRs merged across a team of 3→7 engineers
- 3.5 PRs per engineer per day throughput
- All code AI-generated; zero hand-written source code

## See Also

- [[harness-engineering]] — the methodology developed around running Codex at scale
- [[harness-engineering-leveraging-codex]] — source article
