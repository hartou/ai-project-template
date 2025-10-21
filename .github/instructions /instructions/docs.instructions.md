---
applyTo: 'docs/**'
---

# Documentation Instructions

## Purpose

This instruction file governs all documentation creation, maintenance, and organization within the project. It ensures consistent, high-quality documentation that serves both current development and future maintenance needs.

## Documentation Structure

### Directory Organization
```
docs/
├── README.md                   # Main documentation index
├── ROADMAP.md                  # Project roadmap and planning
├── ARCHITECTURE.md             # System architecture documentation
├── API.md                      # API documentation
├── DEPLOYMENT.md               # Deployment guides
├── DEVELOPMENT.md              # Development setup and guidelines
├── CONTRIBUTING.md             # Contribution guidelines
├── CHANGELOG.md                # Version history and changes
├── api/                        # API documentation
│   ├── endpoints/             # Individual endpoint docs
│   ├── schemas/               # Data schema documentation
│   └── examples/              # API usage examples
├── architecture/               # Architecture documentation
│   ├── diagrams/              # System diagrams
│   ├── decisions/             # Architecture decision records
│   └── patterns/              # Design patterns used
├── guides/                     # User and developer guides
│   ├── user/                  # End-user guides
│   ├── developer/             # Developer guides
│   └── admin/                 # Administrator guides
├── tutorials/                  # Step-by-step tutorials
│   ├── getting-started/       # Getting started tutorials
│   ├── advanced/              # Advanced tutorials
│   └── troubleshooting/       # Troubleshooting guides
└── assets/                     # Documentation assets
    ├── images/                # Images and screenshots
    ├── diagrams/              # Diagram source files
    └── templates/             # Document templates
```

## Documentation Standards

### Writing Guidelines

#### 1. Clarity and Conciseness
- Use clear, simple language
- Avoid jargon unless necessary (define when used)
- Write for your audience (user, developer, admin)
- Use active voice when possible

```markdown
✅ Good:
## Setting Up the Development Environment

To set up your development environment, follow these steps:

1. Install Node.js version 18 or later
2. Clone the repository: `git clone https://github.com/your-repo.git`
3. Install dependencies: `npm install`

❌ Bad:
## Development Environment

The development environment can be set up by installing Node.js (version 18 or later should be used) and cloning the repository from GitHub, after which dependencies should be installed using npm.
```

#### 2. Structure and Organization
- Use descriptive headings
- Organize content logically
- Include table of contents for long documents
- Use consistent formatting

```markdown
# Document Title

