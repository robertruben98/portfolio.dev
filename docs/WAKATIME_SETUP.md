# Guía de Configuración de WakaTime

## 🎯 ¿Qué es WakaTime?

WakaTime es un plugin que rastrea automáticamente tu tiempo de programación. Muestra:
- ⏱️ Cuánto tiempo programas cada día
- 💻 Qué lenguajes usas más
- 🛠️ Editores y sistemas operativos
- 📁 Proyectos en los que trabajas
- 📊 Tendencias y estadísticas

## 📦 Instalación y Configuración

### 1. Crear Cuenta en WakaTime

1. Ve a [wakatime.com](https://wakatime.com)
2. Regístrate con GitHub (recomendado) o email
3. ¡Es gratis para uso personal!

### 2. Instalar Plugin en VS Code

**Opción A: Desde VS Code**
1. Abre VS Code
2. Ve a Extensions (`Ctrl+Shift+X`)
3. Busca "WakaTime"
4. Instala el plugin oficial de WakaTime
5. Te pedirá tu API key (siguiente paso)

**Opción B: Desde terminal**
```bash
code --install-extension WakaTime.vscode-wakatime
```

### 3. Obtener tu API Key

1. Ve a [wakatime.com/settings/api-key](https://wakatime.com/settings/api-key)
2. Copia tu API key (formato: `waka_...`)
3. Cuando el plugin lo pida, pégala

**O pégala manualmente en VS Code**:
- `Ctrl+Shift+P` → "WakaTime: API Key"
- Pega tu key

### 4. Configurar Variables de Entorno

Crea un archivo `.env` en la raíz del proyecto:

```bash
# Copia el archivo de ejemplo
cp .env.example .env
```

Edita `.env` y agrega:

```bash
# Secret API key (para obtener datos detallados)
WAKATIME_API_KEY=waka_tu_api_key_secreta_aqui

# Username público (visible en tu URL de perfil)
PUBLIC_WAKATIME_USERNAME=tu-usuario
```

**¿Dónde encuentro mi username?**
- Ve a tu perfil: `wakatime.com/@tu-usuario`
- El username está en la URL después de `@`

### 5. Hacer tu Perfil Público (Importante)

Para que los badges funcionen sin API key:

1. Ve a [wakatime.com/settings/account](https://wakatime.com/settings/account)
2. Activa **"Display coding activity publicly"**
3. Activa **"Display languages, editors, OS publicly"**

## 🎨 Opciones de Integración

### Opción 1: Componente Completo con API (Recomendado)

**Ventajas**: Datos detallados, totalmente personalizable, mejor UX

**Uso**:
```astro
---
import WakaTimeStats from "@/components/WakaTimeStats.astro"
---

<SectionContainer id="stats">
  <h2>📊 Estadísticas de Código</h2>
  <WakaTimeStats />
</SectionContainer>
```

**Requisitos**: API key configurada en `.env`

### Opción 2: Badge Simple en el Hero

**Ventajas**: Rápido, no requiere API key, siempre actualizado

**Uso**:
```astro
---
import WakaTimeBadge from "@/components/WakaTimeBadge.astro"
---

<!-- En Hero.astro -->
<nav class="flex gap-4">
  <SocialPill href="...">LinkedIn</SocialPill>
  <SocialPill href="...">GitHub</SocialPill>
  <WakaTimeBadge inline={true} />
</nav>
```

### Opción 3: Gráficos Embebidos

**Ventajas**: Gráficos oficiales de WakaTime, muy visuales

**Uso**:
```astro
---
import WakaTimeEmbed from "@/components/WakaTimeEmbed.astro"
---

<SectionContainer id="actividad">
  <h2>🔥 Mi Actividad de Código</h2>
  <WakaTimeEmbed />
</SectionContainer>
```

**Requisitos**: Solo username público

### Opción 4: Integración en Skills

Modifica `Skills.astro` para mostrar tiempo real por lenguaje:

```astro
---
import { getWakaTimeStats } from "@/lib/wakatime"

const stats = await getWakaTimeStats('last_30_days')
const languages = stats?.data.languages || []

// Combinar con tus skills actuales
const SKILLS_WITH_TIME = SKILLS.map(category => ({
  ...category,
  items: category.items.map(skill => {
    const wakaLang = languages.find(l => 
      l.name.toLowerCase().includes(skill.name.toLowerCase())
    )
    return {
      ...skill,
      timeThisMonth: wakaLang?.text || null
    }
  })
}))
---

<!-- Mostrar el tiempo junto al porcentaje -->
<div class="flex justify-between">
  <span>{skill.name}</span>
  <div class="flex gap-2 items-center">
    <span class="text-xs text-gray-500">{skill.timeThisMonth}</span>
    <span class="text-yellow-500">{skill.level}%</span>
  </div>
</div>
```

## 🚀 Implementación Rápida (3 pasos)

### Paso 1: Configurar Variables de Entorno

```bash
# .env
PUBLIC_WAKATIME_USERNAME=robertruben98
WAKATIME_API_KEY=waka_tu_key
```

### Paso 2: Agregar a tu página

Edita `src/pages/index.astro`:

```astro
---
import WakaTimeStats from "@/components/WakaTimeStats.astro"
// ... otros imports
---

<Layout>
  <!-- ... tus secciones existentes ... -->
  
  <!-- Nueva sección de WakaTime -->
  <SectionContainer id="stats">
    <h2 class="flex items-center mb-6 text-3xl font-semibold gap-x-3">
      ⏱️ Mi Actividad de Código
    </h2>
    <WakaTimeStats />
  </SectionContainer>
</Layout>
```

### Paso 3: Rebuild y ver resultados

```bash
npm run dev
```

Visita `http://localhost:4321` y desplázate a la nueva sección.

## 🎨 Personalización

### Cambiar Rango de Tiempo

```astro
---
import { getWakaTimeStats } from "@/lib/wakatime"

// Opciones: 'last_7_days', 'last_30_days', 'last_6_months', 'last_year'
const stats = await getWakaTimeStats('last_30_days')
---
```

### Filtrar Lenguajes Mostrados

```astro
{stats.data.languages
  .filter(lang => lang.percent > 5) // Solo >5%
  .slice(0, 5) // Máximo 5
  .map(lang => (
    <!-- ... -->
  ))
}
```

### Cambiar Colores de Lenguajes

Edita `src/lib/wakatime.ts`:

```typescript
export function getLanguageColor(language: string): string {
  const colors: Record<string, string> = {
    'JavaScript': '#f1e05a',
    'TypeScript': '#3178c6',
    // Agrega más colores aquí
    'TuLenguaje': '#FF5733',
  }
  
  return colors[language] || '#8b949e'
}
```

## 🔧 Troubleshooting

### ❌ "WAKATIME_API_KEY no está configurado"

**Solución**:
1. Verifica que `.env` existe en la raíz del proyecto
2. Verifica que la variable se llama exactamente `WAKATIME_API_KEY`
3. Reinicia el servidor de desarrollo (`npm run dev`)

### ❌ "No se muestran estadísticas"

**Solución**:
1. Verifica que el plugin de WakaTime está instalado y activo en VS Code
2. Verifica que has programado al menos 1 hora (WakaTime necesita datos)
3. Espera ~15 minutos para que los datos se sincronicen
4. Verifica que tu API key es correcta en wakatime.com/settings/api-key

### ❌ "Los badges no se muestran"

**Solución**:
1. Verifica que tu perfil es público (wakatime.com/settings/account)
2. Verifica que tu username es correcto
3. Los badges pueden tardar unos minutos en generarse la primera vez

### ❌ "Errores de CORS al cargar gráficos"

**Solución**: Usa `<embed>` en lugar de `<iframe>` o `<img>` para los gráficos embebidos.

### ❌ "Los datos no se actualizan"

**Recuerda**: Astro es estático. Los datos se obtienen en build time.

**Para actualizar**:
```bash
npm run build
```

**Para datos en tiempo real**, usa la Opción 3 (Embeds) que se actualizan automáticamente.

## 📊 Comparación de Opciones

| Característica | WakaTimeStats | WakaTimeBadge | WakaTimeEmbed |
|---------------|---------------|---------------|---------------|
| API Key requerida | ✅ Sí | ❌ No | ❌ No |
| Datos detallados | ✅✅✅ | ⭐ | ✅✅ |
| Personalizable | ✅✅✅ | ⭐ | ⭐⭐ |
| Fácil setup | ⭐⭐ | ✅✅✅ | ✅✅✅ |
| Tiempo real | ❌ | ✅ | ✅ |
| Impacto visual | 🔥🔥🔥 | 🔥 | 🔥🔥 |

**Recomendación**:
- **Portfolio profesional**: WakaTimeStats (requiere API key)
- **Setup rápido**: WakaTimeEmbed
- **Badge simple**: WakaTimeBadge en Hero

## 🌟 Ejemplos de Uso Real

### En el Hero (Badge inline)

```astro
<div class="flex items-center gap-4">
  <span>Backend Engineer</span>
  <WakaTimeBadge inline={true} />
</div>
```

### Sección dedicada (Componente completo)

```astro
<SectionContainer id="coding-stats">
  <h2>📊 Estadísticas de Programación</h2>
  <p class="mb-6">Mi actividad de código rastreada automáticamente</p>
  <WakaTimeStats />
</SectionContainer>
```

### En Footer (Badge)

```astro
<footer>
  <p>Powered by</p>
  <WakaTimeBadge />
</footer>
```

## 📚 Recursos Adicionales

- [WakaTime Dashboard](https://wakatime.com/dashboard)
- [WakaTime API Docs](https://wakatime.com/developers)
- [WakaTime Plugins](https://wakatime.com/plugins)
- [WakaTime Blog](https://wakatime.com/blog)

## 🎯 Próximos Pasos

1. ✅ Instalar plugin de WakaTime en VS Code
2. ✅ Obtener API key
3. ✅ Configurar `.env`
4. ✅ Elegir componente e integrar
5. ✅ Programar al menos 1 hora para generar datos
6. ✅ Rebuild y deploy

¿Necesitas ayuda? Revisa la sección de Troubleshooting o consulta la documentación oficial.
