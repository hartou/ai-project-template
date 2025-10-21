# API

This directory contains the backend API implementation for the AI project.

## Structure

- `routes/` - API route definitions and handlers
- `middleware/` - Express middleware functions
- `controllers/` - Business logic controllers
- `services/` - Service layer implementations
- `models/` - Data models and schemas
- `utils/` - Utility functions and helpers
- `tests/` - API-specific tests

## Getting Started

1. Install dependencies:

   ```bash
   npm install
   ```

2. Set up environment variables:

   ```bash
   cp .env.example .env
   ```

3. Start the development server:

   ```bash
   npm run dev
   ```

## API Documentation

API documentation is available at `/api/docs` when the server is running, or you can find the OpenAPI specification in the `docs/` directory.

## Testing

Run API tests:

```bash
npm run test:api
```