## Table of Contents
- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Configuration](#configuration)
- [Usage](#usage)
- [Troubleshooting](#troubleshooting)

## Overview
Brief description of what this document covers.

## Prerequisites
List what users need before following this guide.
```

#### 3. Code Examples
- Include working code examples
- Provide context for code snippets
- Use syntax highlighting
- Show both input and expected output

```markdown
## API Usage Example

Here's how to create a new user using the API:

```bash
curl -X POST https://api.example.com/users \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -d '{
    "name": "John Doe",
    "email": "john@example.com"
  }'
```

Expected response:
```json
{
  "id": 123,
  "name": "John Doe",
  "email": "john@example.com",
  "created_at": "2023-01-01T00:00:00Z"
}
```
```

### Document Templates

#### README.md Template
```markdown
# Project Name

Brief description of what this project does and who it's for.

## Table of Contents
- [Features](#features)
- [Quick Start](#quick-start)
- [Installation](#installation)
- [Usage](#usage)
- [API Documentation](#api-documentation)
- [Contributing](#contributing)
- [License](#license)

## Features

- Feature 1: Description
- Feature 2: Description
- Feature 3: Description

## Quick Start

```bash
# Clone the repository
git clone https://github.com/username/project-name.git

# Install dependencies
npm install

# Start the development server
npm run dev
```

## Installation

### Prerequisites
- Node.js 18+
- npm or yarn
- [Other requirements]

### Step-by-step Installation

1. Clone the repository
2. Install dependencies
3. Configure environment variables
4. Start the application

## Usage

### Basic Usage
Explain how to use the basic features.

### Advanced Usage
Explain advanced features and configuration options.

## API Documentation

Link to detailed API documentation or provide basic examples.

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

## License

This project is licensed under the [License Name] - see the [LICENSE](LICENSE) file for details.
```

#### API Documentation Template
```markdown
# API Documentation

## Base URL
```
https://api.example.com/v1
```

## Authentication

All API requests require authentication using a bearer token:

```bash
Authorization: Bearer YOUR_API_TOKEN
```

## Endpoints

### Users

#### GET /users
Retrieve a list of users.

**Parameters:**
- `page` (optional): Page number (default: 1)
- `limit` (optional): Number of items per page (default: 20)
- `search` (optional): Search term

**Response:**
```json
{
  "users": [
    {
      "id": 1,
      "name": "John Doe",
      "email": "john@example.com",
      "created_at": "2023-01-01T00:00:00Z"
    }
  ],
  "pagination": {
    "page": 1,
    "limit": 20,
    "total": 100,
    "pages": 5
  }
}
```

#### POST /users
Create a new user.

**Request Body:**
```json
{
  "name": "John Doe",
  "email": "john@example.com",
  "password": "secure_password"
}
```

**Response:**
```json
{
  "id": 1,
  "name": "John Doe",
  "email": "john@example.com",
  "created_at": "2023-01-01T00:00:00Z"
}
```

**Error Responses:**
- `400 Bad Request`: Invalid input data
- `409 Conflict`: Email already exists
- `500 Internal Server Error`: Server error
```

#### Architecture Decision Record (ADR) Template
```markdown
# ADR-001: [Decision Title]

## Status
[Proposed | Accepted | Deprecated | Superseded]

## Date
YYYY-MM-DD

## Context
Describe the situation and forces that led to this decision.

## Decision
Describe the change we're proposing or have agreed to implement.

## Consequences
Describe the resulting context, positive and negative consequences.

### Positive Consequences
- Benefit 1
- Benefit 2

### Negative Consequences
- Drawback 1
- Drawback 2

### Risks
- Risk 1 and mitigation strategy
- Risk 2 and mitigation strategy

## Alternatives Considered
- Alternative 1: Description and why it was rejected
- Alternative 2: Description and why it was rejected

## Related Decisions
- ADR-XXX: Related decision
- Link to relevant discussions or documents
```

### Visual Documentation Standards

#### Diagrams and Images
- Use consistent styling across all diagrams
- Include source files for editable diagrams
- Provide alt text for accessibility
- Use appropriate file formats (SVG for diagrams, PNG for screenshots)

```markdown
## System Architecture

![System Architecture](assets/diagrams/system-architecture.svg "High-level system architecture showing main components and data flow")

*Figure 1: High-level system architecture showing the main components and their interactions.*
```

#### Screenshots and Examples
- Keep screenshots up to date
- Highlight important areas
- Use consistent browser/OS for screenshots
- Include captions explaining what's shown

## API Documentation Standards

### OpenAPI/Swagger Documentation
```yaml
# api/openapi.yml
openapi: 3.0.3
info:
  title: AI Project API
  description: REST API for the AI Project application
  version: 1.0.0
  contact:
    name: API Support
    email: support@example.com
    url: https://example.com/support

servers:
  - url: https://api.example.com/v1
    description: Production server
  - url: https://staging-api.example.com/v1
    description: Staging server

paths:
  /users:
    get:
      summary: List users
      description: Retrieve a paginated list of users
      parameters:
        - name: page
          in: query
          description: Page number
          required: false
          schema:
            type: integer
            minimum: 1
            default: 1
        - name: limit
          in: query
          description: Number of items per page
          required: false
          schema:
            type: integer
            minimum: 1
            maximum: 100
            default: 20
      responses:
        '200':
          description: Successful response
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/UserListResponse'
        '400':
          description: Bad request
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'

components:
  schemas:
    User:
      type: object
      required:
        - id
        - name
        - email
      properties:
        id:
          type: integer
          description: Unique identifier
        name:
          type: string
          description: User's full name
        email:
          type: string
          format: email
          description: User's email address
        created_at:
          type: string
          format: date-time
          description: When the user was created
```

### Code Documentation Standards

#### Function/Method Documentation
```javascript
/**
 * Creates a new user in the system
 * 
 * @param {Object} userData - The user data object
 * @param {string} userData.name - The user's full name
 * @param {string} userData.email - The user's email address
 * @param {string} userData.password - The user's password (will be hashed)
 * @param {Object} [options={}] - Additional options
 * @param {boolean} [options.sendWelcomeEmail=true] - Whether to send welcome email
 * @returns {Promise<User>} The created user object
 * @throws {ValidationError} When input data is invalid
 * @throws {ConflictError} When email already exists
 * 
 * @example
 * const user = await createUser({
 *   name: 'John Doe',
 *   email: 'john@example.com',
 *   password: 'securePassword123'
 * });
 * console.log(user.id); // 123
 */
async function createUser(userData, options = {}) {
  // Implementation here
}
```

#### Python Docstring Standards
```python
def train_model(data: pd.DataFrame, config: ModelConfig) -> TrainedModel:
    """Train a machine learning model with the provided data.
    
    Args:
        data: Training dataset containing features and labels
        config: Model configuration object containing hyperparameters
        
    Returns:
        Trained model instance ready for inference
        
    Raises:
        ValueError: If data is empty or malformed
        ConfigError: If configuration is invalid
        
    Examples:
        >>> data = pd.read_csv('training_data.csv')
        >>> config = ModelConfig(learning_rate=0.001, epochs=100)
        >>> model = train_model(data, config)
        >>> predictions = model.predict(test_data)
    """
    if data.empty:
        raise ValueError("Training data cannot be empty")
    
    # Implementation here
```

## Maintenance and Updates

### Documentation Lifecycle

#### 1. Creation
- Use appropriate template
- Follow naming conventions
- Include all required sections
- Review for clarity and accuracy

#### 2. Review Process
- Technical review for accuracy
- Editorial review for clarity
- User testing for usability
- Final approval before publication

#### 3. Maintenance
- Regular reviews (quarterly)
- Update with code changes
- Deprecate outdated content
- Archive obsolete documents

### Automated Documentation

#### Code-Generated Documentation
```javascript
// Generate API docs from code comments
npm run docs:generate

// Update OpenAPI spec from code
npm run api:generate-spec

// Generate type documentation
npm run types:docs
```

#### Documentation Testing
```bash
# Test documentation links
npm run docs:test-links

# Validate code examples
npm run docs:test-examples

# Check spelling and grammar
npm run docs:lint
```

### Documentation Metrics

#### Quality Metrics
- **Completeness**: All features documented
- **Accuracy**: Documentation matches implementation
- **Freshness**: Recently updated content
- **Accessibility**: Clear and understandable

#### Usage Metrics
- Page views and popular content
- User feedback and ratings
- Support ticket reduction
- Time to first success for new users

### Tools and Automation

#### Documentation Tools
```json
{
  "devDependencies": {
    "@apidevtools/swagger-parser": "^10.1.0",
    "markdown-link-check": "^3.10.3",
    "markdownlint-cli": "^0.35.0",
    "typedoc": "^0.24.8",
    "jsdoc": "^4.0.2"
  },
  "scripts": {
    "docs:lint": "markdownlint docs/**/*.md",
    "docs:link-check": "markdown-link-check docs/**/*.md",
    "docs:generate": "typedoc src --out docs/api/generated",
    "docs:serve": "docsify serve docs",
    "docs:build": "docsify build docs"
  }
}
```

#### Continuous Integration
```yaml
# .github/workflows/docs.yml
name: Documentation

on:
  push:
    paths:
      - 'docs/**'
      - 'src/**'
  pull_request:
    paths:
      - 'docs/**'

jobs:
  lint-docs:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Lint markdown
        uses: articulate/actions-markdownlint@v1
        with:
          config: .markdownlint.json
          files: 'docs/**/*.md'
      
      - name: Check links
        uses: gaurav-nelson/github-action-markdown-link-check@v1
        with:
          use-quiet-mode: 'yes'
          use-verbose-mode: 'yes'
          config-file: '.markdown-link-check.json'

  generate-docs:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'
      
      - name: Install dependencies
        run: npm ci
      
      - name: Generate API docs
        run: npm run docs:generate
      
      - name: Deploy to GitHub Pages
        uses: peaceiris/actions-gh-pages@v3
        if: github.ref == 'refs/heads/main'
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./docs
```

## Best Practices

### Writing Best Practices

#### 1. User-Focused Content
- Write for your audience
- Include practical examples
- Anticipate common questions
- Provide troubleshooting help

#### 2. Maintainable Documentation
- Keep it simple and focused
- Use version control effectively
- Link to authoritative sources
- Avoid duplicating information

#### 3. Collaborative Documentation
- Enable community contributions
- Provide feedback mechanisms
- Establish review processes
- Recognize contributors

### Content Organization

#### Information Architecture
```
1. Start with overview and getting started
2. Provide comprehensive reference material
3. Include practical tutorials and guides
4. End with troubleshooting and FAQ
```

#### Navigation Structure
- Clear hierarchy with logical grouping
- Consistent navigation across documents
- Search functionality for large documentation sets
- Cross-references and linking between related topics

### Accessibility

#### Writing for Accessibility
- Use clear, simple language
- Provide alternative text for images
- Use heading structure properly
- Ensure good color contrast in diagrams

#### Technical Accessibility
- Semantic HTML in generated docs
- Keyboard navigation support
- Screen reader compatibility
- Mobile-responsive design

---

**Remember**: Good documentation is a force multiplier for your project. Invest time in creating clear, comprehensive documentation that serves your users and contributors effectively.