---
title: "Software Engineering กับ Harness Engineering: 10x หรือ Technical Debt"
tags: [source, software-engineering, harness-engineering, ai-agents, technical-debt]
sources: [https://blog.odds.team/software-engineering-kab-harness-engineering-10x-hruue-technical-debt/]
date: 2026-05-27
---

# Software Engineering กับ Harness Engineering: 10x หรือ Technical Debt

**Author:** ODDS Team Blog
**Source:** [blog.odds.team](https://blog.odds.team/software-engineering-kab-harness-engineering-10x-hruue-technical-debt/)

## Overview

บทความภาษาไทยที่สังเคราะห์แนวคิดจาก [[software-engineering-tipping-point-bender-gcp-2026|Adam Bender (Google I/O 2026)]] และผลงานของ [[openai]] / [[anthropic]] เกี่ยวกับ [[harness-engineering]] วิเคราะห์ว่าเมื่อ AI Agents ทำให้ปริมาณโค้ดเพิ่ม 10–15 เท่าใน 18 เดือน อะไรจะพังก่อน และ Harness Engineering จะช่วยหรือสร้างปัญหาใหม่

เปรียบเทียบสถานการณ์กับร้านก๋วยเตี๋ยวที่ลูกค้าเพิ่ม 10 เท่า แต่เตา หม้อ พนักงานยังเท่าเดิม

## Key Concepts

### Software Ecology (Socio-Technical Ecosystem)
- มนุษย์ (Socio) + เครื่องมือ (Technical) เชื่อมโยงกันแยกไม่ได้
- วัฒนธรรม กระบวนการ โครงสร้างทีม = ส่วนสำคัญเท่าเครื่องมือ

### 10x Moment — Release Cadence Bottlenecks
- **Deploy vs Release vs Output vs Outcome:** คำ 4 คำที่ต้องแยกให้ชัด
- Release เดือนละครั้ง + 10x code = Super Extra Large Changes → War Room
- Release รายอาทิตย์ = คอขวด Cost & Build Time
- Release > 1/สัปดาห์ = focus ย้ายจาก Output → Outcome
- **Cross-functional bottleneck:** Dev → QA → DevOps → Designer ตามไม่ทัน, สอดคล้อง [[conways-law-relationship|Conway's Law]]

### Harness Engineering ตามบทความ
- [[mitchell-hashimoto]] บัญญัติคำนี้ ต่อยอดโดย OpenAI Codex team
- **OpenAI approach:** Environment-First — Distributed Context (AGENT.md/SKILL.md กระจายในทุก Module), Strict Dependency Flows (Types → Config → Repo → Service → Runtime → UI), CI/CD Automated Feedback
- **Anthropic approach:** Multi-Agent decoupling — Planner Agent, Generator Agent, Evaluator Agent แก้ปัญหา AI เข้าข้างตัวเองเมื่อตรวจโค้ดตัวเอง

### Harness Engineering — Trade-offs ที่บทความเน้น
1. **Cost & Latency:** Anthropic Multi-Agent: $9 → $200, 6 ชม, Agent ตีกันเองเผา Token
2. **Test-Passing Illusion:** CI/CD บอก Code ไม่พัง แต่ไม่ได้แปลว่า Architecture ดีหรือ Maintain ได้
3. **Harness Decay** (เปรียบเทียบกับ [[harness-engineering#Anthropic's Perspective (2026)|งานของ Anthropic]]): Harness เก่ากลายเป็น Technical Debt เมื่อ Model อัปเกรด
   - Opus 4.5→4.6: ลบ task-splitting system (เปลือง Cost 40%)
   - Opus 4.7: Self-evaluation harness ไม่ช่วย Quality แต่สูบ Token
   - Manus รื้อ 5 รอบ/6 เดือน, LangChain รื้อ 3 รอบ/ปี
   - Vercel ลบ AI Tools 80% → AI แม่นขึ้น (Rule เยอะทำให้สับสน)

### Decision Framework
- **Solo/ทีมเล็ก:** AGENT.md/CLAUDE.md ใน Repo
- **Enterprise:** Linters + Tests + CI + [[harness-engineering#Böckeler's Framework (ThoughtWorks, 2026)|Architecture Fitness Harness]], เริ่ม Evaluation Loop เมื่อ budget+volume จำเป็น
- **Regulated (Finance/Healthcare):** Harness = Control Framework, Append-only event log, เผื่อ Auditor

## Relationship to Existing Wiki Pages

บทความนี้ทำหน้าที่เป็น **Thai-language synthesis** ที่ดึงเนื้อหาจากหลาย sources ที่ wiki มีอยู่แล้ว:
- [[software-engineering-tipping-point-bender-gcp-2026]] — Adam Bender's talk (ซึ่ง wiki มี source แยกไว้)
- [[harness-engineering]] — แนวคิดหลักที่บทความอธิบาย
- [[harness-engineering-leveraging-codex]] — OpenAI Codex implementation
- [[anthropic-effective-harnesses]] — Anthropic's harness patterns
- [[harness-engineering-coding-agent-users]] — Böckeler's framework

## Unique Contributions

สิ่งที่บทความนี้เพิ่มเติมจาก sources ดั้งเดิม:
- **มุมมอง Cross-functional team bottleneck** (Dev/QA/DevOps/Designer แต่ละตัวเจออะไร) — เชื่อมกับ Conway's Law
- **Harness Decay examples** จาก Manus, LangChain, Vercel (นอกเหนือจาก OpenAI/Anthropic)
- **Vercel insight:** ลบ Tools 80% แล้ว AI ทำงานดีขึ้น — สอดคล้องกับแนวคิดที่ over-engineered harness อาจเป็น burden
- **Decision framework** แบ่งตามสเกลองค์กร (Solo → Enterprise → Regulated)
- **ภาษาไทย** — ทำให้แนวคิดเหล่านี้เข้าถึงได้ง่ายขึ้นในวงการไทย
