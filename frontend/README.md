# Frontend

This directory contains the frontend application for the AI project.

## Structure

- `src/` - Source code
  - `components/` - Reusable React components
  - `pages/` - Page components and routing
  - `hooks/` - Custom React hooks
  - `services/` - API service functions
  - `utils/` - Utility functions and helpers
  - `assets/` - Static assets (images, fonts, etc.)
  - `styles/` - Global styles and theme
- `public/` - Public static files
- `tests/` - Frontend-specific tests

## Tech Stack

- **Framework**: React with TypeScript
- **Styling**: CSS Modules / Styled Components / Tailwind CSS
- **State Management**: Redux Toolkit / Zustand
- **Routing**: React Router
- **Testing**: Jest, React Testing Library
- **Build Tool**: Vite / Create React App

## Getting Started

1. Install dependencies:

   ```bash
   npm install
   ```

2. Set up environment variables:

   ```bash
   cp .env.example .env.local
   ```

3. Start the development server:

   ```bash
   npm run dev
   ```

4. Open [http://localhost:3000](http://localhost:3000) in your browser

## Available Scripts

- `npm run dev` - Start development server
- `npm run build` - Build for production
- `npm run preview` - Preview production build
- `npm run test` - Run tests
- `npm run lint` - Run linting
- `npm run type-check` - Run TypeScript checks

## Testing

Run frontend tests:

```bash
npm run test:frontend
```