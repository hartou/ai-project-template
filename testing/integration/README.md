# Integration Testing

This directory contains integration tests that verify the interaction between different components and systems.

## Structure

- `api/` - API integration tests
- `database/` - Database integration tests
- `services/` - Service integration tests
- `external/` - External API integration tests
- `workflows/` - End-to-end workflow tests
- `fixtures/` - Test data and setup files
- `config/` - Test environment configurations

## Testing Scope

Integration tests verify:
- Component interactions
- Data flow between systems
- API endpoint functionality
- Database operations
- External service integrations
- Authentication and authorization
- Error handling across systems

## Test Categories

### API Integration Tests
Testing complete API workflows:
- Request/response cycles
- Authentication flows
- Data validation
- Error responses
- Rate limiting
- CORS handling

### Database Integration Tests
Testing database operations:
- CRUD operations
- Transaction handling
- Data integrity
- Relationships
- Migrations
- Connection pooling

### Service Integration Tests
Testing service interactions:
- Inter-service communication
- Message queues
- Event handling
- State synchronization
- Dependency management

### External API Integration Tests
Testing third-party integrations:
- Payment gateways
- Authentication providers
- Cloud services
- Analytics services
- Notification services

## Testing Tools

### API Testing
- **Supertest**: HTTP assertion library
- **Newman**: Postman collection runner
- **Insomnia**: API client and testing
- **REST Assured**: Java REST testing

### Database Testing
- **Jest**: JavaScript testing with database
- **pytest**: Python testing with databases
- **TestContainers**: Isolated database testing
- **Factory Boy**: Test data generation

### Mock Servers
- **WireMock**: HTTP service mocking
- **JSON Server**: Quick REST API mocking
- **MockServer**: Advanced mocking and proxying
- **Postman Mock Server**: Postman-based mocking

## Test Environment Setup

### Test Database
```javascript
// Database setup for integration tests
beforeAll(async () => {
  await connectToTestDatabase();
  await runMigrations();
  await seedTestData();
});

afterAll(async () => {
  await cleanupTestData();
  await disconnectFromDatabase();
});
```

### API Server Setup
```javascript
// Express server setup for testing
const request = require('supertest');
const app = require('../app');

describe('API Integration Tests', () => {
  test('POST /api/users should create user', async () => {
    const userData = { name: 'Test User', email: 'test@example.com' };
    
    const response = await request(app)
      .post('/api/users')
      .send(userData)
      .expect(201);
    
    expect(response.body.user.name).toBe(userData.name);
  });
});
```

### External Service Mocking
```javascript
// Mock external APIs
const nock = require('nock');

beforeEach(() => {
  nock('https://api.external-service.com')
    .get('/users/123')
    .reply(200, { id: 123, name: 'External User' });
});
```

## Test Scenarios

### User Registration Flow
```javascript
describe('User Registration Integration', () => {
  test('should register user and send welcome email', async () => {
    // 1. Register user via API
    const response = await request(app)
      .post('/api/register')
      .send({ email: 'test@example.com', password: 'password123' });
    
    // 2. Verify user created in database
    const user = await User.findOne({ email: 'test@example.com' });
    expect(user).toBeTruthy();
    
    // 3. Verify welcome email sent
    expect(emailService.sendWelcomeEmail).toHaveBeenCalledWith(user.email);
  });
});
```

### Payment Processing Flow
```javascript
describe('Payment Processing Integration', () => {
  test('should process payment and update order', async () => {
    // Setup order
    const order = await createTestOrder();
    
    // Process payment
    const response = await request(app)
      .post(`/api/orders/${order.id}/pay`)
      .send({ paymentToken: 'test_token' });
    
    // Verify payment processed
    expect(response.status).toBe(200);
    
    // Verify order updated
    const updatedOrder = await Order.findById(order.id);
    expect(updatedOrder.status).toBe('paid');
  });
});
```

## Running Tests

### All Integration Tests
```bash
npm run test:integration
```

### Specific Test Suites
```bash
npm run test:integration -- --testPathPattern=api
```

### With Test Database
```bash
NODE_ENV=test npm run test:integration
```

### Parallel Execution
```bash
npm run test:integration -- --maxWorkers=4
```

## Environment Configuration

### Test Environment Variables
```bash
# .env.test
NODE_ENV=test
DATABASE_URL=postgresql://user:pass@localhost:5432/testdb
REDIS_URL=redis://localhost:6379/1
API_BASE_URL=http://localhost:3000
EXTERNAL_API_URL=http://localhost:3001/mock
```

### Docker Test Environment
```yaml
# docker-compose.test.yml
version: '3.8'
services:
  test-db:
    image: postgres:13
    environment:
      POSTGRES_DB: testdb
      POSTGRES_USER: testuser
      POSTGRES_PASSWORD: testpass
    ports:
      - "5433:5432"
  
  test-redis:
    image: redis:6
    ports:
      - "6380:6379"
```

## Best Practices

1. **Isolation**: Each test should be independent
2. **Cleanup**: Clean up test data after each test
3. **Realistic Data**: Use realistic test data and scenarios
4. **Mock External Services**: Mock third-party APIs
5. **Test Environments**: Use dedicated test environments
6. **Parallel Execution**: Design tests for parallel execution
7. **Documentation**: Document complex test scenarios