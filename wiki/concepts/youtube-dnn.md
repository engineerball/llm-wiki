---
title: "YouTube DNN"
type: concept
tags: [concept, ml, recommendation-systems, two-tower, google, youtube]
date: 2026-01-14
---

# YouTube Video Recommendation System

Seminal paper by Davidson et al. on YouTube's recommendation pipeline. Pioneered the two-stage **retrieval + ranking** architecture used by modern [[recommendation-systems|recommender systems]].

## Two-Stage Architecture

1. **Retrieval** — fast candidate generation from millions of videos to hundreds
2. **Ranking** — detailed scoring of hundreds of candidates

This separation enables personalized recommendations at scale while meeting latency requirements.

## Related Pages

- [[two-tower-architecture]] — YouTube's retrieval stage inspired two-tower approaches
- [[recommendation-systems]] — broader context
