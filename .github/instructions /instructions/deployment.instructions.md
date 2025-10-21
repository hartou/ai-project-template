---
applyTo: 'deployment/**'
---

# Deployment Instructions

## Purpose

This instruction file governs all deployment-related operations, configurations, and procedures. It ensures consistent, reliable, and secure deployment across all environments and platforms.

## Deployment Structure

### Directory Organization
```
deployment/
├── container/                # Container-based deployments
│   ├── Dockerfile           # Main container configuration
│   ├── docker-compose.yml   # Multi-container orchestration
│   ├── .dockerignore       # Container build exclusions
│   ├── build-*.sh          # Build scripts
│   ├── deploy-*.sh         # Deployment scripts
│   └── README.md           # Container deployment guide
├── cloud/                   # Cloud platform deployments
│   ├── aws/                # AWS-specific configurations
│   ├── azure/              # Azure-specific configurations
│   ├── gcp/                # Google Cloud configurations
│   ├── terraform/          # Infrastructure as Code
│   └── README.md           # Cloud deployment guide
├── local/                   # Local development deployment
│   ├── setup.sh            # Local environment setup
│   ├── start-dev.sh        # Development server startup
│   ├── docker-compose.dev.yml # Local development containers
│   └── README.md           # Local deployment guide
└── README.md               # Main deployment documentation
```

## Container Deployment Standards

### Dockerfile Best Practices

```dockerfile
# ✅ Good Dockerfile structure
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production && npm cache clean --force

FROM node:18-alpine AS production
LABEL maintainer="your-email@example.com"
LABEL version="1.0.0"
LABEL description="AI Project Application"

# Create non-root user
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nextjs -u 1001

WORKDIR /app
COPY --from=builder --chown=nextjs:nodejs /app/node_modules ./node_modules
COPY --chown=nextjs:nodejs . .

# Security: Don't run as root
USER nextjs

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
    CMD curl -f http://localhost:3000/health || exit 1

EXPOSE 3000
CMD ["npm", "start"]
```

### Docker Compose Configuration

```yaml
# docker-compose.yml
version: '3.8'

services:
  app:
    build:
      context: .
      dockerfile: deployment/container/Dockerfile
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=production
      - DATABASE_URL=${DATABASE_URL}
    depends_on:
      - database
    restart: unless-stopped
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:3000/health"]
      interval: 30s
      timeout: 10s
      retries: 3

  database:
    image: postgres:15-alpine
    environment:
      POSTGRES_DB: ${DB_NAME}
      POSTGRES_USER: ${DB_USER}
      POSTGRES_PASSWORD: ${DB_PASSWORD}
    volumes:
      - postgres_data:/var/lib/postgresql/data
    restart: unless-stopped

volumes:
  postgres_data:
```

### Build and Deployment Scripts

```bash
#!/bin/bash
# build-container.sh

set -e

PROJECT_NAME="${PROJECT_NAME:-ai-project}"
VERSION="${VERSION:-latest}"
REGISTRY="${REGISTRY:-}"

echo "Building container for $PROJECT_NAME:$VERSION"

# Build the container
docker build \
  -t "$PROJECT_NAME:$VERSION" \
  -f deployment/container/Dockerfile \
  .

# Tag for registry if specified
if [ -n "$REGISTRY" ]; then
  docker tag "$PROJECT_NAME:$VERSION" "$REGISTRY/$PROJECT_NAME:$VERSION"
  echo "Tagged for registry: $REGISTRY/$PROJECT_NAME:$VERSION"
fi

echo "Build completed successfully"
```

## Cloud Deployment Standards

### Environment Configuration

```bash
# Environment variables template
# Copy to .env and customize

# Application
NODE_ENV=production
PORT=3000
APP_NAME=ai-project

# Database
DATABASE_URL=postgresql://user:pass@localhost:5432/dbname
DB_POOL_SIZE=10

# Security
JWT_SECRET=your-jwt-secret-here
API_KEY=your-api-key-here

# External Services
REDIS_URL=redis://localhost:6379
S3_BUCKET=your-s3-bucket

# AI/ML Configuration
MODEL_ENDPOINT=https://api.openai.com/v1
MODEL_API_KEY=your-model-api-key
```

### AWS Deployment

