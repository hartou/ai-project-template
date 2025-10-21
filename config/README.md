# Configuration

This directory contains configuration files for different environments and application settings.

## Structure

- `development/` - Development environment configurations
- `production/` - Production environment configurations
- `staging/` - Staging environment configurations
- `testing/` - Test environment configurations
- `local/` - Local development overrides
- `shared/` - Shared configuration across environments

## Configuration Types

### Application Config
- Database connection settings
- API endpoints and keys
- Feature flags and toggles
- Logging configurations
- Cache settings

### Environment Variables
- `.env.example` - Template for environment variables
- `.env.development` - Development environment vars
- `.env.production` - Production environment vars
- `.env.test` - Testing environment vars

### Framework Config
- `webpack.config.js` - Build tool configuration
- `tsconfig.json` - TypeScript configuration
- `eslint.config.js` - Linting rules
- `prettier.config.js` - Code formatting
- `jest.config.js` - Testing framework

## Usage

### Loading Configuration

```javascript
// Node.js/Express
const config = require('./config/development/app.json');

// Environment-specific loading
const env = process.env.NODE_ENV || 'development';
const config = require(`./config/${env}/app.json`);
```

### Environment Variables

```bash
# Copy example file
cp config/.env.example .env

# Edit with your values
vim .env
```

### Configuration Hierarchy

1. **Environment Variables** (highest priority)
2. **Local config files** 
3. **Environment-specific config**
4. **Default/shared config** (lowest priority)

## Security Guidelines

- **Never commit secrets**: Keep sensitive data out of version control
- **Use environment variables**: For secrets and environment-specific values
- **Validate config**: Implement configuration validation on startup
- **Document variables**: Maintain clear documentation for all config options

## Best Practices

1. **Environment Separation**: Maintain separate configs for each environment
2. **Documentation**: Document all configuration options
3. **Validation**: Validate configuration on application startup
4. **Defaults**: Provide sensible default values
5. **Secrets Management**: Use proper secret management solutions