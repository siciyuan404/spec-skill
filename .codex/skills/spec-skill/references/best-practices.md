# Spec-Driven Development Best Practices

## Introduction

Spec-driven development (SDD) bridges the gap between conceptual requirements and technical implementation by creating structured specifications before writing code. This document provides best practices for implementing SDD effectively.

## Core Principles

### 1. Structure Before Code

Always follow the three-phase workflow: Requirements → Design → Implementation

**Why:**
- Reduces rework and misunderstanding
- Makes implementation decisions explicit
- Provides documentation for future maintenance
- Enables better estimation and planning

**Practice:**
- Never skip from requirements directly to implementation
- Allocate time to iterate on each phase
- Treat the spec as a contract between product and engineering

### 2. Iterative Refinement

Each phase should be iterated on before moving to the next.

**Why:**
- Early changes are cheaper than later changes
- Catching issues early prevents costly rework
- Multiple perspectives improve quality

**Practice:**
- Review requirements with stakeholders
- Validate design against requirements
- Get approval on tasks before implementation

### 3. Alignment Across Phases

All three spec files (requirements, design, tasks) must align and support each other.

**Why:**
- Misalignment leads to implementation issues
- Ensures all requirements are addressed
- Makes testing and verification easier

**Practice:**
- Check that every requirement maps to design elements
- Verify every design decision maps to tasks
- Create traceability between phases

## Phase-Specific Best Practices

### Requirements Phase

#### 1. Use EARS Notation Consistently

Every acceptance criterion should follow the EARS format:
```
WHEN [condition] THE SYSTEM SHALL [behavior]
```

**Benefits:**
- Testable requirements
- Clear expectations
- Easy to verify

#### 2. Focus on Observable Behavior

Describe what the system does, not how it does it.

**Bad:**
```
WHEN a user logs in THE SYSTEM SHALL query the database
```

**Good:**
```
WHEN a user submits valid credentials THE SYSTEM SHALL authenticate and create a session
```

#### 3. Include Edge Cases and Errors

Don't just document happy paths.

**Checklist:**
- [ ] Success scenarios
- [ ] Invalid input handling
- [ ] Error conditions
- [ ] Edge cases (empty, null, boundary values)
- [ ] Security considerations
- [ ] Performance requirements

#### 4. Be Specific and Testable

Avoid vague terms like "user-friendly", "fast", "good".

**Instead of:**
```
WHEN a user searches THE SYSTEM SHALL respond quickly
```

**Use:**
```
WHEN a user performs a search THE SYSTEM SHALL return results within 500ms for 95% of queries
```

#### 5. Keep Requirements Independent

One requirement should describe one behavior.

**Bad (combines multiple):**
```
WHEN a user submits the form THE SYSTEM SHALL validate, save, and send email
```

**Good (separate):**
```
WHEN a user submits valid data THE SYSTEM SHALL save to database
WHEN data is saved successfully THE SYSTEM SHALL send confirmation email
```

### Design Phase

#### 1. Design Against Requirements

Every design element should trace back to a requirement.

**Practice:**
- Create a mapping document if needed
- Verify all requirements have design coverage
- Check that design decisions support requirements

#### 2. Consider Existing Codebase

Don't design in isolation.

**Check:**
- [ ] Are there existing patterns to follow?
- [ ] Can we reuse existing components?
- [ ] Does this integrate with current architecture?
- [ ] Are there conflicts with existing code?

#### 3. Document Trade-offs

Explain why certain decisions were made.

**Template:**
```
### Tech Stack Decision

Chosen: React + TypeScript

Alternatives Considered:
- Vue.js: Rejected due to team unfamiliarity
- Angular: Rejected due to steep learning curve

Rationale:
- Strong TypeScript support
- Large ecosystem
- Team expertise
- Existing components available
```

#### 4. Include Sequence Diagrams

Visualize component interactions using Mermaid diagrams.

**Benefits:**
- Clear communication flow
- Identify integration points
- Catch missing interactions
- Aid implementation

#### 5. Address Non-Functional Requirements

Don't forget:
- Performance (latency, throughput)
- Security (auth, encryption, validation)
- Scalability (horizontal/vertical)
- Reliability (error handling, recovery)
- Maintainability (modularity, documentation)

### Implementation Phase

