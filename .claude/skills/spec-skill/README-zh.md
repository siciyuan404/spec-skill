# Spec-Skill：AI 助手的规范驱动开发

一个全面的技能，用于在 AI 辅助工作流程中实现 Kiro 风格的规范驱动开发。它提供了结构化的方法、模板和自动化 hooks，用于将自然语言需求转换为详细的规范、设计和实现任务。

## 概述

此技能提供：
- **三阶段规范工作流** - 需求 → 设计 → 实现
- **EARS 表示法** - 清晰、可测试的需求格式
- **Steering 文件** - 项目约定和一致性
- **命令式 Hooks** - 自动化任务（代码检查、文档生成、测试等）
- **完整模板库** - 所有文件类型的标准化模板

## 核心功能

### 🎯 三阶段规范工作流

1. **需求阶段** - 使用 EARS 表示法捕获用户故事
2. **设计阶段** - 记录技术架构和系统设计
3. **实现阶段** - 将工作分解为可追踪的任务

### 📋 EARS 表示法

格式：```
WHEN [条件/事件] THE SYSTEM SHALL [预期行为]
```

示例：```
WHEN 用户提交有效凭据 THE SYSTEM SHALL 认证并创建会话
WHEN 密码太短 THE SYSTEM SHALL 显示"密码必须至少 8 个字符"
```

### 🔧 Steering 文件

- **工作区特定** - 产品、技术栈、项目结构
- **全局** - 适用于所有项目的模式
- **手动引用** - 在对话中引用 `#tech-stack`、`#api-standards` 等

### ⚡ 命令式 Hooks

- **提交前检查** - 验证代码质量
- **文档生成** - 为代码更改生成文档
- **测试生成** - 创建综合测试套件
- **代码审查** - 审查最佳实践和问题
- **性能检查** - 识别性能瓶颈

### ✅ 可执行校验与模式控制（新增）

- **阶段门禁校验**：`gate.requirements` / `gate.design` / `gate.tasks`
- **队列辅助命令**：`queue.validate` / `queue.sync` / `queue.status`
- **防过度规划**：`plan.cap`（默认阈值 pending tasks=20）
- **显式模式**：`planning_mode` / `execution_mode`（`mode.status`、`mode.switch`）

## 快速开始

### 0. 可执行辅助脚本

```powershell
powershell -ExecutionPolicy Bypass -File scripts/spec-skill-ops.ps1 -Command mode.status -ModeFile .specs/spec-mode.md
```

常用命令：

```powershell
# 阶段门禁
powershell -ExecutionPolicy Bypass -File scripts/spec-skill-ops.ps1 -Command gate.requirements -SpecDir .specs/{spec-name}
powershell -ExecutionPolicy Bypass -File scripts/spec-skill-ops.ps1 -Command gate.design -SpecDir .specs/{spec-name}
powershell -ExecutionPolicy Bypass -File scripts/spec-skill-ops.ps1 -Command gate.tasks -SpecDir .specs/{spec-name}

# 队列与防过度规划
powershell -ExecutionPolicy Bypass -File scripts/spec-skill-ops.ps1 -Command queue.validate -QueueFile .specs/task-queue.md
powershell -ExecutionPolicy Bypass -File scripts/spec-skill-ops.ps1 -Command queue.sync -QueueFile .specs/task-queue.md
powershell -ExecutionPolicy Bypass -File scripts/spec-skill-ops.ps1 -Command queue.status -QueueFile .specs/task-queue.md
powershell -ExecutionPolicy Bypass -File scripts/spec-skill-ops.ps1 -Command plan.cap -QueueFile .specs/task-queue.md -PendingTasksThreshold 20 -MaxPendingQueueItems 3

# 模式切换
powershell -ExecutionPolicy Bypass -File scripts/spec-skill-ops.ps1 -Command mode.switch -ToMode planning_mode -ModeFile .specs/spec-mode.md
powershell -ExecutionPolicy Bypass -File scripts/spec-skill-ops.ps1 -Command mode.switch -ToMode execution_mode -ModeFile .specs/spec-mode.md
```

### 1. 创建新规范

告诉 Claude：```
"创建一个用户认证系统，包含邮箱/密码登录、密码重置和 JWT token"
```

