# Build a Team OS with Claude Code — Hannah Stulberg

**Source:** https://www.aakashg.com/hannah-stulberg-podcast/  
**Published:** April 6, 2026  
**Host:** Aakash Gupta (Product Growth)  
**Guest:** Hannah Stulberg  
**Format:** Podcast transcript (~90 min)  
**Tags:** harness-engineering, team-os, claude-code, context-management, plan-mode, parallel-agents, knowledge-repo

---

## The Future of PM Teams (05:46)

Aakash: PMs are supporting more and more people. What does the future look like?

Hannah: The future is both that one PM is supporting a lot more people, but also roles are merging together. Engineers are building product, designers are building product, PMs are shipping code. Not only is one PM starting to support more and more people, but everyone is also starting to be a PM.

How do you scale context throughout the organization when everyone is building product and everyone is making product decisions? Everyone's also starting to do other functions. How do you help everyone make amazing product decisions and get the best of other functions for these merged roles?

## Introducing the Team OS (11:16)

Aakash: Your answer is to create a well-organized high-context repo.

Hannah: This is what I call the Team OS or Team Operating System — your team's knowledge base storing all of your team's shared context in one place that helps everybody on the team move faster and do their job to the best of their abilities.

Three main parts:
1. **`.claude` folder** — shared agents, commands, and skills shared by everyone on the team
2. **`product development` folder** — subfolders across different functions
3. **`team` folder** — team-level documents like onboarding guides or retros

At the top is the `CLAUDE.md` at the root level — the guiding route for Claude throughout the repository. Key components:
- **Doc index** — tells Claude how to navigate the repository. Without this, Claude would need to run explore agents to search the repository.
- **Team roster** — who is on the team, their handles in key products
- **Key Slack channels or DM groups**

Because the CLAUDE.md file is loaded every single time, it loads team members' Slack IDs and can use the Slack MCP to send messages on command.

## Context Management Theory (16:57)

You don't want very much in your CLAUDE.md file. CLAUDE.md files should be very lean, especially in a team repository. There are multiple levels of CLAUDE.md files — the root level loads every session; the remaining files start to load progressively as you type natural language queries.

Four key concepts:

1. **Context** — the information that is in a given session with an LLM, what information the LLM can access at a given point in time
2. **Context window** — how much information the LLM can hold. Frontier labs upped this to ~1 million tokens (~7–8 novels). Sounds like a lot, but the amount of docs produced by a team and company is much more.
3. **Compaction** — when the context window gets full, all that information needs to get compressed down. You lose a lot of fidelity — a compressed summary which is much less useful.
4. **Thinking room** — the difference between how much information is in the conversation and the size of the context window. That gap is where the model can think and reason. The more information you load, the less room there is to think and reason.

The whole repository is structured around helping Claude read and use the right information at the right time. Hannah monitors context usage in her status bar as she writes queries.

## Nested CLAUDE.md Files and Doc Indexes (19:49)

Nested CLAUDE.md files are generally just doc indexes — they tell Claude what is in each folder and what the purpose is.

Demo: querying "who are my top customers?" — Claude loads CLAUDE.md files and uses the doc indexes to navigate the repository and find exactly the right information. Only 3% of context window used. Claude didn't go into the analytics folder or data engineering folder — it didn't read a single unnecessary piece of information.

> "The art of having good CLAUDE.md files is actually minimizing the amount of context that Claude needs in order to answer a given question. It's minimizing the amount of context that's consumed and making sure you're only consuming context relevant to what you are actually trying to do."

## Customer Context and Structured Summaries (21:50)

Under a customers folder, each customer has:
- **Summary file** with 80%-session information: key contacts, what they do, their segment, plus a doc index for key resources on this account
- **Full transcripts** stored separately — only loaded when the summary doesn't have what's needed

Claude only reads summary files by default. Customer calls can be more than an hour; Claude cannot quickly synthesize 50 transcripts at high fidelity, which is why the repo is set up so it only goes into transcripts when necessary.

## Shared Agents, Commands, and Skills (23:44)

Teams should organize information in a structured way for Claude so that all customer call summaries follow the same format. That's why you have a **customer call skill** — everyone on the team who's summarizing a customer call summarizes it in exactly the same way, puts it in exactly the same place. Then cross-customer analysis is easy because everything follows a consistent format.

> "You're multiplying leverage by creating these skill files to take unstructured inputs but then structure the summaries in a similar way."

## The Analytics Folder and Scaling Data Analysis (28:03)

Analytics folder contains: links to dashboards, experiment analysis and results, investigations, and — most importantly — **metrics playbooks, queries, and schemas**.

Organized by topic area and then product area. Under each area:
- All relevant dashboards linked
- SQL queries for those metrics
- Table schemas backing those metrics

As a PM, you get access to the analyst's brain and everything set up for doing analysis correctly. Everyone — PMs, engineers — can check on a feature without being reliant on a data scientist.

**Reason to split out metrics, queries, and schemas separately:** if you just want to know what the metrics for a billing feature are, you don't want Claude to also pull all the queries and all the schemas to answer that.

## Feature Launch Rule (35:04)

> "When we're rolling out a new feature, the feature is not rolled out until the repository is updated."

This ensures the shared context stays current as the product grows more complex.

## Engineering Folder and Bug Investigations (36:06)

Bug investigations stored across the product — helpful because bugs usually recur in the same part of the product. For each investigation: when was it investigated, what was the scope, what parts of the infrastructure did it touch, how was it analyzed, what was the root cause, how was it fixed.

