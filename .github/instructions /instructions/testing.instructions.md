---
applyTo: 'testing/**'
---

# Testing Instructions

## Purpose

This instruction file governs all testing procedures, standards, and automation within the project. It ensures comprehensive test coverage, consistent testing practices, and reliable quality assurance.

## Testing Structure

### Directory Organization
```
testing/
├── unit/                    # Unit tests
│   ├── components/         # Component unit tests
│   ├── services/          # Service unit tests
│   ├── utils/             # Utility function tests
│   └── models/            # Model unit tests
├── integration/            # Integration tests
│   ├── api/               # API integration tests
│   ├── database/          # Database integration tests
│   └── external/          # External service tests
├── e2e/                   # End-to-end tests
│   ├── features/          # Feature-based E2E tests
│   ├── user-journeys/     # User journey tests
│   └── regression/        # Regression test suites
├── performance/           # Performance tests
│   ├── load/              # Load testing
│   ├── stress/            # Stress testing
│   └── benchmarks/        # Performance benchmarks
├── security/              # Security tests
│   ├── penetration/       # Penetration tests
│   ├── vulnerability/     # Vulnerability scans
│   └── compliance/        # Compliance tests
├── fixtures/              # Test data and fixtures
│   ├── data/              # Test datasets
│   ├── mocks/             # Mock objects
│   └── stubs/             # Service stubs
├── test-results/          # Test execution results
│   ├── coverage/          # Code coverage reports
│   ├── reports/           # Test reports
│   └── screenshots/       # E2E test screenshots
└── README.md              # Testing documentation
```

## Testing Standards

### Unit Testing Standards

#### Test Structure
```javascript
// ✅ Good unit test structure
describe('UserService', () => {
  let userService;
  let mockDatabase;

  beforeEach(() => {
    mockDatabase = {
      findUser: jest.fn(),
      createUser: jest.fn(),
      updateUser: jest.fn()
    };
    userService = new UserService(mockDatabase);
  });

  describe('createUser', () => {
    it('should create a new user with valid data', async () => {
      // Arrange
      const userData = {
        email: 'test@example.com',
        name: 'Test User'
      };
      const expectedUser = { id: 1, ...userData };
      mockDatabase.createUser.mockResolvedValue(expectedUser);

      // Act
      const result = await userService.createUser(userData);

      // Assert
      expect(result).toEqual(expectedUser);
      expect(mockDatabase.createUser).toHaveBeenCalledWith(userData);
    });

    it('should throw error for invalid email', async () => {
      // Arrange
      const invalidUserData = {
        email: 'invalid-email',
        name: 'Test User'
      };

      // Act & Assert
      await expect(userService.createUser(invalidUserData))
        .rejects.toThrow('Invalid email format');
    });
  });
});
```

#### Python Unit Testing
```python
# test_user_service.py
import pytest
from unittest.mock import Mock, patch
from src.services.user_service import UserService
from src.models.user import User


class TestUserService:
    """Test suite for UserService class."""
    
    @pytest.fixture
    def mock_database(self):
        """Mock database dependency."""
        return Mock()
    
    @pytest.fixture
    def user_service(self, mock_database):
        """UserService instance with mocked dependencies."""
        return UserService(database=mock_database)
    
    def test_create_user_success(self, user_service, mock_database):
        """Test successful user creation."""
        # Arrange
        user_data = {
            'email': 'test@example.com',
            'name': 'Test User'
        }
        expected_user = User(id=1, **user_data)
        mock_database.create_user.return_value = expected_user
        
        # Act
        result = user_service.create_user(user_data)
        
        # Assert
        assert result == expected_user
        mock_database.create_user.assert_called_once_with(user_data)
    
    def test_create_user_invalid_email(self, user_service):
        """Test user creation with invalid email."""
        # Arrange
        invalid_data = {
            'email': 'invalid-email',
            'name': 'Test User'
        }
        
        # Act & Assert
        with pytest.raises(ValueError, match="Invalid email format"):
            user_service.create_user(invalid_data)
```

