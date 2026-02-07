# Spec-Skill: Spec-Driven Development for AI Agents

A comprehensive skill for implementing Kiro-style spec-driven development in AI-assisted workflows.

## Overview

This skill provides a structured approach to software development using specifications (specs) that bridge the gap between conceptual requirements and technical implementation. It includes three-phase workflow, steering files for project conventions, and command-based hooks for automation.

## Features

### Three-Phase Spec Workflow
1. **Requirements Phase** - Capture user stories with EARS notation
2. **Design Phase** - Document technical architecture and system design
3. **Implementation Phase** - Break down work into trackable tasks

### Steering Files
- Workspace-specific conventions (product, tech, structure)
- Global patterns that apply across projects
- Manual reference system for consistency

### Command-Based Hooks
- Pre-commit checks
- Documentation generation
- Test generation
- Code review
- Performance analysis

## Directory Structure

```
spec-skill/
├── SKILL.md                    # Main skill instructions
├── README.md                   # This file
├── references/                 # Detailed guides and documentation
│   ├── ears-guide.md          # EARS notation guide
│   ├── best-practices.md      # Spec-driven development best practices
│   └── hooks/                 # Hook templates
│       ├── pre-commit-check.md
│       ├── documentation-generator.md
│       ├── test-generator.md
│       ├── code-review.md
│       └── performance-check.md
└── assets/                     # Templates and boilerplates
    ├── templates/              # Spec file templates
    │   ├── requirements-template.md
    │   ├── design-template.md
    │   └── tasks-template.md
    └── steering-templates/     # Steering file templates
        ├── product-template.md
        ├── tech-template.md
        └── structure-template.md
```

## Quick Start

### Creating a New Spec

1. **Describe your feature**
   ```
   "Create a user authentication system with email/password login, password reset, and JWT tokens"
   ```

2. **Generate Requirements**
   - The skill will create `requirements.md` with EARS-formatted acceptance criteria

3. **Create Design**
   - The skill will generate `design.md` with architecture diagrams and technical decisions

4. **Plan Implementation**
   - The skill will create `tasks.md` with detailed, trackable tasks

### Using Steering Files

Reference steering files to maintain consistency:

```
"Implement this feature following our #tech-stack steering guidelines"
```

Available steering files:
- `product.md` - Product overview and objectives
- `tech.md` - Technology stack and constraints
- `structure.md` - Project structure and conventions

### Running Hooks

Execute automation hooks on demand:

```
"Run the pre-commit check hook"
"Generate tests for these changes"
"Perform a code review"
```

## EARS Notation

EARS (Easy Approach to Requirements Syntax) format:

```
WHEN [condition/event] THE SYSTEM SHALL [expected behavior]
```

**Example:**
```
WHEN a user submits valid credentials THE SYSTEM SHALL authenticate and create a session
WHEN the password is too short THE SYSTEM SHALL display "Password must be at least 8 characters"
```

## Best Practices

### Requirements Phase
- Be specific and testable
- Include error cases and edge cases
- Use clear, unambiguous language
- Focus on observable behavior

### Design Phase
- Design against requirements
- Consider existing codebase patterns
- Document trade-offs
- Address non-functional requirements

### Implementation Phase
- Break down into small tasks
- Define clear expected outcomes
- Include testing as sub-tasks
- Track progress regularly

## File Locations

### Specs
```
.specs/{spec-name}/
├── requirements.md
├── design.md
└── tasks.md
```

### Steering
```
.steering/workspace/
├── product.md
├── tech.md
├── structure.md
├── api-standards.md
├── testing-standards.md
└── code-conventions.md
```

```
.steering/global/
├── common-patterns.md
├── coding-standards.md
└── best-practices.md
```

## Common Workflows

### 1. Starting a New Feature

```
"I want to add a feature for [description]"

→ Create requirements.md
→ Create design.md
→ Create tasks.md
→ Execute tasks sequentially
```

### 2. Implementing Existing Spec

```
"I have a spec in .specs/my-feature/"

→ Read requirements.md
→ Read design.md
→ Read tasks.md
→ Start implementing from Task 1
```

### 3. Using Project Conventions

```
"Create a new API endpoint following our #api-standards"

→ Read .steering/workspace/api-standards.md
→ Implement following the guidelines
→ Reference the steering file in the response
```

### 4. Generating Documentation

```
"Generate documentation for the changes I just made"

→ Execute documentation-generator hook
→ Creates function docs, API docs, inline comments
→ Updates README as needed
```

## When to Use This Skill

Use this skill when:
- Creating a new feature or project that requires structured planning
- Working with complex features that benefit from documented requirements
- Need to track implementation progress across multiple tasks
- Want to maintain consistency with project conventions
- Generating documentation, tests, or other automated tasks

## When NOT to Use This Skill

Avoid for:
- Very simple features (single line changes)
- Proof of concepts and experiments
- Emergency fixes or hot patches
- Rapid prototyping without formal requirements

## Integration with AI Assistants

This skill is designed to work with AI assistants like Claude:

1. The skill provides structured workflows
2. AI follows the step-by-step process
3. Templates ensure consistency
4. Reference materials provide guidance

## Templates

### Spec Templates
Located in `assets/templates/`:
- `requirements-template.md` - Requirements structure
- `design-template.md` - Design document structure
- `tasks-template.md` - Implementation task breakdown

### Steering Templates
Located in `assets/steering-templates/`:
- `product-template.md` - Product overview
- `tech-template.md` - Technology stack
- `structure-template.md` - Project structure and conventions

## Hook Templates

Available in `references/hooks/`:
1. **Pre-Commit Check** - Validate code quality before committing
2. **Documentation Generator** - Generate documentation for code changes
3. **Test Generator** - Create comprehensive test suites
4. **Code Review** - Review code for best practices and issues
5. **Performance Check** - Identify performance bottlenecks

## Advanced Features

### Traceability
Track requirements through design to implementation:
- Each requirement maps to design elements
- Each design element maps to tasks
- Task status tracks implementation progress

### Validation
Ensure quality through multiple validation layers:
- EARS notation for clear, testable requirements
- Design reviews against requirements
- Task completion with expected outcomes

### Automation
Automate repetitive tasks through hooks:
- Pre-commit validation
- Automatic documentation
- Test generation
- Code review
- Performance analysis

## Resources

### Reference Materials
- `references/ears-guide.md` - Detailed EARS notation guide
- `references/best-practices.md` - Comprehensive best practices

### Hook Documentation
- Individual hook docs in `references/hooks/`

### Templates
- Ready-to-use templates in `assets/`

## Contributing

To improve this skill:
1. Review the SKILL.md file
2. Update references and templates as needed
3. Test with real-world scenarios
4. Share feedback for improvements

## License

This skill is provided as-is for use with AI-assisted development workflows.

## Acknowledgments

Inspired by Kiro's spec-driven development approach. Simplified for command-line and AI assistant integration.