```yaml
# deployment/cloud/aws/ecs-task-definition.json
{
  "family": "ai-project",
  "taskRoleArn": "arn:aws:iam::account:role/ecsTaskRole",
  "executionRoleArn": "arn:aws:iam::account:role/ecsTaskExecutionRole",
  "networkMode": "awsvpc",
  "requiresCompatibilities": ["FARGATE"],
  "cpu": "256",
  "memory": "512",
  "containerDefinitions": [
    {
      "name": "ai-project",
      "image": "your-account.dkr.ecr.region.amazonaws.com/ai-project:latest",
      "portMappings": [
        {
          "containerPort": 3000,
          "protocol": "tcp"
        }
      ],
      "environment": [
        {
          "name": "NODE_ENV",
          "value": "production"
        }
      ],
      "secrets": [
        {
          "name": "DATABASE_URL",
          "valueFrom": "arn:aws:secretsmanager:region:account:secret:database-url"
        }
      ],
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "/ecs/ai-project",
          "awslogs-region": "us-east-1",
          "awslogs-stream-prefix": "ecs"
        }
      },
      "healthCheck": {
        "command": ["CMD-SHELL", "curl -f http://localhost:3000/health || exit 1"],
        "interval": 30,
        "timeout": 5,
        "retries": 3,
        "startPeriod": 60
      }
    }
  ]
}
```

### Azure Deployment

```yaml
# deployment/cloud/azure/azure-pipelines.yml
trigger:
  branches:
    include:
      - main
      - develop

pool:
  vmImage: 'ubuntu-latest'

variables:
  containerRegistry: 'your-registry.azurecr.io'
  imageRepository: 'ai-project'
  dockerfilePath: 'deployment/container/Dockerfile'
  tag: '$(Build.BuildId)'

stages:
- stage: Build
  displayName: Build and push stage
  jobs:
  - job: Build
    displayName: Build
    steps:
    - task: Docker@2
      displayName: Build and push an image to container registry
      inputs:
        command: buildAndPush
        repository: $(imageRepository)
        dockerfile: $(dockerfilePath)
        containerRegistry: $(dockerRegistryServiceConnection)
        tags: |
          $(tag)
          latest

- stage: Deploy
  displayName: Deploy stage
  dependsOn: Build
  condition: succeeded()
  jobs:
  - deployment: Deploy
    displayName: Deploy
    environment: 'production'
    strategy:
      runOnce:
        deploy:
          steps:
          - task: AzureContainerApps@1
            displayName: Deploy to Azure Container Apps
            inputs:
              azureSubscription: $(azureServiceConnection)
              containerAppName: 'ai-project-app'
              resourceGroup: 'ai-project-rg'
              imageToDeploy: '$(containerRegistry)/$(imageRepository):$(tag)'
```

### Terraform Infrastructure

```hcl
# deployment/cloud/terraform/main.tf
terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# VPC and networking
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  
  name = "${var.project_name}-vpc"
  cidr = "10.0.0.0/16"
  
  azs             = ["${var.aws_region}a", "${var.aws_region}b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]
  
  enable_nat_gateway = true
  enable_vpn_gateway = false
  
  tags = {
    Project = var.project_name
    Environment = var.environment
  }
}

# ECS Cluster
resource "aws_ecs_cluster" "main" {
  name = "${var.project_name}-cluster"
  
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
  
  tags = {
    Project = var.project_name
    Environment = var.environment
  }
}

# Application Load Balancer
resource "aws_lb" "main" {
  name               = "${var.project_name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = module.vpc.public_subnets
  
  enable_deletion_protection = false
  
  tags = {
    Project = var.project_name
    Environment = var.environment
  }
}
```

## Security Standards

### Container Security

1. **Non-root user**: Always run containers as non-root user
2. **Minimal base images**: Use alpine or distroless images
3. **Security scanning**: Scan images for vulnerabilities
4. **Secrets management**: Use proper secrets management
5. **Network policies**: Implement proper network segmentation

```dockerfile
# Security best practices
FROM node:18-alpine

# Create non-root user
RUN addgroup -g 1001 -S nodejs && \
    adduser -S appuser -u 1001

# Install security updates
RUN apk update && apk upgrade

# Use non-root user
USER appuser

# Remove unnecessary packages
RUN apk del --purge wget curl
```

### Secrets Management

```bash
#!/bin/bash
# secrets-setup.sh

# AWS Secrets Manager
aws secretsmanager create-secret \
  --name "ai-project/database-url" \
  --description "Database connection string" \
  --secret-string "$DATABASE_URL"

# Azure Key Vault
az keyvault secret set \
  --vault-name "ai-project-kv" \
  --name "database-url" \
  --value "$DATABASE_URL"

# Kubernetes secrets
kubectl create secret generic ai-project-secrets \
  --from-literal=database-url="$DATABASE_URL" \
  --from-literal=api-key="$API_KEY"
```

## Monitoring and Observability

### Health Checks

