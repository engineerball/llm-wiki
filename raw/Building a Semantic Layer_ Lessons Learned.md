---
title: "Building a Semantic Layer: Lessons Learned"
source: "https://medium.com/towards-data-engineering/building-a-semantic-layer-lessons-learned-d97458e11d40"
author:
  - "[[Christian Edensor Arbon]]"
published: 2026-05-12
created: 2026-06-03
description: "In my last post, I shared that I’ve started building my own semantic layer. Like everyone else who has recently tumbled down the semantic la"
tags:
  - "clippings"
---
I was incredibly inspired by how Airbnb solved the “five dashboards, five different numbers” problem. But I’ll be honest: I don’t have Airbnb’s engineering budget, nor do I have 12,000 metrics and 4,000 dimensions to manage, nor the intellectual capacity of those guys who build it.

So, how do we take the brilliant concepts behind Minerva 2.0 and distill them into a **simplified architecture** that mere plebs like me can actually build and use? Let’s break it down.

## Metrics as Version-Controlled Code

Before we get to the architecture, we have to understand the fundamental shift Minerva brought to the table. Historically, data teams standardized *tables* (like Airbnb’s early `core_data` initiative). But tables aren't metrics. If you give five analysts the same clean table, they will still write five different SQL queries to calculate "Active Users" in Superset or Looker.

Minerva shifted the paradigm to standardizing **business logic as version-controlled code**. The semantic layer becomes the central brain.

![](https://miro.medium.com/v2/resize:fit:700/1*CcbAxC9ULuaC-Lgg8YE0yA.png)

## Deconstructing the Architecture (I dumbed it down for myself)

If we look at Minerva 2.0 and strip away the enterprise complexities, a modern semantic layer really consists of four main components. Here is the simplified architecture I am working towards

## 1\. The Definition Layer (Git + YAML/Python)

This is where the magic starts. Instead of hiding SQL in random Airflow scripts or BI dashboards, metrics and dimensions are defined in a central repository (usually Git) using configuration files (like YAML) or Python.

- **What it does:** It defines the “what” and “how.” (e.g., *Revenue = Sum(Price) — Sum(Discount)*).
- **The Rule:** If a metric isn’t defined here, it doesn’t exist. This acts as our single source of truth.
![](https://miro.medium.com/v2/resize:fit:700/1*2sSjj6kcTKYl6mHEnwdysA.png)

## 2\. The Semantic Engine (SQL as a First-Class Citizen)

In the early days of Minerva (1.0), Airbnb tried to use Python logic to handle transformations. In Minerva 2.0, they realized a hard truth: **don’t reinvent the wheel; let SQL do the heavy lifting.** The semantic engine’s job is not to process data, but to act as a *SQL Generator*. When a user asks for “Revenue by Region,” the engine looks at the Definition Layer, figures out the complex join paths, and generates the exact SQL dialect needed to get the answer.

- **The Tech:** Tools like **SQLGlot** (an open-source Python SQL parser and transpiler used heavily by modern data stacks) are perfect here. They take your semantic requests and reliably transpile them into highly optimized SQL.
![](https://miro.medium.com/v2/resize:fit:700/1*NpdNUQ5iItG9pzrdF2rD9Q.png)

## 3\. The Muscle: The Execution Engine

This was perhaps the biggest lesson I took from Airbnb’s journey. Originally, they relied heavily on Apache Druid, which required them to pre-compute and denormalize data into massive cubes to keep queries fast. But ratios and distinct counts can’t always be pre-computed — they have to be aggregated on the fly based on what the user selects.


Airbnb eventually migrated to **StarRocks**, an insanely fast OLAP database capable of doing multi-table broadcast joins on the fly in sub-seconds.

- **The Simplified Takeaway:** Your semantic layer needs muscle. You don’t want an architecture that forces you to pre-aggregate every possible combination of dimensions (the “pre-computation trap”). Pair your semantic engine with a modern, high-performance execution engine (like StarRocks, ClickHouse, or DuckDB for smaller setups) that can handle on-the-fly joins without breaking a sweat.
![](https://miro.medium.com/v2/resize:fit:700/1*1zSeB11O1Ca1Uuk2nSYz7A.png)

## 4\. The Interface (API Routing)

Finally, you have to meet the users where they are. If you force analysts to learn a proprietary API, your semantic layer will fail.

The final layer is an API proxy that speaks standard SQL. To tools like Tableau, Superset, or even a Python notebook, the semantic layer just looks like another database. They send a simple `SELECT * FROM semantic_layer.daily_revenue`, and the API intercepts it, translates it using the Semantic Engine, runs it on the Execution Engine, and returns the unified truth.

## So why does this work then?

By separating the **definitions** from the **execution**, we get the best of both worlds. We get the strict governance and consistency of version-controlled code, combined with the raw speed and flexibility of modern SQL execution engines.

You don’t need a massive team to implement this pattern. By leveraging open-source transpilers like SQLGlot and fast analytical databases, you can build a semantic layer that completely stops the endless cycle of dashboard inconsistencies.