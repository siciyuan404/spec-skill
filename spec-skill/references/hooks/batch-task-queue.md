# Batch Task Queue Hook

## Purpose

Execute multiple spec `tasks.md` files as a managed queue with clear ordering, status tracking, and blocker handling.

## When to Use

- Multiple specs are ready for implementation
- Each spec already has `requirements.md`, `design.md`, and `tasks.md`
- You want one ordered execution flow instead of manually switching between specs

## Inputs

- Queue file: `.specs/task-queue.md` (recommended)
- Queue item fields:
  - `Queue ID` (`QUEUE-*`)
  - `Tasks File`
  - `Priority`
  - `Depends On`
  - `Mode` (`strict` or `continue_on_blocker`)
  - `Status` (`pending`/`in_progress`/`completed`/`blocked`)

## Execution Rules

1. Process queue in explicit queue order first.
2. Respect `Depends On`; skip items whose dependencies are not completed.
3. Execute one queue item at a time.
4. Inside a queue item, execute internal `TASK-*` sequentially.
5. Update status immediately after each state change.

## Steps

### 1) Validate queue integrity

- Ensure queue file exists and has at least one `pending` item.
- Validate each queued `Tasks File` exists.
- Validate sibling files exist for each spec:
  - `requirements.md`
  - `design.md`
  - `tasks.md`

If validation fails:
- Mark affected queue item `blocked`
- Record blocker in queue `Notes` and `Execution Log`

### 2) Select next queue item

Select the first eligible item where:
- `Status = pending`
- dependencies are completed

Set selected item to `in_progress` and write start timestamp.

### 3) Execute current queue item

Within the selected spec:
1. Read `tasks.md`
2. Find first unblocked `TASK-*` with `Status = pending`
3. Execute task following design + steering constraints
4. Run verification commands in task
5. Update task status to `completed` when verification passes
6. Repeat until all tasks complete or a blocker appears

### 4) Handle blockers

When blocked:
- Record exact blocker cause and evidence (error output, unmet dependency, missing artifact)
- Set queue item `Status = blocked`

Mode behavior:
- `strict`: stop whole queue immediately and report blockers
- `continue_on_blocker`: continue with next eligible queue item

### 5) Finalize queue item

When all tasks in current spec are completed:
- Set queue item `Status = completed`
- Write end timestamp and evidence summary

### 6) Continue until queue end

Repeat from Step 2 until:
- all items are `completed`, or
- strict mode stops on first blocked item

## Retry Workflow for Blocked Items

1. Fix blocker root cause
2. Set blocked queue item back to `pending`
3. Append retry note in `Execution Log`
4. Re-run queue selection from top

## Reporting Format

At each run, report:
- Total queue items
- Completed / In progress / Pending / Blocked counts
- Current item and current internal task
- Blockers with next action

Example summary:

```text
Queue status: 5 total | 2 completed | 1 in_progress | 1 pending | 1 blocked
Current: QUEUE-003 (.specs/billing/tasks.md)
Current task: TASK-004
Blocked: QUEUE-002 (missing design.md)
Next action: create design.md for billing-export spec, then retry QUEUE-002
```

## Validation

This hook passes only if:
- Queue state is internally consistent
- Every status transition is recorded
- Completed queue items have verification evidence
- Blocked queue items have actionable root-cause notes