### Integration Testing Standards

#### API Integration Tests
```javascript
// api-integration.test.js
const request = require('supertest');
const app = require('../src/app');
const { setupTestDB, teardownTestDB } = require('./helpers/database');

describe('API Integration Tests', () => {
  beforeAll(async () => {
    await setupTestDB();
  });

  afterAll(async () => {
    await teardownTestDB();
  });

  describe('POST /api/users', () => {
    it('should create a new user', async () => {
      const userData = {
        email: 'integration@test.com',
        name: 'Integration Test User'
      };

      const response = await request(app)
        .post('/api/users')
        .send(userData)
        .expect(201);

      expect(response.body).toMatchObject({
        id: expect.any(Number),
        email: userData.email,
        name: userData.name,
        createdAt: expect.any(String)
      });
    });

    it('should return 400 for invalid data', async () => {
      const invalidData = {
        email: 'invalid-email',
        name: ''
      };

      const response = await request(app)
        .post('/api/users')
        .send(invalidData)
        .expect(400);

      expect(response.body).toHaveProperty('errors');
    });
  });
});
```

#### Database Integration Tests
```python
# test_database_integration.py
import pytest
import asyncio
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from src.database.models import Base, User
from src.repositories.user_repository import UserRepository


@pytest.fixture(scope="session")
def test_engine():
    """Create test database engine."""
    engine = create_engine("sqlite:///:memory:")
    Base.metadata.create_all(engine)
    return engine


@pytest.fixture
def test_session(test_engine):
    """Create test database session."""
    Session = sessionmaker(bind=test_engine)
    session = Session()
    try:
        yield session
    finally:
        session.rollback()
        session.close()


@pytest.fixture
def user_repository(test_session):
    """UserRepository instance with test session."""
    return UserRepository(session=test_session)


class TestUserRepository:
    """Integration tests for UserRepository."""
    
    def test_create_and_find_user(self, user_repository):
        """Test creating and finding a user."""
        # Create user
        user_data = {
            'email': 'test@example.com',
            'name': 'Test User'
        }
        created_user = user_repository.create(user_data)
        
        # Find user
        found_user = user_repository.find_by_email('test@example.com')
        
        # Assert
        assert found_user is not None
        assert found_user.id == created_user.id
        assert found_user.email == user_data['email']
        assert found_user.name == user_data['name']
```

### End-to-End Testing Standards

#### Playwright E2E Tests
```javascript
// e2e/user-registration.spec.js
const { test, expect } = require('@playwright/test');

test.describe('User Registration Flow', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/register');
  });

  test('successful user registration', async ({ page }) => {
    // Fill registration form
    await page.fill('[data-testid="email-input"]', 'test@example.com');
    await page.fill('[data-testid="name-input"]', 'Test User');
    await page.fill('[data-testid="password-input"]', 'SecurePassword123!');
    await page.fill('[data-testid="confirm-password-input"]', 'SecurePassword123!');

    // Submit form
    await page.click('[data-testid="register-button"]');

    // Verify success
    await expect(page.locator('[data-testid="success-message"]')).toBeVisible();
    await expect(page).toHaveURL('/dashboard');
  });

  test('validation errors for invalid data', async ({ page }) => {
    // Submit empty form
    await page.click('[data-testid="register-button"]');

    // Verify validation errors
    await expect(page.locator('[data-testid="email-error"]')).toContainText('Email is required');
    await expect(page.locator('[data-testid="name-error"]')).toContainText('Name is required');
    await expect(page.locator('[data-testid="password-error"]')).toContainText('Password is required');
  });

  test('password confirmation mismatch', async ({ page }) => {
    await page.fill('[data-testid="email-input"]', 'test@example.com');
    await page.fill('[data-testid="name-input"]', 'Test User');
    await page.fill('[data-testid="password-input"]', 'SecurePassword123!');
    await page.fill('[data-testid="confirm-password-input"]', 'DifferentPassword');

    await page.click('[data-testid="register-button"]');

    await expect(page.locator('[data-testid="confirm-password-error"]'))
      .toContainText('Passwords do not match');
  });
});
```

