# Spec-Skill: Installation and Usage Guide

## Complete File Inventory

### Core Files
```
spec-skill/
├── SKILL.md                           # Main skill definition (required)
├── README.md                          # User guide
└── TECHNICAL_DOCUMENTATION.md          # Technical documentation
```

### Reference Materials
```
spec-skill/references/
├── ears-guide.md                       # EARS notation specification
└── best-practices.md                   # Spec-driven development best practices
```

### Hook Templates
```
spec-skill/references/hooks/
├── pre-commit-check.md                # Code quality validation
├── documentation-generator.md          # Generate documentation
├── test-generator.md                  # Create test suites
├── code-review.md                     # Review code for best practices
└── performance-check.md              # Analyze performance
```

### Spec File Templates
```
spec-skill/assets/templates/
├── requirements-template.md            # Requirements structure
├── design-template.md                 # Design document structure
└── tasks-template.md                  # Implementation tasks structure
```

### Steering File Templates
```
spec-skill/assets/steering-templates/
├── product-template.md                # Product overview
├── tech-template.md                   # Technology stack
└── structure-template.md              # Project structure and conventions
```

## Installation

### Option 1: Manual Installation

1. Create skill directory:
```bash
mkdir -p ~/.claude/skills/spec-skill
```

2. Copy all files:
```bash
cp -r spec-skill/* ~/.claude/skills/spec-skill/
```

3. Verify installation:
```bash
ls ~/.claude/skills/spec-skill/
```

### Option 2: Automatic Installation (if package available)

```bash
# Extract and install
unzip spec-skill.zip -d ~/.claude/skills/
```

## Quick Start

### 1. Create Your First Spec

Ask Claude:
```
"I want to add user authentication with email/password login, JWT tokens, and password reset. Create a spec for this feature."
```

Claude will:
1. Create `.specs/user-authentication/requirements.md` with EARS format
2. Create `.specs/user-authentication/design.md` with architecture
3. Create `.specs/user-authentication/tasks.md` with implementation plan

### 2. Set Up Steering Files

Create steering files for project consistency:

```
"Generate steering files for my project using the templates. We're using React, TypeScript, and PostgreSQL."
```

Claude will create:
- `.steering/workspace/product.md`
- `.steering/workspace/tech.md`
- `.steering/workspace/structure.md`

### 3. Use Steering in Development

Reference steering to maintain consistency:

```
"Create a new API endpoint following our #api-standards"
```

Claude will:
1. Read `.steering/workspace/api-standards.md`
2. Implement following the guidelines
3. Reference which steering file was used

### 4. Run Hooks for Automation

Execute automation tasks:

```
"Run the pre-commit check hook"
"Generate documentation for the changes I just made"
"Create tests for the user authentication module"
"Review my code for performance issues"
```

## Usage Patterns

### Pattern 1: New Feature Development

```
User: "I want to add a feature for {description}"
Claude:
  1. Parse description
  2. Generate requirements.md
  3. Generate design.md
  4. Generate tasks.md
  5. Present for review

User: "Looks good, let's implement"
Claude:
  1. Read tasks.md
  2. Start Task 1
  3. Implement following design.md
  4. Update task status
  5. Move to Task 2
  6. Repeat until complete
```

### Pattern 2: Using Project Conventions

```
User: "Implement this following our #tech-stack guidelines"
Claude:
  1. Read .steering/workspace/tech.md
  2. Apply technology choices
  3. Follow framework patterns
  4. Use specified libraries
  5. Document compliance
```

### Pattern 3: Code Quality Automation

```
User: "I'm ready to commit. Run all checks"
Claude:
  1. Execute pre-commit-check hook
  2. Run code-review hook
  3. Execute test-generator hook
  4. Run performance-check hook
  5. Generate documentation
  6. Report results
```

## File Reference

### When Claude Uses Each File

