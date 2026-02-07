# Project Structure

## Overview
{Brief description of how the project is organized}

---

## Directory Structure

```
{project-name}/
├── docs/                    # Documentation
│   ├── api/                 # API documentation
│   ├── user/                # User documentation
│   └── technical/           # Technical documentation
├── src/                     # Source code
│   ├── api/                 # API layer
│   ├── components/          # Frontend components
│   ├── services/            # Business logic
│   ├── utils/               # Utility functions
│   └── types/               # Type definitions
├── tests/                   # Test files
│   ├── unit/                # Unit tests
│   ├── integration/         # Integration tests
│   └── e2e/                 # End-to-end tests
├── scripts/                 # Build and utility scripts
├── config/                  # Configuration files
├── database/                # Database related files
│   ├── migrations/          # Database migrations
│   └── seeds/               # Seed data
├── assets/                  # Static assets
│   ├── images/              # Images
│   ├── fonts/               # Fonts
│   └── styles/              # Global styles
├── .specs/                  # Specifications
│   └── {spec-name}/         # Individual specs
│       ├── requirements.md
│       ├── design.md
│       └── tasks.md
├── .steering/               # Steering files
│   ├── workspace/           # Project-specific steering
│   └── global/              # Global steering
├── public/                  # Public files
├── dist/                    # Build output (generated)
├── node_modules/            # Dependencies (generated)
└── README.md               # Project readme
```

---

## File Naming Conventions

### General Rules
- Use {kebab-case/camelCase/snake_case}
- Be descriptive but concise
- Avoid abbreviations unless well-known

### Specific Patterns

**Components:**
- Format: {PascalCase} (e.g., `UserProfile.tsx`)
- Suffix: {Component type} (e.g., `UserProfile.tsx`, `UserProfile.test.tsx`)

**Files/Modules:**
- Format: {kebab-case} (e.g., `user-service.ts`)
- Format: {snake_case} for Python (e.g., `user_service.py`)

**Tests:**
- Format: Same as source file with `.test` or `.spec` suffix
- Example: `user-service.test.ts`, `user_service_test.py`

**Configuration:**
- Format: {lowercase} with dots for sections
- Example: `database.config.js`, `api.routes.js`

---

## Code Organization Patterns

### Feature-Based Structure (Recommended)
```
src/
├── auth/
│   ├── components/
│   │   ├── LoginForm.tsx
│   │   └── SignupForm.tsx
│   ├── services/
│   │   ├── auth.service.ts
│   │   └── token.service.ts
│   ├── types/
│   │   └── auth.types.ts
│   ├── api/
│   │   └── auth.routes.ts
│   └── auth.module.ts
├── users/
│   ├── components/
│   ├── services/
│   └── types/
└── shared/
    ├── components/
    ├── utils/
    └── types/
```

### Layer-Based Structure
```
src/
├── components/              # All UI components
│   ├── auth/
│   │   ├── LoginForm.tsx
│   │   └── SignupForm.tsx
│   └── users/
│       └── UserProfile.tsx
├── services/                # All business logic
│   ├── auth.service.ts
│   └── user.service.ts
├── api/                     # All API routes
│   ├── auth.routes.ts
│   └── user.routes.ts
└── types/                   # All type definitions
    ├── auth.types.ts
    └── user.types.ts
```

---

## Import/Export Patterns

### Relative Imports
```typescript
// From within same feature
import { LoginForm } from './LoginForm';
import { authService } from '../services/auth.service';

// From different feature
import { UserProfile } from '../../users/components/UserProfile';
```

### Absolute Imports (if configured)
```typescript
// When using absolute imports
import { LoginForm } from '@/auth/components/LoginForm';
import { authService } from '@/auth/services/auth.service';
```

### Barrel Exports (index.ts)
```typescript
// src/auth/index.ts
export { LoginForm } from './components/LoginForm';
export { SignupForm } from './components/SignupForm';
export { authService } from './services/auth.service';
export * from './types/auth.types';

// Usage
import { LoginForm, authService } from '@/auth';
```

