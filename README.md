# porfolio.dev — Robert Ruben's Personal Portfolio

A fast, bilingual (ES/EN) personal portfolio website built with **Astro** and deployed to a self-hosted VPS via **Docker + nginx** with a fully automated **GitHub Actions CI/CD** pipeline.

🔗 **Live:** [https://www.a-robertdev.com](https://www.a-robertdev.com)

<div align="center">

[![CI](https://github.com/robertruben98/portfolio.dev/actions/workflows/ci.yml/badge.svg)](https://github.com/robertruben98/portfolio.dev/actions/workflows/ci.yml)
![Astro](https://img.shields.io/badge/Astro-BC52EE?logo=astro&logoColor=fff&style=flat)
![TypeScript](https://img.shields.io/badge/TypeScript-3178C6?logo=typescript&logoColor=fff&style=flat)
![Docker](https://img.shields.io/badge/Docker-2496ED?logo=docker&logoColor=fff&style=flat)
![nginx](https://img.shields.io/badge/nginx-009639?logo=nginx&logoColor=fff&style=flat)
![GitHub Actions](https://img.shields.io/badge/GitHub%20Actions-2088FF?logo=githubactions&logoColor=fff&style=flat)

</div>

<!-- Screenshot: add a homepage screenshot here once available, e.g. ![Portfolio preview](./public/screenshot.webp) -->

## Features

- **Bilingual ES / EN** — instant language toggle (no page reload). Content is authored with `data-en` / `data-es` attributes and the chosen language is persisted in `localStorage`.
- **Dark mode** — automatic theme that honors the visitor's system preference (`prefers-color-scheme`) using CSS custom properties.
- **Responsive** — mobile-first layout with fluid typography (`clamp()`) and a properly set viewport, looks great from phones to desktops.
- **SEO-ready** — descriptive `<title>` and meta description, Open Graph tags, a generated `robots.txt`, sitemap reference and per-bot crawl rules via `astro-robots-txt`.
- **Fast & lightweight** — zero client-side framework; Astro ships static HTML/CSS with only a tiny vanilla-JS snippet for the language toggle.
- **CV downloads** — bundled ES/EN résumé PDFs served as static assets.
- **Production deployment** — multi-stage Docker build (Node for building, nginx for serving) with a container `HEALTHCHECK`.
- **CI/CD to VPS** — push to `main` triggers a GitHub Actions workflow that builds, deploys over SSH, tags a rollback backup image, runs a health check, prunes old images, and sends Telegram notifications on start / success / failure.
- **Ops tooling** — helper scripts for health checks (`scripts/health-check.sh`) and rollback (`scripts/rollback.sh`).

## Tech Stack

| Layer       | Technology |
|-------------|------------|
| Framework   | [Astro](https://astro.build) 5 |
| Language    | TypeScript |
| Styling     | Hand-written CSS with custom properties (no UI framework) |
| Fonts       | Inter |
| SEO         | `astro-robots-txt` (robots.txt + sitemap) |
| Web server  | nginx (alpine) |
| Container   | Docker (multi-stage) + Docker Compose |
| CI/CD       | GitHub Actions → SSH deploy to VPS |

## Getting Started

Requirements: **Node.js 22+** and npm.

```bash
# Install dependencies
npm install

# Start the dev server (http://localhost:4321)
npm run dev

# Type-check and build for production (output in ./dist)
npm run build

# Preview the production build locally
npm run preview
```

### Run with Docker

```bash
# Build the image and start the container (served on http://localhost:4321)
docker compose up --build
```

## Project Structure

```
.
├── src/
│   ├── pages/
│   │   └── index.astro      # Single-page portfolio (ES/EN content, styles, lang toggle)
│   └── env.d.ts
├── public/                  # Static assets (favicon, robots.txt, CV PDFs)
├── scripts/                 # Ops helpers (health-check.sh, rollback.sh, check-wakatime.js)
├── docs/                    # Additional project documentation
├── .github/workflows/       # CI/CD: build + deploy to VPS
├── astro.config.mjs         # Astro config (site URL, robots.txt/sitemap)
├── Dockerfile               # Multi-stage build (Node → nginx)
├── docker-compose.yml
└── nginx.conf               # Server config + rate limiting
```

## Deployment

Deployment is fully automated. On every push to `main`, GitHub Actions:

1. Installs dependencies and runs `npm run build` (type-check + build).
2. Connects to the VPS over SSH, pulls the latest code and rebuilds the Docker image.
3. Tags the previous image as a timestamped backup (for quick rollback).
4. Recreates the container with zero-downtime and verifies it's healthy.
5. Cleans up old images and notifies via Telegram (start / success / failure).

## Screenshot

> _Add a screenshot of the homepage here (light or dark mode) once captured — see the placeholder comment near the top of this README. Save it under `public/` and reference it with a relative path._

## License

See [`LICENSE`](./LICENSE). MIT is recommended for this codebase.

---

Built by **Robert Ruben** · [a-robertdev.com](https://www.a-robertdev.com)