| File | When Used | Purpose |
|------|-----------|---------|
| SKILL.md | Every interaction | Main workflow and instructions |
| references/ears-guide.md | Creating requirements | EARS notation format and examples |
| references/best-practices.md | Throughout development | Guidance on best practices |
| references/hooks/* | When hook requested | Execute automation tasks |
| assets/templates/* | Creating specs | Template structure for consistency |
| assets/steering-templates/* | Creating steering | Project convention templates |

## Common Commands

### Creating Specs

```
"Create a spec for: {feature description}"
"Update the requirements.md to include {new requirement}"
"Modify the design to use {alternative approach}"
"Add a task for {specific implementation}"
```

### Implementing Specs

```
"Implement the spec in .specs/{spec-name}/"
"Start implementing Task 1"
"What's the current status of tasks?"
"Update task status to completed for Task 3"
```

### Using Steering

```
"Refer to #api-standards for this implementation"
"Check our #tech-stack before choosing a library"
"Follow #structure guidelines for file organization"
"Update #code-conventions with new pattern"
```

### Running Hooks

```
"Run the pre-commit check"
"Generate tests for these changes"
"Perform a code review"
"Check for performance issues"
"Generate documentation"
```

## Project Structure Setup

### Recommended Directory Layout

```
{project-root}/
├── .specs/                    # Specifications
│   └── {spec-name}/
│       ├── requirements.md
│       ├── design.md
│       └── tasks.md
├── .steering/                 # Steering files
│   ├── workspace/             # Project-specific
│   │   ├── product.md
│   │   ├── tech.md
│   │   ├── structure.md
│   │   ├── api-standards.md
│   │   ├── testing-standards.md
│   │   └── code-conventions.md
│   └── global/                # Global (all projects)
│       ├── common-patterns.md
│       ├── coding-standards.md
│       └── best-practices.md
├── src/                       # Source code
├── tests/                     # Tests
└── docs/                      # Documentation
```

## Troubleshooting

### Issue: Skill Not Recognized

**Solution:**
1. Verify SKILL.md exists with correct frontmatter
2. Check file is in `~/.claude/skills/spec-skill/`
3. Restart Claude or reload skill

### Issue: Templates Not Found

**Solution:**
1. Verify `assets/templates/` directory exists
2. Check template files are present
3. Ensure paths are correct in skill instructions

### Issue: Hook Template Missing

**Solution:**
1. Check `references/hooks/` directory
2. Verify hook template file exists
3. Create custom hook if template not available

### Issue: Steering File Not Found

**Solution:**
1. Check `.steering/workspace/` or `.steering/global/`
2. Create steering file using templates
3. Verify file name matches reference (#filename)

## Customization

### Adding Custom Hooks

1. Create new hook file in `references/hooks/`
2. Follow hook template structure:
   - Purpose
   - When to Use
   - Steps
   - Validation
3. Reference in SKILL.md hooks section

### Adding Custom Templates

1. Create template file in `assets/templates/` or `assets/steering-templates/`
2. Follow existing template structure
3. Document template purpose and usage
4. Reference in SKILL.md templates section

### Modifying Workflows

1. Edit SKILL.md workflow sections
2. Update instructions for custom processes
3. Maintain consistency with skill principles
4. Document changes in README.md

## Best Practices

### For Spec Creation
1. Be specific with feature descriptions
2. Review each phase before proceeding
3. Iterate on requirements as needed
4. Validate design against requirements
5. Ensure tasks are actionable

### For Implementation
1. Follow tasks sequentially
2. Reference design during implementation
3. Update task status regularly
4. Test before marking task complete
5. Document any deviations

### For Steering
1. Keep steering files focused
2. Update as project evolves
3. Reference before making decisions
4. Document trade-offs and rationale
5. Share with team for consistency

### For Hooks
1. Run hooks regularly
2. Review hook results
3. Customize hooks to project needs
4. Create new hooks for repetitive tasks
5. Document hook changes

## Resources

### Documentation
- README.md - User guide and overview
- TECHNICAL_DOCUMENTATION.md - Technical details
- SKILL.md - Main skill definition

### Reference Materials
- references/ears-guide.md - EARS notation guide
- references/best-practices.md - Best practices

### Templates
- assets/templates/ - Spec file templates
- assets/steering-templates/ - Steering file templates

### Hooks
- references/hooks/pre-commit-check.md - Pre-commit validation
- references/hooks/documentation-generator.md - Documentation generation
- references/hooks/test-generator.md - Test generation
- references/hooks/code-review.md - Code review
- references/hooks/performance-check.md - Performance analysis

## Support

For issues or questions:
1. Check this guide for solutions
2. Review SKILL.md for workflow details
3. Consult reference materials for guidance
4. Review templates for examples

## Version History

### v1.0.0 (Current)
- Initial release
- Three-phase spec workflow
- EARS notation support
- Steering file system
- Five hook templates
- Complete template library
- Comprehensive documentation

## Acknowledgments

Based on Kiro's spec-driven development approach. Simplified for command-line and AI assistant integration.

## License

Provided as-is for use with AI-assisted development workflows.

---

**Enjoy structured, spec-driven development with Spec-Skill! 🚀**
