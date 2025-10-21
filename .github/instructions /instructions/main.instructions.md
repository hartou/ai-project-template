---
applyTo: '**'
---

# AI Project Template - Main Instructions

## Project Overview

This is a **template for AI-based projects** that provides a solid foundation with modern development practices, organized structure, and deployment-ready configurations.

**Template Purpose**: Standardized structure for AI/ML projects  
**Technology**: Adaptable to any tech stack  
**Features**: Issue tracking, deployment automation, testing framework, documentation standards  

## Core Concepts

### 1. **Organized Structure**
Clean separation of concerns with dedicated directories:
- `issues/` - Issue tracking and completion documentation
- `docs/` - Project documentation and planning
- `deployment/` - Multi-platform deployment configurations
- `testing/` - Comprehensive testing framework
- `src/` - Main source code (customize for your stack)

### 2. **Issue-Driven Development**
Each feature/issue gets its own directory with:
- `README.md` - Issue overview and context
- `completion.md` - Implementation documentation
- `handoff.md` - Handoff notes (if applicable)

### 3. **Deployment Ready**
Multiple deployment options out of the box:
- Container builds (Docker/OCI)
- Cloud platform configurations
- Local development setup

## Technology Stack (Customize)

This template is technology-agnostic. Adapt these sections for your specific stack:

### Frontend (if applicable)
- **React/Vue/Angular** - Modern web frameworks
- **TypeScript** - Type safety and better development experience
- **Tailwind/Styled Components** - Consistent styling

### Backend (if applicable)
- **Node.js/Python/Go** - API and business logic
- **FastAPI/Express/Flask** - Web framework
- **Database** - SQL/NoSQL based on requirements

### AI/ML Stack (customize)
- **PyTorch/TensorFlow** - Deep learning frameworks
- **Hugging Face** - Pre-trained models and tokenizers
- **MLflow/Weights & Biases** - Experiment tracking
- **Docker** - Containerized model serving

## Coding Guidelines

### TypeScript/JavaScript Projects

1. **Strict mode enabled** - Honor all TypeScript strict checks
2. **Type imports** - Use `import type` for type-only imports
3. **Interface over type** - Prefer interfaces for object shapes
4. **No `any`** - Always provide explicit types

```typescript
// ✅ Good
import type { ModelConfig } from '@/types'
interface ServiceConfig {
  modelName: string
  temperature: number
}

// ❌ Bad
import { ModelConfig } from '../types'
type ServiceConfig = any
```

### Python Projects

1. **Type hints** - Use type annotations throughout
2. **Docstrings** - Document all functions and classes
3. **Consistent formatting** - Use black and isort
4. **Virtual environments** - Always use virtual environments

```python
# ✅ Good
from typing import Dict, List, Optional
import logging

def process_data(
    input_data: List[Dict[str, str]], 
    config: Optional[Dict[str, Any]] = None
) -> List[Dict[str, Any]]:
    """Process input data according to configuration.
    
    Args:
        input_data: List of input records
        config: Optional configuration parameters
        
    Returns:
        Processed data records
    """
    # Implementation here
    pass

# ❌ Bad
def process_data(input_data, config=None):
    # No types, no documentation
    pass
```

### File Organization

```
your-ai-project/
├── .github/instructions/    # AI coding instructions
├── issues/                  # Issue tracking and completion docs
│   ├── issue1/             # Each issue has its own directory
│   │   ├── README.md       # Issue overview
│   │   ├── completion.md   # Completion documentation
│   │   └── handoff.md      # Handoff notes (if applicable)
│   └── issue[2-N]/         # Additional issues
├── docs/                    # Project documentation
│   ├── ROADMAP.md          # Development roadmap
│   ├── API.md              # API documentation
│   └── *.md                # Other documentation
├── deployment/              # Deployment configurations
│   ├── container/          # Container deployment
│   ├── cloud/              # Cloud platform deployment
│   └── local/              # Local development
├── testing/                 # All test files and results
│   ├── e2e/                # End-to-end tests
│   ├── integration/        # Integration tests
│   └── unit/               # Unit tests
├── scripts/                 # Development and setup scripts
├── assets/                  # Static assets and resources
├── archive/                 # Historical files and old versions
├── src/                     # Main source code
├── api/                     # API endpoints (if applicable)
├── frontend/                # Frontend code (if applicable)
├── models/                  # AI/ML models and training scripts
├── data/                    # Data files and datasets
└── config/                  # Configuration files
```

### Naming Conventions

1. **Files and directories** - Use kebab-case or snake_case consistently
2. **Classes** - PascalCase
3. **Functions/variables** - camelCase (JS/TS) or snake_case (Python)
4. **Constants** - UPPER_SNAKE_CASE
5. **Components** - PascalCase (if using React/Vue)

## AI/ML Specific Guidelines

### Model Development

1. **Version control models** - Use Git LFS or model registries
2. **Experiment tracking** - Document all experiments
3. **Reproducible environments** - Pin all dependencies
4. **Data versioning** - Track data changes

