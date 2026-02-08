# {Feature Name} Implementation Tasks

## Usage Notes

- Keep each task small and independently verifiable (typically 1-4 hours).
- Use IDs for traceability: `TASK-001`, `TASK-002`, ...
- Link each task to requirement/design IDs (e.g., `RQ-001`, `DSN-002`).
- Prefer this template over fixed backend/frontend task lists.

---

## Progress Summary

- Total Tasks: {N}
- Completed: {N}
- In Progress: {N}
- Pending: {N}

---

## TASK-001: {Task Title}

**Status:** pending

**Type:** implementation | test | refactor | docs | migration

**Traceability:**
- Requirements: RQ-001
- Design: DSN-001

**Description:**
{What to implement and why this task exists}

**Definition of Done:**
- {Concrete outcome 1}
- {Concrete outcome 2}

**Dependencies:**
- None

**Parallelizable:**
- no

**Files to Create/Modify (optional):**
- `{path/to/file}`

**Verification:**
- Command: `{command}`
- Expected: {observable expected result}

**Completion Evidence (required when Status = completed):**
- Verified By: manual | automation
- Verified At: `{yyyy-mm-dd hh:mm:ss}`
- Evidence: `{command output summary / test report / PR link}`

**Sub-tasks:**
- [ ] {Sub-task 1}
- [ ] {Sub-task 2}

---

## TASK-002: {Task Title}

**Status:** pending

**Type:** implementation | test | refactor | docs | migration

**Traceability:**
- Requirements: RQ-00X
- Design: DSN-00X

**Description:**
{What to implement and why this task exists}

**Definition of Done:**
- {Concrete outcome 1}
- {Concrete outcome 2}

**Dependencies:**
- TASK-001

**Parallelizable:**
- yes

**Files to Create/Modify (optional):**
- `{path/to/file}`

**Verification:**
- Command: `{command}`
- Expected: {observable expected result}

**Completion Evidence (required when Status = completed):**
- Verified By: manual | automation
- Verified At: `{yyyy-mm-dd hh:mm:ss}`
- Evidence: `{command output summary / test report / PR link}`

**Sub-tasks:**
- [ ] {Sub-task 1}
- [ ] {Sub-task 2}

---

## Optional Task Library (Pick as Needed)

Use only the sections that match this feature's scope.

1. Schema/data migration
2. API surface changes
3. Domain/business logic
4. UI/interaction updates
5. Automated tests
6. Performance/security hardening
7. Documentation/changelog
8. Release/deployment preparation

---

## Execution Notes

- Update status in real time: `pending` -> `in_progress` -> `completed`.
- If implementation deviates from design, record reason and impact.
- Do not mark completed without `Completion Evidence`.
