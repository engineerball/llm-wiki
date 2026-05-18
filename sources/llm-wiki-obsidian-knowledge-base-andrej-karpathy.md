# How I Took Karpathy's LLM Wiki and Built an AI-Powered Second Brain in Obsidian

**Source:** https://aimaker.substack.com/p/llm-wiki-obsidian-knowledge-base-andrej-karpathy
**Author:** AI Maker Lab
**Ingested:** 2026-05-18

---

## Summary

The author describes building a personal knowledge base using the "LLM Wiki" pattern popularized by Andrej Karpathy. Instead of manually maintaining notes and drawing connections between them, an LLM (Claude Code) reads raw source materials and automatically generates wiki pages, cross-references, concept maps, and connections.

## Key Quote

> "Obsidian is the IDE, the LLM is the programmer, the wiki is the codebase." — Andrej Karpathy

## Three-Layer Architecture

1. **Sources/** — Raw, immutable source materials (articles, book notes, podcast takeaways, PDFs). Organized by category (AI, health-and-fitness, human-psychology, personal-productivity, books, podcasts). Never edit files in this folder.

2. **Wiki/** — LLM-generated summary pages, cross-references, and concept maps. This is the living, synthesized knowledge layer. Rarely edited manually.

3. **Schema (CLAUDE.md)** — Instructions that turn Claude from a generic chatbot into a disciplined wiki maintainer. Defines how content should be structured, linked, and formatted.

## Three Core Operations

- **/ingest-url** — Feed a URL, Claude extracts the article and compiles it into the wiki, touching 5-15 pages in a single pass
- **/process-inbox** — Fleeting thoughts and quick notes get classified and integrated automatically
- **/lint-wiki** — Health check: finds broken links, orphan pages, contradictions, and content gaps the wiki suggests researching next

## Why This Works

- **Maintenance is the killer** of note-taking systems like Zettelkasten. Most people don't draw connections between notes because it takes too much effort.
- The LLM handles all the bookkeeping automatically — wikilinks, cross-references, concept pages.
- **It compounds.** Every new source makes the whole wiki smarter. An article about automation gets connected to a podcast about AI coding workflow, which connects to an essay about writing — connections you'd never draw on your own.

## Stack

- **Interface:** Obsidian (with Obsidian Skills by Steph Ango for wikilinks, callouts, canvas, frontmatter, CLI)
- **Agent:** Claude Code
- **Storage:** Markdown files, Obsidian vault

## Related People & Concepts

- **Andrej Karpathy** — AI researcher, popularized the "LLM Wiki" pattern
- **Steph Ango** — CEO of Obsidian, released Obsidian Skills for Claude
- **Tim Dettmers** — Automation framework
- **Addy Osmani** — AI coding workflow
- **Dan Koe** — "Writing is thinking" essay
- **Paul Graham** — "How to Think for Yourself"
- **Tiago Forte** — PARA Method

## Tags

#llm-wiki #knowledge-management #obsidian #claude-code #second-brain #personal-knowledge-base #karpathy #agent-workflow