### AI/ML Testing Standards

#### Model Testing
```python
# test_model_performance.py
import pytest
import numpy as np
from sklearn.metrics import accuracy_score, precision_score, recall_score
from src.models.classifier import TextClassifier
from src.data.test_datasets import load_test_data


class TestTextClassifier:
    """Test suite for text classification model."""
    
    @pytest.fixture(scope="class")
    def model(self):
        """Load trained model for testing."""
        return TextClassifier.load_from_checkpoint("models/text_classifier_v1.pkl")
    
    @pytest.fixture(scope="class")
    def test_data(self):
        """Load test dataset."""
        return load_test_data("test_classification_data.csv")
    
    def test_model_accuracy_threshold(self, model, test_data):
        """Test that model meets minimum accuracy threshold."""
        X_test, y_test = test_data
        predictions = model.predict(X_test)
        accuracy = accuracy_score(y_test, predictions)
        
        assert accuracy >= 0.85, f"Model accuracy {accuracy:.3f} below threshold 0.85"
    
    def test_model_precision_recall(self, model, test_data):
        """Test model precision and recall."""
        X_test, y_test = test_data
        predictions = model.predict(X_test)
        
        precision = precision_score(y_test, predictions, average='weighted')
        recall = recall_score(y_test, predictions, average='weighted')
        
        assert precision >= 0.80, f"Precision {precision:.3f} below threshold 0.80"
        assert recall >= 0.80, f"Recall {recall:.3f} below threshold 0.80"
    
    def test_model_inference_time(self, model):
        """Test model inference performance."""
        import time
        
        # Generate sample input
        sample_text = "This is a sample text for performance testing."
        
        # Measure inference time
        start_time = time.time()
        prediction = model.predict([sample_text])
        inference_time = time.time() - start_time
        
        assert inference_time < 1.0, f"Inference time {inference_time:.3f}s too slow"
        assert prediction is not None, "Model should return prediction"
    
    def test_model_batch_processing(self, model):
        """Test model batch processing capability."""
        batch_size = 100
        sample_texts = [f"Sample text {i}" for i in range(batch_size)]
        
        predictions = model.predict(sample_texts)
        
        assert len(predictions) == batch_size, "Should predict for all inputs"
        assert all(pred is not None for pred in predictions), "All predictions should be valid"
```

#### Data Validation Tests
```python
# test_data_validation.py
import pytest
import pandas as pd
from src.data.validators import DataValidator
from src.data.schemas import UserDataSchema


class TestDataValidation:
    """Test data validation and quality checks."""
    
    def test_data_schema_validation(self):
        """Test data schema validation."""
        valid_data = {
            'user_id': 123,
            'email': 'test@example.com',
            'age': 25,
            'created_at': '2023-01-01T00:00:00Z'
        }
        
        validator = DataValidator(UserDataSchema)
        result = validator.validate(valid_data)
        
        assert result.is_valid is True
        assert len(result.errors) == 0
    
    def test_data_schema_validation_errors(self):
        """Test data validation with invalid data."""
        invalid_data = {
            'user_id': 'not_a_number',
            'email': 'invalid_email',
            'age': -5,
            'created_at': 'invalid_date'
        }
        
        validator = DataValidator(UserDataSchema)
        result = validator.validate(invalid_data)
        
        assert result.is_valid is False
        assert len(result.errors) > 0
        assert 'user_id' in result.errors
        assert 'email' in result.errors
    
    def test_data_quality_checks(self):
        """Test data quality validation."""
        df = pd.DataFrame({
            'id': [1, 2, 3, 4, 5],
            'name': ['Alice', 'Bob', None, 'David', 'Eve'],
            'score': [0.95, 0.87, 0.92, 0.88, 1.05]  # Score > 1.0 is invalid
        })
        
        validator = DataValidator()
        quality_report = validator.check_data_quality(df)
        
        assert quality_report.missing_values['name'] == 1
        assert quality_report.outliers['score'] == 1
        assert quality_report.total_rows == 5
```

