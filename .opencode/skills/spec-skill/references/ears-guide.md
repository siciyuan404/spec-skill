# EARS Notation Guide

## What is EARS?

EARS (Easy Approach to Requirements Syntax) is a structured format for writing clear, testable requirements. Each requirement follows this pattern:

```
WHEN [condition/event] THE SYSTEM SHALL [expected behavior]
```

## Why Use EARS?

- **Clarity**: Requirements are unambiguous and easy to understand
- **Testability**: Each requirement can be directly translated into test cases
- **Traceability**: Individual requirements can be tracked through implementation
- **Completeness**: The format encourages thinking through all conditions and behaviors

## EARS Patterns

### 1. Event-Based Requirements

Use when the system should respond to a specific event or action.

```
WHEN a user submits the login form THE SYSTEM SHALL validate credentials
WHEN a file upload completes THE SYSTEM SHALL generate a thumbnail
WHEN the system detects invalid input THE SYSTEM SHALL display an error message
```

### 2. State-Based Requirements

Use when the system should behave differently depending on its state.

```
WHEN the system is in maintenance mode THE SYSTEM SHALL return a 503 status code
WHEN a user session is expired THE SYSTEM SHALL redirect to the login page
WHEN the database connection is lost THE SYSTEM SHALL attempt to reconnect
```

### 3. Conditional Requirements

Use when behavior depends on specific conditions.

```
WHEN the user is an administrator THE SYSTEM SHALL show advanced configuration options
WHEN the order total exceeds $100 THE SYSTEM SHALL apply free shipping
WHEN the API rate limit is reached THE SYSTEM SHALL return a 429 status
```

### 4. Time-Based Requirements

Use when behavior is time-dependent.

```
WHEN the scheduled maintenance window begins THE SYSTEM SHALL temporarily disable new sign-ups
WHEN a user is inactive for 30 minutes THE SYSTEM SHALL automatically log them out
WHEN the daily backup completes THE SYSTEM SHALL send a notification email
```

### 5. Exception Requirements

Use for error handling and edge cases.

```
WHEN payment processing fails THE SYSTEM SHALL log the error and display a user-friendly message
WHEN the file exceeds the size limit THE SYSTEM SHALL reject the upload with a specific error
WHEN the database query times out THE SYSTEM SHALL retry up to 3 times
```

## EARS Templates

### User Story with Acceptance Criteria

```markdown
### Story: User Authentication

As a user, I want to authenticate with my credentials, so that I can access my personalized content.

**Acceptance Criteria:**

1. Valid Credentials
WHEN a user submits valid email and password credentials THE SYSTEM SHALL authenticate the user and redirect to the dashboard

2. Invalid Credentials
WHEN a user submits invalid credentials THE SYSTEM SHALL display an error message "Invalid email or password"

3. Account Locked
WHEN a user exceeds 5 failed login attempts THE SYSTEM SHALL temporarily lock the account for 15 minutes

4. Password Reset
WHEN a user clicks "Forgot Password" THE SYSTEM SHALL send a password reset email

5. Session Management
WHEN a user successfully authenticates THE SYSTEM SHALL create a secure session token valid for 24 hours
```

### Feature Requirements Document

```markdown
# Password Reset Feature Requirements

## Overview
Allow users to reset their password when they have forgotten it.

## User Stories

### Story 1: Request Password Reset
As a user, I want to request a password reset, so that I can regain access to my account if I forget my password.

**Acceptance Criteria:**
- WHEN a user enters a valid email address THE SYSTEM SHALL send a password reset email
- WHEN a user enters an invalid email format THE SYSTEM SHALL display a validation error
- WHEN the email address is not registered THE SYSTEM SHALL show "If this email exists, a reset link has been sent"
- WHEN the reset email is sent THE SYSTEM SHALL include a token valid for 1 hour

### Story 2: Reset Password with Token
As a user, I want to set a new password using the reset link, so that I can access my account again.

**Acceptance Criteria:**
- WHEN a user clicks a valid reset link THE SYSTEM SHALL allow them to set a new password
- WHEN a user uses an expired token THE SYSTEM SHALL display "This reset link has expired"
- WHEN a user uses an already-used token THE SYSTEM SHALL display "This reset link has already been used"
- WHEN the new password meets strength requirements THE SYSTEM SHALL update the password and redirect to login
- WHEN the new password does not meet requirements THE SYSTEM SHALL display specific validation errors
```

## Best Practices for Writing EARS Requirements

### 1. Be Specific

**Bad:**
```
WHEN a user logs in THE SYSTEM SHALL work
```

