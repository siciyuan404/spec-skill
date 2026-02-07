# Spec-Skill: Technical Documentation

## Overview

Spec-Skill is a comprehensive skill for implementing Kiro-style spec-driven development in AI-assisted workflows. It provides structured methodologies, templates, and automation hooks for transforming natural language requirements into detailed specifications, designs, and implementation tasks.

## Architecture

### Core Components

```
Spec-Skill
├── SKILL.md                    # Main skill definition and instructions
├── README.md                   # User documentation
├── references/                 # Reference materials and guides
│   ├── ears-guide.md          # EARS notation specification
│   ├── best-practices.md      # Development best practices
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

### Component Responsibilities

| Component | Purpose | Target Users |
|-----------|---------|--------------|
| SKILL.md | Main skill definition and workflow instructions | AI Agents |
| references/ears-guide.md | EARS notation specification and examples | AI Agents |
| references/best-practices.md | Spec-driven development guidelines | AI Agents |
| references/hooks/* | Automation hook templates | AI Agents |
| assets/templates/* | Spec file templates for consistency | AI Agents |
| assets/steering-templates/* | Project convention templates | AI Agents/Users |
| README.md | User guide and documentation | End Users |

## Core Workflows

### 1. Spec Creation Workflow

```
Natural Language Input
        ↓
    [Parse]
        ↓
Requirements.md (EARS Format)
        ↓
    [Validate]
        ↓
Design.md (Architecture)
        ↓
    [Validate]
        ↓
Tasks.md (Implementation Plan)
        ↓
    [Execute]
        ↓
Code Implementation
```

### 2. Hook Execution Workflow

```
User Request
        ↓
    [Identify Hook]
        ↓
    [Read Hook Template]
        ↓
    [Execute Steps]
        ↓
    [Validate Results]
        ↓
    [Report Output]
```

### 3. Steering Reference Workflow

```
Task Request
        ↓
    [Parse Steering Reference]
        ↓
    [Read Steering File]
        ↓
    [Apply Guidelines]
        ↓
    [Execute Task]
        ↓
    [Document Compliance]
```

## Data Structures

### Spec File Structure

#### requirements.md
```markdown
# {Feature Name} Requirements

## Overview
- Brief description

## User Stories
### Story 1: {Title}
- As a {user}, I want to {action}, so that {benefit}
- Acceptance Criteria (EARS format)
  - WHEN [condition] THE SYSTEM SHALL [behavior]

## Non-Functional Requirements
- Performance
- Security
- Reliability
- Usability
```

#### design.md
```markdown
# {Feature Name} Design

## System Architecture
- Overview
- Components

## Data Models
- Entities
- Fields
- Relationships

## API Design
- Endpoints
- Request/Response formats

## Sequence Diagrams
- User flows (Mermaid format)

## Technology Stack
- Frameworks
- Libraries
- Tools

## Security & Performance
- Considerations
- Optimizations
```

#### tasks.md
```markdown
# {Feature Name} Implementation Tasks

## Task 1: {Title}
- Description
- Expected Outcome
- Dependencies
- Sub-tasks
- Status: pending/in_progress/completed

[... more tasks ...]
```

### Steering File Structure

#### product.md
```markdown
# Product Overview

## Target Users
- Primary users
- Secondary users

## Key Features
- Feature descriptions
- Priorities

## Business Objectives
- Short-term goals
- Long-term goals

## Success Metrics
- KPIs
- Targets
```

#### tech.md
```markdown
# Technology Stack

## Programming Languages
- Versions and purposes

## Frameworks
- Frontend
- Backend

## Database
- Type
- Technology

## DevOps & Infrastructure
- CI/CD
- Cloud provider
```

#### structure.md
```markdown
# Project Structure

## Directory Layout
- Folder organization

## File Naming Conventions
- Patterns
- Examples