Claude 将：
- 创建 `requirements.md`（EARS 格式需求）
- 创建 `design.md`（架构和技术决策）
- 创建 `tasks.md`（详细实现计划）

### 2. 设置 Steering 文件

为项目一致性创建 steering 文件：```
"生成我们项目的 steering 文件。我们使用 React、TypeScript 和 PostgreSQL。"
```

Claude 将创建：
- `product.md` - 产品概览
- `tech.md` - 技术栈
- `structure.md` - 项目结构

### 3. 使用项目约定

引用 steering 以保持一致性：```
"按照我们的 #api-standards 实现这个功能"
```

Claude 将：
- 读取 `.steering/workspace/api-standards.md`
- 按照指南实现
- 引用使用了哪个 steering 文件

### 4. 运行 Hooks

按需执行自动化任务：```
"运行提交前检查"
"为我刚才做的更改生成文档"
"为这些更改创建测试"
"审查我的代码性能"
```

## 目录结构

```
spec-skill/
├── SKILL.md                 # 技能定义（主文件）
├── README-zh.md             # 中文用户指南（本文件）
├── references/              # 参考资料和指南
│   ├── ears-guide.md        # EARS 表示法规范
│   ├── best-practices.md    # 开发最佳实践
│   └── hooks/             # Hook 模板
│       ├── pre-commit-check.md
│       ├── documentation-generator.md
│       ├── test-generator.md
│       ├── code-review.md
│       └── performance-check.md
└── assets/                 # 模板和样板
    ├── templates/          # 规范文件模板
    │   ├── requirements-template.md
    │   ├── design-template.md
    │   └── tasks-template.md
    └── steering-templates/ # Steering 文件模板
        ├── product-template.md
        ├── tech-template.md
        └── structure-template.md
```

## 常见工作流程

### 工作流程 1：启动新功能

```
用户："我想添加一个 [描述] 的功能"

→ 创建 requirements.md
→ 创建 design.md
→ 创建 tasks.md
→ 顺序执行任务
```

### 工作流程 2：实现现有规范

```
用户："我在 .specs/my-feature/ 有一个规范"

→ 读取 requirements.md
→ 读取 design.md
→ 读取 tasks.md
→ 从任务 1 开始实现
```

### 工作流程 3：使用项目约定

```
用户："创建一个新的 API 端点，遵循我们的 #api-standards"

→ 读取 .steering/workspace/api-standards.md
→ 按照指南实现
→ 响应中引用 steering 文件
```

### 工作流程 4：生成文档

```
用户："为我刚才做的更改生成文档"

→ 执行 documentation-generator hook
→ 创建函数文档、API 文档、内联注释
→ 根据需要更新 README
```

## 何时使用此技能

在以下情况下使用此技能：
- 创建需要结构化规划的新功能或项目
- 处理受益于文档化需求和架构的复杂功能
- 需要在多个任务中追踪实现进度
- 希望通过 steering 维护项目约定的一致性
- 通过命令式 hooks 生成文档、测试或其他自动化任务

## 何时不使用此技能

避免用于：
- 非常简单的功能（单行更改）
- 概念验证和实验
- 紧急修复或热修复
- 没有正式需求的快速原型制作

## 文件位置

### 规范文件
```
.specs/{spec-name}/
├── requirements.md
├── design.md
└── tasks.md
```

### Steering 文件
```
.steering/workspace/     # 项目特定
├── product.md
├── tech.md
├── structure.md
├── api-standards.md
├── testing-standards.md
└── code-conventions.md

.steering/global/        # 全局（所有项目）
├── common-patterns.md
├── coding-standards.md
└── best-practices.md
```

## 模板

### 规范模板
位于 `assets/templates/`：
- `requirements-template.md` - 需求结构
- `design-template.md` - 设计文档结构
- `tasks-template.md` - 实现任务分解

### Steering 模板
位于 `assets/steering-templates/`：
- `product-template.md` - 产品概览
- `tech-template.md` - 技术栈
- `structure-template.md` - 项目结构和约定

## Hook 模板

在 `references/hooks/` 中可用：
1. **提交前检查** - 提交前验证代码质量
2. **文档生成器** - 为代码更改生成文档
3. **测试生成器** - 创建综合测试套件
4. **代码审查** - 审查最佳实践和问题
5. **性能检查** - 识别性能瓶颈

