# End-to-End (E2E) Testing

This directory contains end-to-end tests that verify complete user workflows and system functionality.

## Structure

- `tests/` - E2E test files
- `fixtures/` - Test data and setup files
- `pages/` - Page object models
- `utils/` - Test utilities and helpers
- `config/` - Test environment configurations
- `reports/` - Test execution reports
- `screenshots/` - Failure screenshots and recordings

## Testing Tools

### Primary Frameworks
- **Playwright**: Modern browser automation
- **Cypress**: Developer-friendly E2E testing
- **Selenium WebDriver**: Cross-browser testing
- **Puppeteer**: Headless Chrome automation

### Supporting Tools
- **Percy**: Visual regression testing
- **Axe**: Accessibility testing
- **Lighthouse CI**: Performance testing
- **BrowserStack**: Cross-browser cloud testing

## Test Categories

### User Journey Tests
Complete user workflows:
- User registration and onboarding
- Authentication and profile management
- Core feature usage
- Purchase and payment flows
- Data export and import

### Cross-Browser Tests
Browser compatibility verification:
- Chrome, Firefox, Safari, Edge
- Mobile browsers (iOS Safari, Chrome Mobile)
- Different browser versions
- Responsive design testing

### Performance Tests
Application performance validation:
- Page load times
- JavaScript performance
- Memory usage
- Network requests
- Core Web Vitals

### Accessibility Tests
Accessibility compliance verification:
- Screen reader compatibility
- Keyboard navigation
- Color contrast
- ARIA attributes
- WCAG guidelines

## Page Object Model

### Page Class Structure
```javascript
// pages/LoginPage.js
class LoginPage {
  constructor(page) {
    this.page = page;
    this.emailInput = page.locator('#email');
    this.passwordInput = page.locator('#password');
    this.loginButton = page.locator('button[type="submit"]');
    this.errorMessage = page.locator('.error-message');
  }

  async login(email, password) {
    await this.emailInput.fill(email);
    await this.passwordInput.fill(password);
    await this.loginButton.click();
  }

  async getErrorMessage() {
    return await this.errorMessage.textContent();
  }
}

module.exports = LoginPage;
```

### Test Implementation
```javascript
// tests/auth.spec.js
const { test, expect } = require('@playwright/test');
const LoginPage = require('../pages/LoginPage');

test.describe('Authentication', () => {
  test('should login with valid credentials', async ({ page }) => {
    const loginPage = new LoginPage(page);
    
    await page.goto('/login');
    await loginPage.login('user@example.com', 'password123');
    
    await expect(page).toHaveURL('/dashboard');
  });
});
```

## Test Scenarios

### User Registration Flow
```javascript
test('complete user registration', async ({ page }) => {
  // Navigate to registration
  await page.goto('/register');
  
  // Fill registration form
  await page.fill('#firstName', 'John');
  await page.fill('#lastName', 'Doe');
  await page.fill('#email', 'john.doe@example.com');
  await page.fill('#password', 'securePassword123');
  
  // Submit form
  await page.click('button[type="submit"]');
  
  // Verify email confirmation page
  await expect(page.locator('h1')).toContainText('Check Your Email');
  
  // Simulate email confirmation (in test environment)
  await confirmEmailInTestEnvironment('john.doe@example.com');
  
  // Login with new account
  await page.goto('/login');
  await page.fill('#email', 'john.doe@example.com');
  await page.fill('#password', 'securePassword123');
  await page.click('button[type="submit"]');
  
  // Verify successful login
  await expect(page).toHaveURL('/dashboard');
});
```

### E-commerce Purchase Flow
```javascript
test('complete purchase flow', async ({ page }) => {
  // Login
  await loginAsUser(page, 'customer@example.com');
  
  // Browse products
  await page.goto('/products');
  await page.click('.product-card:first-child');
  
  // Add to cart
  await page.click('#add-to-cart');
  await expect(page.locator('.cart-count')).toHaveText('1');
  
  // Go to checkout
  await page.click('.cart-icon');
  await page.click('#checkout-button');
  
  // Fill shipping information
  await page.fill('#shipping-address', '123 Test Street');
  await page.fill('#shipping-city', 'Test City');
  await page.fill('#shipping-zip', '12345');
  
  // Select payment method
  await page.click('#payment-card');
  await page.fill('#card-number', '4111111111111111');
  await page.fill('#card-expiry', '12/25');
  await page.fill('#card-cvc', '123');
  
  // Complete purchase
  await page.click('#complete-purchase');
  
  // Verify order confirmation
  await expect(page.locator('h1')).toContainText('Order Confirmed');
});
```

## Test Configuration

### Playwright Configuration
```javascript
// playwright.config.js
module.exports = {
  testDir: './tests',
  timeout: 30000,
  expect: { timeout: 5000 },
  use: {
    baseURL: 'http://localhost:3000',
    trace: 'on-first-retry',
    screenshot: 'only-on-failure',
    video: 'retain-on-failure'
  },
  projects: [
    { name: 'chromium', use: { ...devices['Desktop Chrome'] } },
    { name: 'firefox', use: { ...devices['Desktop Firefox'] } },
    { name: 'webkit', use: { ...devices['Desktop Safari'] } },
    { name: 'mobile', use: { ...devices['iPhone 12'] } }
  ]
};
```

### Cypress Configuration
```javascript
// cypress.config.js
module.exports = {
  e2e: {
    baseUrl: 'http://localhost:3000',
    viewportWidth: 1280,
    viewportHeight: 720,
    video: true,
    screenshotOnRunFailure: true,
    setupNodeEvents(on, config) {
      // Plugin configuration
    }
  }
};
```

## Running Tests

### Local Development
```bash
# Install dependencies
npm install

# Start application
npm run dev

# Run E2E tests
npm run test:e2e

# Run tests in headless mode
npm run test:e2e:headless

# Run specific test file
npm run test:e2e -- tests/auth.spec.js
```

### CI/CD Pipeline
```bash
# Run tests in CI environment
npm run test:e2e:ci

# Generate test reports
npm run test:e2e:report

# Upload test artifacts
npm run test:e2e:upload-artifacts
```

## Test Data Management

### Test Fixtures
```javascript
// fixtures/users.json
{
  "validUser": {
    "email": "test@example.com",
    "password": "password123",
    "firstName": "Test",
    "lastName": "User"
  },
  "adminUser": {
    "email": "admin@example.com",
    "password": "admin123",
    "role": "admin"
  }
}
```

### Database Seeding
```javascript
// utils/testData.js
async function seedTestData() {
  await db.users.create({
    email: 'test@example.com',
    password: await hashPassword('password123'),
    role: 'user'
  });
  
  await db.products.create({
    name: 'Test Product',
    price: 29.99,
    inventory: 100
  });
}
```

## Best Practices

1. **Stable Selectors**: Use data-testid attributes for reliable element selection
2. **Independent Tests**: Each test should be able to run independently
3. **Test Data**: Use consistent test data and clean up after tests
4. **Wait Strategies**: Use proper wait conditions instead of fixed delays
5. **Page Objects**: Organize tests using page object patterns
6. **Error Handling**: Implement proper error handling and debugging
7. **Parallel Execution**: Design tests for parallel execution
8. **Visual Testing**: Include visual regression tests for UI changes