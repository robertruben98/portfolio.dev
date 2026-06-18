# 🎯 Comandos Rápidos - SEO Portfolio

## 📦 Build & Deploy

```bash
# Verificar tipos y construir para producción
npm run build

# Preview local del build de producción
npm run preview

# Servidor de desarrollo
npm run dev
```

---

## 🔍 Verificar Optimizaciones SEO

### 1. Ver HTML Generado (Local)
```bash
# Build el proyecto
npm run build

# Ver el HTML generado
cat dist/index.html | grep "Robert Ruben Benitez Bosque"

# Ver robots.txt
cat dist/robots.txt

# Ver sitemap.xml
cat dist/sitemap.xml
```

### 2. Verificar en Producción
```bash
# Ver código fuente en navegador
# Click derecho → "Ver código fuente de la página"
# Buscar: Robert Ruben Benitez Bosque
```

---

## 🌐 URLs de Verificación Online

### Rich Results Test (Google)
```bash
https://search.google.com/test/rich-results
# Ingresar: https://porfolio.dev/
```

### Schema Markup Validator
```bash
https://validator.schema.org/
# Ingresar: https://porfolio.dev/
```

### Facebook Sharing Debugger
```bash
https://developers.facebook.com/tools/debug/
# Ingresar: https://porfolio.dev/
```

### Twitter Card Validator
```bash
https://cards-dev.twitter.com/validator
# Ingresar: https://porfolio.dev/
```

### PageSpeed Insights
```bash
https://pagespeed.web.dev/
# Ingresar: https://porfolio.dev/
```

---

## 🔍 Búsquedas en Google (Después de indexar)

```bash
# Verificar indexación
site:porfolio.dev

# Búsqueda por nombre completo
"Robert Ruben Benitez Bosque"

# Búsqueda por nombre + profesión
Robert Ruben Benitez Bosque backend engineer

# Búsqueda profesional local
backend engineer Madrid Node.js
```

---

## 📊 Google Search Console

### Registrar Sitio
```bash
# 1. Ir a:
https://search.google.com/search-console

# 2. Agregar propiedad: https://porfolio.dev/

# 3. Verificar con HTML tag (agregar en Layout.astro):
<meta name="google-site-verification" content="TU_CODIGO_AQUI" />
```

### Enviar Sitemap
```bash
# En Google Search Console → Sitemaps
# Ingresar: https://porfolio.dev/sitemap.xml
```

### Solicitar Indexación
```bash
# En Google Search Console → Inspección de URLs
# Ingresar: https://porfolio.dev/
# Click en "Solicitar indexación"
```

---

## 🐳 Docker (Producción)

```bash
# Build imagen
docker-compose build

# Levantar contenedor
docker-compose up -d

# Ver logs
docker-compose logs -f

# Health check
bash scripts/health-check.sh -v

# Detener
docker-compose down
```

---

## 📝 Git Workflow

```bash
# Ver cambios
git status
git diff

# Commit optimizaciones SEO
git add .
git commit -m "🚀 SEO: Optimización completa para indexación de 'Robert Ruben Benitez Bosque'

- Título optimizado con nombre completo + ubicación
- Meta description con 38 keywords
- H1 con nombre completo visible
- 3 schemas JSON-LD (Person, WebSite, BreadcrumbList)
- Open Graph & Twitter Cards completos
- SEO local Madrid (geo tags)
- robots.txt configurado
- sitemap.xml con image sitemap
- Documentación completa SEO"

# Push a GitHub
git push origin main
```

---

## 📚 Archivos de Documentación

```bash
# Resumen visual de optimizaciones
cat RESUMEN_SEO.md

# Guía paso a paso Google Search Console
cat GOOGLE_SEARCH_CONSOLE.md

# Detalles técnicos de optimizaciones
cat SEO_OPTIMIZACIONES.md

# Este archivo
cat COMANDOS_SEO.md
```

---

## 🔧 Troubleshooting

### No aparece en Google después de 1 semana

```bash
# 1. Verificar robots.txt
curl https://porfolio.dev/robots.txt
# Debe decir: Allow: /

# 2. Verificar sitemap.xml
curl https://porfolio.dev/sitemap.xml
# Debe abrir XML válido

# 3. Revisar Google Search Console
# Cobertura → Ver errores

# 4. Forzar re-crawl
# Inspección de URLs → Solicitar indexación nuevamente
```

