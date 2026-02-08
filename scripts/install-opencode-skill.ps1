$ErrorActionPreference = "Stop"

$repoUrl = "https://github.com/siciyuan404/spec-skill.git"
$targetDir = Join-Path $HOME ".config/opencode/skills/spec-skill"
$tempRoot = Join-Path $env:TEMP "spec-skill-install"

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
  throw "[error] git 未安装，请先安装 git。"
}

if (Test-Path -LiteralPath $tempRoot) {
  Remove-Item -Recurse -Force -LiteralPath $tempRoot
}

try {
  Write-Host "[info] 克隆仓库到临时目录..."
  git clone --depth 1 $repoUrl $tempRoot
  if ($LASTEXITCODE -ne 0) { throw "git clone failed with exit code $LASTEXITCODE" }

  $sourceDir = Join-Path $tempRoot "spec-skill" "*"
  if (-not (Test-Path -Path (Join-Path $tempRoot "spec-skill"))) {
    throw "[error] 克隆的仓库中未找到 spec-skill/ 目录"
  }

  Write-Host "[info] 创建安装目录: $targetDir"
  New-Item -ItemType Directory -Force -Path $targetDir | Out-Null

  Write-Host "[info] 复制 skill 文件..."
  Copy-Item -Recurse -Force -Path $sourceDir -Destination $targetDir

  Write-Host "[done] 安装完成: $targetDir"
  Write-Host "[tip] 可执行: Get-ChildItem `"$targetDir`""
} finally {
  if (Test-Path -LiteralPath $tempRoot) {
    Remove-Item -Recurse -Force -LiteralPath $tempRoot -ErrorAction SilentlyContinue
  }
}
