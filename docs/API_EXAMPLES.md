# Ejemplos Rápidos de Integración de APIs

## 🚀 Implementación en 5 minutos

### 1. GitHub Projects (Recomendado para empezar)

**Paso 1**: Edita `src/lib/github.ts` línea 29:
```typescript
const GITHUB_USERNAME = 'tu-usuario-aqui' // ← Cambia esto
```

**Paso 2**: Reemplaza el contenido de `src/components/Projects.astro`:
```astro
---
import GitHubProjects from "@/components/GitHubProjects.astro"
---

<GitHubProjects />
```

**Paso 3**: Rebuild y verifica:
```bash
npm run build
npm run preview
```

✅ ¡Listo! Ahora tus proyectos se actualizan automáticamente desde GitHub.

---

## 📊 Más Ejemplos Prácticos

### 2. Badge de Visitors Counter (1 línea)

Agrega esto a tu `Hero.astro` o `Footer.astro`:

```astro
<img 
  src="https://komarev.com/ghpvc/?username=tu-usuario&color=yellow&style=flat-square&label=Visitas" 
  alt="Contador de visitas"
/>
```

Alternativa con API personalizada:
```astro
<script>
  // Incrementa el contador
  fetch('https://api.countapi.xyz/hit/tu-dominio.com/visits')
    .then(res => res.json())
    .then(data => {
      document.getElementById('visit-count').textContent = data.value
    })
</script>
<p>Visitas: <span id="visit-count">...</span></p>
```

---

### 3. GitHub Profile README Stats

Agrega estadísticas visuales con imágenes generadas:

```astro
---
// src/components/GitHubBadges.astro
const username = "tu-usuario"
---

<div class="flex flex-wrap gap-4 justify-center">
  <!-- Estadísticas generales -->
  <img 
    src={`https://github-readme-stats.vercel.app/api?username=${username}&show_icons=true&theme=dark&hide_border=true`}
    alt="GitHub Stats"
    class="rounded-lg"
  />

  <!-- Lenguajes más usados -->
  <img 
    src={`https://github-readme-stats.vercel.app/api/top-langs/?username=${username}&layout=compact&theme=dark&hide_border=true`}
    alt="Top Languages"
    class="rounded-lg"
  />

  <!-- Racha de commits -->
  <img 
    src={`https://github-readme-streak-stats.herokuapp.com/?user=${username}&theme=dark&hide_border=true`}
    alt="GitHub Streak"
    class="rounded-lg"
  />

  <!-- Trofeos -->
  <img 
    src={`https://github-profile-trophy.vercel.app/?username=${username}&theme=darkhub&no-frame=true&row=1`}
    alt="GitHub Trophies"
    class="rounded-lg"
  />
</div>
```

**Uso**:
```astro
import GitHubBadges from "@/components/GitHubBadges.astro"

<SectionContainer>
  <h2>Mi Actividad en GitHub</h2>
  <GitHubBadges />
</SectionContainer>
```

---

### 4. LinkedIn Badge Oficial

```astro
<!-- src/components/LinkedInBadge.astro -->
<div class="linkedin-badge-container">
  <script src="https://platform.linkedin.com/badges/js/profile.js" async defer type="text/javascript"></script>
  <div 
    class="badge-base LI-profile-badge" 
    data-locale="es_ES" 
    data-size="medium" 
    data-theme="dark" 
    data-type="VERTICAL" 
    data-vanity="tu-linkedin-username"
    data-version="v1"
  >
  </div>
</div>
```

---

### 5. Spotify Now Playing

**Opción A: Badge simple** (sin backend):
```astro
<a href="https://open.spotify.com/user/tu-usuario">
  <img 
    src="https://spotify-github-profile.vercel.app/api/view?uid=tu-spotify-user-id&cover_image=true&theme=default"
    alt="Spotify"
  />