### Performance Testing Standards

#### Load Testing with Artillery
```yaml
# performance/load/api-load-test.yml
config:
  target: 'http://localhost:3000'
  phases:
    - duration: 60
      arrivalRate: 10
      name: "Warm up"
    - duration: 120
      arrivalRate: 50
      name: "Sustained load"
    - duration: 60
      arrivalRate: 100
      name: "Peak load"
  processor: "./load-test-functions.js"

scenarios:
  - name: "User registration and login"
    weight: 70
    flow:
      - post:
          url: "/api/auth/register"
          json:
            email: "test{{ $randomInt(1, 10000) }}@example.com"
            name: "Test User {{ $randomInt(1, 1000) }}"
            password: "SecurePassword123!"
          capture:
            - json: "$.user.id"
              as: "userId"
            - json: "$.token"
              as: "authToken"
      - post:
          url: "/api/auth/login"
          json:
            email: "{{ email }}"
            password: "SecurePassword123!"
          expect:
            - statusCode: 200

  - name: "API data operations"
    weight: 30
    flow:
      - get:
          url: "/api/users/{{ userId }}"
          headers:
            Authorization: "Bearer {{ authToken }}"
          expect:
            - statusCode: 200
            - contentType: json
```

#### Performance Benchmarks
```python
# performance/benchmarks/model_benchmark.py
import time
import pytest
import statistics
from src.models.classifier import TextClassifier


class TestModelBenchmarks:
    """Performance benchmarks for ML models."""
    
    @pytest.fixture(scope="class")
    def model(self):
        return TextClassifier.load_from_checkpoint("models/text_classifier_v1.pkl")
    
    def test_single_inference_benchmark(self, model):
        """Benchmark single inference performance."""
        sample_text = "This is a benchmark test for single inference."
        times = []
        
        # Warm up
        for _ in range(10):
            model.predict([sample_text])
        
        # Benchmark
        for _ in range(100):
            start = time.time()
            model.predict([sample_text])
            times.append(time.time() - start)
        
        avg_time = statistics.mean(times)
        p95_time = statistics.quantiles(times, n=20)[18]  # 95th percentile
        
        assert avg_time < 0.1, f"Average inference time {avg_time:.3f}s too slow"
        assert p95_time < 0.2, f"P95 inference time {p95_time:.3f}s too slow"
    
    def test_batch_inference_benchmark(self, model):
        """Benchmark batch inference performance."""
        batch_sizes = [1, 10, 50, 100]
        
        for batch_size in batch_sizes:
            sample_texts = [f"Sample text {i}" for i in range(batch_size)]
            
            start = time.time()
            predictions = model.predict(sample_texts)
            total_time = time.time() - start
            
            time_per_item = total_time / batch_size
            
            assert len(predictions) == batch_size
            assert time_per_item < 0.05, f"Batch size {batch_size}: {time_per_item:.3f}s per item too slow"
```

### Security Testing Standards

