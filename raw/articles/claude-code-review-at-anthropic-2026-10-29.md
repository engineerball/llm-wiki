---
source_url: https://claude.dev/blog/solving-code-review-at-anthropic/
ingested: 2026-10-29
sha256: 6c773b9276cf47c384d0f4f13fc46cbc3319c0043eea01953186b1e31ef60d39
---

# Solving Code Review at Anthropic

Captured from the Anthropic Claude blog on 2026-10-29.

How the Claude Code team does code review

TREE

Rethinking the purpose of code review

The scarce resource: human time and attention

The life of a change

Layer by layer

How we make the reviewer better

Where humans stay in the loop

Sharing context across the team

You land it, you own it

When we change direction

How you can adopt this process

Where this is going

We've said before that Claude writes about 90 percent of Claude Code's own code.
The post explains how the team reviews code at the volume it produces.
From June to September, merged pull requests to Claude Code's codebase more than doubled while the share that had to be reverted fell by more than 40 percent.
The team did not remove review.
It moved most reading to machines, optimized for human time and attention, and invested in making mistakes fast and easy to undo.

## Rethinking the purpose of code review

Code review has two jobs: find and fix issues before they ship, and build shared context and codebase understanding across the team.
The post focuses mainly on finding and fixing issues.
The team replaces the question "did a human read the code?" with "what could go wrong with this change, and which check, automated or human, is the right one to catch it?"
Review runs continuously, more like spellcheck while writing.
Most changes are reviewed and fixed by Claude at least once before a human is asked to look.

## The scarce resource: human time and attention

The goal is that most pull requests in the Claude Code repositories merge with at most one human in the loop, who can be the author, with no increase in reverts or incidents.
The team tracks human approvals per PR, median and 95th percentile approvals, human comments, and how long a PR waits on a person.
Revert and incident rates are guardrails: if they rise, the team has not saved human time, but only moved it into later repair work.

## The life of a change

Before a PR, Claude runs tests, build, and linter, while a second agent reviews the diff in a fresh context.
On every PR, required CI runs lint, types, tests across platforms, build, and packaging.
Claude code review agents hunt for bugs in parallel, verifier agents vote on findings, and surviving findings are ranked by severity.
A separate security review blocks merge while findings remain open.
A risk classifier sets the approval tier at zero, one, or two human approvals, with some paths always requiring a person.
The merge queue reruns checks on the latest main with the change applied.
After merge, new behavior is placed behind a flag, used internally first, released through latest before stable, and monitored for fix-forward or rollback.

## Layer by layer

### Verification before a pull request

The team gives Claude executable checks and asks it to show outputs rather than merely claim completion.
The checks may be a bash command, test suite, browser run, phone simulator, screenshot comparison, or other domain-specific verification.
Repeated review findings are moved into the source of truth, such as a skill, lint rule, or instructional file.
`CLAUDE.md` describes the project, stack, conventions, goals, and non-goals.
`REVIEW.md` tells reviewers what matters in a code area, what failure looks like, which paths to skip, and what evidence to provide.

### AI review on every pull request

The reviewer reads the diff against the whole repository and the stated intent of the PR.
Multiple agents search for bugs in parallel.
A separate group verifies each finding and only findings with enough agreement are posted.
Style issues, diagnostics, and cleanup findings are filtered.
Findings are shown inline and labeled Important, Nit, or Pre-existing.
Every finding must be fixed or resolved with a reason.

### Security review

Security review is a separate blocking pass.
An open finding must be fixed or closed with a short reason.
A later commit that fixes the issue can clear the finding automatically.

### Automated checks

Required checks include lint, type checks, tests on every platform, and build.
The PR template asks how the change was tested and how it can be undone.

### Human approval scaled by risk

Low-risk changes such as docs, copy, internal-only features, and additive changes behind a flag may need no human approval after automated checks are green.
Medium-risk product changes and sensitive areas such as caching, the auto-updater, or system prompts need one person.
High-risk code and selected sensitive paths need two people.
The change sets the risk tier, not the author.
CI workflow files and owner-listed sensitive paths always require a person.
An agent approval never counts as a required human approval.
Approval covers a specific commit and must be renewed when untrusted new commits land.

### Merge queue, flags, and gradual release

The merge queue reruns checks against main with the change applied, preventing separately passing pull requests from combining into broken main.
New behavior ships behind a flag to Anthropic employees first.
Public releases go to the latest channel first while stable trails it.

### Fast detection and rollback

Flags can be turned off without a deploy.
A weekly on-call rotation, authors, telemetry, revert dashboards, and incident dashboards help detect problems.
The post notes that the team did not yet have circuit breakers that automatically tighten approval when error signals move.

## How the team makes the reviewer better

Past incident-causing PRs, fix-forwards, and reverts become an evaluation set.
Engineers familiar with the code confirm each bug and where it lived.
The reviewer is run against the set daily whenever prompts, tools, or models change.
The set grows with every incident.

Noise is measured by what people do with comments: fix them, reject them as wrong, mark behavior intentional, or decide they do not matter.
The reviewer also runs on known-clean PRs to measure harmful false positives.

Review must converge.
One CLI PR went through more than fifty review and fix rounds overnight.
About 59 percent of repeated findings were code that had existed since the reviewer's first pass, showing that the reviewer was often finding more old bugs rather than new bugs.
The team added a three-round cap, diff-only re-review after early passes, class-level bug fixes, and no repeats of posted findings.
The reported results were: pass after one review and fix round increased from 65 percent to 78 percent; PRs needing five or more rounds fell from 8.9 percent to 1.5 percent; and mean reviews to pass fell from 2.08 to 1.32.
Review agents also run nightly over existing code.

## Where humans stay in the loop

Humans decide whether to build a feature, set direction and scope, review risky code, review architecture, read evidence, and own the outcome.
The person directing an agent-written PR is accountable for the change.

## Sharing context across the team

Instead of requiring people to read every trivial diff, engineers ask Claude for explainers or small visual artifacts about the exact part of the codebase they need to understand.
Open channels also let people observe work while it is being built.

## You land it, you own it

The team norm is that the person who lands a small or medium change usually fixes it if something goes wrong.
Small changes, flags, reverts, staged releases, fast telemetry, and system-focused incident reviews make this ownership model workable.

## Adoption guidance

Before a PR, give the agent runnable checks in a short `CLAUDE.md`, use hooks for formatters and linters, run code and security review locally or through a fresh-context subagent, and add a concise `REVIEW.md`.
On every PR, require CI, add Testing, Risk, and How to revert to the template, introduce AI review in one repository, add automated security review, resolve every review thread, match review depth to risk, and cap review rounds.
For approval, define risk tiers from the change, use CODEOWNERS and branch protection for sensitive paths, never allow a bot to replace a required human, and dismiss approvals on new commits.
After merge, use a merge queue, feature flags, internal use first, staged releases, one-step rollback, and an evaluation set built from incidents and reverts.

## Boundary of evidence

This capture records the claims and measurements stated by the source.
The article does not establish that AI review alone caused the revert-rate change.
The stated percentages are Anthropic's internal results and should not be treated as universal benchmarks without local baselines.