```python
# ✅ Good - Model configuration
@dataclass
class ModelConfig:
    model_name: str
    learning_rate: float
    batch_size: int
    epochs: int
    random_seed: int = 42

def train_model(config: ModelConfig, data_path: str) -> str:
    """Train model with given configuration."""
    # Set random seeds for reproducibility
    torch.manual_seed(config.random_seed)
    # Training implementation
    pass
```

### Data Handling

1. **Data validation** - Validate input data schemas
2. **Privacy compliance** - Follow data privacy regulations
3. **Efficient storage** - Use appropriate data formats
4. **Backup strategies** - Implement data backup plans

### Model Serving

1. **API design** - RESTful or GraphQL APIs
2. **Error handling** - Graceful error responses
3. **Monitoring** - Track model performance
4. **Scaling** - Design for horizontal scaling

## Testing Guidelines

### Test Structure
- **Unit tests** - Test individual functions/classes
- **Integration tests** - Test component interactions
- **End-to-end tests** - Test complete workflows
- **Model tests** - Test model accuracy and performance

### AI/ML Testing
```python
# ✅ Good - Model testing
def test_model_accuracy():
    model = load_model("test_model")
    test_data = load_test_data()
    
    predictions = model.predict(test_data.inputs)
    accuracy = calculate_accuracy(predictions, test_data.labels)
    
    assert accuracy >= 0.85, f"Model accuracy {accuracy} below threshold"

def test_model_inference_time():
    model = load_model("test_model")
    test_input = generate_test_input()
    
    start_time = time.time()
    prediction = model.predict(test_input)
    inference_time = time.time() - start_time
    
    assert inference_time < 1.0, f"Inference too slow: {inference_time}s"
```

## Deployment Guidelines

### Container Best Practices

1. **Multi-stage builds** - Optimize image size
2. **Security scanning** - Scan for vulnerabilities
3. **Health checks** - Implement health endpoints
4. **Resource limits** - Set appropriate limits

```dockerfile
# ✅ Good - Multi-stage build
FROM python:3.11-slim AS builder
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

FROM python:3.11-slim AS production
COPY --from=builder /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages
COPY src/ ./src/
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
    CMD curl -f http://localhost:8000/health || exit 1
CMD ["python", "src/main.py"]
```

### Cloud Deployment

1. **Environment variables** - Use for configuration
2. **Secrets management** - Secure credential handling
3. **Monitoring** - Implement logging and metrics
4. **Scaling policies** - Auto-scaling configuration

## Development Workflow

### Starting Development

```bash
# Install dependencies (customize for your stack)
./scripts/bootstrap.sh

# Start development environment
./scripts/start-dev.sh

# Run tests
./scripts/run-tests.sh
```

### Issue Management

1. Create issue directory: `issues/issue[N]/`
2. Document requirements in `README.md`
3. Implement solution
4. Document completion in `completion.md`
5. Add tests and results

### Version Control

1. **Commit messages** - Clear, descriptive messages
2. **Branch naming** - `feature/`, `fix/`, `docs/` prefixes
3. **Pull requests** - Use PR templates
4. **Code review** - Mandatory before merging

## Security Guidelines

### General Security

1. **No secrets in code** - Use environment variables
2. **Input validation** - Validate all inputs
3. **Authentication** - Implement proper auth
4. **HTTPS** - Use secure connections

### AI/ML Security

1. **Model security** - Protect against adversarial attacks
2. **Data privacy** - Implement privacy-preserving techniques
3. **API security** - Rate limiting and authentication
4. **Inference security** - Validate model inputs/outputs

## Performance Guidelines

### General Performance

1. **Profiling** - Regular performance profiling
2. **Caching** - Implement appropriate caching
3. **Database optimization** - Optimize queries
4. **Asset optimization** - Compress and optimize assets

### AI/ML Performance

1. **Model optimization** - Quantization, pruning
2. **Batch processing** - Process data in batches
3. **GPU utilization** - Optimize GPU usage
4. **Memory management** - Efficient memory usage

## Troubleshooting

### Common Issues

1. **Dependency conflicts** - Use virtual environments
2. **Memory issues** - Monitor and optimize memory usage
3. **Performance bottlenecks** - Profile and optimize
4. **Deployment failures** - Check logs and configurations

### Debug Tools

- **Logging** - Comprehensive logging strategies
- **Monitoring** - Application and infrastructure monitoring
- **Profiling** - Performance profiling tools
- **Testing** - Comprehensive test coverage

## Specialized Instructions

This template uses specialized instruction files for different areas:

### Available Instruction Files
- **issues.instructions.md** - Issue management standards
- **deployment.instructions.md** - Deployment procedures
- **testing.instructions.md** - Testing standards
- **docs.instructions.md** - Documentation guidelines

When working in specific areas, reference the appropriate instruction file for detailed guidance.

---

**Remember**: This template is designed to be customized for your specific AI project needs. Adapt the technology stack, guidelines, and structure to match your requirements while maintaining the organizational benefits.