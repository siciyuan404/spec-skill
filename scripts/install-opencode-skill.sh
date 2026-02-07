#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/siciyuan404/spec-skill.git"
TARGET_DIR="${HOME}/.config/opencode/skills/spec-skill"

if ! command -v git >/dev/null 2>&1; then
  echo "[error] git 未安装，请先安装 git。" >&2
  exit 1
fi

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "${TMP_DIR}"' EXIT

echo "[info] 克隆仓库到临时目录..."
git clone --depth 1 "${REPO_URL}" "${TMP_DIR}/repo" >/dev/null

echo "[info] 创建安装目录: ${TARGET_DIR}"
mkdir -p "${TARGET_DIR}"

echo "[info] 复制 skill 文件..."
cp -R "${TMP_DIR}/repo/spec-skill/." "${TARGET_DIR}/"

echo "[done] 安装完成: ${TARGET_DIR}"
echo "[tip] 可执行: ls \"${TARGET_DIR}\""
