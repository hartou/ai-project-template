#!/bin/bash

# AI Project Template Setup Script
# This script helps customize the template for your specific project

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Default values
DEFAULT_PROJECT_NAME="my-ai-project"
DEFAULT_DESCRIPTION="An AI-powered application built with modern development practices"
DEFAULT_AUTHOR="Your Name"
DEFAULT_EMAIL="your.email@example.com"
DEFAULT_TECH_STACK="node"

echo -e "${BLUE}🚀 AI Project Template Setup${NC}"
echo -e "${BLUE}===============================${NC}"
echo ""

# Function to prompt for input with default
prompt_with_default() {
    local prompt="$1"
    local default="$2"
    local var_name="$3"
    
    echo -n -e "${YELLOW}$prompt${NC} (default: $default): "
    read input
    if [ -z "$input" ]; then
        declare -g "$var_name=$default"
    else
        declare -g "$var_name=$input"
    fi
}

# Collect project information
echo -e "${GREEN}📋 Project Information${NC}"
echo "Please provide information about your project:"
echo ""

prompt_with_default "Project name" "$DEFAULT_PROJECT_NAME" "PROJECT_NAME"
prompt_with_default "Project description" "$DEFAULT_DESCRIPTION" "DESCRIPTION"
prompt_with_default "Author name" "$DEFAULT_AUTHOR" "AUTHOR_NAME"
prompt_with_default "Author email" "$DEFAULT_EMAIL" "AUTHOR_EMAIL"

echo ""
echo -e "${GREEN}🛠️  Technology Stack${NC}"
echo "Select your technology stack:"
echo "1) Node.js + React (default)"
echo "2) Python + FastAPI"
echo "3) Node.js only (API)"
echo "4) Python only"
echo "5) Custom (manual setup)"
echo ""

echo -n -e "${YELLOW}Choose option (1-5):${NC} "
read tech_choice

case $tech_choice in
    2) TECH_STACK="python" ;;
    3) TECH_STACK="node-api" ;;
    4) TECH_STACK="python-only" ;;
    5) TECH_STACK="custom" ;;
    *) TECH_STACK="node" ;;
esac

echo ""
echo -e "${GREEN}🔧 Configuration${NC}"
echo "Your project configuration:"
echo "  Name: $PROJECT_NAME"
echo "  Description: $DESCRIPTION"
echo "  Author: $AUTHOR_NAME <$AUTHOR_EMAIL>"
echo "  Tech Stack: $TECH_STACK"
echo ""

echo -n -e "${YELLOW}Continue with setup? (y/N):${NC} "
read confirm

if [[ ! $confirm =~ ^[Yy]$ ]]; then
    echo -e "${RED}Setup cancelled.${NC}"
    exit 1
fi

echo ""
echo -e "${BLUE}⚙️  Setting up your project...${NC}"

# Create package.json based on tech stack
setup_package_json() {
    echo -e "${YELLOW}📦 Updating package.json...${NC}"
    
    # Update package.json with project details
    if command -v jq &> /dev/null; then
        jq --arg name "$PROJECT_NAME" \
           --arg desc "$DESCRIPTION" \
           --arg author "$AUTHOR_NAME <$AUTHOR_EMAIL>" \
           '.name = $name | .description = $desc | .author = $author' \
           package.json > package.json.tmp && mv package.json.tmp package.json
    else
        # Fallback to sed if jq is not available
        sed -i.bak "s/\"ai-project-template\"/\"$PROJECT_NAME\"/" package.json
        sed -i.bak "s/\"A comprehensive template.*\"/\"$DESCRIPTION\"/" package.json
        sed -i.bak "s/\"Your Name <your.email@example.com>\"/\"$AUTHOR_NAME <$AUTHOR_EMAIL>\"/" package.json
        rm package.json.bak
    fi
}