## Ownership and Shared Responsibility (37:23)

Everyone is an owner of the knowledge repository. Each functional lead takes ownership of their area. But the team as a whole agrees on how to structure the information.

Shared automations as the third pillar: using information in the repository to run a weekly report that synthesizes all customer research, then posting a message in Slack so everyone stays up to date.

## Checking In Daily Work (38:54)

Hannah only works in Claude Code. Every single doc is written first in Claude, then checked into the repo for review. Whole design team, engineers, data scientists work this way.

Non-technical roles — business operations, product operations, strategy and operations partners — are also participating, putting up PRs, adding context into the repo. One strategy partner had never opened GitHub two months ago; now she puts up PRs every day.

> "I see a lot of chatter online that this way of working is only for PMs, or only for engineers, or only for technical people. I think that's very incorrect. Anyone can learn how to do this."

## GitHub 101 (44:07)

Process: put work onto a branch → commit at milestones → open a pull request for review → tag reviewers → merge to main when done.

With GitHub CLI or MCP hooked up, you can write "put up a PR for Morgan to review this PRD" and it just works. Shared commands can create PRs that post Slack messages to the team channel with specific structures.

## Plan Mode Deep Dive (45:06)

Without plan mode: Claude has a bias for action — like an eager junior employee who dives straight in without guidance.

To enter plan mode: **Shift+Tab twice**. This takes away the bias for action — like taking away the keys, saying "we're only planning right now."

**Lightweight alignment proposal first (even for simple tasks):** Even just asking "give me a proposal for what you're going to do" gets much better, more consistent results before diving in.

**Reading the plan:** The most important part of having a good plan is actually reading it. If you're going to send someone off to burn a bunch of tokens, you want to know what they're going to do.

## Context Rot (52:53)

**Context rot** — when context in the repository becomes outdated and Claude uses stale information. Keeping the repo updated is critical. When checking in a PR, it contains every single thing changed in the repo as it relates to the task — not just the output doc but also the updated competitive intel, metrics files, etc.

## Advanced Planning Techniques (55:15 – 1:07:04)

**Parallel research:** Claude does not naturally parallelize plans. You need to explicitly create phases of work and broaden the scope to get work done at once. Create checkpoints in the plan for human review between phases.

**Verification:** A key part of planning is telling Claude what good work looks like and how to know the work is done. Examples: cite sources, provide URLs, use Playwright MCP to validate front-end features in a loop.

**Parallel agents for long documents:** Writing is expensive. When writing a very long-form doc, you generally cannot have one agent read 40 context files and write a great doc. Split sections across multiple agents. Be directive about:
- Which sections each agent writes
- What context each section needs
- Who writes each section
- How the orchestrating agent synthesizes them

**Critical:** each agent must write output to temporary files. If ten agents return work to the parent simultaneously, everything crashes and you lose all work.

**Storing plan files in the repo:** Put time into writing a plan → store it in the repo for future reference. Natural plan files are ephemeral (wiped every 24–72 hours). Store them explicitly to speed up future similar work and provide historical context. (OpenAI published on this in their harness engineering article — making plan files first-class artifacts of the shared repo.)

**Agent prompts:** Ask Claude to write out what it's going to prompt every single sub-agent with — what context, what files. Especially important for writing tasks where inconsistent context means inconsistent output.

**Do not summarize plan files** — you want another session to be able to build off the plan in its entirety.

## Inviting Claude as a Thinking Partner (1:07:04)

Use the ask-user-question tool explicitly: "use the ask-user-question tool to push me on my thinking and help me consider other angles." Claude will interview you — catching gaps in reasoning, pushing to consider things from different angles.

> "Most people rush in, let it write the first draft, then yell at it. Your approach is: spend time getting the plan right and then iterate on it."

## Writing Guides and Skill Invocation (1:11:06)

Skills only have ~70% auto-invoke rate. When letting something run for a long time, don't leave anything to chance — always explicitly specify in the plan which commands or skills to call.

Writing guides stored in user-level `.claude` folder. In plans, agents are explicitly given the writing guide.

The skill improvement flywheel: when a PM sees an amazing strategy doc, they tell Claude to update the skill based on that example, iterate, see where it fell apart, and improve the skill itself.

## Beginner's Mindset (1:17:16)

Ask Claude about anything you don't understand. Ask it to explain why a repository is structured the way it is, and what could be improved. Don't use skills, commands, or agents you don't understand — if you're just copying without understanding, when it doesn't work you won't know how to fix it.

Aakash's "10x my setup" prompt: research everything Anthropic has shipped in the last 90 days → research top Claude Code influencers' best posts → compare to your current setup → tell you how to improve.

## Key Takeaways

- **Team OS = shared knowledge repo** — the organizational layer that makes AI-native teams work
- **Lean CLAUDE.md files** — progressive disclosure of context, not front-loaded dumps
- **Structured summaries** — skills enforce consistent format; cross-analysis becomes easy
- **Feature not shipped until repo updated** — context currency as a launch gate
- **Everyone participates** — non-technical team members can and should contribute via PRs
- **Plan before building** — under-planning is the most common mistake
- **Store plan files** — ephemeral by default; explicitly save complex plans to the repo
- **Parallel agents with temp files** — split long writing tasks; prevent simultaneous returns
- **Context rot is real** — keep repo updated or Claude uses stale information
- **70% skill auto-invoke rate** — explicitly specify skills in plans for long-running tasks