#### Security Test Suite
```python
# security/test_security.py
import pytest
import requests
from src.app import create_app
from src.security.validators import InputValidator


class TestSecurityValidation:
    """Security validation tests."""
    
    def test_sql_injection_protection(self):
        """Test protection against SQL injection."""
        malicious_inputs = [
            "'; DROP TABLE users; --",
            "1' OR '1'='1",
            "admin'/*",
            "1; DELETE FROM users WHERE 1=1 --"
        ]
        
        validator = InputValidator()
        
        for malicious_input in malicious_inputs:
            with pytest.raises(ValueError, match="Invalid input detected"):
                validator.validate_user_input(malicious_input)
    
    def test_xss_protection(self):
        """Test protection against XSS attacks."""
        xss_payloads = [
            "<script>alert('XSS')</script>",
            "javascript:alert('XSS')",
            "<img src=x onerror=alert('XSS')>",
            "&#60;script&#62;alert('XSS')&#60;/script&#62;"
        ]
        
        validator = InputValidator()
        
        for payload in xss_payloads:
            sanitized = validator.sanitize_html_input(payload)
            assert "<script>" not in sanitized
            assert "javascript:" not in sanitized
            assert "onerror=" not in sanitized
    
    def test_authentication_required(self):
        """Test that protected endpoints require authentication."""
        app = create_app(testing=True)
        
        with app.test_client() as client:
            protected_endpoints = [
                '/api/users/profile',
                '/api/admin/users',
                '/api/data/export'
            ]
            
            for endpoint in protected_endpoints:
                response = client.get(endpoint)
                assert response.status_code == 401, f"Endpoint {endpoint} should require authentication"
    
    def test_rate_limiting(self):
        """Test rate limiting protection."""
        app = create_app(testing=True)
        
        with app.test_client() as client:
            # Make multiple requests quickly
            responses = []
            for _ in range(105):  # Assuming rate limit is 100 req/min
                response = client.post('/api/auth/login', json={
                    'email': 'test@example.com',
                    'password': 'wrongpassword'
                })
                responses.append(response.status_code)
            
            # Should get rate limited (429) after exceeding limit
            assert 429 in responses, "Rate limiting should be enforced"
```

## Test Configuration and Setup

### Jest Configuration
```javascript
// jest.config.js
module.exports = {
  testEnvironment: 'node',
  coverageDirectory: 'testing/test-results/coverage',
  collectCoverageFrom: [
    'src/**/*.{js,ts}',
    '!src/**/*.d.ts',
    '!src/**/*.test.{js,ts}',
    '!src/index.ts'
  ],
  coverageThreshold: {
    global: {
      branches: 80,
      functions: 80,
      lines: 80,
      statements: 80
    }
  },
  setupFilesAfterEnv: ['<rootDir>/testing/setup.js'],
  testMatch: [
    '<rootDir>/testing/unit/**/*.test.{js,ts}',
    '<rootDir>/testing/integration/**/*.test.{js,ts}'
  ],
  reporters: [
    'default',
    ['jest-html-reporters', {
      publicPath: 'testing/test-results/reports',
      filename: 'test-report.html'
    }]
  ]
};
```

### Pytest Configuration
```ini
# pytest.ini
[tool:pytest]
testpaths = testing
python_files = test_*.py *_test.py
python_classes = Test*
python_functions = test_*
addopts = 
    --strict-markers
    --strict-config
    --verbose
    --tb=short
    --cov=src
    --cov-report=html:testing/test-results/coverage
    --cov-report=term-missing
    --cov-fail-under=80
    --junitxml=testing/test-results/reports/junit.xml
markers =
    unit: Unit tests
    integration: Integration tests
    e2e: End-to-end tests
    slow: Slow running tests
    security: Security tests
```

### Playwright Configuration
```javascript
// playwright.config.js
module.exports = {
  testDir: './testing/e2e',
  outputDir: './testing/test-results/e2e-results',
  timeout: 30000,
  expect: {
    timeout: 5000
  },
  fullyParallel: true,
  forbidOnly: !!process.env.CI,
  retries: process.env.CI ? 2 : 0,
  workers: process.env.CI ? 1 : undefined,
  reporter: [
    ['html', { outputFolder: 'testing/test-results/reports/playwright' }],
    ['json', { outputFile: 'testing/test-results/reports/test-results.json' }]
  ],
  use: {
    baseURL: 'http://localhost:3000',
    trace: 'on-first-retry',
    screenshot: 'only-on-failure',
    video: 'retain-on-failure'
  },
  projects: [
    {
      name: 'chromium',
      use: { ...devices['Desktop Chrome'] }
    },
    {
      name: 'firefox',
      use: { ...devices['Desktop Firefox'] }
    },
    {
      name: 'webkit',
      use: { ...devices['Desktop Safari'] }
    }
  ],
  webServer: {
    command: 'npm start',
    port: 3000,
    reuseExistingServer: !process.env.CI
  }
};
```

## Test Data Management