# Update README.md
setup_readme() {
    echo -e "${YELLOW}📝 Updating README.md...${NC}"
    
    cat > README.md << EOF
# $PROJECT_NAME

$DESCRIPTION

## Quick Start

\`\`\`bash
# Clone the repository
git clone https://github.com/your-username/$PROJECT_NAME.git
cd $PROJECT_NAME

# Install dependencies
npm install

# Copy environment variables
cp .env.example .env

# Start development server
npm run dev
\`\`\`

## Features

- 🤖 AI/ML integration ready
- 🏗️ Organized project structure
- 🧪 Comprehensive testing setup
- 🚀 Deployment-ready configurations
- 📚 Detailed documentation
- 🔒 Security best practices

## Technology Stack

- **Tech Stack**: $TECH_STACK
- **Testing**: Jest, Playwright
- **CI/CD**: GitHub Actions
- **Deployment**: Docker, Cloud platforms

## Documentation

- [Development Guide](docs/DEVELOPMENT.md)
- [API Documentation](docs/API.md)
- [Deployment Guide](docs/DEPLOYMENT.md)
- [Contributing Guidelines](CONTRIBUTING.md)

## Getting Started

1. **Setup Environment**
   \`\`\`bash
   cp .env.example .env
   # Edit .env with your configuration
   \`\`\`

2. **Install Dependencies**
   \`\`\`bash
   npm install
   \`\`\`

3. **Start Development**
   \`\`\`bash
   npm run dev
   \`\`\`

4. **Run Tests**
   \`\`\`bash
   npm test
   \`\`\`

## Project Structure

\`\`\`
$PROJECT_NAME/
├── .github/          # GitHub workflows and templates
├── docs/             # Project documentation
├── src/              # Source code
├── testing/          # Test files and results
├── deployment/       # Deployment configurations
└── scripts/          # Development scripts
\`\`\`

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
EOF
}

# Setup git repository
setup_git() {
    echo -e "${YELLOW}🔧 Setting up Git repository...${NC}"
    
    if [ ! -d ".git" ]; then
        git init
        git add .
        git commit -m "Initial commit: Set up $PROJECT_NAME from AI project template"
    fi
    
    # Create .gitignore if it doesn't exist
    if [ ! -f ".gitignore" ]; then
        echo "Creating .gitignore..."
        # .gitignore is already created in template
    fi
}

# Create initial directories
setup_directories() {
    echo -e "${YELLOW}📁 Creating project directories...${NC}"
    
    # Create directories that might not exist
    mkdir -p src/components
    mkdir -p src/services
    mkdir -p src/utils
    mkdir -p src/types
    mkdir -p data/raw
    mkdir -p data/processed
    mkdir -p models
    mkdir -p config
}

# Setup based on technology choice
setup_tech_stack() {
    case $TECH_STACK in
        "python")
            echo -e "${YELLOW}🐍 Setting up Python stack...${NC}"
            # Create requirements.txt
            cat > requirements.txt << EOF
# Web Framework
fastapi==0.104.1
uvicorn[standard]==0.24.0

# Database
sqlalchemy==2.0.23
alembic==1.13.1

# AI/ML Libraries
torch==2.1.1
transformers==4.35.2
scikit-learn==1.3.2
pandas==2.1.3
numpy==1.24.4

# Development
pytest==7.4.3
black==23.11.0
flake8==6.1.0
mypy==1.7.1

# Utilities
python-dotenv==1.0.0
pydantic==2.5.0
requests==2.31.0
EOF
            ;;
        "node-api")
            echo -e "${YELLOW}🟢 Setting up Node.js API stack...${NC}"
            # Remove frontend-related scripts from package.json
            if command -v jq &> /dev/null; then
                jq 'del(.scripts["dev:frontend"]) | del(.scripts["build:frontend"])' package.json > package.json.tmp && mv package.json.tmp package.json
            fi
            ;;
    esac
}

# Run setup functions
setup_package_json
setup_readme
setup_directories
setup_tech_stack
setup_git

echo ""
echo -e "${GREEN}✅ Setup completed successfully!${NC}"
echo ""
echo -e "${BLUE}🎯 Next Steps:${NC}"
echo "1. Edit .env file with your configuration"
echo "2. Update the repository URL in package.json"
echo "3. Install dependencies: npm install"
echo "4. Start development: npm run dev"
echo "5. Begin building your AI project!"
echo ""
echo -e "${GREEN}Happy coding! 🚀${NC}"