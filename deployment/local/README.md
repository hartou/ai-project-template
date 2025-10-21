# Local Deployment

This directory contains configurations and scripts for local development and testing environments.

## Structure

- `docker-compose/` - Local Docker Compose configurations
- `scripts/` - Local setup and management scripts  
- `configs/` - Local configuration files
- `data/` - Local development data and fixtures
- `ssl/` - Local SSL certificates for HTTPS development

## Development Environments

### Docker Compose Setup
Complete local environment with all services:
- Application server
- Database (PostgreSQL/MySQL/MongoDB)
- Redis cache
- Message queue (RabbitMQ/Kafka)
- Monitoring stack (Grafana, Prometheus)

### Native Development
Run services directly on the host machine:
- Node.js/Python development server
- Local database instance
- Hot reload and debugging enabled
- IDE integration support

### Hybrid Approach
Mix of containerized and native services:
- Database and cache in containers
- Application running natively for debugging
- External services mocked or containerized

## Quick Start

### Full Docker Environment

```bash
# Start all services
cd deployment/local/docker-compose
docker-compose up -d

# View logs
docker-compose logs -f

# Stop services
docker-compose down
```

### Native Development

```bash
# Install dependencies
npm install

# Start local database
./scripts/start-db.sh

# Run development server
npm run dev
```

### Hybrid Setup

```bash
# Start infrastructure services
docker-compose -f docker-compose.infrastructure.yml up -d

# Run application natively
npm run dev
```

## Available Services

### Application Stack
- **Frontend**: React development server (port 3000)
- **Backend API**: Node.js/Express server (port 8000)
- **Database**: PostgreSQL (port 5432)
- **Redis**: Cache and sessions (port 6379)

### Development Tools
- **Mailhog**: Email testing (port 8025)
- **Adminer**: Database administration (port 8080)
- **Redis Commander**: Redis GUI (port 8081)

### Monitoring (Optional)
- **Grafana**: Metrics dashboard (port 3001)
- **Prometheus**: Metrics collection (port 9090)
- **Jaeger**: Distributed tracing (port 16686)

## Configuration

### Environment Variables
```bash
# Copy example environment file
cp .env.example .env.local

# Edit with local values
vim .env.local
```

### Database Setup
```bash
# Initialize database
./scripts/init-db.sh

# Load sample data
./scripts/load-sample-data.sh

# Reset database
./scripts/reset-db.sh
```

### SSL/HTTPS Setup
```bash
# Generate local SSL certificates
./scripts/generate-ssl.sh

# Trust certificates (macOS)
sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain ssl/localhost.crt
```

## Development Workflows

### Hot Reload Development
- Frontend: Automatic browser refresh
- Backend: Server restart on file changes
- Database: Schema migrations on change detection

### Testing Workflows
- Unit tests with file watching
- Integration tests with test database
- E2E tests with isolated environment

### Debugging Setup
- VS Code debug configurations
- Chrome DevTools integration
- Database query logging
- Network request monitoring

## Troubleshooting

### Common Issues
- **Port conflicts**: Change ports in docker-compose.yml
- **Permission issues**: Check Docker daemon permissions
- **Database connection**: Verify database is running and accessible
- **Environment variables**: Ensure all required variables are set

### Reset Environment
```bash
# Clean up containers and volumes
./scripts/cleanup.sh

# Full reset including node_modules
./scripts/full-reset.sh
```

## Best Practices

1. **Use environment files**: Keep sensitive data in .env files
2. **Docker volumes**: Persist data between container restarts
3. **Hot reload**: Enable for faster development cycles
4. **Logging**: Configure appropriate log levels for development
5. **Health checks**: Implement service health monitoring