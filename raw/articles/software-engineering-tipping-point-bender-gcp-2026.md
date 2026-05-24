# Software Engineering at the Tipping Point

- **Source:** https://youtu.be/2n41YjR5QfU
- **Speaker:** Adam Bender (Principal Software Engineer, Google)
- **Event:** Google I/O 2026
- **Saved:** 2026-05-24

## Core Thesis

AI กำลังเพิ่มปริมาณโค้ดที่สร้างได้อย่างรวดเร็ว (10x - 100x หรือมากกว่านั้น) แต่มันกำลังผลักให้ระบบวิศวกรรมซอฟต์แวร์ทั้งหมดเข้าสู่ "จุดเปลี่ยน" (tipping point) ที่โครงสร้างพื้นฐานรอบข้างตามไม่ทัน

## Key Takeaways

### 1. Code ≠ Engineering
- AI สร้างโค้ดได้เร็วกว่าเดิมมาก แต่มันไม่ได้หมายความว่า "วิศวกรรม" จะเร็วขึ้นตามไปด้วย
- การเขียนโค้ดเป็นแค่ 1 ส่วนของ pipeline ทั้งหมด

### 2. จุดอ่อนถูกเปิดเผย
- เมื่อเขียนโค้ดง่ายขึ้น ปัญหาจะไปทับส่วนอื่น: testing, code review, architecture, deployment, maintenance
- จุดคอขวดไม่ได้อยู่ที่การเขียนโค้ดแล้ว แต่อยู่ที่ส่วนอื่น

### 3. Software Ecology
- ต้องใช้ "systems thinking" มองภาพรวม ecosystem ที่สร้างซอฟต์แวร์ ไม่ใช่แค่มองที่ตัวโค้ด
- Software ecology = การศึกษา holistic ของ socio-technical ecosystem ที่ผลิตซอฟต์แวร์

### 4. Shared Fate อาจล้มเหลว
- Google ใช้หลักการ "shared fate" — ทุกคนรับผิดชอบระบบร่วมกัน ทีมที่เขียนโค้ดต้องดูแลและรับผิดชอบผลกระทบด้วย
- เมื่อโค้ดถูกสร้างเยอะขนาดนี้ (โดย AI) คนที่เขียนอาจไม่ได้ "เจอกับผลกระทบ" → shared fate หมดความหมาย
- อาจนำไปสู่ cascading failures เมื่อไม่มีใครเข้าใจ context เต็ม

### 5. Call to Action
- **หยุดมองแค่ "โค้ด" — ต้องมอง "ระบบ"**: ต้องมองภาพรวม code → test → review → deploy → monitor → maintain
- **ปรับ Infrastructure รอบข้างให้ทัน**: testing pipeline, code review (AI-assisted), CI/CD, deployment strategy ต้อง scale
- **เปลี่ยนวิธีคิดเรื่องความรับผิดชอบ**: redesign shared fate ให้ทันกับยุค AI; ให้ AI เป็นเครื่องมือ ไม่ใช่คนตัดสินใจ
- **ลงทุนใน Software Ecology thinking**: วัด metric ใหม่ — ไม่ใช่แค่ "เขียนโค้ดเร็วแค่ไหน" แต่ "ระบบรวมทำงานดีแค่ไหน"
- **อย่ารอให้พังก่อนถึงจะแก้**: ตอนนี้คือจุดเปลี่ยน ไม่ใช่จุดจบ แต่ถ้าไม่ทำอะไรตอนนี้ มันจะกลายเป็นจุดจบ

## Related
- Andrew Ng "AI Coding Agents & Software Engineering" (AI Dev 26) — มองแง่ดีกว่าเรื่องโอกาสสำหรับ engineer
