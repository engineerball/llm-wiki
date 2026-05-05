---
title: "Airbyte"
tags: ["#entity", "#data-integration", "#elt", "#cdc"]
sources: ["sources/rise-of-semantic-layer-airbyte-2026-05-05.md"]
date: 2026-05-05
---

# Airbyte

**Airbyte** is an open-source data integration platform that provides a foundational layer for [[semantic-layer|semantic layers]] by ensuring accurate and synchronized data flow.

## Role in the Modern Data Stack

- **Data Integration:** Offers 600+ connectors for moving data from various sources to warehouses and lakes.
- **Change Data Capture (CDC):** Provides real-time synchronization capabilities that are essential for modern, event-driven semantic layers.
- **Foundational for AI:** By providing reliable, automated schema evolution and data movement, it ensures the data feeding [[RAG]] and semantic systems remains current.

## Relationship to Semantic Layers

Airbyte provides the "physical" data movement that enables "logical" semantic abstractions to function. Its CDC capabilities specifically support **streaming materialization** and event-driven synchronization within semantic architectures.
