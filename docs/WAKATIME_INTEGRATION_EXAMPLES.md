# Ejemplo de Integración de WakaTime en index.astro

Este archivo muestra las diferentes formas de integrar WakaTime en tu portfolio.

## Opción 1: Sección Completa con Estadísticas Detalladas

```astro
---
import Layout from "@/layouts/Layout.astro"
import WakaTimeStats from "@/components/WakaTimeStats.astro"
import SectionContainer from "@/components/SectionContainer.astro"
// ... otros imports
---

<Layout title="...">
  <main class="px-4">
    <!-- Tus secciones existentes -->
    
    <!-- Nueva sección de WakaTime -->
    <SectionContainer id="coding-stats">
      <h2 class="flex items-center mb-6 text-3xl font-semibold gap-x-3 text-black/80 dark:text-white">
        ⏱️ Mi Actividad de Código
      </h2>
      <p class="text-lg text-gray-600 dark:text-gray-400 mb-8">
        Estadísticas reales de mi tiempo de programación, rastreadas automáticamente
      </p>
      <WakaTimeStats />
    </SectionContainer>
  </main>
</Layout>
```

## Opción 2: Badge Simple en el Hero

```astro
---
import Hero from "@/components/Hero.astro"
import WakaTimeBadge from "@/components/WakaTimeBadge.astro"
---

<!-- Dentro de Hero.astro -->
<div class="flex items-center gap-3">
  <h2>Backend Engineer</h2>
  <span class="text-gray-400">·</span>
  <WakaTimeBadge inline={true} />
</div>
```

## Opción 3: Gráficos Embebidos (Sin API Key)

```astro
---
import WakaTimeEmbed from "@/components/WakaTimeEmbed.astro"
---

<SectionContainer id="actividad">
  <h2 class="flex items-center mb-6 text-3xl font-semibold gap-x-3">
    🔥 Actividad de Programación
  </h2>
  <WakaTimeEmbed />
</SectionContainer>
```

## Opción 4: En la sección de Skills

```astro
---
import Skills from "@/components/Skills.astro"
import { getWakaTimeStats } from "@/lib/wakatime"

// Obtener estadísticas de WakaTime
const wakaStats = await getWakaTimeStats('last_30_days')
---

<SectionContainer id="habilidades">
  <div class="flex items-center justify-between mb-6">
    <h2 class="text-3xl font-semibold">Habilidades técnicas</h2>
    
    {wakaStats && (
      <div class="text-right">
        <p class="text-sm text-gray-500">Últimos 30 días</p>
        <p class="text-2xl font-bold text-blue-600">
          {wakaStats.data.human_readable_total}
        </p>
        <p class="text-xs text-gray-400">de código</p>
      </div>
    )}
  </div>
  
  <Skills />
</SectionContainer>
```

## Opción 5: Combinar con GitHub Stats

```astro
---
import GitHubStats from "@/components/GitHubStats.astro"
import WakaTimeStats from "@/components/WakaTimeStats.astro"
---

<SectionContainer id="stats">
  <h2 class="text-3xl font-semibold mb-8">📊 Mis Estadísticas</h2>
  
  <!-- Tabs o grid -->
  <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
    <div>
      <h3 class="text-xl font-bold mb-4">GitHub Activity</h3>
      <GitHubStats />
    </div>
    
    <div>
      <h3 class="text-xl font-bold mb-4">Coding Time</h3>
      <WakaTimeStats />
    </div>
  </div>
</SectionContainer>
```

## Opción 6: Mini Badge en Footer

```astro
---
// Footer.astro
import WakaTimeBadge from "@/components/WakaTimeBadge.astro"
---

<footer class="...">
  <div class="flex items-center justify-between">
    <p>© 2024 RobertDev</p>
    <WakaTimeBadge inline={true} />
  </div>
</footer>
```

## Recomendación para tu Portfolio

Basándome en tu estructura actual, te recomiendo esta configuración:

### 1. Badge inline en el Hero (sutil pero efectivo)

En `Hero.astro`, agrega después de la descripción:

```astro
<div class="flex items-center gap-3 mt-4 text-sm text-gray-600 dark:text-gray-400">
  <span>📍 Madrid, España</span>
  <span>·</span>
  <WakaTimeBadge inline={true} />
</div>
```

### 2. Sección completa después de Skills

En `index.astro`, agrega una nueva sección:

```astro
<SectionContainer id="stats">
  <h2 class="flex items-center mb-6 text-3xl font-semibold gap-x-3 text-black/80 dark:text-white">
    <svg class="size-8" fill="currentColor" viewBox="0 0 24 24">
      <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.41 0-8-3.59-8-8s3.59-8 8-8 8 3.59 8 8-3.59 8-8 8zm.5-13H11v6l5.25 3.15.75-1.23-4.5-2.67z"/>
    </svg>
    Estadísticas de Código
  </h2>
  <WakaTimeStats />
</SectionContainer>
```

### 3. Actualizar Header Navigation

En `Header.astro`, agrega el link:

```typescript
const navItems = [
  { title: "Experiencia", label: "experiencia", url: "/#experiencia" },
  { title: "Proyectos", label: "proyectos", url: "/#proyectos" },
  { title: "Habilidades", label: "habilidades", url: "/#habilidades" },
  { title: "Estadísticas", label: "stats", url: "/#stats" }, // ← Nuevo
  { title: "Certificaciones", label: "certificaciones", url: "/#certificaciones" },
  { title: "Sobre mí", label: "sobre-mi", url: "/#sobre-mi" },
  { title: "Contacto", label: "contacto", url: "/#contacto" },
]
```

## Testing

Para probar la integración:

```bash
# 1. Configurar .env
cp .env.example .env
# Editar .env con tus credenciales

# 2. Instalar dependencias (si es necesario)
npm install

# 3. Modo desarrollo
npm run dev

# 4. Abrir http://localhost:4321
```

## Notas Importantes

1. **Sin API Key**: Los componentes mostrarán badges públicos automáticamente
2. **Con API Key**: Obtendrás datos detallados y personalizables
3. **Build Time**: Los datos se obtienen durante el build, no en tiempo real
4. **Rate Limits**: La API de WakaTime es generosa, no te preocupes por límites

## Troubleshooting Rápido

- **No se ven datos**: Asegúrate de haber programado al menos 1 hora con WakaTime activo
- **Error de API**: Verifica que tu API key es correcta
- **Perfil no público**: Ve a wakatime.com/settings/account y activa "Display publicly"
