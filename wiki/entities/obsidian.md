---
title: "Obsidian"
tags: [entity, tool, knowledge-management, pkm, obsidian, markdown]
sources: [raw/articles/obsidian-ai-second-brain-nxcode-2026.md]
date: 2026-05-22
---

# Obsidian

A local-first, Markdown-based personal knowledge management (PKM) tool. Notes are stored as plain `.md` files on the user's device — no cloud lock-in. The primary PKM platform for AI-augmented knowledge work as of 2026.

## Key Stats (2026)

- **Users:** 1.5 million
- **YoY growth:** 22%
- **Plugins:** 2,700+

## Why Obsidian Works Well with AI

Local files + Markdown = any AI can read the vault without a special API. This enables:
- Swapping AI providers without migration (Ollama, OpenAI, Claude)
- Claude Code + [[model-context-protocol|MCP]] integration for direct vault read/write
- RAG plugins (Smart Connections) that index the vault into vector embeddings

## Core Concepts

- **Vault** — the root directory containing all notes
- **Wikilinks** — `[[page-name]]` cross-references between notes; rendered as a graph
- **Graph View** — visual map of all note connections
- **Backlinks** — automatic reverse-link detection

## AI Integration Modes

| Mode | Mechanism | Examples |
|------|-----------|---------|
| RAG plugins | Vector embeddings over vault | Smart Connections, Smart Second Brain |
| Inline AI editing | In-editor LLM calls | Nova, Copilot |
| Agent + MCP | Claude Code reads/writes vault directly | Claude Code + Obsidian MCP server |

The Agent + MCP mode implements the [[llm-wiki-pattern]] natively — the LLM maintains the knowledge base rather than just querying it.

## Recommended Plugins (AI Workflow)

- **Smart Connections** — most popular; RAG-based vault Q&A
- **Copilot** — multi-model Q&A
- **Templater** — dynamic templates for structured notes
- **Dataview** — SQL-like queries over YAML frontmatter
- **Calendar** — daily notes and review workflows

## vs Notion

Obsidian wins on: AI model choice, offline, privacy, plugin ecosystem.  
Notion wins on: team collaboration, structured databases.

## Connections

- [[llm-wiki-pattern]] — Obsidian is the primary host platform for the LLM-wiki pattern
- [[rag]] — Smart Connections implements RAG over the local vault
- [[model-context-protocol]] — MCP enables Claude Code to treat the vault as a live workspace
- [[tiago-forte]] — creator of Building a Second Brain; Obsidian is his recommended tool
- [[how-we-built-an-ai-second-brain-for-60k-knowledge-workers-meta]] — Meta's team-scale second brain parallels Obsidian's individual-scale pattern
- [[obsidian-ai-second-brain-nxcode-2026]] — primary source for this page
