# 跨运行时兼容声明与验收矩阵（中文）

## 目标

本项目的 `spec-skill` 是跨运行时技能包，目标兼容：
- Claude Code
- OpenCode
- Codex（按目录约定）
- iFlow

安装入口：`docs/INSTALL-zh.md`
- Raw 链接（可直接复制给工具）：`https://raw.githubusercontent.com/siciyuan404/spec-skill/main/docs/INSTALL-zh.md`
- 用途：集中查看并执行 OpenCode / Claude Code / Codex 的安装命令

---

## 兼容策略

### 1. 单一事实源（Single Source of Truth）

- 规范源目录：`.claude/skills/spec-skill`
- 其他目录（`spec-skill`、`.opencode/skills/spec-skill`、`.iflow/skills/spec-skill`、`.codex/skills/spec-skill`）由脚本同步生成
- 禁止手工在分发目录直接修改

### 2. 中文优先策略

- 正文统一中文
- `SKILL.md` frontmatter 保留最小英文触发语义（建议）以提升跨模型触发稳定性
- 删除英文说明型冗余文档（通过同步脚本 `-ChineseOnly`）

### 3. 版本一致性

- 每次发布前执行同步与一致性校验
- 保证关键文件 hash 一致

---

## 目录约定

### 源目录
- `.claude/skills/spec-skill`

### 分发目录
- `spec-skill`
- `.opencode/skills/spec-skill`
- `.iflow/skills/spec-skill`
- `.codex/skills/spec-skill`（若不存在则按需创建）

---

## 发布流程（建议）

1. 在源目录完成修改（仅改 `.claude/skills/spec-skill`）
2. 执行同步脚本
3. 执行一致性校验脚本
4. 运行跨运行时 smoke 测试
5. 更新变更记录并发布

命令示例：

```powershell
powershell -ExecutionPolicy Bypass -File scripts/sync-spec-skill.ps1 -ChineseOnly
powershell -ExecutionPolicy Bypass -File scripts/verify-spec-skill-consistency.ps1
```

---

## 验收矩阵（Smoke）

### A. 结构与文件完整性

- [ ] `SKILL.md` 存在
- [ ] `README-zh.md` 存在
- [ ] `assets/templates/task-queue-template.md` 存在
- [ ] `references/hooks/batch-task-queue.md` 存在

### B. 核心能力一致性

- [ ] 三阶段流程（requirements/design/tasks）存在
- [ ] 追踪模型（RQ/DSN/TASK）存在
- [ ] 批量队列模型（QUEUE）存在
- [ ] `strict` / `continue_on_blocker` 模式说明存在

### C. 跨运行时加载检查

- [ ] Claude Code 可发现并触发 `spec-skill`
- [ ] OpenCode 可发现并触发 `spec-skill`
- [ ] Codex 可加载目标目录中的 `spec-skill`
- [ ] iFlow 可发现并触发 `spec-skill`

### D. 行为级验证（最小场景）

场景：创建 2 个 spec，各自 `tasks.md`，使用队列按顺序执行。

- [ ] 能创建 `.specs/task-queue.md`
- [ ] 能识别并执行 `QUEUE-001` 后再执行 `QUEUE-002`
- [ ] 遇到 blocker 时，`strict` 模式会停止并报告
- [ ] 遇到 blocker 时，`continue_on_blocker` 模式会继续后续项
- [ ] 状态更新正确：`pending -> in_progress -> completed/blocked`

---

## 常见失败与处理

1. **某运行时缺少新文件**
   - 处理：重新执行同步脚本，再执行一致性校验

2. **某运行时触发不到 skill**
   - 处理：检查 skill 安装路径、索引缓存、frontmatter 描述

3. **队列能力在不同运行时行为不一致**
   - 处理：核对 `SKILL.md` 与 `batch-task-queue.md` 是否一致；跑最小场景回归

---

## 维护原则

- 只在源目录开发，禁止分发目录手工热修
- 每次改动都走同步 + 校验 + smoke
- 新能力先更新模板，再更新 hooks，再更新技能正文
- 优先保持文档简洁，降低运行时误读概率
