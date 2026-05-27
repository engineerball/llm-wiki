# Software Engineering กับ Harness Engineering: 10x หรือ Technical Debt

**Author:** ODDS Team Blog
**URL:** https://blog.odds.team/software-engineering-kab-harness-engineering-10x-hruue-technical-debt/
**Date:** 2026 (ตีพิมพ์ก่อน 27 May 2026)
**Language:** ภาษาไทย

## บทคัดย่อ

บทความสังเคราะห์แนวคิดจากงาน Google I/O 2026 (Adam Bender) และผลงานของ OpenAI / Anthropic ที่เกี่ยวกับ Harness Engineering วิเคราะห์ว่าเมื่อ AI Agents ทำให้ผลิตโค้ดเพิ่ม 10-15 เท่า ใน 18 เดือน อะไรจะพังก่อน และ Harness Engineering จะช่วยหรือสร้างปัญหาใหม่

## เนื้อหาสำคัญ

### Software Ecology
- แนวคิด Socio-Technical Ecosystem: มนุษย์ (Socio) + เครื่องมือ (Technical) เชื่อมโยงกันไม่ได้แยก
- อ้างอิง [[software-engineering-tipping-point-bender-gcp-2026|Adam Bender]] และพี่รูฟ (Socio-Technical Architecture)

### 10x Moment — Release Cadence Bottlenecks
- 4 คำสำคัญ: Deploy, Release, Output, Outcome
- Release เดือนละครั้ง = Code ก้อนใหญ่ 10x, Root Cause หายาก, War Room
- Release รายอาทิตย์ = คอขวด Cost & Build Time (Unit Test → Integration → E2E)
- Release > 1 ครั้ง/อาทิตย์ = เปลี่ยน focus จาก Output → Outcome วัด Business Impact
- Cross-functional team bottleneck: Dev ผลิตเร็วแต่ QA, DevOps, Designer ตามไม่ทัน → Conway's Law

### Harness Engineering
- ได้รับการบัญญัติโดย Mitchell Hashimoto (HashiCorp co-founder), ต่อยอดโดย OpenAI Codex team
- OpenAI: Environment-First Harness — Distributed Context (AGENT.md/SKILL.md), Strict Dependency Flows, CI/CD Automated Feedback
- Anthropic: Multi-Agent 3 ตัว — Planner Agent, Generator Agent, Evaluator Agent (แก้ปัญหา AI เข้าข้างตัวเอง)

### ปัญหาจริงของ Harness Engineering
- **Cost & Latency:** Anthropic Multi-Agent cost พุ่ง $9 → $200, ใช้เวลา 6 ชม, Agent ตีกันเองเผา Token
- **Test-Passing Illusion:** CI/CD บอกแค่ Code ไม่พัง แต่ไม่ได้แปลว่า Architecture ดี
- **Harness Decay:** Harness เก่ากลายเป็น Technical Debt เมื่อ AI อัปเกรด
  - Opus 4.5 → 4.6: ลบ task-splitting system ทิ้งเพราะเปลือง Cost 40%
  - Opus 4.7: Self-evaluation system ที่เขียนไว้ไม่ช่วยเพิ่ม Quality แต่สูบ Token
  - Manus รื้อ System ใหม่ 5 รอบ/6 เดือน; LangChain รื้อ 3 รอบ/ปี
  - Vercel ลบ AI Tools 80% → AI ทำงานแม่นขึ้น เพราะ AI ฉลาดแล้ว Rule เยอะทำให้สับสน

### Decision Framework
- Solo Dev / ทีมเล็ก: AGENT.md/CLAUDE.md ใน Repo
- Enterprise: Linters, Tests, CI + Architecture Fitness Harness, เริ่ม Evaluation Loop ถ้า budget พอ
- Finance/Healthcare: Harness = Control Framework, Append-only event log, เผื่อ Auditor

### ข้อคิดจาก Adam Bender
- Own Your Agency
- Radical Mentorship
- Systems Thinking
- "AI เป็น Amplifier — ถ้า foundation ไม่ดี AI จะขยายความผิดพลาด"

## References
- https://ai.gopubby.com/harness-engineering-what-every-ai-engineer-needs-to-know-in-2026-0ab649e5686a
- https://www.youtube.com/watch?v=2n41YjR5QfU (Adam Bender, Google I/O)
- https://mitchellh.com/writing/my-ai-adoption-journey (Mitchell Hashimoto)