---

## Component/Module Structure

### Component File Structure
```typescript
// 1. Imports
import React, { useState, useEffect } from 'react';
import { SomeType } from '@/types';
import { useAuth } from '@/hooks';

// 2. Types/Interfaces
interface UserProfileProps {
  userId: string;
  onUpdate?: () => void;
}

// 3. Constants
const MAX_ATTEMPTS = 3;

// 4. Component Definition
export const UserProfile: React.FC<UserProfileProps> = ({ userId, onUpdate }) => {
  // 5. Hooks
  const [user, setUser] = useState<SomeType | null>(null);
  const { isAuthenticated } = useAuth();

  // 6. Helper functions
  const handleUpdate = (data: SomeType) => {
    // Implementation
  };

  // 7. Effect hooks
  useEffect(() => {
    // Implementation
  }, [userId]);

  // 8. Render
  if (!user) return <Loading />;

  return (
    <div className="user-profile">
      {/* JSX */}
    </div>
  );
};
```

### Service File Structure
```typescript
// 1. Imports
import { db } from '@/database';
import { logger } from '@/utils/logger';

// 2. Types
interface UserService {
  getUserById(id: string): Promise<User>;
  createUser(data: UserData): Promise<User>;
}

// 3. Class definition
class UserService implements UserService {
  // 4. Private properties
  private readonly tableName = 'users';

  // 5. Public methods
  async getUserById(id: string): Promise<User> {
    try {
      const user = await db.query(
        `SELECT * FROM ${this.tableName} WHERE id = ?`,
        [id]
      );
      return user;
    } catch (error) {
      logger.error('Failed to get user', { id, error });
      throw error;
    }
  }

  async createUser(data: UserData): Promise<User> {
    // Implementation
  }
}

// 6. Export singleton instance
export const userService = new UserService();
```

---

## Documentation Standards

### File Header Documentation
```typescript
/**
 * Authentication Service
 *
 * Handles user authentication, token management, and session handling.
 *
 * @module auth
 * @requires express
 * @requires jsonwebtoken
 *
 * @example
 * import { authService } from '@/auth/services/auth.service';
 * const token = await authService.authenticate(email, password);
 */
```

### Function Documentation
```typescript
/**
 * Authenticates a user with email and password.
 *
 * @param email - The user's email address
 * @param password - The user's password (will be hashed)
 * @returns Promise resolving to authentication token
 * @throws {ValidationError} If credentials are invalid
 * @throws {DatabaseError} If database operation fails
 *
 * @example
 * const token = await authenticateUser('user@example.com', 'password123');
 */
export async function authenticateUser(
  email: string,
  password: string
): Promise<string> {
  // Implementation
}
```

---

## Configuration File Standards

### Environment Variables
```typescript
// config/environment.ts
export const config = {
  // API Configuration
  api: {
    port: parseInt(process.env.API_PORT || '3000'),
    host: process.env.API_HOST || 'localhost',
    cors: {
      origin: process.env.CORS_ORIGIN || '*',
    },
  },

  // Database Configuration
  database: {
    host: process.env.DB_HOST || 'localhost',
    port: parseInt(process.env.DB_PORT || '5432'),
    name: process.env.DB_NAME || 'myapp',
    user: process.env.DB_USER || 'postgres',
    password: process.env.DB_PASSWORD || '',
  },

  // Authentication
  auth: {
    jwtSecret: process.env.JWT_SECRET || 'secret',
    jwtExpiration: process.env.JWT_EXPIRATION || '24h',
  },
};
```

---

## Testing Structure