## 高级功能

### 可追踪性
通过设计追踪需求到实现：
- 每个需求映射到设计元素
- 每个设计元素映射到任务
- 任务状态追踪实现进度

### 验证
通过多层验证确保质量：
- EARS 表示法用于清晰、可测试的需求
- 根据需求进行设计审查
- 带有预期结果的任务完成

### 自动化
通过 hooks 自动化重复性任务：
- 提交前验证
- 自动文档生成
- 测试生成
- 代码审查
- 性能分析

## 资源

### 更新说明
- `CHANGELOG.md` - 版本更新记录（新增/修复/变更/破坏性变更/迁移步骤）

### 参考资料
- `references/ears-guide.md` - 详细的 EARS 表示法指南
- `references/best-practices.md` - 全面的最佳实践

### Hook 文档
- `references/hooks/` 中的单独 hook 文档

### 模板
- `assets/` 中的即用型模板

## 安装

建议将 `docs/INSTALL-zh.md` 作为安装总入口文档：
- 提供可直接复制给工具的 Raw 链接
- 集中维护 OpenCode / Claude Code / Codex 的安装命令
- 适合在 issue、聊天或团队文档中直接引用

快速入口：`docs/INSTALL-zh.md`

### Claude Code

安装到 Claude Skills 目录：

Linux/macOS:
```bash
mkdir -p ~/.claude/skills/spec-skill
cp -r spec-skill/* ~/.claude/skills/spec-skill/
ls ~/.claude/skills/spec-skill/
```

Windows PowerShell:
```powershell
New-Item -ItemType Directory -Force "$HOME/.claude/skills/spec-skill" | Out-Null
Copy-Item -Recurse -Force "spec-skill/*" "$HOME/.claude/skills/spec-skill/"
Get-ChildItem "$HOME/.claude/skills/spec-skill"
```

### OpenCode

推荐两种方式（二选一）：

1) 本仓库内分发目录（适合当前项目）
```powershell
powershell -ExecutionPolicy Bypass -File scripts/sync-spec-skill.ps1 -ChineseOnly
```
执行后会同步到 `.opencode/skills/spec-skill`。

2) 全局用户目录（适合跨项目复用）

Linux/macOS:
```bash
mkdir -p ~/.config/opencode/skills/spec-skill
cp -r spec-skill/* ~/.config/opencode/skills/spec-skill/
```

Windows PowerShell:
```powershell
New-Item -ItemType Directory -Force "$HOME/.config/opencode/skills/spec-skill" | Out-Null
Copy-Item -Recurse -Force "spec-skill/*" "$HOME/.config/opencode/skills/spec-skill/"
```

### Codex

安装到 Codex Skills 目录：

Linux/macOS:
```bash
mkdir -p ~/.codex/skills/spec-skill
cp -r spec-skill/* ~/.codex/skills/spec-skill/
ls ~/.codex/skills/spec-skill/
```

Windows PowerShell:
```powershell
New-Item -ItemType Directory -Force "$HOME/.codex/skills/spec-skill" | Out-Null
Copy-Item -Recurse -Force "spec-skill/*" "$HOME/.codex/skills/spec-skill/"
Get-ChildItem "$HOME/.codex/skills/spec-skill"
```

### 安装后校验（建议）

执行一致性校验，确保多运行时目录关键文件一致：

```powershell
powershell -ExecutionPolicy Bypass -File scripts/verify-spec-skill-consistency.ps1
```

## 示例对话

### 示例 1：创建规范

```
用户："我想添加一个用户评论功能，用户可以发表、编辑和删除评论。
      评论应该支持回复和点赞。创建一个规范。"

助手：
1. 创建 .specs/user-comments/requirements.md
   - EARS 格式的用户故事
   - 验收标准

2. 创建 .specs/user-comments/design.md
   - 数据模型（用户、评论、回复、点赞）
   - API 端点
   - 序列图
   - 技术栈选择

3. 创建 .specs/user-comments/tasks.md
   - 10-12 个详细任务
   - 依赖关系映射
   - 状态追踪

用户："看起来不错，开始实现。"

助手：
- 读取 tasks.md
- 从任务 1 开始：数据库架构
- 按照 design.md 实现
- 更新状态
- 继续直到完成
```

