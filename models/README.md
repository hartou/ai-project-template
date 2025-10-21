# Models

This directory contains AI/ML models, schemas, and related configurations.

## Structure

- `trained/` - Pre-trained model files and weights
- `schemas/` - Data schemas and model definitions
- `configs/` - Model configuration files
- `scripts/` - Training and evaluation scripts
- `checkpoints/` - Model checkpoints during training
- `exports/` - Exported models for deployment

## Model Types

### Machine Learning Models
- Classification models
- Regression models
- Clustering algorithms
- Recommendation systems

### Deep Learning Models
- Neural networks
- Computer vision models
- Natural language processing models
- Generative models

### Data Models
- Database schemas
- API data models
- Validation schemas
- Type definitions

## File Formats

- `.pkl` - Scikit-learn models
- `.h5` - Keras/TensorFlow models
- `.pt` - PyTorch models
- `.onnx` - ONNX format for interoperability
- `.json` - Model configurations and metadata

## Usage

### Loading Models

```python
import joblib
import tensorflow as tf
import torch

# Scikit-learn
model = joblib.load('trained/classifier.pkl')

# TensorFlow/Keras
model = tf.keras.models.load_model('trained/neural_net.h5')

# PyTorch
model = torch.load('trained/pytorch_model.pt')
```

### Model Versioning

Models are versioned using semantic versioning (e.g., `v1.0.0`) and stored in subdirectories:

```
models/
├── trained/
│   ├── v1.0.0/
│   ├── v1.1.0/
│   └── latest/
```

## Best Practices

1. **Version Control**: Track model versions and metadata
2. **Documentation**: Document model architecture and performance
3. **Validation**: Include validation datasets and metrics
4. **Reproducibility**: Save training configurations and seeds
5. **Deployment**: Export models in deployment-ready formats