---
title: "RAG (Retrieval-Augmented Generation)"
tags: [concept, rag, llm, knowledge-retrieval, ai]
date: 2026-05-05
---

# RAG (Retrieval-Augmented Generation)

A technique where an LLM retrieves relevant document chunks from a vector store at query time and includes them in the prompt context before generating a response. Combines parametric knowledge (model weights) with non-parametric knowledge (retrieved documents).

## How It Works

1. Documents chunked and embedded into a vector store
2. Query embedded and used to retrieve top-k similar chunks
3. Chunks injected into the LLM prompt as context
4. LLM generates a response grounded in retrieved content

## Contrast: RAG vs LLM-Wiki

| RAG | [[llm-wiki-pattern\|LLM-Wiki]] |
|-----|----------|
| Knowledge retrieved at query time from raw chunks | LLM pre-processes sources into structured wiki pages |
| No accumulation — same raw docs every time | Compounding artifact — wiki grows richer with each ingest |
| Rediscovers context from scratch each query | Persistent cross-referenced knowledge base |

## See Also

- [[llm-wiki-pattern]] — an alternative to RAG for personal knowledge bases
- [[graph-rag]] — graph-enhanced variant of RAG
- [[semantic-layer]] — provides structured context that RAG systems can query
