# Running OpenClaw safely: identity, isolation, and runtime risk

**Author:** Microsoft Defender Security Research Team  
**Date:** February 19, 2026  
**Source:** [Microsoft Security Blog](https://www.microsoft.com/en-us/security/blog/2026/02/19/running-openclaw-safely-identity-isolation-runtime-risk/)

---

## Main Content

Self-hosted agent runtimes like OpenClaw are showing up fast in enterprise pilots, and they introduce a blunt reality: OpenClaw includes limited built-in security controls. The runtime can ingest untrusted text, download and execute skills (i.e. code) from external sources, and perform actions using the credentials assigned to it.

This effectively shifts the execution boundary from static application code to dynamically supplied content and third-party capabilities, without equivalent controls around identity, input handling, or privilege scoping.

### The Three Primary Risks
In an unguarded deployment, three risks materialize quickly:
1. **Credential Exposure:** Credentials and accessible data may be exposed or exfiltrated.
2. **Memory Manipulation:** The agent's persistent state or “memory” can be modified, causing it to follow attacker-supplied instructions over time.
3. **Host Compromise:** The host environment can be compromised if the agent is induced to retrieve and execute malicious code.

Because of these characteristics, **OpenClaw should be treated as untrusted code execution with persistent credentials.** It is not appropriate to run on a standard personal or enterprise workstation.

### Runtime vs. Platform
To reason about controls, it is important to separate where code executes from where instructions propagate:
*   **OpenClaw (Runtime):** A self-hosted agent runtime that runs on a workstation, VM, or container. It inherits the trust (and risk) of the machine and the identities it can use. Installing a "skill" is essentially installing privileged code.
*   **Moltbook (Platform):** An agent-focused platform and identity layer where agents post, read, and authenticate through APIs. It can become a high-volume stream of attacker-influenceable content that agents ingest on a schedule.

### How Agents Shift the Security Boundary
The runtime environment becomes the new security boundary, consisting of:
*   **Identity:** The tokens the agent uses (SaaS APIs, repos, mail, cloud control planes).
*   **Execution:** The tools it can run that change state (files, shell, infrastructure).
*   **Persistence:** The ways it can keep changes across runs (tasks, config, schedules).

### End-to-End Attack Scenario: The Poisoned Skill
1.  **Distribution:** An attacker publishes a malicious skill to ClawHub (the public skills registry).
2.  **Installation:** A developer or agent initiates installation without sufficient human approval.
3.  **State Access:** The attacker targets agent state, including tokens, cached credentials, and transcripts.
4.  **Privilege Reuse:** Using valid identity material, the attacker performs actions through legitimate APIs.
5.  **Persistence:** The attacker maintains control through durable configuration changes (e.g., new OAuth consents or modified tasks).

### Minimum Safe Operating Posture
If an organization chooses to evaluate OpenClaw, the following baseline guardrails are recommended:
1.  **Run only in isolation:** Use a dedicated virtual machine or separate physical device. Treat the environment as disposable.
2.  **Use dedicated credentials:** Create accounts and tokens solely for the agent. Assume compromise is possible and plan for regular rotation.
3.  **Monitor for state manipulation:** Regularly review saved instructions and state for unexpected rules or changes in behavior.
4.  **Back up state:** Snapshot `.openclaw/workspace/` to enable rapid rebuilds.
5.  **Treat rebuild as an expected control:** Reinstall regularly and rebuild immediately if anomalous behavior is observed.

### Security Controls Mapping
| Category | Implementation Approach |
| :--- | :--- |
| **Identity** | Use dedicated identities; enforce least privilege via Microsoft Entra ID. |
| **Endpoint** | Separate pilots from production; onboard hosts to Microsoft Defender for Endpoint. |
| **Supply Chain** | Restrict install sources; pin versions for approved skills. |
| **Network** | Restrict outbound access to known required destinations. |
| **Data Protection** | Use Microsoft Purview sensitivity labeling to audit/block movement of labeled data. |
| **Monitoring** | Log agent actions; use Microsoft Defender XDR for hunting and incident correlation. |

### Conclusion
Self-hosted agents combine untrusted code and untrusted instructions into a single execution loop. For most environments, the appropriate decision may be not to deploy it. If a team proceeds, the defensible posture is to assume compromise is possible: isolate the runtime, constrain access, and monitor continuously.