### 示例 2：使用 Steering

```
用户："创建一个新的 API 端点来获取用户资料。
      遵循我们的 #api-standards"

助手：
1. 读取 .steering/workspace/api-standards.md
2. 应用指南：
   - 端点命名：GET /api/users/{id}
   - 请求/响应格式
   - 错误处理模式
   - 认证要求
3. 实现端点
4. 记录合规性
5. 报告："应用了来自 .steering/workspace/api-standards.md 的指南"
```

### 示例 3：运行 Hooks

```
用户："我准备好提交了。运行所有质量检查。"

助手：
1. 执行 pre-commit-check hook
   - 语法验证
   - 测试执行
   - 文档验证
   - 安全检查
2. 执行 code-review hook
   - 结构分析
   - 安全审查
   - 性能检查
   - 最佳实践验证
3. 执行 test-generator hook
   - 生成单元测试
   - 创建集成测试
   - 添加边缘情况测试
4. 执行 performance-check hook
   - 分析时间复杂度
   - 检查数据库查询
   - 识别瓶颈
5. 生成综合报告
```

### 示例 4：批量队列执行多个 Spec

```
用户："我有 3 个 spec，都已经有 tasks.md。请按顺序批量执行。"

助手：
1. 创建 .specs/task-queue.md
2. 写入队列项：QUEUE-001 / QUEUE-002 / QUEUE-003
3. 校验每个 spec 存在 requirements.md、design.md、tasks.md
4. 按队列顺序执行（默认 strict）
5. 持续更新状态：pending -> in_progress -> completed/blocked
6. 输出队列进度与阻塞原因
```

### 示例 5：队列阻塞处理（strict vs continue_on_blocker）

```
用户："QUEUE-002 被阻塞了，继续后面的。"

助手：
1. 将 QUEUE-002 标记为 blocked
2. 记录 blocker 与证据
3. 将队列模式切换为 continue_on_blocker
4. 继续执行 QUEUE-003
5. 最后汇总 blocked 项与重试建议
```

### 示例 6：从已有 Spec 恢复执行

```
用户："昨天做到一半，继续 .specs/order-refund/ 这个 spec。"

助手：
1. 读取 requirements.md / design.md / tasks.md
2. 定位首个 pending 且依赖满足的 TASK
3. 继续执行并更新任务状态
4. 若实现偏离设计，记录偏离原因与影响
```

### 示例 7：需求到测试的追踪执行

```
用户："请确保这次实现能追踪到需求和设计。"

助手：
1. 在 requirements 使用 RQ-* 编号
2. 在 design 建立 RQ -> DSN 覆盖关系
3. 在 tasks 绑定 TASK -> RQ/DSN
4. 每个 TASK 补验证命令与预期结果
5. 交付时输出追踪摘要
```

## 最佳实践

### 对于 AI 助手

1. **始终验证**：检查需求是否符合 EARS 格式
2. **迭代**：在每个阶段允许用户审查
3. **引用模板**：使用提供的模板以保持一致性
4. **追踪进度**：定期更新任务状态
5. **记录**：解释决策和权衡

### 对于用户

1. **具体说明**：提供详细的功能描述
2. **仔细审查**：在进行之前验证每个阶段
3. **使用 Steering**：通过 steering 文件保持一致性
4. **运行 Hooks**：自动化重复性任务
5. **更新文档**：保持规范和 steering 文件最新

## 与 Kiro 的比较

| 功能 | Kiro IDE | Spec-Skill | 说明 |
|---------|-----------|------------|------|
| 三阶段工作流 | ✅ | ✅ | 完整实现 |
| EARS 表示法 | ✅ | ✅ | 完整实现 |
| 设计文档 | ✅ | ✅ | 完整实现 |
| 任务规划 | ✅ | ✅ | 完整实现 |
| Steering 文件 | ✅ | ✅ | 手动引用（vs 自动）|
| Hooks | ✅ | ✅ | 命令式（vs 事件式）|
| 事件触发器 | ✅ | ❌ | 不适合 CLI |
| IDE 集成 | ✅ | ❌ | 不适用 |
| 实时监控 | ✅ | ❌ | 手动追踪 |
| PBT 生成 | ✅ | ❌ | 未实现 |
| Dev Servers | ✅ | ❌ | 未实现 |
| LSP 诊断 | ✅ | ❌ | 未实现 |
| Subagent 系统 | ✅ | ❌ | 未实现 |

