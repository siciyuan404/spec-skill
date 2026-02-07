param(
  [string]$SourceDir = ".claude/skills/spec-skill",
  [string[]]$TargetDirs = @(
    "spec-skill",
    ".opencode/skills/spec-skill",
    ".iflow/skills/spec-skill"
  ),
  [switch]$ChineseOnly,
  [switch]$WhatIf
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Resolve-FullPath([string]$p) {
  return (Resolve-Path -LiteralPath $p).Path
}

if (-not (Test-Path -LiteralPath $SourceDir)) {
  throw "SourceDir not found: $SourceDir"
}

$sourceFull = Resolve-FullPath $SourceDir
Write-Host "[sync] source: $sourceFull"

foreach ($target in $TargetDirs) {
  if ([string]::IsNullOrWhiteSpace($target)) { continue }

  $targetFull = Join-Path (Get-Location) $target
  if (-not (Test-Path -LiteralPath $targetFull)) {
    if ($WhatIf) {
      Write-Host "[whatif] mkdir $targetFull"
    } else {
      New-Item -ItemType Directory -Path $targetFull -Force | Out-Null
    }
  }

  Write-Host "[sync] $sourceFull -> $targetFull"
  if (-not $WhatIf) {
    $null = robocopy $sourceFull $targetFull /MIR /R:1 /W:1 /NFL /NDL /NJH /NJS /NP
    if ($LASTEXITCODE -ge 8) {
      throw "robocopy failed for target: $target (exit=$LASTEXITCODE)"
    }
  }

  if ($ChineseOnly) {
    $englishDocs = @(
      "README.md",
      "PROJECT_SUMMARY.md",
      "INSTALLATION_GUIDE.md",
      "TECHNICAL_DOCUMENTATION.md"
    )

    foreach ($f in $englishDocs) {
      $full = Join-Path $targetFull $f
      if (Test-Path -LiteralPath $full) {
        if ($WhatIf) {
          Write-Host "[whatif] rm $full"
        } else {
          Remove-Item -LiteralPath $full -Force
          Write-Host "[clean] removed $full"
        }
      }
    }
  }
}

Write-Host "[done] sync completed"
