---
title: "Claude Skill Creator — A Practical Handbook (2026)"
tags: [source, claude, skills, prompt-engineering, claude-code, thai]
sources: [raw/articles/claude-skill-creator-vibecodingthailand-2026.md]
date: 2026-05-24
---

# Claude Skill Creator — A Practical Handbook (2026)

**Author:** Vibe Coding Thailand (TK)
**Format:** PDF (97 pages) — scanned, OCR-extracted
**Source:** https://vibecodingthailand.com/downloads/claude-skill-creator.pdf
**Series:** Prompt-First Series, Vol. 01 — Prompt-First กับการสร้าง Claude Skill + 12 ซุ่มยังชีพ + Prompt 10 อัน

## Overview

หนังสือเล่มนี้เป็นคู่มือภาษาไทยเกี่ยวกับการสร้าง **Claude Skills** สำหรับ Claude Code โดยใช้แนวทาง **Prompt-First** — เน้น prompt engineering ที่ทำให้ Claude เข้าใจและทำงานได้ถูกต้อง แบ่งเป็น 3 ส่วนหลัก:

- **Part 1:** พื้นฐาน — ความรู้เบื้องต้นเกี่ยวกับ Skill (Chapter 0-4)
- **Part 2:** 6 ซุ่มยังชีพ — Skill ตัวอย่าง 6 แบบ (Chapter 5-10)
- **Part 3:** เทคนิคขั้นสูง — ทดสอบและแพ็กเกจ Skill (Chapter 11-12)
- **Appendix A-C:** Prompt library, glossary, official sources

---

## Part 1: Foundations (Chapter 0-4)

### Chapter 0 — Skill คืออะไร (What is a Skill?)

- **Skill = คำสั่งที่ Claude จดจำและทำงานได้เอง** — เขียนเป็น prompt เดียวหรือชุดคำสั่งใน SKILL.md
- Skill ช่วยให้ Claude ทำงานซ้ำๆ ได้คุณภาพคงที่ โดยไม่ต้องพิมพ์คำสั่งยาวใหม่ทุกครั้ง
- 3 use case หลัก:
  1. **Productivity Skill** — rewrite, summarize, translate เป็น brand tone
  2. **Plugin/Connector Skill** — ใช้ external tool (API, MCP server) เช่น Claude + Google Drive, Claude + YouTube
  3. **Workflow Skill** — ทำงานหลาย step ต่อเนื่อง เช่น "จัดการ meeting → action items → follow-up email"

- **Key principle:** "Skill ไม่ใช่แค่คำสั่ง — Skill คือทางลัดไปสู่ผลลัพธ์ที่คาดหวังได้"

### Chapter 1 — เตรียมความพร้อม (Setup)

- ต้องมี: Claude account, Terminal app, โฟลเดอร์ทำงาน
- ความรู้พื้นฐานที่แนะนำ: Linux/shell commands, npm/pip/brew basics, config files
- ติดตั้ง Claude Code จาก claude.com/code เท่านั้น — ระวัง malware จาก URL ปลอม
- เปิด Claude Code ในโฟลเดอร์ `my-skills/` เพื่อเริ่มสร้าง Skill

### Chapter 2 — โครงสร้าง Skill (Skill Anatomy)

- **Skill = โฟลเดอร์ที่มี SKILL.md + references/ + assets/ + scripts/ (optional)**
- `SKILL.md` — ใจกลางของ Skill: YAML frontmatter (name, description) + Markdown instructions
- `references/` — เอกสารอ้างอิง (brand guide, glossary, sample output)
- `assets/` — ไฟล์ประกอบ (template, sample input)
- `scripts/` — Python/shell scripts สำหรับงานที่ Claude ทำเองไม่ได้ (เช่น ดาวน์โหลด video)
- **⚠️ ห้ามใส่ secret (API key, password) ใน Skill folder**

### Chapter 3 — Skill Creator กับ Prompt-First

