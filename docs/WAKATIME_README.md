# 🎉 WakaTime Integrado en tu Portfolio

## ✅ ¿Qué he creado?

He integrado **WakaTime** en tu portfolio con 4 componentes diferentes y documentación completa.

### 📦 Archivos Creados

#### 1. **Librería de WakaTime** (`src/lib/wakatime.ts`)
- ✅ Funciones para obtener estadísticas de WakaTime API
- ✅ Soporte para diferentes rangos de tiempo (7 días, 30 días, 6 meses, 1 año)
- ✅ Formateo de duraciones
- ✅ Colores para lenguajes de programación
- ✅ URLs de badges y gráficos

#### 2. **Componente de Estadísticas Completas** (`WakaTimeStats.astro`)
- ✅ Muestra tiempo total y promedio diario
- ✅ Gráfico de lenguajes más usados con barras de progreso
- ✅ Editores y sistemas operativos
- ✅ Proyectos activos
- ✅ Mejor día de la semana
- ✅ Fallback automático a badges si no hay API key

#### 3. **Badge Simple** (`WakaTimeBadge.astro`)
- ✅ Badge inline para usar en Hero o navegación
- ✅ Versión compacta y versión con card
- ✅ No requiere API key

#### 4. **Gráficos Embebidos** (`WakaTimeEmbed.astro`)
- ✅ Gráficos oficiales de WakaTime
- ✅ Incluye lenguajes y editores
- ✅ No requiere API key
- ✅ Se actualiza automáticamente

### 📚 Documentación

1. **`docs/WAKATIME_SETUP.md`** - Guía completa de configuración
2. **`docs/WAKATIME_INTEGRATION_EXAMPLES.md`** - Ejemplos de uso
3. **`.env.example`** - Variables de entorno actualizadas

---

## 🚀 Cómo Empezar (3 Pasos)

### Paso 1: Instalar WakaTime en VS Code

```bash
# Desde terminal
code --install-extension WakaTime.vscode-wakatime

# O desde VS Code:
# Ctrl+Shift+X → Buscar "WakaTime" → Instalar
```

### Paso 2: Configurar Variables de Entorno

```bash
# Copiar archivo de ejemplo
cp .env.example .env
```

Edita `.env` y agrega:

```bash
# Tu username público de WakaTime
PUBLIC_WAKATIME_USERNAME=tu-usuario

# (Opcional) API key para datos detallados
WAKATIME_API_KEY=waka_tu_api_key
```

**Obtener API Key**:
1. Ve a https://wakatime.com/settings/api-key
2. Copia tu key
3. Pégala en `.env`

**Obtener Username**:
- Tu perfil es: `wakatime.com/@TU-USERNAME`
- Usa ese username

### Paso 3: Integrar en tu Portfolio

**Opción A: Componente Completo (Recomendado)**

Edita `src/pages/index.astro` y agrega:

```astro
---
// ... imports existentes
import WakaTimeStats from "@/components/WakaTimeStats.astro"
---

<Layout>
  <!-- ... tus secciones existentes ... -->
  
  <!-- Nueva sección después de Skills -->
  <SectionContainer id="coding-stats">
    <h2 class="flex items-center mb-6 text-3xl font-semibold gap-x-3 text-black/80 dark:text-white">
      ⏱️ Estadísticas de Código
    </h2>
    <WakaTimeStats />
  </SectionContainer>
</Layout>
```

**Opción B: Badge Simple en Hero**

Edita `src/components/Hero.astro`:

```astro
---
import WakaTimeBadge from "@/components/WakaTimeBadge.astro"
---

<!-- Agrega después de tu descripción -->
<div class="flex items-center gap-3 mt-4">
  <span>📍 Madrid, España</span>
  <WakaTimeBadge inline={true} />
</div>
```

**Opción C: Solo Gráficos (Sin API Key)**

```astro
---
import WakaTimeEmbed from "@/components/WakaTimeEmbed.astro"
---

<SectionContainer id="actividad">
  <h2>🔥 Mi Actividad</h2>
  <WakaTimeEmbed />
</SectionContainer>
```

---

## 📊 Comparación de Opciones

| Componente | API Key | Personalizable | Datos en Tiempo Real | Impacto Visual |
|-----------|---------|----------------|---------------------|----------------|
| **WakaTimeStats** | ✅ Sí | ✅✅✅ | ❌ (build time) | 🔥🔥🔥 Alto |
| **WakaTimeBadge** | ❌ No | ⭐ Básico | ✅ Sí | 🔥 Bajo |
| **WakaTimeEmbed** | ❌ No | ⭐⭐ Medio | ✅ Sí | 🔥🔥 Medio |

---

## 🎨 Vista Previa de lo que verás

