# Portfolio.dev - AI Coding Agent Instructions

## Architecture Overview
This is an **Astro 5.x static portfolio website** optimized for performance and SEO:
- **Framework**: Astro 5.14+ with TypeScript strict mode
- **Styling**: Tailwind CSS 3.4+ with `darkMode: 'class'` configuration
- **Font**: Self-hosted Onest Variable via `@fontsource-variable/onest`
- **Deployment**: Multi-stage Dockerfile (Node build → Nginx runtime) serving static files on port 80

## Critical Developer Workflows

### Development Commands
```bash
npm run dev         # Dev server on localhost:4321 with hot reload
npm run build       # Type-check (astro check) THEN build to dist/
npm run preview     # Preview production build locally
```

### Docker Workflow
```bash
docker-compose up   # Builds image, maps port 4321:80, includes healthcheck
# Uses nginx:mainline-alpine-slim with custom nginx.conf
# Multi-stage build: node:22-alpine (build) → nginx (runtime)
```

### Deployment Scripts (Bash)
- `scripts/health-check.sh [-v]` - Verifies Docker, containers, HTTP response, Git state
- `scripts/rollback.sh` - Interactive rollback to previous commits or branches

## Component Architecture Patterns

### Section-Based Page Structure
`index.astro` uses vertical section layout wrapped in `SectionContainer`:
```astro
<SectionContainer id="experiencia">  <!-- id matches Header nav label -->
  <h2 class="flex items-center..."><Icon/>Title</h2>
  <ComponentName />
</SectionContainer>
```
**Critical**: Section `id` must match `navItems[].label` in `Header.astro` for IntersectionObserver highlighting.

### Data-Driven Components Pattern
Experience, projects, certifications use **inline data arrays** (not external JSON):
```javascript
const EXPERIENCE = [
  { date, title, company, description, achievements: [], technologies: [] }
]
// Then map over array in template
```
**When editing**: Update these arrays directly in component files, not separate data files.

### Client-Side Interactivity
- **Standard pattern**: `<script>` tags with `document.addEventListener("astro:page-load", ...)`
  - Example: `Header.astro` IntersectionObserver, `ContactForm.astro` validation
- **Exception**: `ThemeToggle.astro` uses `<script is:inline>` to run BEFORE hydration (theme flash prevention)
- **No client directives**: This is a 100% static site - no `client:load` or framework components

### Icon System
- Location: `src/components/icons/*.astro`
- Pattern: Simple Astro components with SVG, accept `class` prop for size/color
- Usage: `<GitHub class="size-5"/>` - Tailwind's `size-*` for width+height

## Styling & Animation Conventions

### Tailwind Customization
- **No extended theme**: Uses default Tailwind + `darkMode: 'class'`
- **Yellow accent**: Primary color is `yellow-500` (light) / `yellow-400` (dark)
- **Dark mode toggle**: Controlled by `<html class="dark">` via localStorage + system preference

### Scroll-Based Animations
```css
/* Header blur effect using scroll-driven animations */
#header-nav {
  animation: blur linear both 0.5s;
  animation-timeline: scroll();      /* Native CSS scroll timeline */
  animation-range: 0 500px;
}
```
**Pattern used in**: `Layout.astro` (header blur), `Header.astro` (nav shadow)

### Responsive Strategy
- **Mobile-first**: Base styles assume mobile, use `md:` (768px+) and `lg:` (1024px+)
- **Header behavior**: Hidden on mobile (`hidden md:flex`), mobile menu not implemented
- **Container widths**: `lg:max-w-4xl md:max-w-2xl` via `SectionContainer`

## SEO & Metadata Management

### Critical SEO Elements in Layout.astro
```astro
<meta property="og:image" content="https://porfolio.dev/a-robertdev.webp" />
<script type="application/ld+json">  <!-- JSON-LD Person schema -->
  { "@type": "Person", "name": "...", "knowsAbout": [...] }
</script>
```
**When personalizing**: Update ALL instances of URLs, names, and social links in:
- `Layout.astro` (meta tags + JSON-LD)
- `astro.config.mjs` (site URL)
- `Header.astro`, `Hero.astro`, `Footer.astro` (navigation/contact links)

### Performance Optimizations
- `scroll-behavior: smooth` with `scroll-padding-top: 80px` (header height)
- `@media (prefers-reduced-motion: reduce)` disables animations
- Preconnect hints for external resources (currently none in use)

## Import Path & File Organization

### Path Alias Configuration
```typescript
// Always use @/ alias (configured in tsconfig.json)
import Layout from "@/layouts/Layout.astro"
import Hero from "@/components/Hero.astro"
```

### Directory Structure Rules
- `src/pages/*.astro` - Routes (only `index.astro` and `components.astro` exist)
- `src/components/*.astro` - UI components, icons subfolder for SVGs
- `src/layouts/Layout.astro` - Single layout with SEO, fonts, global styles
- `public/` - Static assets (images, CV PDFs, favicon)
  - `public/projects/*.webp` - Project screenshots

## Content Customization Workflow

### Adding New Sections
1. Create component in `src/components/NewSection.astro`
2. Add to `index.astro` wrapped in `<SectionContainer id="new-section">`
3. Add navigation item to `Header.astro` navItems array: `{ title, label: "new-section", url: "/#new-section" }`
4. Section id, label, and URL fragment must match exactly

### Modifying Experience/Projects
Edit arrays directly in component files:
- `src/components/Experience.astro` - EXPERIENCE array
- `src/components/Projects.astro` - PROJECTS array + TAGS object
- `src/components/Skills.astro` - SKILLS array with category/level structure
- `src/components/Certifications.astro` - EDUCATION + CERTIFICATIONS arrays

### Image Optimization
- Format: WebP for photos, SVG for icons
- Location: `public/` root for profile, `public/projects/` for project images
- Reference: Absolute paths from public (`/me.png`, `/projects/svgl.webp`)

## Common Patterns & Gotchas

### Theme Toggle Implementation
`ThemeToggle.astro` manages three states (Light/Dark/System) with dropdown menu:
- Uses `<script is:inline>` to prevent FOUC (Flash of Unstyled Content)
- Stores preference in `localStorage.theme`
- Falls back to system preference via `prefers-color-scheme` media query

### Navigation Active State
`Header.astro` uses IntersectionObserver with `threshold: 0.3` to detect visible sections:
```javascript
navItems.forEach((item) => {
  if (item.getAttribute("aria-label") == entry.target.id) {
    item.classList.add("text-yellow-500")
  }
})
```
**Critical**: Section IDs must match `aria-label` values exactly (case-sensitive).

### Form Validation Pattern
`ContactForm.astro` uses vanilla JS validation (no libraries):
- Client-side validation on submit event
- Error messages appended to `.error-message` spans
- Currently mocked submission (see `CONTACTO_FEATURE.md` for Web3Forms integration)

## External Integrations

- **astro-robots-txt**: Auto-generates robots.txt on build
- **No analytics**: Add Google Analytics/Plausible in `Layout.astro` `<head>` if needed
- **No contact backend**: Form ready for Web3Forms/EmailJS integration (see documentation)

## Documentation Files
- `README.md` - Setup, tech stack, deployment
- `GUIA_PERSONALIZACION.md` - Step-by-step content customization guide
- `CONTACTO_FEATURE.md` - Contact form implementation details + integration options
- `scripts/README.md` - Docker health checks, rollback procedures