### Test File Organization
```
tests/
├── unit/                   # Unit tests
│   ├── auth/
│   │   ├── auth.service.test.ts
│   │   └── token.service.test.ts
│   └── users/
│       └── user.service.test.ts
├── integration/            # Integration tests
│   ├── api/
│   │   ├── auth.routes.test.ts
│   │   └── user.routes.test.ts
│   └── database/
│       └── migrations.test.ts
└── e2e/                    # End-to-end tests
    ├── auth.e2e.test.ts
    └── user-flow.e2e.test.ts
```

### Test File Structure
```typescript
// tests/unit/auth/auth.service.test.ts
import { authService } from '@/auth/services/auth.service';
import { mockDatabase } from '../mocks/database';

describe('AuthService', () => {
  beforeEach(() => {
    // Setup before each test
    mockDatabase.clear();
  });

  afterEach(() => {
    // Cleanup after each test
    mockDatabase.restore();
  });

  describe('authenticateUser', () => {
    it('should authenticate with valid credentials', async () => {
      // Arrange
      const email = 'test@example.com';
      const password = 'password123';
      mockDatabase.users.add({
        email,
        password: 'hashed_password',
      });

      // Act
      const result = await authService.authenticateUser(email, password);

      // Assert
      expect(result).toBeDefined();
      expect(result.token).toBeDefined();
    });

    it('should throw error with invalid credentials', async () => {
      // Arrange
      const email = 'test@example.com';
      const password = 'wrongpassword';

      // Act & Assert
      await expect(
        authService.authenticateUser(email, password)
      ).rejects.toThrow('Invalid credentials');
    });
  });
});
```

---

## Git Workflow

### Branch Naming
- **Features:** `feature/{feature-name}`
- **Bug Fixes:** `bugfix/{bug-description}`
- **Hot Fixes:** `hotfix/{issue-description}`
- **Refactoring:** `refactor/{description}`

### Commit Messages
Follow Conventional Commits:
```
feat: add user authentication feature

fix: resolve login timeout issue

docs: update API documentation

refactor: simplify data processing logic

test: add unit tests for auth service

chore: update dependencies
```

---

## Code Review Guidelines

### Before PR
- [ ] All tests passing
- [ ] Code follows project conventions
- [ ] Documentation updated
- [ ] No console.log or debug statements
- [ ] No hardcoded secrets

### Review Checklist
- [ ] Code is readable and maintainable
- [ ] Naming conventions followed
- [ ] Error handling is proper
- [ ] Security best practices followed
- [ ] Performance considered
- [ ] Tests are adequate

---

## Additional Standards

### Error Handling
```typescript
// Standard error response structure
interface ApiError {
  error: {
    code: string;
    message: string;
    details?: Record<string, unknown>;
    stack?: string; // Only in development
  };
}
```

### Logging Standards
```typescript
// Use appropriate log levels
logger.debug('Detailed debugging information');
logger.info('General information');
logger.warn('Warning about potential issues');
logger.error('Error that occurred', { error, context });
logger.critical('Critical system failure');
```

### Constants Management
```typescript
// Place constants in dedicated files
// src/constants/endpoints.ts
export const API_ENDPOINTS = {
  AUTH: {
    LOGIN: '/api/auth/login',
    LOGOUT: '/api/auth/logout',
  },
  USERS: {
    LIST: '/api/users',
    DETAIL: (id: string) => `/api/users/${id}`,
  },
} as const;

// src/constants/messages.ts
export const MESSAGES = {
  AUTH: {
    SUCCESS: 'Login successful',
    INVALID_CREDENTIALS: 'Invalid email or password',
  },
  VALIDATION: {
    REQUIRED: 'This field is required',
    INVALID_EMAIL: 'Invalid email format',
  },
} as const;
```

---

## Resources

### Documentation
- [Project README](../../README.md)
- [API Documentation](../api/)
- [Contributing Guide](../CONTRIBUTING.md)

### Tools
- [Linter Configuration](../../.eslintrc.js)
- [Formatter Configuration](../../.prettierrc)
- [Build Configuration](../../webpack.config.js)
