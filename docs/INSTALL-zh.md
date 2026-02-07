# 安装说明（可直接用 Raw 链接）

本文档用于给 OpenCode / Claude Code / Codex 直接安装 `spec-skill`。

Raw 链接（可直接复制给工具）：

`https://raw.githubusercontent.com/siciyuan404/spec-skill/main/docs/INSTALL-zh.md`

---

## OpenCode 一键安装

### Linux / macOS

```bash
curl -fsSL https://raw.githubusercontent.com/siciyuan404/spec-skill/main/scripts/install-opencode-skill.sh | bash
```

### Windows PowerShell

```powershell
powershell -ExecutionPolicy Bypass -Command "iwr -useb https://raw.githubusercontent.com/siciyuan404/spec-skill/main/scripts/install-opencode-skill.ps1 | iex"
```

安装目标目录：
- `~/.config/opencode/skills/spec-skill`

---

## Claude Code 安装

### Linux / macOS

```bash
mkdir -p ~/.claude/skills/spec-skill
git clone --depth 1 https://github.com/siciyuan404/spec-skill.git /tmp/spec-skill-install
cp -R /tmp/spec-skill-install/spec-skill/. ~/.claude/skills/spec-skill/
```

### Windows PowerShell

```powershell
New-Item -ItemType Directory -Force "$HOME/.claude/skills/spec-skill" | Out-Null
git clone --depth 1 https://github.com/siciyuan404/spec-skill.git "$env:TEMP/spec-skill-install"
Copy-Item -Recurse -Force "$env:TEMP/spec-skill-install/spec-skill/*" "$HOME/.claude/skills/spec-skill/"
```

---

## Codex 安装

### Linux / macOS

```bash
mkdir -p ~/.codex/skills/spec-skill
git clone --depth 1 https://github.com/siciyuan404/spec-skill.git /tmp/spec-skill-install
cp -R /tmp/spec-skill-install/spec-skill/. ~/.codex/skills/spec-skill/
```

### Windows PowerShell

```powershell
New-Item -ItemType Directory -Force "$HOME/.codex/skills/spec-skill" | Out-Null
git clone --depth 1 https://github.com/siciyuan404/spec-skill.git "$env:TEMP/spec-skill-install"
Copy-Item -Recurse -Force "$env:TEMP/spec-skill-install/spec-skill/*" "$HOME/.codex/skills/spec-skill/"
```

---

## 校验（建议）

```powershell
powershell -ExecutionPolicy Bypass -File scripts/verify-spec-skill-consistency.ps1
```