- **Skill Creator = Skill ที่สร้าง Skill อื่น** — official tool จาก Anthropic (anthropics/skills repo)
- ใช้ Skill Creator เพื่อ enforce best practices: structure, testing, documentation
- **Workflow:** copy SKILL.md → เปิด Claude Code → ใส่ prompt กำหนด context → Claude สร้าง Skill จาก official spec
- ข้อดี: Skill ที่สร้างด้วย Skill Creator จะตรงตาม official spec และทดสอบได้ง่าย

### Chapter 4 — ออกแบบ Skill ให้ทำงานจริง

- **Skill = Trigger + Workflow + Output**
- **Trigger คือ:** keyword ที่ Claude จับได้ว่า "นี่ต้องใช้ Skill ตัวนี้"
- **3 ขั้นตอนออกแบบ:**
  1. กำหนด trigger ให้ชัด
  2. กำหนด input/output format
  3. ทดสอบและปรับ — ใช้ "Skill Brief 7 หัว" เป็น template

- **Skill Brief 7 หัว:** ชื่อ / Trigger / Input / Output / Workflow / เงื่อนไข / Draft prompt

---

## Part 2: 6 Skill ซุ่มยังชีพ (Chapter 5-10)

### Ch.5 — Brand Voice Rewriter (Skill ไม่ต้องใช้ script)

- **Brief:** Rewrite ข้อความให้ตรง brand voice + tone + platform
- **Trigger:** "rewrite tone", "เขียน brand voice"
- **Workflow:** อ่าน references/brand-voice.md → match tone → rewrite → explain → suggest headlines
- **Key lesson:** ใช้ examples เพื่อให้ Claude เข้าใจ tone ได้ดีขึ้น (5-10 ตัวอย่างอย่างน้อย)
- **Test 3 case:** standard rewrite / inputผิดพลาด / inputผิด platform

### Ch.6 — YouTube Content Extractor (Skill ใช้ script)

- **Brief:** จาก YouTube URL → content pack: transcript + summary + key moments + thumbnails + Facebook posts + Reels caption
- **Tools ที่ใช้:** yt-dlp (download), ffmpeg (extract frames) — official open-source
- **Key principle:** "ให้ Claude ค้นหา + ติดตั้ง tool เอง" — สอน Claude ค้นหา official source และติดตั้งผ่าน brew/pip
- **⚠️ ห้ามดาวน์โหลด private video — ระวังละเมิด copyright**

### Ch.7 — Facebook Launch Pack Generator

- **Brief:** สร้าง launch pack: posts (3) + founder story + FAQ + objection handling + caption (10) + CTA + comment reply template
- **Output 6 ส่วน:** Launch Post / Founder Story / FAQ / Objection Handling / Caption / Comment Reply
- **Key lesson:** output หลาย format → Skill มีค่ามาก; ป้องกัน clickbait headline + อย่าใส่ claim โกหก
- **Skill Pack concept:** รวมหลาย Skill เข้าด้วยกันเป็น pack (เช่น Launch Pack = this + Brand Voice Rewriter + YouTube Extractor)

### Ch.8 — Meeting-to-Action Pack

- **Brief:** จาก meeting transcript/note → action plan + follow-up email + next agenda + chat message
- **Trigger:** "จัดการ meeting", "action items", "follow up"
- **Output:** Executive Summary + Decisions + Action Items (owner + deadline) + Risks + Follow-up Email + Next Agenda
- **Key lesson:** ป้องกัน action item ไม่มี deadline → Claude จะถาม owner + deadline ทุกครั้ง
- **ตัวอย่างคุณค่า:** project-context.md ใน references/ → Claude เข้าใจรอบด้าน ทำให้ action items แม่นขึ้น

### Ch.9 — Research-to-Carousel Planner

- **Brief:** จาก source/article/report → carousel post 7-10 slides พร้อม source notes
- **Key concept:** แยก **Fact (F)** กับ **Interpretation (I)** อย่างชัด — ป้องกัน misinformation
- **Workflow:** อ่าน sources → ดึง main insight → outline slides → draft headlines → attach source ทุก claim
- **Key lesson:** educational content ต้องมี source ทุก claim — label F/I ทุก slide

