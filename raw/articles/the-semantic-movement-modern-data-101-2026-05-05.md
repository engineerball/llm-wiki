# THE SEMANTIC LAYER MOVEMENT: THE RISE & CURRENT STATE
## SEMANTIC MISTRUST, THE RELIABLE SEMANTIC STACK, DATA APIS & PRODUCTS

**Source:** Modern Data 101 — <https://moderndata101.substack.com/p/the-semantic-movement-the-story-of>
**Publication Date:** May 02, 2024
**Author:** Animesh Kumar
**Ingested:** 2026-05-05

---

### Introduction
If you’re reading this, you’ve already heard about the semantic layer. This is especially true in the recent past when semantics wasn’t just a layer in the data stack anymore but transformed into a movement that deems it a must-have. It’s good news for all of us that data discovery and context are getting the attention they deserve.

While data was ever present and hasn’t actually grown in volume, we’ve just become better at tech capabilities that have evolved to capture various streams of data. Every click, view, and event has significant business results if patterns are identified successfully.

> **Key Diagram/Visual Description:** A meme captioned "When you find out what data you actually have 😼" illustrating the realization of the vast, often hidden data assets within an organization.

---

### THE SEMANTIC MOVEMENT
As the data we tap into has grown, the need for automated context has grown as well. When problems pop up from countless tables, data formats, sources, and business domains, the cost of understanding the data is back-breaking. There is a loss of time, opportunities, and the cost of "semantic mistrust."

### BUT FIRST, FOR A STANDARD REFERENCE, LET’S UNDERSTAND SEMANTICS
Instead of defining by characteristics, we want to express semantics in terms of its purpose:
*   Adds meaning and context to data (elaborating assets, entities, dimensions, relationships, etc.).
*   Represents in business-consumable form.
*   Enables consistency in how data is understood.
*   Acts as the concrete bridge between raw data & insights/knowledge.

---

### THE WORKAROUND: N-DIMENSIONAL DATA CUBES & MARTS
In modern data ecosystems, context starts taking shape when data entities are stacked. For example, a "discount %" is a complicated function involving customer conditions, source tables, and domain logic.

To solve recurrent analytics requirements, we created **data cubes** that stored standard aggregations and calculations. You could slice, roll up, or pivot this cube.

**Why did it become obsolete?**
Cubes were excellent when compute power was limited, but they left no space for analytical innovation. You had to stay within the bounds of pre-calculated measures. As novel queries stacked up, the cube model became impractical, leading to frustration between analytics engineers and business teams.

> **Quote from Reddit Excerpt:** A frustrated engineer suggests accessing raw tables directly instead of cubing them to avoid the bottleneck of constant remodeling.

---

### THE OBVIOUS NEXT STEP: BI TOOLS
BI Tools taught us that context needed to be globally accessible. By providing a direct path to data (e.g., warehouses), BI tools allowed users to define semantics through logical models.

**The Trap:**
BI tools created a form of "limited semantics." An analytics team could have a fully defined model locked inside their preferred BI tool, making it inaccessible or inoperable for any other team or tool outside that ecosystem. Semantics shouldn't be trapped inside one tool or vendor.

---

### THE SOLUTION: THE SEMANTIC LAYER
The proposition is a dedicated layer for semantics that can talk to multiple BI tools and various tech counterparts. It is a pure decoupling of semantics and BI. This implies multiple use cases across multiple domains benefiting from the same logical layer instead of reworking logic from the ground up.

---

### BE WARY OF SEMANTIC MISTRUST
The semantic layer could turn into a "wolf in sheep’s clothing." Semantic untrustworthiness stems from chaotic modern data stacks. By placing a semantic layer over physical data, you risk duplicating data issues (lack of quality and governance) into the semantic layer.

### POWERING SEMANTICS THROUGH DATA PRODUCTS
Model-first data products start from context and move down to activation. Through a prototype of the logical model in the semantic layer, you define exact requirements, enabling the data to become dependable through guarded SLOs (Service Level Objectives) on quality and access.

### POWERING APPLICATIONS THROUGH THE SEMANTIC LAYER
The semantic layer should not be limited to reporting. With **Data APIs** (like GraphQL), data becomes accessible to a wide range of applications, LLMs, and predictive models. You can templatize industry-standard applications for reusability and scale.

---

### THE RELIABLE SEMANTIC STACK
On its own, the semantic layer is just solving discoverability. A complete "Reliable Semantic Stack" vertical includes:
1.  **Data Products + Semantic Layer** (Model-first data products).
2.  **All-Purpose Catalog** (The bridge between logical and physical layers).
3.  **Application Layer** (Through Data APIs).

---

### THE OUTCOME OF A RELIABLE SEMANTIC LAYER
*   Seamless discovery and rich context.
*   Purpose-driven, quality-approved, and access-controlled data.
*   Direct source for:
    *   Purpose-Driven BI Reporting.
    *   Use-Case-Specific Data Applications.
    *   App & Reporting Templates.
