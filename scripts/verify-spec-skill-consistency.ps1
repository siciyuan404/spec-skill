param(
  [string[]]$Dirs = @(
    ".claude/skills/spec-skill",
    "spec-skill",
    ".opencode/skills/spec-skill",
    ".iflow/skills/spec-skill"
  )
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$requiredFiles = @(
  "SKILL.md",
  "README-zh.md",
  "assets/templates/requirements-template.md",
  "assets/templates/design-template.md",
  "assets/templates/tasks-template.md",
  "assets/templates/task-queue-template.md",
  "references/hooks/pre-commit-check.md",
  "references/hooks/documentation-generator.md",
  "references/hooks/test-generator.md",
  "references/hooks/code-review.md",
  "references/hooks/performance-check.md",
  "references/hooks/batch-task-queue.md"
)

function Get-Hash([string]$path) {
  return (Get-FileHash -Algorithm SHA256 -LiteralPath $path).Hash
}

$existingDirs = @()
foreach ($d in $Dirs) {
  if (Test-Path -LiteralPath $d) {
    $existingDirs += $d
  } else {
    Write-Host "[warn] missing dir: $d"
  }
}

if ($existingDirs.Count -lt 2) {
  throw "Need at least 2 existing skill dirs to compare."
}

$base = $existingDirs[0]
Write-Host "[base] $base"

$failed = $false

foreach ($rel in $requiredFiles) {
  $baseFile = Join-Path $base $rel
  if (-not (Test-Path -LiteralPath $baseFile)) {
    Write-Host "[error] missing in base: $baseFile"
    $failed = $true
    continue
  }

  $baseHash = Get-Hash $baseFile

  foreach ($d in $existingDirs[1..($existingDirs.Count - 1)]) {
    $file = Join-Path $d $rel
    if (-not (Test-Path -LiteralPath $file)) {
      Write-Host "[error] missing file: $file"
      $failed = $true
      continue
    }

    $hash = Get-Hash $file
    if ($hash -ne $baseHash) {
      Write-Host "[diff] $rel"
      Write-Host "       base=$base"
      Write-Host "       curr=$d"
      $failed = $true
    }
  }
}

if ($failed) {
  Write-Host "[result] inconsistent"
  exit 1
}

Write-Host "[result] consistent"