### Con API Key (WakaTimeStats):
```
┌─────────────────────────────────────────────┐
│ ⏱️ Últimos 7 días      Desde siempre: 500hrs│
│                                              │
│ Total: 42 hrs    Promedio: 6 hrs    Mejor: 8│
├─────────────────────────────────────────────┤
│ 💻 Lenguajes más usados                     │
│                                              │
│ 🟡 TypeScript  15 hrs ████████████░░ 35.7%  │
│ 🔵 JavaScript  12 hrs ██████████░░░░ 28.5%  │
│ 🟣 Python       8 hrs ████████░░░░░░ 19.0%  │
│ 🟠 HTML         4 hrs ████░░░░░░░░░ 9.5%    │
├─────────────────────────────────────────────┤
│ Editores           Sistemas                  │
│ VS Code: 40hrs    Windows: 42hrs            │
│ WebStorm: 2hrs                              │
└─────────────────────────────────────────────┘
```

### Sin API Key (WakaTimeEmbed):
```
┌─────────────────────────────────────────────┐
│ 📊 Estadísticas de WakaTime                 │
│                                              │
│ [Badge: Total time coded]                   │
│                                              │
│ [Gráfico de actividad semanal]              │
│                                              │
│ Ver perfil completo en WakaTime →          │
└─────────────────────────────────────────────┘
```

---

## 🔧 Configuración Recomendada

### Para Portfolio Profesional:

```astro
---
// index.astro
import WakaTimeStats from "@/components/WakaTimeStats.astro"
---

<!-- Orden recomendado de secciones: -->
<Hero />
<Experience />
<Projects />
<Skills />
<WakaTimeStats />  ← Nueva sección aquí
<Certifications />
<AboutMe />
<ContactForm />
```

**Ventajas**:
- ✅ Muestra compromiso con la programación
- ✅ Datos reales, no inventados
- ✅ Muy visual y profesional
- ✅ Destaca tus lenguajes principales

### Para Setup Rápido:

Solo agrega el badge en el Hero:

```astro
<WakaTimeBadge inline={true} />
```

**Ventajas**:
- ✅ Setup en 30 segundos
- ✅ No requiere API key
- ✅ Se actualiza automáticamente
- ✅ Discreto pero efectivo

---

## 📋 Checklist de Implementación

- [ ] Instalar plugin de WakaTime en VS Code
- [ ] Obtener API key de wakatime.com/settings/api-key
- [ ] Copiar `.env.example` a `.env`
- [ ] Configurar `PUBLIC_WAKATIME_USERNAME` y `WAKATIME_API_KEY`
- [ ] Hacer tu perfil público en wakatime.com/settings/account
- [ ] Elegir componente (WakaTimeStats, Badge o Embed)
- [ ] Importar componente en `index.astro`
- [ ] Agregar sección con el componente
- [ ] (Opcional) Actualizar `Header.astro` con nuevo nav item
- [ ] Programar al menos 1 hora para generar datos
- [ ] Probar con `npm run dev`
- [ ] Build y deploy: `npm run build`

---

## 🐛 Solución Rápida de Problemas

### "No veo estadísticas"

```bash
# 1. Verifica que WakaTime está instalado
code --list-extensions | grep -i wakatime

# 2. Verifica que .env existe
cat .env

# 3. Reinicia el servidor
npm run dev
```

### "Badge no se muestra"

1. Verifica que tu perfil es público: https://wakatime.com/settings/account
2. Activa "Display coding activity publicly"
3. Espera 5-10 minutos para que se genere

### "Datos vacíos"

- **Causa**: No has programado suficiente tiempo
- **Solución**: Programa al menos 1 hora con WakaTime activo
- **Nota**: Los datos se sincronizan cada 15 minutos

---

## 🎯 Próximos Pasos

1. **Ahora**: Configura WakaTime e integra el componente
2. **Mañana**: Verifica que los datos se están rastreando
3. **Esta semana**: Programa al menos 5 horas para tener datos significativos
4. **Deploy**: Haz rebuild y sube los cambios

---

## 📚 Recursos

- **Documentación completa**: `docs/WAKATIME_SETUP.md`
- **Ejemplos de código**: `docs/WAKATIME_INTEGRATION_EXAMPLES.md`
- **WakaTime Dashboard**: https://wakatime.com/dashboard
- **WakaTime API Docs**: https://wakatime.com/developers

---

## 💡 Tips Pro

1. **Combina con GitHub Stats**: Muestra tanto WakaTime como GitHub en la misma sección
2. **Agrega al CV**: Las estadísticas de WakaTime impresionan a reclutadores
3. **Comparte en LinkedIn**: Los gráficos de WakaTime generan engagement
4. **Usa en presentaciones**: Muestra tu dedicación con datos reales

---

## 🚀 Ready to Go!

Todo está listo. Solo necesitas:
1. Configurar `.env`
2. Elegir un componente
3. Agregar 3 líneas de código a `index.astro`

**¿Necesitas ayuda?** Revisa `docs/WAKATIME_SETUP.md` para una guía paso a paso completa.

**¿Quieres ver ejemplos?** Abre `docs/WAKATIME_INTEGRATION_EXAMPLES.md` para copiar y pegar código.

---

**Happy coding! 🎉** Tu portfolio ahora puede mostrar tu actividad real de programación.