## Code Organization
- Feature-based vs layer-based
- Import patterns
```

## EARS Notation Specification

### Format
```
WHEN [condition/event] THE SYSTEM SHALL [expected behavior]
```

### Patterns

1. **Event-Based**
   ```
   WHEN a user submits the form THE SYSTEM SHALL validate input
   ```

2. **State-Based**
   ```
   WHEN the system is in maintenance mode THE SYSTEM SHALL return 503
   ```

3. **Conditional**
   ```
   WHEN the user is an admin THE SYSTEM SHALL show advanced options
   ```

4. **Time-Based**
   ```
   WHEN the maintenance window begins THE SYSTEM SHALL disable signups
   ```

5. **Exception**
   ```
   WHEN payment fails THE SYSTEM SHALL log error and notify user
   ```

### Benefits
- **Clarity**: Unambiguous requirements
- **Testability**: Direct translation to tests
- **Traceability**: Track through implementation
- **Completeness**: Encourages thorough thinking

## Hook Templates

### Pre-Commit Check Hook
**Purpose**: Validate code quality before committing

**Steps**:
1. Check syntax errors
2. Run tests
3. Check TODO/FIXME comments
4. Verify documentation updates
5. Check for secrets
6. Review file sizes
7. Validate configuration files
8. Check for debug statements

**Validation**: All checks pass successfully

### Documentation Generator Hook
**Purpose**: Generate documentation for code changes

**Steps**:
1. Analyze code changes
2. Generate function/method documentation
3. Update API documentation
4. Add inline comments for complex logic
5. Update README
6. Generate type documentation
7. Document data models
8. Add usage examples
9. Update changelog
10. Review and validate

**Validation**: All new code documented appropriately

### Test Generator Hook
**Purpose**: Generate comprehensive test suites

**Steps**:
1. Analyze the code
2. Generate unit tests
3. Generate integration tests
4. Generate edge case tests
5. Generate mock tests
6. Generate performance tests
7. Generate security tests
8. Create test data
9. Update test coverage
10. Document tests

**Validation**: Test coverage >80%, all tests pass

### Code Review Hook
**Purpose**: Review code for best practices and issues

**Steps**:
1. Analyze code changes
2. Review structure and organization
3. Review naming and readability
4. Review error handling
5. Review security
6. Review performance
7. Review testing
8. Review documentation
9. Review consistency
10. Generate review report

**Validation**: No critical issues, recommendations provided

### Performance Check Hook
**Purpose**: Identify performance bottlenecks

**Steps**:
1. Identify performance-critical code
2. Analyze time complexity
3. Check database performance
4. Check memory usage
5. Check I/O performance
6. Check caching opportunities
7. Check asynchronous operations
8. Generate performance report
9. Benchmark changes

**Validation**: Performance issues identified, optimizations suggested

## Integration with AI Agents

### Skill Activation

The skill is automatically activated when the AI agent detects:
- Creation of new features/projects
- Mention of "spec" or "specification"
- Reference to steering files (#tech-stack, #api-standards, etc.)
- Request for hooks (pre-commit, documentation, tests, etc.)
- Complex feature implementations

### Workflow Execution

1. **Initial Context**
   - Load SKILL.md
   - Understand skill capabilities
   - Wait for user request

2. **Spec Creation**
   - Parse user's feature description
   - Generate requirements.md using EARS notation
   - Present for review and iteration
   - Generate design.md with architecture
   - Present for review and iteration
   - Generate tasks.md with implementation plan
   - Present for review

3. **Task Execution**
   - Read tasks.md
   - Start with first pending task
   - Reference design.md during implementation
   - Reference requirements.md for validation
   - Update task status (pending → in_progress → completed)
   - Move to next task
   - Repeat until all tasks completed

4. **Hook Execution**
   - Parse hook request
   - Read corresponding hook template
   - Execute steps sequentially
   - Validate results
   - Report output to user

5. **Steering Reference**
   - Parse steering reference (#filename)
   - Locate steering file (workspace or global)
   - Read guidelines
   - Apply conventions
   - Document compliance

### Template Usage

Templates are used as starting points:

```python
# Pseudo-code for template usage
def create_spec(feature_description):
    # Parse description
    user_stories = extract_user_stories(feature_description)

    # Load template
    template = read_file('assets/templates/requirements-template.md')

    # Fill template
    content = template.format(
        feature_name=extract_name(feature_description),
        user_stories=generate_ears_requirements(user_stories)
    )

    # Write file
    write_file('.specs/{feature}/requirements.md', content)
