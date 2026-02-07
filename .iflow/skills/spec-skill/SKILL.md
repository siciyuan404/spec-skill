---
name: spec-skill
description: Use when a feature needs structured planning before coding, with explicit requirements, technical design, and trackable implementation tasks.
---

# 规范驱动开发技能 (Spec-Skill)

## 目的

通过 spec-first 工作流，将功能想法沉淀为三个对齐的产物：
- `requirements.md`（做什么）
- `design.md`（怎么做）
- `tasks.md`（如何落地与验证）

该技能用于降低歧义、提高实现可预测性，并保持产品/设计/工程的一致性。

## 何时使用

在以下场景使用：
- 新功能存在非平凡复杂度，需要先规划后编码
- 多角色协作，需要共享且可审阅的规范
- 需要将工作拆解为可追踪任务
- 需要通过 steering 约束实现一致性
- 需要需求到测试的可追踪链路

对于极小改动（如错别字、单行非行为变更）可跳过完整三阶段流程。

## 工作区结构

```text
.specs/
└── {spec-name}/
    ├── requirements.md
    ├── design.md
    └── tasks.md

.steering/
├── workspace/
│   ├── product.md
│   ├── tech.md
│   └── structure.md
└── global/
    └── common-patterns.md
```

## 工作流

### 阶段 1：需求 (`requirements.md`)

1. 用业务语言整理用户故事
2. 将验收标准转为 EARS 格式
3. 覆盖成功、错误、边界场景
4. 补充非功能需求（性能/安全/可靠性/可用性）

EARS 格式：

```markdown
WHEN [条件/事件] THE SYSTEM SHALL [预期行为]
```

#### 阶段门禁（退出条件）

满足以下条件才进入设计阶段：
- 每个故事都有 EARS 验收标准
- 含糊表达已去除或量化
- 错误与边界路径已明确
- Out of Scope 已列出
- 未决问题已登记

### 阶段 2：设计 (`design.md`)

1. 将需求映射到架构与组件
2. 定义数据模型与接口
3. 为关键流程补充时序图
4. 记录取舍与非功能策略

#### 阶段门禁（退出条件）

满足以下条件才进入任务阶段：
- 所有需求均有设计覆盖
- 外部依赖与风险已明确
- 安全/性能策略已记录
- 未决问题有负责人和决策时间点

### 阶段 3：实现计划 (`tasks.md`)

1. 将设计拆为可执行任务
2. 标注依赖关系与并行机会
3. 为每个任务补充验证命令与预期结果
4. 在已知情况下标注目标文件

#### 阶段门禁（退出条件）

满足以下条件才开始编码：
- 任务粒度小且可测试
- 每个任务有完成定义（DoD）
- 验证步骤明确
- 需求/设计/任务 ID 已建立关联

### 阶段 4：执行任务

1. 读取 `tasks.md`，从首个未阻塞任务开始
2. 状态流转：`pending` -> `in_progress` -> `completed`
3. 实现时遵循 `design.md` 与 steering 约束
4. 执行验证并记录结果
5. 更新追踪关系后推进下一任务

### 阶段 5：批量队列执行（多 Spec）

当多个 spec 已经生成 `tasks.md`，并需要按顺序批量执行时使用。

1. 创建队列清单（建议路径：`.specs/task-queue.md`）
2. 每个 spec 的 `tasks.md` 对应一个队列项
3. 校验每个队列项都存在 `requirements.md`、`design.md`、`tasks.md`
4. 按队列顺序（或显式优先级）逐项执行
5. 每个队列项内部按 `TASK-*` 顺序执行
6. 持续更新队列状态与任务状态，直至完成

默认行为：
- 严格串行模式：当前队列项被阻塞即暂停队列并报告阻塞原因

可选行为：
- 阻塞后继续模式：将当前队列项标记为 `blocked`，继续执行后续项

## 追踪模型（必需）

使用统一 ID 保持三文档对齐：
- 需求：`RQ-001`, `RQ-002`, ...
- 设计：`DSN-001`, `DSN-002`, ...
- 任务：`TASK-001`, `TASK-002`, ...
- 测试/检查（建议）：`TST-001`, `TST-002`, ...

最低映射要求：
- 每个 `RQ-*` 至少映射一个 `DSN-*`
- 每个 `DSN-*` 至少映射一个 `TASK-*`
- 每个 `TASK-*` 必须有验证步骤

## Steering 文件

Steering 用于沉淀项目长期约定。

### 应用方式

1. 识别 `.steering/workspace/` 与 `.steering/global/` 的相关文件
2. 在设计和实现中应用约束
3. 在响应中明确说明使用了哪些 steering

冲突规则：
- workspace steering 优先于 global steering

常见 workspace 文件：
- `product.md`, `tech.md`, `structure.md`
- `api-standards.md`, `testing-standards.md`, `code-conventions.md`
- `security-policies.md`, `deployment-workflow.md`

## Hooks（命令式）

按需手动执行 `references/hooks/` 下模板：
- `pre-commit-check.md`
- `documentation-generator.md`
- `test-generator.md`
- `code-review.md`
- `performance-check.md`
- `batch-task-queue.md`

执行流程：
1. 用户请求执行某个 hook
2. 读取对应模板
3. 根据仓库技术栈落地执行
4. 返回可验证结果与失败信息

## 处理已有 Spec

处理现有 spec 时：
1. 先读全三件套（`requirements.md`/`design.md`/`tasks.md`）
2. 判断当前阶段与缺失项
3. 仅更新必要章节并保持 ID 稳定
4. 持续维护状态与追踪关系

## 批量队列模型

使用队列 ID 追踪多 spec 执行：
- 队列项：`QUEUE-001`, `QUEUE-002`, ...

建议队列字段：
- `Spec`：可读名称
- `Tasks File`：路径（例如 `.specs/auth/tasks.md`）
- `Priority`：`high` / `medium` / `low`
- `Status`：`pending` / `in_progress` / `completed` / `blocked`
- `Mode`：`strict` / `continue_on_blocker`
- `Depends On`：依赖的队列项 ID

执行顺序规则：
1. 优先遵循显式队列顺序
2. 其次遵循 `Depends On`
3. 若无顺序定义，再按 `Priority`

队列完成条件：
- 所有队列项为 `completed`
- 或在严格模式下因阻塞暂停，并输出明确阻塞报告

## 质量检查

在宣布阶段完成前，至少确认：
- `requirements.md`：EARS 合规、可测试、范围清晰
- `design.md`：需求覆盖、设计取舍、非功能策略
- `tasks.md`：任务可执行、DoD 明确、验证与依赖完整
- 跨文档 ID 关联未断裂

## 最佳实践

- 需求描述行为，不写实现细节
- 设计聚焦决策，不堆砌模板内容
- 任务保持小步（通常 1-4 小时）
- 用可量化指标替代模糊描述
- 执行偏离设计时记录原因与影响

## 常见问题

- 需求太模糊 -> 量化行为并拆分验收标准
- 设计覆盖不足 -> 增加需求-设计映射表
- 任务过大 -> 按产出与依赖继续拆分
- steering 冲突 -> 按 workspace 优先并显式说明

## 参考与模板

按需读取：
- `references/ears-guide.md`
- `references/best-practices.md`
- `references/hooks/`

复用模板：
- `assets/templates/requirements-template.md`
- `assets/templates/design-template.md`
- `assets/templates/tasks-template.md`
- `assets/templates/task-queue-template.md`
- `assets/steering-templates/`
