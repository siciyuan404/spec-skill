# Task Queue (Multi-Spec)

Use this file to execute multiple spec `tasks.md` files in batch order.

## Queue Settings

- Default Mode: strict
- Queue Status: pending
- Owner: {name/role}
- Last Updated: {yyyy-mm-dd hh:mm}
- Planning Cap:
  - Max Pending Tasks: 20
  - Max Pending Queue Items: 3

Modes:
- `strict`: stop queue when current item is blocked
- `continue_on_blocker`: mark blocked and continue next item

---

## Queue Items

| Queue ID | Spec | Tasks File | Priority | Depends On | Mode | Status | Notes |
|----------|------|------------|----------|------------|------|--------|-------|
| QUEUE-001 | {spec-name} | `.specs/{spec-name}/tasks.md` | high | - | strict | pending | {optional} |
| QUEUE-002 | {spec-name} | `.specs/{spec-name}/tasks.md` | medium | QUEUE-001 | strict | pending | {replace/merge reason if new planning} |

---

## Execution Log

### QUEUE-001
- Start: {timestamp}
- End: {timestamp}
- Result: completed | blocked
- Blocker (if any): {details}
- Evidence: {commands/tests/review notes}

### QUEUE-002
- Start: {timestamp}
- End: {timestamp}
- Result: completed | blocked
- Blocker (if any): {details}
- Evidence: {commands/tests/review notes}

---

## Completion Criteria

- Queue is complete when all items are `completed`.
- In `strict` mode, any `blocked` item pauses the queue until unblocked.
- In `continue_on_blocker` mode, blocked items remain visible for retry pass.

---

## Queue Helper Commands (PowerShell)

```powershell
# Validate queue files + dependency cycle
powershell -ExecutionPolicy Bypass -File scripts/spec-skill-ops.ps1 -Command queue.validate -QueueFile .specs/task-queue.md

# Sync queue status from each tasks.md
powershell -ExecutionPolicy Bypass -File scripts/spec-skill-ops.ps1 -Command queue.sync -QueueFile .specs/task-queue.md

# Show queue status summary
powershell -ExecutionPolicy Bypass -File scripts/spec-skill-ops.ps1 -Command queue.status -QueueFile .specs/task-queue.md

# Enforce anti-over-planning limits
powershell -ExecutionPolicy Bypass -File scripts/spec-skill-ops.ps1 -Command plan.cap -QueueFile .specs/task-queue.md -PendingTasksThreshold 20 -MaxPendingQueueItems 3
```
