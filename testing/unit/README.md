# Unit Testing

This directory contains unit tests for individual components, functions, and modules.

## Structure

- `api/` - API endpoint and controller tests
- `components/` - Frontend component tests
- `services/` - Business logic service tests
- `utils/` - Utility function tests
- `models/` - Data model and validation tests
- `fixtures/` - Test data and mock objects
- `helpers/` - Test helper functions and utilities

## Testing Framework

### Frontend Tests
- **Jest**: JavaScript testing framework
- **React Testing Library**: Component testing utilities
- **Enzyme**: Alternative component testing (if used)
- **Vue Test Utils**: Vue.js component testing

### Backend Tests
- **Jest**: Node.js testing framework
- **Mocha**: Alternative testing framework
- **Chai**: Assertion library
- **Sinon**: Mocking and stubbing

### AI/ML Tests
- **pytest**: Python testing framework
- **unittest**: Python standard testing
- **numpy.testing**: Numerical testing utilities
- **scikit-learn**: Model testing utilities

## Test Categories

### Component Tests
Testing individual UI components in isolation:
- Props handling
- State management
- Event handling
- Rendering behavior
- Accessibility

### Function Tests
Testing individual functions and methods:
- Input validation
- Output verification
- Edge cases
- Error handling
- Performance

### Model Tests
Testing data models and schemas:
- Data validation
- Serialization/deserialization
- Model methods
- Relationships
- Constraints

## Testing Patterns

### Arrange-Act-Assert (AAA)
```javascript
describe('Calculator', () => {
  test('should add two numbers correctly', () => {
    // Arrange
    const calculator = new Calculator();
    const a = 5;
    const b = 3;
    
    // Act
    const result = calculator.add(a, b);
    
    // Assert
    expect(result).toBe(8);
  });
});
```

### Given-When-Then (BDD)
```javascript
describe('User authentication', () => {
  test('should authenticate valid user', () => {
    // Given
    const validCredentials = { username: 'test', password: 'pass123' };
    
    // When
    const result = authenticateUser(validCredentials);
    
    // Then
    expect(result.isAuthenticated).toBe(true);
  });
});
```

## Mock and Stub Strategies

### API Mocking
```javascript
// Mock external API calls
jest.mock('../services/apiService', () => ({
  fetchUserData: jest.fn().mockResolvedValue({ id: 1, name: 'Test User' })
}));
```

### Database Mocking
```javascript
// Mock database operations
jest.mock('../models/User', () => ({
  findById: jest.fn(),
  save: jest.fn(),
  delete: jest.fn()
}));
```

### Component Mocking
```javascript
// Mock child components
jest.mock('../components/ComplexComponent', () => {
  return function MockComplexComponent(props) {
    return <div data-testid="mock-complex">{props.children}</div>;
  };
});
```

## Running Tests

### All Unit Tests
```bash
npm run test:unit
```

### Specific Test Files
```bash
npm test -- api/userController.test.js
```

### Watch Mode
```bash
npm test -- --watch
```

### Coverage Report
```bash
npm run test:coverage
```

## Test Configuration

### Jest Configuration
```javascript
// jest.config.js
module.exports = {
  testEnvironment: 'jsdom',
  setupFilesAfterEnv: ['<rootDir>/src/setupTests.js'],
  moduleNameMapping: {
    '^@/(.*)$': '<rootDir>/src/$1'
  },
  collectCoverageFrom: [
    'src/**/*.{js,jsx,ts,tsx}',
    '!src/index.js'
  ]
};
```

### Test Setup
```javascript
// setupTests.js
import '@testing-library/jest-dom';
import { configure } from '@testing-library/react';

configure({ testIdAttribute: 'data-testid' });
```

## Best Practices

1. **Test Structure**: Use clear describe/test blocks
2. **Naming**: Use descriptive test names
3. **Isolation**: Each test should be independent
4. **Mocking**: Mock external dependencies
5. **Coverage**: Aim for high code coverage
6. **Fast Execution**: Keep tests fast and focused
7. **Maintainability**: Write maintainable test code