**Good:**
```
WHEN a user submits valid credentials THE SYSTEM SHALL authenticate the user and create a session
```

### 2. Focus on Observable Behavior

**Bad:**
```
WHEN data is saved THE SYSTEM SHALL validate internally
```

**Good:**
```
WHEN a user submits the form THE SYSTEM SHALL validate all required fields before saving
```

### 3. Avoid Ambiguity

**Bad:**
```
WHEN the system is slow THE SYSTEM SHALL optimize
```

**Good:**
```
WHEN the API response time exceeds 2 seconds THE SYSTEM SHALL log a performance warning
```

### 4. Include Error Cases

**Bad:**
```
WHEN a user submits data THE SYSTEM SHALL save it
```

**Good:**
```
WHEN a user submits valid data THE SYSTEM SHALL save it successfully
WHEN a user submits invalid data THE SYSTEM SHALL display validation errors with specific messages
```

### 5. Make Requirements Testable

**Bad:**
```
WHEN the user uses the system THE SYSTEM SHALL be user-friendly
```

**Good:**
```
WHEN a new user first visits the dashboard THE SYSTEM SHALL display an onboarding tutorial
WHEN a user clicks the help button THE SYSTEM SHALL show contextual help for the current page
```

## Common Mistakes to Avoid

### 1. Combining Multiple Behaviors

**Bad:**
```
WHEN a user submits the form THE SYSTEM SHALL validate the input, save it to the database, and send an email
```

**Good:**
```
WHEN a user submits valid form data THE SYSTEM SHALL save it to the database
WHEN the data is successfully saved THE SYSTEM SHALL send a confirmation email
```

### 2. Using Vague Terms

**Bad:**
```
WHEN the system processes the request THE SYSTEM SHALL respond quickly
```

**Good:**
```
WHEN a user submits a request THE SYSTEM SHALL respond within 200ms for 95% of requests
```

### 3. Missing Conditions

**Bad:**
```
THE SYSTEM SHALL display the user profile
```

**Good:**
```
WHEN a user navigates to their profile page THE SYSTEM SHALL display their profile information
```

### 4. Focusing on Implementation

**Bad:**
```
WHEN a request is received THE SYSTEM SHALL query the database using SQL
```

**Good:**
```
WHEN a user searches for products THE SYSTEM SHALL return matching results within 500ms
```

## EARS Requirements Checklist

For each EARS requirement, verify:

- [ ] Starts with "WHEN"
- [ ] Clearly describes the condition/event
- [ ] States the system's expected behavior with "THE SYSTEM SHALL"
- [ ] Is specific and unambiguous
- [ ] Describes observable behavior
- [ ] Can be tested or verified
- [ ] Is independent (one requirement per statement)
- [ ] Includes error/edge cases where applicable
- [ ] Avoids implementation details
- [ ] Is complete (doesn't leave ambiguity)

## Translating Natural Language to EARS

### Example 1

**Natural Language:**
"Users should be able to upload files up to 10MB."

**EARS:**
```
WHEN a user uploads a file under 10MB THE SYSTEM SHALL save the file successfully
WHEN a user attempts to upload a file over 10MB THE SYSTEM SHALL reject the upload and display "File size exceeds 10MB limit"
```

### Example 2

**Natural Language:**
"The system needs to send email notifications for important events."

**EARS:**
```
WHEN a critical error occurs THE SYSTEM SHALL send an email notification to the admin team within 1 minute
WHEN a user successfully completes an order THE SYSTEM SHALL send an order confirmation email
```

### Example 3

**Natural Language:**
"Make sure the API handles rate limiting."

**EARS:**
```
WHEN a client makes more than 100 requests per minute THE SYSTEM SHALL return a 429 status code
WHEN the rate limit is exceeded THE SYSTEM SHALL include a "Retry-After" header with the remaining time
```

## Testing EARS Requirements

Each EARS requirement should translate to one or more test cases:

```
Requirement:
WHEN a user submits valid credentials THE SYSTEM SHALL authenticate the user and create a session

Test Cases:
1. Test with correct email and password → Expect successful login
2. Test with correct email but wrong password → Expect error message
3. Test with email that doesn't exist → Expect error message
4. Test with empty fields → Expect validation error
```

## Summary

EARS notation provides a structured approach to writing requirements that:
- Improves clarity and understanding
- Enables direct translation to tests
- Supports traceability through development
- Encourages comprehensive thinking about system behavior

Use EARS consistently across all requirements to ensure quality and alignment between product, design, and engineering teams.