</a>
```

**Opción B: Widget interactivo** (requiere API key):

Primero, crea una función serverless en Vercel:

```typescript
// api/spotify.ts
export default async function handler(req, res) {
  const response = await fetch('https://api.spotify.com/v1/me/player/currently-playing', {
    headers: {
      Authorization: `Bearer ${process.env.SPOTIFY_ACCESS_TOKEN}`
    }
  })
  
  if (response.status === 204) {
    return res.json({ isPlaying: false })
  }
  
  const data = await response.json()
  return res.json({
    isPlaying: true,
    title: data.item.name,
    artist: data.item.artists[0].name,
    album: data.item.album.name,
    albumImageUrl: data.item.album.images[0].url,
    songUrl: data.item.external_urls.spotify
  })
}
```

Luego en Astro:
```astro
<div id="spotify-widget">
  <p>Cargando música...</p>
</div>

<script>
  async function loadSpotify() {
    const res = await fetch('/api/spotify')
    const data = await res.json()
    
    if (data.isPlaying) {
      document.getElementById('spotify-widget').innerHTML = `
        <div class="flex items-center gap-4 bg-green-500 text-white p-4 rounded-lg">
          <img src="${data.albumImageUrl}" class="size-16 rounded" />
          <div>
            <p class="font-bold">${data.title}</p>
            <p>${data.artist}</p>
          </div>
          <span class="animate-pulse">🎵</span>
        </div>
      `
    }
  }
  loadSpotify()
  setInterval(loadSpotify, 30000) // Actualiza cada 30 segundos
</script>
```

---

### 6. Dev.to Latest Posts

```astro
---
// src/components/BlogPosts.astro
const username = "tu-usuario-devto"
const response = await fetch(`https://dev.to/api/articles?username=${username}&per_page=3`)
const posts = await response.json()
---

<div class="grid grid-cols-1 md:grid-cols-3 gap-6">
  {posts.map(post => (
    <a 
      href={post.url}
      target="_blank"
      class="group bg-white dark:bg-gray-800 rounded-lg p-6 border hover:border-yellow-500 transition-all"
    >
      {post.cover_image && (
        <img 
          src={post.cover_image} 
          alt={post.title}
          class="w-full h-48 object-cover rounded-lg mb-4"
        />
      )}
      <h3 class="text-xl font-bold mb-2 group-hover:text-yellow-500">
        {post.title}
      </h3>
      <p class="text-sm text-gray-600 dark:text-gray-400 mb-4">
        {post.description}
      </p>
      <div class="flex items-center gap-4 text-sm text-gray-500">
        <span>❤️ {post.positive_reactions_count}</span>
        <span>💬 {post.comments_count}</span>
        <span>📖 {post.reading_time_minutes} min</span>
      </div>
    </a>
  ))}
</div>
```

---

### 7. WakaTime Stats (Gráfico de tiempo de código)

**Opción A: Badge embebido**:
```astro
<img 
  src="https://wakatime.com/badge/user/tu-wakatime-id.svg" 
  alt="Tiempo total de código"
/>
```

**Opción B: Gráfico completo**:
```astro
<figure>
  <embed 
    src="https://wakatime.com/share/@tu-usuario/embed-wakatime-chart.svg"
    width="100%"
    height="400"
  />
</figure>
```

**Opción C: Widget de lenguajes**:
```astro
<img 
  src="https://github-readme-stats.vercel.app/api/wakatime?username=tu-usuario&layout=compact&theme=dark"
  alt="WakaTime Stats"
/>
```

---

### 8. Weather Widget (OpenWeather)

```astro
---
// Obtén tu API key gratis en: https://openweathermap.org/api
const API_KEY = import.meta.env.OPENWEATHER_API_KEY
const CITY = "Madrid" // Tu ciudad

let weather = null
if (API_KEY) {
  const response = await fetch(
    `https://api.openweathermap.org/data/2.5/weather?q=${CITY}&appid=${API_KEY}&units=metric&lang=es`
  )
  weather = await response.json()
}
---

{weather && (
  <div class="flex items-center gap-2 text-sm">
    <img 
      src={`https://openweathermap.org/img/wn/${weather.weather[0].icon}.png`}
      alt={weather.weather[0].description}
      class="size-8"
    />
    <span>
      📍 {weather.name} · {Math.round(weather.main.temp)}°C · {weather.weather[0].description}
    </span>
  </div>
)}
```

Agrégalo en tu `Hero.astro`:
```astro
<p class="text-gray-600 dark:text-gray-400">
  Backend Engineer | 
  <WeatherWidget />