### Test Fixtures
```python
# fixtures/user_fixtures.py
import pytest
from src.models.user import User


@pytest.fixture
def sample_user_data():
    """Sample user data for testing."""
    return {
        'email': 'test@example.com',
        'name': 'Test User',
        'age': 25,
        'is_active': True
    }


@pytest.fixture
def sample_users():
    """List of sample users for testing."""
    return [
        User(id=1, email='user1@example.com', name='User One'),
        User(id=2, email='user2@example.com', name='User Two'),
        User(id=3, email='user3@example.com', name='User Three')
    ]


@pytest.fixture
def large_dataset():
    """Large dataset for performance testing."""
    return [
        {'id': i, 'value': f'data_{i}', 'score': i * 0.1}
        for i in range(10000)
    ]
```

### Mock Services
```javascript
// fixtures/mocks/external-services.js
const nock = require('nock');

class ExternalServiceMocks {
  static setupAuthServiceMock() {
    return nock('https://auth.example.com')
      .post('/api/validate')
      .reply(200, { valid: true, user_id: 123 });
  }

  static setupPaymentServiceMock() {
    return nock('https://payments.example.com')
      .post('/api/charge')
      .reply(200, { 
        transaction_id: 'txn_123',
        status: 'success',
        amount: 100.00
      });
  }

  static setupMLModelMock() {
    return nock('https://ml-api.example.com')
      .post('/api/predict')
      .reply(200, {
        prediction: 'positive',
        confidence: 0.95,
        model_version: '1.0.0'
      });
  }

  static cleanupMocks() {
    nock.cleanAll();
  }
}

module.exports = ExternalServiceMocks;
```

## Continuous Integration

### GitHub Actions Workflow
```yaml
# .github/workflows/test.yml
name: Test Suite

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  unit-tests:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'
          cache: 'npm'
      
      - name: Install dependencies
        run: npm ci
      
      - name: Run unit tests
        run: npm run test:unit
      
      - name: Upload coverage reports
        uses: codecov/codecov-action@v3
        with:
          file: ./testing/test-results/coverage/lcov.info

  integration-tests:
    runs-on: ubuntu-latest
    services:
      postgres:
        image: postgres:15
        env:
          POSTGRES_PASSWORD: postgres
          POSTGRES_DB: test_db
        options: >-
          --health-cmd pg_isready
          --health-interval 10s
          --health-timeout 5s
          --health-retries 5
    
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'
          cache: 'npm'
      
      - name: Install dependencies
        run: npm ci
      
      - name: Run integration tests
        run: npm run test:integration
        env:
          DATABASE_URL: postgresql://postgres:postgres@localhost:5432/test_db

  e2e-tests:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'
          cache: 'npm'
      
      - name: Install dependencies
        run: npm ci
      
      - name: Install Playwright
        run: npx playwright install --with-deps
      
      - name: Run E2E tests
        run: npm run test:e2e
      
      - name: Upload E2E artifacts
        uses: actions/upload-artifact@v3
        if: failure()
        with:
          name: playwright-report
          path: testing/test-results/reports/playwright/
```

## Quality Gates

### Coverage Requirements
- **Unit Tests**: Minimum 80% code coverage
- **Integration Tests**: Critical paths covered
- **E2E Tests**: All user journeys tested
- **Performance Tests**: Response time thresholds met

### Quality Metrics
```javascript
// quality-gates.js
const qualityGates = {
  coverage: {
    lines: 80,
    functions: 80,
    branches: 75,
    statements: 80
  },
  performance: {
    apiResponseTime: 500, // ms
    modelInferenceTime: 100, // ms
    pageLoadTime: 2000, // ms
  },
  security: {
    vulnerabilities: {
      critical: 0,
      high: 0,
      medium: 5,
      low: 10
    }
  },
  reliability: {
    testPassRate: 95, // %
    flakeRate: 2, // %
  }
};

module.exports = qualityGates;
```

---

**Remember**: Comprehensive testing is essential for reliable software. Maintain high standards, automate where possible, and always validate that tests are meaningful and maintainable.