#### 1. Break Down into Small Tasks

Tasks should be completable in 1-4 hours.

**Too large:**
```
Task: Build authentication system
```

**Better:**
```
Task 1: Create login API endpoint
Task 2: Implement password hashing
Task 3: Create session management
Task 4: Build login UI component
Task 5: Add form validation
Task 6: Implement error handling
```

#### 2. Identify Dependencies

Clearly state task dependencies.

**Why:**
- Correct execution order
- Parallelization opportunities
- Risk identification

**Template:**
```
**Dependencies:**
- Task 3 (must complete first)
- Task 5 (can start in parallel)
```

#### 3. Define Expected Outcomes

Each task should have a clear completion criteria.

**Example:**
```
**Expected Outcome:**
- Login endpoint accepting POST requests at /api/auth/login
- Returns JWT token on successful authentication
- Returns 401 on invalid credentials
- Includes rate limiting (5 attempts/minute)
- Has unit tests with >80% coverage
```

#### 4. Include Testing in Tasks

Testing shouldn't be an afterthought.

**Practice:**
- Add "Write unit tests" as a sub-task
- Specify test coverage expectations
- Include integration tests where appropriate

#### 5. Update Status Regularly

Track progress through task states: pending → in_progress → completed

**Benefits:**
- Visibility into progress
- Identify blockers
- Measure velocity

## Steering Files Best Practices

### 1. Keep Focused

One steering file per domain.

**Good structure:**
```
.steering/workspace/
├── tech.md              # Technology stack only
├── api-standards.md     # API conventions only
├── testing-standards.md # Testing patterns only
└── code-conventions.md  # Code style only
```

### 2. Use Clear Names

Names should immediately convey the file's purpose.

**Examples:**
- ✓ `api-rest-conventions.md`
- ✓ `testing-unit-patterns.md`
- ✓ `components-form-validation.md`
- ✗ `stuff.md`
- ✗ `guidelines.md`
- ✗ `rules.md`

### 3. Include Examples

Don't just describe rules - show them.

**Bad:**
```
Follow REST conventions for API endpoints.
```

**Good:**
```
### API Endpoint Naming

Use kebab-case and resource-based naming:

✓ Good:
- GET /api/users
- POST /api/users
- GET /api/users/{id}
- DELETE /api/users/{id}

✗ Bad:
- GET /api/getUsers
- POST /api/createUser
- GET /api/user
```

### 4. Explain "Why"

Document the reasoning behind decisions.

**Example:**
```
### Error Response Format

We use a consistent error response format:

```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Email is required",
    "details": {
      "field": "email",
      "value": ""
    }
  }
}
```

**Why:** This format allows frontend to:
- Programmatically handle different error types
- Display user-friendly messages
- Show field-specific validation errors
- Log structured errors for debugging
```

### 5. Security First

Never include secrets in steering files.

**Remember:**
- Steering files are part of the codebase
- They may be shared or committed
- Use environment variables for secrets
- Document what secrets are needed, not the secrets themselves

## Workflow Best Practices

### 1. Don't Rush to Code

Take time to create quality specs.

**Time allocation recommendation:**
- Requirements: 20-30% of planning time
- Design: 30-40% of planning time
- Implementation planning: 20-30% of planning time

### 2. Review and Iterate

Get feedback at each phase.

**Review checklist:**
- [ ] Requirements reviewed with product owner
- [ ] Design reviewed with tech lead
- [ ] Tasks reviewed by implementer
- [ ] All stakeholders aligned

### 3. Maintain Traceability

Keep track of how requirements flow through to implementation.

**Approaches:**
- Number requirements and reference them in design/tasks
- Use tags or labels
- Create a traceability matrix document

### 4. Document Deviations

If implementation differs from spec, document why.

**Template:**
```
## Deviations from Design

### Database Schema

**Design:** Use UUIDs for all primary keys
**Actual:** Used auto-increment integers for user IDs
**Reason:** Migration compatibility with legacy system
**Impact:** User ID handling code adjusted accordingly
```

### 5. Keep Specs Updated

Specs are living documents.

**When to update:**
- Requirements change
- New constraints discovered
- Architecture evolves
- Lessons learned during implementation

## Common Pitfalls and How to Avoid Them