```

## Quality Assurance

### Validation Criteria

#### Spec Quality
- [ ] All requirements use EARS notation
- [ ] Requirements are specific and testable
- [ ] Design addresses all requirements
- [ ] Tasks are discrete and actionable
- [ ] Dependencies are clearly defined

#### Hook Quality
- [ ] All steps are clearly defined
- [ ] Validation criteria specified
- [ ] Common issues documented
- [ ] Troubleshooting steps provided

#### Template Quality
- [ ] All sections clearly labeled
- [ ] Examples provided
- [ ] Placeholders clearly marked
- [ ] Documentation included

### Metrics

**Spec Creation**
- Time to create spec
- Iterations required
- Requirements completeness
- Design coverage

**Implementation**
- Tasks completed
- Deviations from spec
- Test coverage
- Documentation completeness

**Hook Execution**
- Issues found
- Time to execute
- User satisfaction

## Best Practices

### For AI Agents

1. **Always validate**: Check requirements against EARS format
2. **Iterate**: Allow user review at each phase
3. **Reference templates**: Use provided templates for consistency
4. **Track progress**: Update task status regularly
5. **Document**: Explain decisions and trade-offs

### For Users

1. **Be specific**: Provide detailed feature descriptions
2. **Review carefully**: Validate each phase before proceeding
3. **Use steering**: Maintain consistency through steering files
4. **Run hooks**: Automate repetitive tasks
5. **Update docs**: Keep specs and steering files current

## File Locations

### Spec Files
```
.specs/{spec-name}/
├── requirements.md    # EARS-format requirements
├── design.md         # Architecture and technical design
└── tasks.md          # Implementation tasks and tracking
```

### Steering Files
```
.steering/workspace/           # Project-specific
├── product.md                # Product overview
├── tech.md                   # Technology stack
├── structure.md              # Project structure
├── api-standards.md          # API conventions
├── testing-standards.md      # Testing patterns
├── code-conventions.md       # Code style
├── security-policies.md      # Security guidelines
└── deployment-workflow.md    # Deployment process

.steering/global/              # Global (all projects)
├── common-patterns.md        # Universal patterns
├── coding-standards.md       # Coding standards
└── best-practices.md         # Best practices
```

## Troubleshooting

### Common Issues

1. **Spec Not Creating**
   - Check: Is feature description clear?
   - Solution: Ask for clarification

2. **Requirements Too Vague**
   - Check: Are they specific and testable?
   - Solution: Apply EARS notation

3. **Tasks Too Large**
   - Check: Can tasks be completed in 1-4 hours?
   - Solution: Break down further

4. **Steering File Not Found**
   - Check: Does file exist in workspace or global?
   - Solution: Create steering file first

5. **Hook Template Missing**
   - Check: Is template in references/hooks/?
   - Solution: Create custom hook template

## Limitations

### Compared to Full Kiro Implementation

**Not Implemented:**
- ❌ Automatic event triggering (file save, etc.)
- ❌ IDE integration (diff viewing, live updates)
- ❌ Autonomous task execution with real-time monitoring
- ❌ Built-in dev servers
- ❌ Live LSP diagnostics
- ❌ Property-based testing (PBT) generation
- ❌ Subagent system for distributed context

**Implemented (Simplified):**
- ✅ Three-phase spec workflow
- ✅ EARS notation requirements
- ✅ Design documentation with diagrams
- ✅ Task planning and tracking
- ✅ Steering files (manual reference)
- ✅ Command-based hooks
- ✅ Templates for consistency

### Workarounds for Limitations

**Event Triggering → Manual Execution**
- User explicitly requests hook execution
- Example: "Run pre-commit checks"

**IDE Integration → File Operations**
- Use Read/Write tools
- Display diffs in chat
- Track changes manually

**Autonomous Execution → Sequential Implementation**
- Execute tasks one at a time
- Wait for user approval between tasks
- Manual status tracking

## Future Enhancements

### Potential Additions

1. **Interactive Specs**
   - Web UI for spec editing
   - Visual progress tracking
   - Real-time collaboration

2. **Enhanced Hooks**
   - More hook templates
   - Custom hook builder
   - Hook scheduling

3. **Advanced Steering**
   - Steering file validation
   - Conflict detection
   - Automatic suggestion engine

4. **Integration Tools**
   - Git integration hooks
   - CI/CD pipeline integration
   - Documentation hosting integration

## Support and Documentation

### Reference Materials
- SKILL.md - Main skill definition
- README.md - User guide
- references/ears-guide.md - EARS notation guide
- references/best-practices.md - Best practices

### Templates
- assets/templates/ - Spec file templates
- assets/steering-templates/ - Steering file templates

### Hooks
- references/hooks/ - Hook templates with detailed instructions

## Conclusion

Spec-Skill provides a comprehensive, structured approach to spec-driven development suitable for AI-assisted workflows. While it doesn't match the full feature set of Kiro's IDE implementation, it captures the core workflows and benefits of spec-driven development in a command-line and AI assistant-friendly format.

The skill enables:
- Clear, testable requirements (EARS notation)
- Comprehensive design documentation
- Trackable implementation tasks
- Consistent project conventions (steering)
- Automation of repetitive tasks (hooks)

By following the structured workflow and using the provided templates and references, teams can improve code quality, reduce misunderstandings, and ship better software faster.
