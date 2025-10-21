# Setup Script for AI Project Template

This script helps you customize the AI project template for your specific project needs.

## Features

- **Project customization**: Replace template placeholders with your project details
- **Technology stack setup**: Configure dependencies for your chosen tech stack
- **Environment setup**: Create necessary configuration files
- **Git initialization**: Set up git repository with proper remotes
- **Documentation generation**: Create initial documentation structure

## Usage

```bash
# Make the script executable
chmod +x scripts/setup-template.sh

# Run the setup script
./scripts/setup-template.sh

# Or run with specific options
./scripts/setup-template.sh --project-name "My AI Project" --tech-stack "node"
```

## Configuration Options

The setup script will prompt you for:

1. **Project Information**
   - Project name
   - Description
   - Author/Organization
   - License type
   - Repository URL

2. **Technology Stack**
   - Frontend framework (React, Vue, Angular, or none)
   - Backend technology (Node.js, Python, Go, or none)
   - Database (PostgreSQL, MongoDB, SQLite, or none)
   - AI/ML frameworks (PyTorch, TensorFlow, Hugging Face, or none)

3. **Deployment Options**
   - Container support (Docker)
   - Cloud platforms (AWS, Azure, GCP)
   - CI/CD preferences (GitHub Actions, GitLab CI)

4. **Additional Features**
   - Testing frameworks
   - Documentation tools
   - Monitoring and logging
   - Security tools

## What the Script Does

1. **Replaces placeholders** in template files with your project details
2. **Generates package.json** or requirements.txt based on your tech stack
3. **Creates environment files** (.env.example, .env.local)
4. **Sets up configuration files** (tsconfig.json, eslint.config.js, etc.)
5. **Initializes git repository** with proper .gitignore
6. **Creates initial documentation** structure
7. **Sets up GitHub Actions** workflows based on your preferences
8. **Installs initial dependencies** (optional)

## Customization

After running the setup script, you can further customize:

- **Modify instruction files** in `.github/instructions/` for your team's needs
- **Update workflows** in `.github/workflows/` for your specific deployment process
- **Customize issue templates** in `.github/ISSUE_TEMPLATE/`
- **Add project-specific documentation** in `docs/`

## Manual Customization

If you prefer manual setup, update these key files:

1. **README.md** - Project description and usage instructions
2. **package.json** or **requirements.txt** - Dependencies for your tech stack
3. **.env.example** - Environment variables template
4. **deployment/** - Deployment configurations for your platforms
5. **.github/workflows/** - CI/CD workflows for your processes

## Next Steps

After setup:

1. **Review and commit** the generated files
2. **Set up your development environment** using the generated instructions
3. **Configure your deployment platforms** using the deployment configs
4. **Start developing** your AI project with the organized structure
5. **Use the issue tracking system** for managing development tasks

## Support

For help with the template setup:

1. Check the [Template Documentation](docs/TEMPLATE_USAGE.md)
2. Review the [Architecture Guide](docs/ARCHITECTURE.md)
3. Visit our [GitHub Discussions](https://github.com/template-repo/discussions)
4. Contact the template maintainers

---

This template is designed to give you a solid foundation for AI/ML projects with modern development practices, organized structure, and deployment-ready configurations.