### Pitfall 1: Over-Engineering Specs

**Problem:** Spending too much time on specs for simple features.

**Solution:** Adjust spec depth based on complexity:
- Simple feature (1-2 hours of work): Minimal spec
- Medium feature (1-3 days): Standard spec
- Large feature (1-2 weeks): Detailed spec

### Pitfall 2: Not Iterating Enough

**Problem:** Creating spec once and never revisiting.

**Solution:** Build iteration into the process:
- Review requirements after initial draft
- Get design feedback
- Walk through tasks before starting

### Pitfall 3: Ignoring Existing Patterns

**Problem:** Designing without considering existing codebase.

**Solution:**
- Always search for similar existing code
- Follow established patterns
- Consult with team members

### Pitfall 4: Vague Requirements

**Problem:** Requirements that are open to interpretation.

**Solution:**
- Use EARS notation consistently
- Include specific metrics where applicable
- Define all terms that might be ambiguous

### Pitfall 5: Missing Error Cases

**Problem:** Only documenting happy path scenarios.

**Solution:**
- Checklist for error scenarios
- Think about what could go wrong
- Include error handling requirements

### Pitfall 6: Not Testing Against Spec

**Problem:** Implementing features but not verifying they meet the spec.

**Solution:**
- Create test cases from requirements
- Verify acceptance criteria
- Update spec if testing reveals gaps

## Metrics and KPIs

Track these metrics to improve your spec-driven development process:

### Spec Quality Metrics
- **Requirements to Design Coverage**: % of requirements with design elements
- **Design to Tasks Coverage**: % of design elements with corresponding tasks
- **EARS Compliance**: % of requirements following proper EARS format

### Process Metrics
- **Spec Creation Time**: Time spent on each phase
- **Review Cycle Time**: Time between review and approval
- **Implementation Adherence**: % of implemented features matching spec

### Outcome Metrics
- **Rework Rate**: % of features requiring significant changes after implementation
- **Bug Rate**: Bugs found in production for spec-driven vs non-spec features
- **Delivery Velocity**: Features delivered per sprint with and without specs

## When NOT to Use Spec-Driven Development

Spec-driven development isn't always the right choice. Consider these scenarios:

### 1. Very Simple Features

**Example:** Fixing a typo, adding a single field

**Approach:** Direct implementation is faster

### 2. Proof of Concepts

**Example:** Testing a new idea, feasibility study

**Approach:** Flexible, rapid iteration is more important

### 3. Emergency Fixes

**Example:** Production outage, critical security patch

**Approach:** Fix first, document later

### 4. Experimenting

**Example:** A/B test, feature flag experiment

**Approach:** Lean documentation, learn and iterate

## Team Collaboration

### Roles and Responsibilities

**Product Owner:**
- Provide feature requirements
- Review and approve requirements
- Provide domain knowledge

**Tech Lead/Architect:**
- Guide design decisions
- Review architecture
- Ensure technical feasibility

**Developer:**
- Create design documentation
- Break down into tasks
- Implement following the spec

**QA Engineer:**
- Create tests from requirements
- Verify acceptance criteria
- Identify gaps in specs

### Communication Patterns

**Requirements Review:**
- Product owner presents requirements
- Engineering asks clarifying questions
- Identify edge cases together

**Design Review:**
- Tech lead presents design
- Team evaluates technical approach
- Discuss alternatives and trade-offs

**Task Planning:**
- Developer walks through tasks
- Team estimates effort
- Identify dependencies and risks

## Continuous Improvement

### Retrospectives

After each spec-driven feature, ask:
1. What worked well in our spec process?
2. What could we improve?
3. Did the spec help or hinder implementation?
4. Were there missing requirements?

### Pattern Library

Build a library of reusable patterns:
- Common requirement templates
- Standard design patterns
- Reusable task breakdowns

### Knowledge Sharing

Share learnings with the team:
- Present successful spec examples
- Discuss challenges and solutions
- Update best practices based on experience

## Conclusion

Spec-driven development is most effective when:
- Applied to appropriate complexity levels
- Iterated on at each phase
- Aligned across requirements, design, and tasks
- Reviewed and approved by stakeholders
- Kept updated as implementation proceeds

The key is balance: enough structure to guide development, enough flexibility to adapt to learning and change.