</p>
```

---

### 9. Google Analytics (Contador de visitas propias)

```astro
<!-- src/components/AnalyticsCount.astro -->
<script>
  // Usando localStorage para tracking simple
  const VISITS_KEY = 'portfolio-visits'
  const visits = parseInt(localStorage.getItem(VISITS_KEY) || '0') + 1
  localStorage.setItem(VISITS_KEY, visits.toString())
  
  document.getElementById('visit-count').textContent = visits
</script>

<p class="text-sm text-gray-500">
  Has visitado este portfolio <span id="visit-count">0</span> veces
</p>
```

Para analytics globales, usa [Umami](https://umami.is/) (auto-hospedado) o [Plausible](https://plausible.io/):

```astro
<!-- En Layout.astro -->
<head>
  <script async defer data-website-id="tu-id" src="https://analytics.umami.is/script.js"></script>
</head>
```

---

### 10. CodersRank Profile Widget

```astro
<script 
  src="https://profile.codersrank.io/widget/widget.js"
></script>

<codersrank-summary 
  username="tu-usuario"
  layout="vertical"
></codersrank-summary>
```

---

## 🎨 Template Completo: Hero con APIs

```astro
---
// Hero mejorado con múltiples APIs
const GITHUB_USERNAME = "tu-usuario"

// GitHub Stats
const ghStats = await fetch(`https://api.github.com/users/${GITHUB_USERNAME}`).then(r => r.json())

// Weather
const weather = await fetch(
  `https://api.openweathermap.org/data/2.5/weather?q=Madrid&appid=${import.meta.env.OPENWEATHER_API_KEY}&units=metric`
).then(r => r.json())
---

<section class="...">
  <div class="flex items-center gap-4">
    <img 
      src={ghStats.avatar_url}
      alt="Profile"
      class="size-20 rounded-full border-4 border-yellow-500"
    />
    <div>
      <h1>Robert Dev</h1>
      <p>Backend Engineer</p>
    </div>
  </div>

  <!-- Stats Row -->
  <div class="flex flex-wrap gap-6 mt-6">
    <div class="flex items-center gap-2">
      <svg>...</svg>
      <span>{ghStats.public_repos} proyectos</span>
    </div>
    
    <div class="flex items-center gap-2">
      <svg>...</svg>
      <span>{ghStats.followers} seguidores</span>
    </div>
    
    <div class="flex items-center gap-2">
      <img src={`https://openweathermap.org/img/wn/${weather.weather[0].icon}.png`} />
      <span>📍 {weather.name} · {Math.round(weather.main.temp)}°C</span>
    </div>
  </div>

  <!-- Badges -->
  <div class="flex gap-2 mt-4">
    <img src="https://komarev.com/ghpvc/?username=tu-usuario&color=yellow" />
    <img src="https://wakatime.com/badge/user/tu-id.svg" />
  </div>
</section>
```

---

## 🚦 Estado de las APIs

| API | Gratis | Token Necesario | Rate Limit | Dificultad |
|-----|--------|----------------|------------|------------|
| GitHub | ✅ | ❌ (opcional) | 60/hora | ⭐ Fácil |
| Dev.to | ✅ | ❌ | Sin límite | ⭐ Fácil |
| WakaTime | ✅ | ✅ | Generoso | ⭐⭐ Media |
| OpenWeather | ✅ | ✅ | 1000/día | ⭐ Fácil |
| Spotify | ✅ | ✅ | Complejo OAuth | ⭐⭐⭐ Difícil |
| LinkedIn | ✅ | ✅ (aprobación) | Muy limitado | ⭐⭐⭐⭐ Muy difícil |
| CountAPI | ✅ | ❌ | Sin límite | ⭐ Fácil |

---

## 📚 Próximos Pasos

1. **Comienza simple**: Implementa GitHub API primero
2. **Agrega badges**: Son instantáneos y no requieren configuración
3. **Incrementa complejidad**: Agrega APIs que requieran tokens
4. **Monitorea performance**: Usa Lighthouse para verificar que tu sitio sigue rápido

¿Necesitas ayuda con alguna implementación específica? ¡Solo pregunta!
