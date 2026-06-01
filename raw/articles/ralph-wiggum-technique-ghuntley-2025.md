---
title: "Ralph Wiggum as a 'software engineer'"
source_url: https://ghuntley.com/ralph/
author: Geoffrey Huntley
date_fetched: 2026-06-01
tags: [ai-coding, harness-engineering, agentic-loop, claude-code, vibe-coding]
---

# Ralph Wiggum as a "software engineer"

How Ralph Wiggum went from 'The Simpsons' to the biggest name in AI right now - [Venture Beat](https://venturebeat.com/technology/how-ralph-wiggum-went-from-the-simpsons-to-the-biggest-name-in-ai-right-now?ref=ghuntley.com)

watch this to see it in practice and learn the theory; read below to go deeper

watch this to learn why the claude code plugin isn't it 🤝

If you've seen my socials lately, you might have seen me talking about Ralph and wondering what Ralph is. Ralph is a technique. In its purest form, Ralph is a Bash loop.

```bash
while :; do cat PROMPT.md | claude-code ; done
```

Ralph can replace the majority of outsourcing at most companies for greenfield projects. It has defects, but these are identifiable and resolvable through various styles of prompts.

That's the beauty of Ralph - the technique is deterministically bad in an undeterministic world. Ralph can be done with any tool that does not cap tool calls and usage.

Ralph is currently building a brand new programming language. We are on the final leg before a brand new production-grade esoteric programming language is released. What's kind of wild to me is that Ralph has been able to build this language and is also able to program in this language without that language being in the LLM's training data set.

## what's in the prompt.md? can I have it?

There seems to be an obsession in the programming community with the perfect prompt. There is no such thing as a perfect prompt.

Whilst it might be tempting to take the prompt from CURSED, it won't make sense unless you know how to wield it. You probably won't get the same outcomes by taking the prompt verbatim, because it has evolved through continual tuning based on observation of LLM behaviour. When CURSED is being built, I'm sitting there watching the stream, looking for patterns of bad behaviour—opportunities to tune Ralph.

## first some fundamentals

While I was in SFO, everyone seemed to be trying to crack on multi-agent, agent-to-agent communication and multiplexing. At this stage, it's not needed. Consider microservices and all the complexities that come with them. Now, consider what microservices would look like if the microservices (agents) themselves are non-deterministic—a red hot mess.

What's the opposite of microservices? A monolithic application. A single operating system process that scales vertically. Ralph is monolithic. Ralph works autonomously in a single repository as a single process that performs one task per loop.

To get good outcomes with Ralph, you need to ask Ralph to do one thing per loop. Only one thing. Now, this might seem wild, but you also need to trust Ralph to decide what's the most important thing to implement. This is full hands-off vibe coding that will test the bounds of what you consider "responsible engineering".

LLMs are surprisingly good at reasoning about what is important to implement and what the next steps are.

Your task is to implement missing stdlib (see @specs/stdlib/*) and compiler functionality and produce an compiled application in the cursed language via LLVM for that functionality using parrallel subagents. Follow the @fix_plan.md and choose the most important thing.

There's a few things in the above prompt which I'll expand upon shortly but the other key thing is deterministically allocate the stack the same way every loop.

The items that you want to allocate to the stack every loop are your plan ("@fix_plan.md") and your specifications. See below if specs are a new concept to you.

## one item per loop

One item per loop. I need to repeat myself here—one item per loop. You may relax this restriction as the project progresses, but if it starts going off the rails, then you need to narrow it down to just one item.

The name of the game is that you only have approximately 170k of context window to work with. So it's essential to use as little of it as possible. The more you use the context window, the worse the outcomes you'll get. Yes, this is wasteful because you're effectively burning the allocation of the specifications every loop and not reusing the allocation.

## extend the context window

The way that agentic loops work is by executing a tool and then evaluating the result of that tool. The evaluation results in an allocation being added to your context window.

Ralph requires a mindset of not allocating to the primary context window. Instead, what you should do is spawn subagents. Your primary context window should operate as a scheduler, scheduling other subagents to perform expensive allocation-type work, such as summarising whether your test suite worked.

Another thing to realise is that you can control the amount of parallelism for subagents.

If you were to fan out to a couple of hundred subagents and then tell those subagents to run the build and test of an application, what you'll get is bad form back pressure. Thus, the instruction above is that only a single subagent should be used for validation, but Ralph can use as many subagents as he likes for searching the file system and for writing files.

## don't assume it's not implemented

The way that all these coding agents work is via ripgrep, and it's essential to understand that code-based search can be non-deterministic.

A common failure scenario for Ralph is when the LLM runs ripgrep and comes to the incorrect conclusion that the code has not been implemented. This failure scenario is easily resolved by erecting a sign for Ralph, instructing Ralph not to make assumptions.

Before making changes search codebase (don't assume an item is not implemented) using parrallel subagents. Think hard.

If you wake up to find that Ralph is doing multiple implementations, then you need to tune this step. This nondeterminism is the Achilles' heel of Ralph.

## phase one: generate

Generating code is now cheap, and the code that Ralph generates is within your complete control through your technical standard library and your specifications.

If Ralph is generating the wrong code or using the wrong technical patterns, then you should update your standard library to steer it to use the correct patterns.

If Ralph is building the wrong thing completely, then your specifications may be incorrect. A big, hard lesson for me when building CURSED was that it was only a month in that I noticed that my specification for the lexer defined a keyword twice for two opposing scenarios, which resulted in a lot of time wasted. Ralph was doing stupid shit, and I guess it's easy to blame the tools instead of the operator.

## phase two: backpressure

This is where you need to have your engineering hat on. As code generation is easy now, what is hard is ensuring that Ralph has generated the right thing. Specific programming languages have inbuilt back pressure through their type system.

Now you might be thinking, "Rust! It's got the best type system." However, one thing with Rust is that the compilation speed is slow. It's the speed of the wheel turning that matters, balanced against the axis of correctness.

Which language to use requires experimentation. As I'm creating a compiler, I wanted extreme correctness, which meant using Rust; however, this approach means it's built more slowly. These LLMs are not very good at generating the perfect Rust code in one attempt, which means they need to make more attempts.

That can be either a positive or a negative thing.

In the diagram above, it just shows the words "test and build", but this is where you put your engineering hat on. Anything can be wired in as back pressure to reject invalid code generation. That could be security scanners, it could be static analysers, it could be anything. But the key collective sum is that the wheel has got to turn fast.

A staple when building CURSED has been the following prompt. After making a change, run a test just for that unit of code that was implemented and improved.

After implementing functionality or resolving problems, run the tests for that unit of code that was improved. If you're using a dynamically typed language, I must stress the importance of wiring in a static analyser/type checker when Ralphing, such as:

- https://www.erlang.org/doc/apps/dialyzer/dialyzer.html
- https://pyrefly.org/

If you do not, then you will run into a bonfire of outcomes.

## capture the importance of tests in the moment

When you instruct Ralph to write tests as a form of back pressure, because we are writing Ralph doing one thing and one thing only, every loop, with each loop with its new context window, it's crucial in that moment to ask Ralph to write out the meaning and the importance of the test explaining what it's trying to do.

Important: When authoring documentation (ie. rust doc or cursed stdlib documentation) capture the why tests and the backing implementation is important.

In implementation, it looks similar to this. To me, I see it like leaving little notes for future iterations by the LLM, explaining why a test exists and its importance because future loops will not have the reasoning in their context window.

I've found that it helps the LLMs decide if a test is no longer relevant or if the test is important, and it affects the decision-making whether to delete, modify or resolve a test [failure].

## no cheating

Claude has the inherent bias to do minimal and placeholder implementations. So, at various stages in the development of CURSED, I've brought in a variation of this prompt.

After implementing functionality or resolving problems, run the tests for that unit of code that was improved. If functionality is missing then it's your job to add it as per the application specifications. Think hard.

If tests unrelated to your work fail then it's your job to resolve these tests as part of the increment of change.

9999999999999999999999999999. DO NOT IMPLEMENT PLACEHOLDER OR SIMPLE IMPLEMENTATIONS. WE WANT FULL IMPLEMENTATIONS. DO IT OR I WILL YELL AT YOU

Do not be dismayed if, in the early days, Ralph ignores this sign and does placeholder implementations. The models have been trained to chase their reward function, and the reward function is compiling code. You can always run more Ralphs to identify placeholders and minimal implementations and transform that into a to-do list for future Ralph loops.

## the todo list

Speaking of which, here is the prompt stack I've been using over the last couple of weeks to build the TODO list. This is the part where I say Ralph will test you. You have to believe in eventual consistency and know that most issues can be resolved through more loops with Ralph, focusing on the areas where Ralph is making mistakes.

study specs/* to learn about the compiler specifications and fix_plan.md to understand plan so far.

The source code of the compiler is in src/*

The source code of the examples is in examples/* and the source code of the tree-sitter is in tree-sitter/*. Study them.

The source code of the stdlib is in src/stdlib/*. Study them.

First task is to study @fix_plan.md (it may be incorrect) and is to use up to 500 subagents to study existing source code in src/ and compare it against the compiler specifications. From that create/update a @fix_plan.md which is a bullet point list sorted in priority of the items which have yet to be implemeneted. Think extra hard and use the oracle to plan. Consider searching for TODO, minimal implementations and placeholders. Study @fix_plan.md to determine starting point for research and keep it up to date with items considered complete/incomplete using subagents.

Second task is to use up to 500 subagents to study existing source code in examples/ then compare it against the compiler specifications. From that create/update a fix_plan.md which is a bullet point list sorted in priority of the items which have yet to be implemeneted. Think extra hard and use the oracle to plan. Consider searching for TODO, minimal implementations and placeholders.

Third task is to use up to 500 subagents to study existing source code in src/stdlib/ then compare it against the compiler specifications. From that create/update a fix_plan.md which is a bullet point list sorted in priority of the items which have yet to be implemeneted. Think extra hard and use the oracle to plan. Consider searching for TODO, minimal implementations and placeholders.

Fourth task is to use up to 500 subagents to study existing source code in tree-sitter/ then compare it against the compiler specifications. From that create/update a fix_plan.md which is a bullet point list sorted in priority of the items which have yet to be implemeneted. Think extra hard and use the oracle to plan. Consider searching for TODO, minimal implementations and placeholders.

What is described above is the TODO list generation technique. You use large-scale parallel subagents (up to 500 per task) to audit the entire codebase against specifications, identify gaps, and produce a prioritized fix_plan.md. This is how you build the TODO list — not by guessing, but by exhaustively comparing implementation against spec.

Once the TODO list is built, you hand it to Ralph and let Ralph work through it one item at a time.