### Schemas no aparecen en Rich Results Test

```bash
# 1. Verificar HTML generado
npm run build
grep -n "application/ld+json" dist/index.html

# 2. Validar JSON
https://validator.schema.org/

# 3. Revisar consola del navegador
# F12 → Console → Ver errores
```

### Open Graph no se ve en LinkedIn

```bash
# 1. Limpiar caché de LinkedIn
https://www.linkedin.com/post-inspector/

# 2. Verificar meta tags
curl -s https://porfolio.dev/ | grep "og:"

# 3. Forzar re-scrape en Facebook
https://developers.facebook.com/tools/debug/
# Click en "Scrape Again"
```

---

## 📊 Monitoreo Continuo

### Semanal
```bash
# Google Search Console
# - Verificar impresiones
# - Revisar CTR
# - Ver queries de búsqueda
```

### Mensual
```bash
# PageSpeed Insights
# - Core Web Vitals
# - Performance score
# - Comparar con mes anterior

# Google Analytics
# - Tráfico orgánico
# - Páginas más visitadas
# - Tiempo en página
```

---

## 🎯 Quick Checklist

```bash
# Antes de Deploy
[ ] npm run build sin errores
[ ] npm run preview funciona
[ ] robots.txt correcto
[ ] sitemap.xml válido

# Después de Deploy
[ ] https://porfolio.dev/ carga
[ ] Ver código fuente → "Robert Ruben Benitez Bosque" aparece
[ ] Rich Results Test → Pass
[ ] Schema Validator → Pass

# Google Search Console
[ ] Propiedad verificada
[ ] Sitemap enviado
[ ] Indexación solicitada

# Redes Sociales
[ ] LinkedIn profile actualizado
[ ] GitHub bio actualizado
[ ] GitHub Profile README creado
```

---

## 🚀 Deploy a Producción

```bash
# 1. Build local
npm run build

# 2. Commit cambios
git add .
git commit -m "🚀 SEO optimizations"
git push

# 3. Deploy (según tu hosting)
# Netlify: git push auto-deploys
# Vercel: git push auto-deploys
# Docker: docker-compose up --build -d

# 4. Verificar producción
curl -I https://porfolio.dev/
# Status: 200 OK

# 5. Verificar SEO
https://search.google.com/test/rich-results
```

---

## ✨ Comandos de Mantenimiento

```bash
# Actualizar dependencias
npm update

# Verificar vulnerabilidades
npm audit

# Limpiar caché
rm -rf node_modules/.cache
rm -rf dist

# Reinstalar dependencias
rm -rf node_modules
npm install

# Verificar tipos TypeScript
npx astro check
```

---

## 📱 Mobile Testing

```bash
# Responsive Design Mode en navegador
# F12 → Toggle Device Toolbar (Ctrl+Shift+M)

# Mobile-Friendly Test (Google)
https://search.google.com/test/mobile-friendly
# Ingresar: https://porfolio.dev/
```

---

## 🌍 Internacionalización (Futuro)

```bash
# Si quieres agregar versión en inglés:
# 1. Crear src/pages/en/index.astro
# 2. Agregar hreflang tags:
<link rel="alternate" hreflang="es" href="https://porfolio.dev/" />
<link rel="alternate" hreflang="en" href="https://porfolio.dev/en/" />

# 3. Actualizar sitemap.xml con ambas URLs
```

---

## 📈 Analytics (Opcional)

```bash
# Google Analytics 4
# 1. Crear cuenta: https://analytics.google.com/
# 2. Obtener ID (G-XXXXXXXXXX)
# 3. Agregar en Layout.astro:
<script async src="https://www.googletagmanager.com/gtag/js?id=G-XXXXXXXXXX"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'G-XXXXXXXXXX');
</script>
```

---

## 🎓 Recursos

```bash
# Google SEO
https://developers.google.com/search/docs

# Schema.org
https://schema.org/Person

# Open Graph
https://ogp.me/

# Astro Docs
https://docs.astro.build/

# Tailwind CSS
https://tailwindcss.com/docs
```

---

**Última actualización**: 5 de Octubre, 2025  
**Versión**: 1.0  
**Autor**: GitHub Copilot AI Assistant