### Ch.10 — Personal SOP Builder

- **Brief:** จาก workflow ที่ทำเป็นประจำ → SOP + checklist + prompt template
- **Output 6 ส่วน:** SOP ฉบับร่าง / Checklist / Prompt Template / Common Mistakes / Quality Bar / Handoff Instruction
- **Key lesson:** Skill ที่สร้าง SOP → เป็น digital product ขายได้ (3-6 workflow → SOP library)

---

## Part 3: Advanced Techniques (Chapter 11-12)

### Ch.11 — ทดสอบ Skill (Testing Skills)

- **Test 3 case:** ปกติ (happy path) / ผิดพลาด (edge case) / ผิด format
- **Grade 4 เกณฑ์:** ถูกต้อง / ตาม description / output สมบูรณ์ / มีค่าเพิ่ม
- **Improve workflow:** test → grade → fix SKILL.md → retest → ทำซ้ำจนครบ 4/4
- **Regression test:** เก็บ test cases ไว้ → ทุกครั้งที่ update Skill → ทดสอบใหม่ ป้องกัน regress

### Ch.12 — แพ็กเกจ Skill (Packaging Skills)

- **ก่อนแชร์:** ตรวจสอบไม่มี secret, hardcoded path, sensitive info ใน Skill folder
- **README ควรมี:** ชื่อ / Trigger / ตัวอย่าง / เวอร์ชัน (semver: 0.1.0 → 0.2.0 → 1.0.0)
- **Skill Pack (3-5 Skills):** Skill Folder + Usage Guide + Example Prompts + Sample Input/Output + Troubleshooting
- **ความแตกต่างระหว่าง Internal vs Public vs Paid:**
  - Internal: Dropbox/Slack — ไม่ต้องมี README
  - Public: GitHub — ต้องมี README + examples + no secrets
  - Paid: Gumroad/Notion — ต้องมี sales page + refund policy + troubleshooting

---

## Appendix: Prompt Library (10 Copy-Ready Prompts)

1. ให้ Claude เขียน Skill จากประโยคเดียว
2. ให้ Claude ออกแบบ Skill อย่างละเอียด
3. ให้ Claude อ่าน Skill จาก official spec และออกแบบ
4. ให้ Claude วาง Skill Brief 7 หัว
5. ให้ Claude สร้าง Skill (no script)
6. ให้ Claude สร้าง Skill (with script + external tools)
7. ให้ Claude ทดสอบ Skill 3 case + grade
8. ให้ Claude เพิ่ม description และ trigger
9. ให้ Claude ตรวจสอบ Skill folder (security check)
10. ให้ Claude แพ็กเกจ Skill เป็น Skill Pack

---

## Key Themes & Principles

1. **Prompt-First approach** — เน้น prompt engineering ก่อนสร้าง Skill; ให้ Claude เข้าใจก่อนจะ automate
2. **Official sources only** — ค้นหาและอ้างอิงจาก official docs/repo เท่านั้น; ระวัง third-party ที่ไม่น่าเชื่อถือ
3. **Security first** — ห้ามใส่ secret ใน Skill folder; ตรวจสอบทุกครั้งก่อนแชร์
4. **Test-driven improvement** — ทดสอบ 3 case ทุกครั้ง → grade → improve → retest
5. **Skill as product** — Skill ที่ดี = digital product ที่ขายหรือแชร์ได้ (Skill Pack concept)
6. **Brand voice consistency** — examples ทำให้ Claude เข้าใจ tone ได้แม่นขึ้น
7. **Fact vs Interpretation** — educational content ต้องแยก F/I อย่างชัด ป้องกัน misinformation

## Related

- [[skill-creator|Skill Creator (OpenClaw)]] — OpenClaw's built-in skill for creating AgentSkills
- [[harness-engineering|Harness Engineering]] — broader discipline of designing AI agent environments
- [[claude-code|Claude Code]] — Anthropic's CLI coding agent that runs Skills
- [[skills-as-markdown|Skills as Markdown]] — concept of skills as reusable agent workflows in markdown + scripts