**整体功能覆盖率**：约 Kiro 规范驱动功能的 60%
**核心工作流覆盖率**：100%（三阶段工作流）

## 限制

### 与完整 Kiro 实现相比

**未实现：**
- ❌ 自动事件触发（文件保存等）
- ❌ IDE 集成（diff 查看、实时更新）
- ❌ 带实时监控的自主任务执行
- ❌ 内置 dev servers
- ❌ 实时 LSP 诊断
- ❌ 属性基测试（PBT）生成
- ❌ 分布式上下文的 Subagent 系统

**已实现（简化）：**
- ✅ 三阶段规范工作流
- ✅ EARS 表示法需求
- ✅ 带有图表的设计文档
- ✅ 任务规划和追踪
- ✅ Steering 文件（手动引用）
- ✅ 命令式 hooks
- ✅ 一致性模板

### 局限性的解决方法

**事件触发 → 手动执行**
- 用户显式请求 hook 执行
- 示例："运行提交前检查"

**IDE 集成 → 文件操作**
- 使用读/写工具
- 在聊天中显示 diff
- 手动追踪更改

**自主执行 → 顺序实现**
- 一次执行一个任务
- 任务之间等待用户批准
- 手动状态追踪

## 故障排除

### 常见问题

1. **规范未创建**
   - 检查：功能描述是否清晰？
   - 解决方案：请求澄清

2. **需求太模糊**
   - 检查：它们是否具体和可测试？
   - 解决方案：应用 EARS 表示法

3. **任务太大**
   - 检查：任务是否可以在 1-4 小时内完成？
   - 解决方案：进一步分解

4. **找不到 Steering 文件**
   - 检查：文件是否存在于工作区或全局中？
   - 解决方案：首先创建 steering 文件

5. **缺少 Hook 模板**
   - 检查：模板是否在 `references/hooks/` 中？
   - 解决方案：创建自定义 hook 模板

## 支持和文档

### 文档
- **SKILL.md** - 主要技能定义
- **README-zh.md** - 本用户指南（中文）

### 参考资料
- `references/ears-guide.md` - EARS 表示法指南
- `references/best-practices.md` - 最佳实践

### 模板
- `assets/templates/` - 规范文件模板
- `assets/steering-templates/` - Steering 文件模板

### Hooks
- `references/hooks/` - 带有详细说明的 hook 模板

## 未来增强

### 潜在添加

1. **交互式规范**
   - 规范编辑的 Web UI
   - 可视化进度追踪
   - 实时协作

2. **增强的 Hooks**
   - 更多 hook 模板
   - 自定义 hook 构建器
   - Hook 调度

3. **高级 Steering**
   - Steering 文件验证
   - 冲突检测
   - 自动建议引擎

4. **集成工具**
   - Git 集成 hooks
   - CI/CD 管道集成
   - 文档托管集成

## 结论

Spec-Skill 为适合 AI 辅助工作流程的命令行和 AI 助手友好的格式，提供了全面、结构化的规范驱动开发方法。虽然它不匹配 Kiro 的完整 IDE 功能集，但它捕获了规范驱动开发的核心工作流和好处。

该技能提供：
- 清晰、可测试的需求（EARS 表示法）
- 全面的设计文档
- 可追踪的实现任务
- 一致的项目约定（steering）
- 重复性任务的自动化（hooks）

通过遵循结构化工作流程和使用提供的模板和参考资料，团队可以提高代码质量、减少误解并更快地交付更好的软件。

---

**享受使用 Spec-Skill 进行结构化、规范驱动的开发！🚀**

如有问题，请查阅：
- SKILL.md - 主要技能定义
- README-zh.md - 本用户指南
- references/ears-guide.md - EARS 表示法指南
- references/best-practices.md - 最佳实践

## 许可证

按原样提供，用于 AI 辅助开发工作流程。

## 致谢

基于 Kiro 的规范驱动开发方法。简化用于命令行和 AI 助手集成。
