param(
  [Parameter(Mandatory = $true)]
  [ValidateSet("gate.requirements", "gate.design", "gate.tasks", "queue.validate", "queue.sync", "queue.status", "plan.cap", "mode.switch", "mode.status")]
  [string]$Command,

  [string]$SpecDir,
  [string]$RequirementsFile,
  [string]$DesignFile,
  [string]$TasksFile,
  [string]$QueueFile = ".specs/task-queue.md",

  [ValidateSet("planning_mode", "execution_mode")]
  [string]$ToMode,

  [string]$ModeFile = ".specs/spec-mode.md",
  [int]$PendingTasksThreshold = 20,
  [int]$MaxPendingQueueItems = 3
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Fail([string]$message) {
  throw "[fail] $message"
}

function Resolve-SpecFiles {
  if ($SpecDir) {
    return @{
      Requirements = Join-Path $SpecDir "requirements.md"
      Design = Join-Path $SpecDir "design.md"
      Tasks = Join-Path $SpecDir "tasks.md"
    }
  }

  if (-not $RequirementsFile -or -not $DesignFile -or -not $TasksFile) {
    Fail "Provide -SpecDir OR all of -RequirementsFile -DesignFile -TasksFile"
  }

  return @{
    Requirements = $RequirementsFile
    Design = $DesignFile
    Tasks = $TasksFile
  }
}

function Read-Lines([string]$path) {
  if (-not (Test-Path -LiteralPath $path)) {
    Fail "File not found: $path"
  }
  return Get-Content -LiteralPath $path
}

function Get-IdsFromLines([string[]]$lines, [string]$prefix) {
  $pattern = "${prefix}-\d{3}"
  $ids = New-Object System.Collections.Generic.HashSet[string]
  foreach ($line in $lines) {
    foreach ($m in [regex]::Matches($line, $pattern)) {
      $null = $ids.Add($m.Value)
    }
  }
  return @($ids)
}

function Parse-QueueItems([string]$queuePath) {
  $lines = Read-Lines $queuePath
  $items = @()
  $lineIndex = 0

  foreach ($line in $lines) {
    $lineIndex++
    if ($line -notmatch '^\|\s*QUEUE-\d{3}\s*\|') { continue }
    $parts = $line.Split('|')
    if ($parts.Count -lt 10) { continue }

    $items += [pscustomobject]@{
      QueueId = $parts[1].Trim()
      Spec = $parts[2].Trim()
      TasksFile = $parts[3].Trim().Trim('`')
      Priority = $parts[4].Trim()
      DependsOnRaw = $parts[5].Trim()
      Mode = $parts[6].Trim()
      Status = $parts[7].Trim()
      Notes = $parts[8].Trim()
      RawLine = $line
      LineNumber = $lineIndex
    }
  }

  return @($items)
}

function Parse-Depends([string]$raw) {
  if ([string]::IsNullOrWhiteSpace($raw) -or $raw -eq '-') {
    return @()
  }
  $items = $raw.Split(',') | ForEach-Object { $_.Trim() } | Where-Object { $_ -ne '' -and $_ -ne '-' }
  return @($items)
}

function Get-TaskStatusCounts([string]$tasksPath) {
  $lines = Read-Lines $tasksPath
  $counts = @{
    pending = 0
    in_progress = 0
    completed = 0
    blocked = 0
  }

  foreach ($line in $lines) {
    if ($line -match '^\*\*Status:\*\*\s*(pending|in_progress|completed|blocked)\s*$') {
      $status = $Matches[1]
      $counts[$status] = [int]$counts[$status] + 1
    }
  }

  return $counts
}

function Detect-QueueCycle($items) {
  $graph = @{}
  $all = New-Object System.Collections.Generic.HashSet[string]

  foreach ($i in $items) {
    $null = $all.Add($i.QueueId)
    $graph[$i.QueueId] = Parse-Depends $i.DependsOnRaw
  }

  $visited = @{}
  $stack = @{}

  function Visit([string]$node) {
    if ($stack.ContainsKey($node) -and $stack[$node]) { return $true }
    if ($visited.ContainsKey($node) -and $visited[$node]) { return $false }

    $visited[$node] = $true
    $stack[$node] = $true

    if ($graph.ContainsKey($node)) {
      foreach ($dep in $graph[$node]) {
        if (-not $all.Contains($dep)) { continue }
        if (Visit $dep) { return $true }
      }
    }

    $stack[$node] = $false
    return $false
  }

  foreach ($node in $graph.Keys) {
    if (Visit $node) { return $true }
  }

  return $false
}

function Run-GateRequirements {
  $files = Resolve-SpecFiles
  $lines = Read-Lines $files.Requirements
  $gaps = @()

  $rqHeadings = $lines | Where-Object { $_ -match '^###\s+RQ-\d{3}:' }
  if ($rqHeadings.Count -eq 0) {
    $gaps += "No requirement headings found (expected: '### RQ-001: ...')"
  }

  $allRqs = Get-IdsFromLines $lines "RQ"
  foreach ($rq in $allRqs) {
    $start = ($lines | Select-String -Pattern "^###\s+${rq}:" -SimpleMatch).LineNumber
    if (-not $start) { continue }
  }

  $earsCount = ($lines | Where-Object { $_ -match '^-\s*WHEN\s+.+\s+THE SYSTEM SHALL\s+.+' }).Count
  if ($earsCount -eq 0) {
    $gaps += "No valid EARS criteria found (WHEN ... THE SYSTEM SHALL ...)"
  }

  $outOfScopeIndex = ($lines | Select-String -Pattern '^##\s+Out of Scope\s*$').LineNumber
  if (-not $outOfScopeIndex) {
    $gaps += "Missing '## Out of Scope' section"
  } else {
    $tail = $lines[($outOfScopeIndex)..([Math]::Min($lines.Count - 1, $outOfScopeIndex + 20))]
    if (($tail | Where-Object { $_ -match '^-\s+.+' }).Count -eq 0) {
      $gaps += "Out of Scope section has no explicit bullet items"
    }
  }

  if ($gaps.Count -gt 0) {
    Write-Host "[gate.requirements] failed"
    foreach ($g in $gaps) { Write-Host " - $g" }
    throw "gate.requirements failed"
  }

  Write-Host "[gate.requirements] passed"
}

function Run-GateDesign {
  $files = Resolve-SpecFiles
  $rqLines = Read-Lines $files.Requirements
  $dsnLines = Read-Lines $files.Design
  $gaps = @()

  $rqs = Get-IdsFromLines $rqLines "RQ"
  if ($rqs.Count -eq 0) {
    $gaps += "No RQ IDs found in requirements.md"
  }

  foreach ($rq in $rqs) {
    if (-not ($dsnLines | Where-Object { $_ -match "\b$rq\b" })) {
      $gaps += "Design coverage missing for $rq"
    }
  }

  $dsnIds = Get-IdsFromLines $dsnLines "DSN"
  if ($dsnIds.Count -eq 0) {
    $gaps += "No DSN IDs found in design.md"
  }

  if ($gaps.Count -gt 0) {
    Write-Host "[gate.design] failed"
    foreach ($g in $gaps) { Write-Host " - $g" }
    throw "gate.design failed"
  }

  Write-Host "[gate.design] passed"
}

function Run-GateTasks {
  $files = Resolve-SpecFiles
  $dsnLines = Read-Lines $files.Design
  $taskLines = Read-Lines $files.Tasks
  $gaps = @()

  $dsnIds = Get-IdsFromLines $dsnLines "DSN"
  $taskIds = Get-IdsFromLines $taskLines "TASK"

  if ($taskIds.Count -eq 0) {
    $gaps += "No TASK IDs found in tasks.md"
  }

  foreach ($dsn in $dsnIds) {
    if (-not ($taskLines | Where-Object { $_ -match "\b$dsn\b" })) {
      $gaps += "Task coverage missing for $dsn"
    }
  }

  $taskSections = ($taskLines | Select-String -Pattern '^##\s+TASK-\d{3}:' )
  foreach ($section in $taskSections) {
    $start = $section.LineNumber - 1
    $end = $taskLines.Count - 1
    $next = $taskLines | Select-String -Pattern '^##\s+TASK-\d{3}:' | Where-Object { $_.LineNumber -gt $section.LineNumber } | Select-Object -First 1
    if ($next) { $end = $next.LineNumber - 2 }
    $slice = $taskLines[$start..$end]

    $taskId = [regex]::Match($section.Line, 'TASK-\d{3}').Value
    if (-not ($slice | Where-Object { $_ -match '^\*\*Verification:\*\*\s*$' })) {
      $gaps += "$taskId missing Verification section"
      continue
    }

    if (-not ($slice | Where-Object { $_ -match '^-\s*Command:\s*`?.+`?\s*$' })) {
      $gaps += "$taskId missing verification command"
    }

    if (-not ($slice | Where-Object { $_ -match '^-\s*Expected:\s*.+' })) {
      $gaps += "$taskId missing verification expected result"
    }
  }

  if ($gaps.Count -gt 0) {
    Write-Host "[gate.tasks] failed"
    foreach ($g in $gaps) { Write-Host " - $g" }
    throw "gate.tasks failed"
  }

  Write-Host "[gate.tasks] passed"
}

function Run-QueueValidate {
  $items = Parse-QueueItems $QueueFile
  if ($items.Count -eq 0) {
    Fail "No queue items found in $QueueFile"
  }

  $errors = @()
  $idSet = New-Object System.Collections.Generic.HashSet[string]

  foreach ($item in $items) {
    if (-not $idSet.Add($item.QueueId)) {
      $errors += "Duplicate queue id: $($item.QueueId)"
    }

    if (-not (Test-Path -LiteralPath $item.TasksFile)) {
      $errors += "$($item.QueueId) missing tasks file: $($item.TasksFile)"
      continue
    }

    $specDir = Split-Path -Parent $item.TasksFile
    foreach ($file in @("requirements.md", "design.md", "tasks.md")) {
      $p = Join-Path $specDir $file
      if (-not (Test-Path -LiteralPath $p)) {
        $errors += "$($item.QueueId) missing sibling file: $p"
      }
    }
  }

  foreach ($item in $items) {
    foreach ($dep in (Parse-Depends $item.DependsOnRaw)) {
      if (-not ($items | Where-Object { $_.QueueId -eq $dep })) {
        $errors += "$($item.QueueId) depends on missing item: $dep"
      }
    }
  }

  if (Detect-QueueCycle $items) {
    $errors += "Dependency cycle detected in queue"
  }

  if ($errors.Count -gt 0) {
    Write-Host "[queue.validate] failed"
    foreach ($e in $errors) { Write-Host " - $e" }
    throw "queue.validate failed"
  }

  Write-Host "[queue.validate] passed"
}

function Run-QueueSync {
  $items = Parse-QueueItems $QueueFile
  if ($items.Count -eq 0) {
    Fail "No queue items found in $QueueFile"
  }

  $lines = Get-Content -LiteralPath $QueueFile
  foreach ($item in $items) {
    if (-not (Test-Path -LiteralPath $item.TasksFile)) { continue }

    $counts = Get-TaskStatusCounts $item.TasksFile
    $newStatus = "pending"
    if ($counts.blocked -gt 0) {
      $newStatus = "blocked"
    } elseif ($counts.in_progress -gt 0) {
      $newStatus = "in_progress"
    } elseif ($counts.pending -eq 0 -and ($counts.completed -gt 0)) {
      $newStatus = "completed"
    }

    $row = $lines[$item.LineNumber - 1]
    $parts = $row.Split('|')
    if ($parts.Count -ge 10) {
      $parts[7] = " " + $newStatus + " "
      $lines[$item.LineNumber - 1] = [string]::Join('|', $parts)
    }
  }

  Set-Content -LiteralPath $QueueFile -Value $lines
  Write-Host "[queue.sync] updated statuses in $QueueFile"
}

function Run-QueueStatus {
  $items = Parse-QueueItems $QueueFile
  if ($items.Count -eq 0) {
    Fail "No queue items found in $QueueFile"
  }

  $counts = @{
    pending = 0
    in_progress = 0
    completed = 0
    blocked = 0
  }

  foreach ($i in $items) {
    if ($counts.ContainsKey($i.Status)) {
      $counts[$i.Status] = [int]$counts[$i.Status] + 1
    }
  }

  Write-Host ("[queue.status] total={0} completed={1} in_progress={2} pending={3} blocked={4}" -f $items.Count, $counts.completed, $counts.in_progress, $counts.pending, $counts.blocked)
  foreach ($i in $items) {
    Write-Host (" - {0} | {1} | {2}" -f $i.QueueId, $i.Status, $i.TasksFile)
  }
}

function Run-PlanCap {
  $items = Parse-QueueItems $QueueFile
  if ($items.Count -eq 0) {
    Fail "No queue items found in $QueueFile"
  }

  $pendingTasks = 0
  $pendingQueues = 0
  foreach ($item in $items) {
    if ($item.Status -eq "pending") { $pendingQueues++ }
    if (-not (Test-Path -LiteralPath $item.TasksFile)) { continue }
    $counts = Get-TaskStatusCounts $item.TasksFile
    $pendingTasks += [int]$counts.pending
  }

  Write-Host "[plan.cap] pending_tasks=$pendingTasks threshold=$PendingTasksThreshold pending_queue_items=$pendingQueues cap=$MaxPendingQueueItems"

  $errors = @()
  if ($pendingTasks -gt $PendingTasksThreshold) {
    $errors += "Pending tasks exceed threshold. Prioritize execution before adding new specs."
  }
  if ($pendingQueues -gt $MaxPendingQueueItems) {
    $errors += "Pending queue items exceed cap. Merge or replace old planning items first."
  }

  if ($errors.Count -gt 0) {
    Write-Host "[plan.cap] failed"
    foreach ($e in $errors) { Write-Host " - $e" }
    throw "plan.cap failed"
  }

  Write-Host "[plan.cap] passed"
}

function Run-ModeStatus {
  if (-not (Test-Path -LiteralPath $ModeFile)) {
    Write-Host "[mode.status] planning_mode (default, mode file not found)"
    return
  }

  $lines = Get-Content -LiteralPath $ModeFile
  $modeLine = $lines | Where-Object { $_ -match '^Current Mode:\s*(planning_mode|execution_mode)\s*$' } | Select-Object -First 1
  if ($modeLine) {
    Write-Host "[mode.status] $($modeLine -replace '^Current Mode:\s*', '')"
    return
  }

  Write-Host "[mode.status] planning_mode (fallback)"
}

function Run-ModeSwitch {
  if (-not $ToMode) {
    Fail "mode.switch requires -ToMode planning_mode|execution_mode"
  }

  $warnings = @()
  if ($ToMode -eq "execution_mode") {
    try { Run-QueueValidate } catch { $warnings += "queue.validate did not pass" }
    try { Run-PlanCap } catch { $warnings += "plan.cap did not pass" }
    $warnings += "Switching to execution_mode means stop creating new spec by default."
  } else {
    $warnings += "Switching to planning_mode means avoid marking implementation tasks completed."
  }

  $content = @(
    "# Spec Skill Mode",
    "",
    "Current Mode: $ToMode",
    "Updated At: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')",
    "",
    "## Risk Reminder",
    "- " + ($warnings -join "`n- ")
  )

  $dir = Split-Path -Parent $ModeFile
  if ($dir -and -not (Test-Path -LiteralPath $dir)) {
    New-Item -ItemType Directory -Force -Path $dir | Out-Null
  }

  Set-Content -LiteralPath $ModeFile -Value $content
  Write-Host "[mode.switch] switched to $ToMode"
  foreach ($w in $warnings) { Write-Host " - $w" }
}

try {
  switch ($Command) {
    "gate.requirements" { Run-GateRequirements; break }
    "gate.design" { Run-GateDesign; break }
    "gate.tasks" { Run-GateTasks; break }
    "queue.validate" { Run-QueueValidate; break }
    "queue.sync" { Run-QueueSync; break }
    "queue.status" { Run-QueueStatus; break }
    "plan.cap" { Run-PlanCap; break }
    "mode.switch" { Run-ModeSwitch; break }
    "mode.status" { Run-ModeStatus; break }
    default { Fail "Unknown command: $Command" }
  }
} catch {
  $msg = $_.Exception.Message
  if (-not $msg.StartsWith("[fail]")) {
    Write-Host "[fail] $msg"
  } else {
    Write-Host $msg
  }
  exit 1
}