```javascript
// health-check.js
app.get('/health', async (req, res) => {
  try {
    // Check database connection
    await db.query('SELECT 1')
    
    // Check external services
    const modelStatus = await checkModelService()
    
    // Check system resources
    const memoryUsage = process.memoryUsage()
    const cpuUsage = process.cpuUsage()
    
    res.status(200).json({
      status: 'healthy',
      timestamp: new Date().toISOString(),
      services: {
        database: 'up',
        model: modelStatus,
      },
      system: {
        memory: memoryUsage,
        cpu: cpuUsage,
      }
    })
  } catch (error) {
    res.status(503).json({
      status: 'unhealthy',
      error: error.message,
      timestamp: new Date().toISOString()
    })
  }
})
```

### Logging Configuration

```yaml
# logging-config.yml
version: 1
formatters:
  standard:
    format: '%(asctime)s [%(levelname)s] %(name)s: %(message)s'
  json:
    class: pythonjsonlogger.jsonlogger.JsonFormatter
    format: '%(asctime)s %(name)s %(levelname)s %(message)s'

handlers:
  console:
    class: logging.StreamHandler
    level: INFO
    formatter: json
    stream: ext://sys.stdout
  
  file:
    class: logging.handlers.RotatingFileHandler
    level: DEBUG
    formatter: standard
    filename: /var/log/ai-project.log
    maxBytes: 10485760
    backupCount: 5

loggers:
  ai_project:
    level: DEBUG
    handlers: [console, file]
    propagate: no

root:
  level: WARNING
  handlers: [console]
```

## Performance Optimization

### Application Performance

1. **Resource limits**: Set appropriate CPU and memory limits
2. **Caching**: Implement caching strategies
3. **Connection pooling**: Use connection pooling for databases
4. **Horizontal scaling**: Design for horizontal scaling

### Infrastructure Performance

1. **Auto-scaling**: Implement auto-scaling policies
2. **Load balancing**: Use proper load balancing
3. **CDN**: Use CDN for static assets
4. **Database optimization**: Optimize database queries and indexes

## Deployment Procedures

### Pre-deployment Checklist

- [ ] All tests pass
- [ ] Security scan completed
- [ ] Environment variables configured
- [ ] Database migrations ready
- [ ] Rollback plan prepared
- [ ] Monitoring alerts configured

### Deployment Steps

1. **Preparation**
   ```bash
   # Build and test
   ./deployment/container/build-container.sh
   docker run --rm -it ai-project:latest npm test
   ```

2. **Security Scan**
   ```bash
   # Scan container for vulnerabilities
   docker run --rm -v /var/run/docker.sock:/var/run/docker.sock \
     aquasec/trivy image ai-project:latest
   ```

3. **Deploy**
   ```bash
   # Deploy to staging first
   ./deployment/cloud/deploy-staging.sh
   
   # Run smoke tests
   ./scripts/smoke-tests.sh staging
   
   # Deploy to production
   ./deployment/cloud/deploy-production.sh
   ```

4. **Post-deployment**
   ```bash
   # Verify deployment
   ./scripts/verify-deployment.sh production
   
   # Monitor for issues
   ./scripts/monitor-deployment.sh
   ```

### Rollback Procedures

```bash
#!/bin/bash
# rollback.sh

ENVIRONMENT="${1:-production}"
PREVIOUS_VERSION="${2}"

if [ -z "$PREVIOUS_VERSION" ]; then
  echo "Error: Previous version not specified"
  exit 1
fi

echo "Rolling back $ENVIRONMENT to version $PREVIOUS_VERSION"

# Update container image
kubectl set image deployment/ai-project \
  app="$REGISTRY/ai-project:$PREVIOUS_VERSION" \
  -n "$ENVIRONMENT"

# Wait for rollout
kubectl rollout status deployment/ai-project -n "$ENVIRONMENT"

# Verify rollback
./scripts/verify-deployment.sh "$ENVIRONMENT"

echo "Rollback completed"
```

## Troubleshooting

### Common Issues

1. **Container won't start**
   - Check logs: `docker logs container-name`
   - Verify environment variables
   - Check health endpoint

2. **Database connection issues**
   - Verify connection string
   - Check network connectivity
   - Validate credentials

3. **Performance issues**
   - Check resource utilization
   - Review application logs
   - Monitor database performance

### Debug Commands

```bash
# Container debugging
docker exec -it container-name sh
docker logs --follow container-name

# Kubernetes debugging
kubectl describe pod pod-name
kubectl logs pod-name --follow
kubectl exec -it pod-name -- sh

# Cloud platform debugging
aws ecs describe-tasks --tasks task-arn
az container logs --name container-name --resource-group rg-name
```

---

**Remember**: Deployment is a critical phase. Always test thoroughly, have rollback plans ready, and monitor closely after deployment.