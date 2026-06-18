# Integración de APIs en el Portfolio

## 📚 Contenido

- [APIs Implementadas](#apis-implementadas)
- [Configuración](#configuración)
- [Componentes Disponibles](#componentes-disponibles)
- [Otras APIs Recomendadas](#otras-apis-recomendadas)
- [Consideraciones de Performance](#consideraciones-de-performance)

---

## 🚀 APIs Implementadas

### 1. GitHub API

**Propósito**: Mostrar proyectos reales y estadísticas de actividad automáticamente.

**Características**:
- ✅ Lista de repositorios públicos más recientes
- ✅ Estadísticas del perfil (repos, seguidores, etc.)
- ✅ Gráfico de contribuciones del último año
- ✅ Filtrado automático de forks y repos de prueba
- ✅ Colores por lenguaje de programación

**Endpoints utilizados**:
```
GET https://api.github.com/users/{username}/repos
GET https://api.github.com/users/{username}
```

**Rate Limits**:
- Sin autenticación: 60 requests/hora
- Con token personal: 5,000 requests/hora

---

## ⚙️ Configuración

### 1. Configurar Usuario de GitHub

Edita `src/lib/github.ts` y cambia el username:

```typescript
const GITHUB_USERNAME = 'tu-usuario-github'
```

### 2. (Opcional) Agregar Token Personal

Para aumentar el rate limit, crea un archivo `.env`:

```bash
GITHUB_TOKEN=ghp_tu_token_aqui
```

Y descomenta esta línea en `github.ts`:
```typescript
'Authorization': `Bearer ${import.meta.env.GITHUB_TOKEN}`,
```

**Cómo obtener un token**:
1. Ve a GitHub Settings → Developer Settings → Personal Access Tokens
2. Crea un token con permisos de `public_repo` (read-only)
3. Cópialo al `.env`

### 3. Usar los Componentes

#### Opción A: Reemplazar la sección de Proyectos

En `src/pages/index.astro`:

```astro
// Reemplaza esto:
import Projects from "@/components/Projects.astro"

// Por esto:
import GitHubProjects from "@/components/GitHubProjects.astro"

// Y en el template:
<SectionContainer id="proyectos">
  <h2>Proyectos destacados</h2>
  <GitHubProjects />
</SectionContainer>
```

#### Opción B: Agregar Estadísticas de GitHub

En `src/pages/index.astro`:

```astro
import GitHubStats from "@/components/GitHubStats.astro"

// Agregar una nueva sección:
<SectionContainer id="github">
  <h2>Mi Actividad en GitHub</h2>
  <GitHubStats />
</SectionContainer>
```

#### Opción C: Combinar Proyectos Manuales + GitHub

Puedes mantener tus proyectos destacados manuales y agregar una subsección dinámica:

```astro
<SectionContainer id="proyectos">
  <h2>Proyectos destacados</h2>
  <Projects /> <!-- Tus 2-3 proyectos principales -->
  
  <h3 class="mt-12 mb-6">Otros Proyectos</h3>
  <GitHubProjects /> <!-- Repos automáticos de GitHub -->
</SectionContainer>
```

---

## 🧩 Componentes Disponibles

### `<GitHubProjects />`

Muestra una grid de tarjetas con tus repositorios de GitHub.

**Características**:
- Grid responsivo (1 columna en móvil, 2 en desktop)
- Badge de última actualización
- Lenguaje de programación con colores
- Stars y forks visibles
- Topics/tags del repositorio
- Enlaces a código y demo

**Props**: Ninguna (configuración global en `github.ts`)

---

### `<GitHubStats />`

Muestra estadísticas del perfil y gráfico de contribuciones.

**Características**:
- Contador de repos públicos
- Contador de seguidores/siguiendo
- Gráfico de contribuciones del último año
- Ubicación y empresa (si están configuradas)

**Props**: Ninguna

---

## 🌟 Otras APIs Recomendadas

### 2. Dev.to / Hashnode API

**Para qué**: Mostrar tus artículos de blog si escribes contenido técnico.

```typescript
// src/lib/blog.ts
export async function getLatestPosts() {
  const response = await fetch(
    'https://dev.to/api/articles?username=tu-usuario&per_page=6'
  )
  return response.json()
}
```

**Componente sugerido**: Lista de artículos con imagen, título, descripción y stats.

---

### 3. WakaTime API

**Para qué**: Mostrar estadísticas de tiempo de programación y lenguajes más usados.

```typescript
// src/lib/wakatime.ts
export async function getWakatimeStats() {
  const response = await fetch(
    'https://wakatime.com/api/v1/users/current/stats/last_7_days',
    {
      headers: {
        Authorization: `Bearer ${import.meta.env.WAKATIME_API_KEY}`,
      },
    }
  )
  return response.json()
}
```

**Configuración**:
1. Crea cuenta en [wakatime.com](https://wakatime.com)
2. Instala el plugin en VS Code
3. Obtén tu API key en Settings
4. Agrégala a `.env`

---

### 4. OpenWeather API

**Para qué**: Touch personal en el Hero mostrando tu ubicación con clima.

```typescript
// src/lib/weather.ts
export async function getCurrentWeather(city: string) {
  const response = await fetch(
    `https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${API_KEY}&units=metric&lang=es`
  )
  return response.json()
}
```

**Implementación sugerida**:
```astro
<!-- En Hero.astro -->
<p>📍 Trabajando desde {city} · {weather.temp}°C {weather.icon}</p>
```

---

### 5. Visitor Counter API

**Para qué**: Mostrar cuántas personas han visitado tu portfolio.

**Opciones**:
- [CountAPI](https://countapi.xyz/) - Gratuita, sin registro
- [GoatCounter](https://www.goatcounter.com/) - Open source, con dashboard
- [Umami](https://umami.is/) - Self-hosted

```typescript
// Usando CountAPI (más simple)
export async function trackVisit() {
  await fetch('https://api.countapi.xyz/hit/tu-dominio.com/visits')
}

export async function getVisitCount() {
  const response = await fetch('https://api.countapi.xyz/get/tu-dominio.com/visits')
  return response.json()
}
```

---

### 6. GitHub Gists API

**Para qué**: Mostrar snippets de código o notas técnicas.

```typescript
export async function getPublicGists() {
  const response = await fetch(
    `https://api.github.com/users/${GITHUB_USERNAME}/gists`
  )
  return response.json()
}
```

---

### 7. Spotify API

**Para qué**: Mostrar la canción que estás escuchando actualmente (muy popular en portfolios).

**Requiere**:
- Crear app en Spotify Developer Dashboard
- OAuth2 flow para obtener token
- Refresh token automático

**Librerías recomendadas**:
- [spotify-now-playing](https://github.com/novatorem/novatorem)

---

### 8. LinkedIn API

**Para qué**: Mostrar tu perfil profesional y conexiones.

**⚠️ Limitaciones**:
- Requiere aprobación de LinkedIn
- API muy restrictiva
- Alternativa: Usa web scraping ético o badges oficiales

---

### 9. Twitter/X API

**Para qué**: Mostrar tus últimos tweets.

**Estado actual**: API de pago desde 2023. Alternativa: embeds oficiales.

---

### 10. Google Analytics API

**Para qué**: Mostrar estadísticas de visitas en tu portfolio mismo.

```typescript
// Requiere Google Analytics configurado
export async function getPageViews() {
  // Usa Google Analytics Data API
  // Requiere cuenta de servicio
}
```

---

## ⚡ Consideraciones de Performance

### 1. Build Time vs Runtime

**Astro renderiza en build time por defecto**, esto significa:

✅ **Ventajas**:
- Datos se obtienen una vez durante el build
- Sitio generado es 100% estático y rápido
- No hay llamadas API desde el cliente

❌ **Desventajas**:
- Datos solo se actualizan cuando haces rebuild
- No son datos en tiempo real

### 2. Estrategias de Actualización

#### Opción A: Rebuild Manual
```bash
npm run build  # Regenera el sitio con datos frescos
```

#### Opción B: Rebuild Automático con GitHub Actions

Crea `.github/workflows/rebuild.yml`:

```yaml
name: Rebuild Daily
on:
  schedule:
    - cron: '0 2 * * *'  # 2 AM diario
  workflow_dispatch:  # Manual trigger

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
      - run: npm ci
      - run: npm run build
      - uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./dist
```

#### Opción C: Islands con `client:load`

Para datos en tiempo real, usa Astro Islands:

```astro
---
// src/components/LiveGitHubStats.astro
---
<div id="live-stats" class="...">
  <p>Cargando...</p>
</div>

<script>
  // Este código se ejecuta en el cliente
  async function loadStats() {
    const response = await fetch('https://api.github.com/users/tu-usuario')
    const data = await response.json()
    
    document.getElementById('live-stats').innerHTML = `
      <p>Repositorios: ${data.public_repos}</p>
      <p>Seguidores: ${data.followers}</p>
    `
  }
  
  loadStats()
</script>
```

**⚠️ Importante**: Esto afecta la performance (JavaScript en el cliente).

### 3. Caché y Rate Limits

Para evitar problemas con rate limits:

```typescript
// src/lib/cache.ts
const CACHE_DURATION = 1000 * 60 * 60 // 1 hora

let cache = new Map()

export async function fetchWithCache(url: string) {
  const cached = cache.get(url)
  
  if (cached && Date.now() - cached.timestamp < CACHE_DURATION) {
    return cached.data
  }
  
  const response = await fetch(url)
  const data = await response.json()
  
  cache.set(url, { data, timestamp: Date.now() })
  return data
}
```

---

## 📝 Checklist de Implementación

### Fase 1: GitHub API (Ya implementada)
- [x] Crear `src/lib/github.ts`
- [x] Crear componente `GitHubProjects.astro`
- [x] Crear componente `GitHubStats.astro`
- [ ] Configurar tu username en `github.ts`
- [ ] Integrar en `index.astro`
- [ ] Probar con `npm run dev`
- [ ] Build y verificar datos: `npm run build && npm run preview`

### Fase 2: Otras APIs (Opcional)
- [ ] Decidir qué otras APIs agregar
- [ ] Crear archivos en `src/lib/` para cada API
- [ ] Crear componentes correspondientes
- [ ] Obtener API keys necesarias
- [ ] Configurar variables de entorno
- [ ] Implementar manejo de errores

### Fase 3: Automatización (Opcional)
- [ ] Configurar GitHub Actions para rebuild automático
- [ ] Configurar webhooks si usas API de terceros
- [ ] Implementar analytics para tracking

---

## 🐛 Troubleshooting

### Error: "Cannot find module '@/lib/github'"

**Solución**: Verifica que el archivo `src/lib/github.ts` existe y que `tsconfig.json` tiene la configuración de alias:

```json
{
  "compilerOptions": {
    "paths": {
      "@/*": ["./src/*"]
    }
  }
}
```

### Error: "Rate limit exceeded"

**Solución**: 
1. Agrega un token personal de GitHub
2. Implementa caché
3. Reduce la frecuencia de builds

### Los datos no se actualizan

**Recuerda**: Astro es estático. Debes hacer rebuild para obtener datos frescos:

```bash
npm run build
```

### Errores de CORS en el cliente

**Problema**: Algunas APIs no permiten llamadas desde el navegador.

**Solución**: Usa Server-Side Rendering de Astro (llamadas en el frontmatter `---`) en vez de `<script>` tags.

---

## 📚 Recursos

- [Astro Docs](https://docs.astro.build)
- [GitHub REST API](https://docs.github.com/en/rest)
- [Public APIs List](https://github.com/public-apis/public-apis)
- [Dev.to API](https://developers.forem.com/api)
- [WakaTime API](https://wakatime.com/developers)

---

## 🤝 Contribuciones

¿Tienes ideas de otras APIs útiles para portfolios? ¡Abre un issue o PR!
