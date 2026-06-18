# 🎉 WakaTime Integrado en tu Portfolio

## ✅ ¿Qué se ha hecho?

He integrado WakaTime en **3 ubicaciones estratégicas** de tu portfolio:

### 1. 📍 Badge en el Hero
- Ubicación: Debajo de tu descripción principal
- Muestra: Tiempo total de código
- Badge inline discreto junto a "Madrid, España"

### 2. 📊 Sección Completa de Estadísticas
- Ubicación: Nueva sección después de "Habilidades"
- ID de navegación: `#estadisticas`
- Muestra:
  - ⏱️ Tiempo total y promedio diario
  - 💻 Lenguajes más usados con barras de progreso
  - 🛠️ Editores y sistemas operativos
  - 📁 Proyectos activos
  - 🌟 Mejor día de la semana

### 3. 🧭 Navegación Actualizada
- Nuevo link "Estadísticas" en el Header
- Entre "Habilidades" y "Educación"

---

## 🚀 Configuración (3 pasos)

### Paso 1: Obtener tu WakaTime API Key

1. Ve a: https://wakatime.com/settings/api-key
2. Copia tu API key (empieza con `waka_...`)

### Paso 2: Actualizar el archivo `.env`

Edita el archivo `.env` y reemplaza esta línea:

```bash
WAKATIME_API_KEY="waka_tu_api_key_aqui"
```

Por tu API key real:

```bash
WAKATIME_API_KEY="waka_1234567890abcdef..."
```

También verifica tu username:

```bash
PUBLIC_WAKATIME_USERNAME="robertruben98"
```

**¿Dónde encuentro mi username?**
- Ve a tu perfil: https://wakatime.com/@robertruben98
- El username es lo que aparece después de `@`

### Paso 3: Hacer tu perfil público

1. Ve a: https://wakatime.com/settings/account
2. Activa:
   - ✅ "Display coding activity publicly"
   - ✅ "Display languages, editors, OS publicly"

---

## 🖥️ Ver tu Portfolio

Tu servidor de desarrollo ya está corriendo en:

**🌐 http://localhost:4322/**

Abre esa URL en tu navegador para ver los cambios.

---

## 📍 Ubicaciones de WakaTime en tu Portfolio

```
┌─────────────────────────────────────────┐
│         🏠 HERO                         │
│  ¡Hola! Soy RobertDev                   │
│  Backend Engineer & FullStack Developer │
│                                         │
│  📍 Madrid, España · [WakaTime Badge] ← │
│  ✉️ Contáctame  🔗 LinkedIn  💻 GitHub  │
└─────────────────────────────────────────┘
          ↓
┌─────────────────────────────────────────┐
│  💼 Experiencia laboral                 │
└─────────────────────────────────────────┘
          ↓
┌─────────────────────────────────────────┐
│  💻 Proyectos destacados                │
└─────────────────────────────────────────┘
          ↓
┌─────────────────────────────────────────┐
│  🎯 Habilidades técnicas                │
└─────────────────────────────────────────┘
          ↓
┌─────────────────────────────────────────┐
│  ⏱️ ESTADÍSTICAS DE CÓDIGO           ← │
│                                         │
│  🔥 Últimos 7 días: 42 hrs              │
│  📊 Lenguajes más usados                │
│  💻 Editores y SO                       │
│  📁 Proyectos activos                   │
└─────────────────────────────────────────┘
          ↓
┌─────────────────────────────────────────┐
│  🎓 Educación y Certificaciones         │
└─────────────────────────────────────────┘
```

---

## 🎨 Vista Previa de la Sección

La nueva sección de estadísticas mostrará:

```
╔════════════════════════════════════════════════╗
║ ⏱️ ESTADÍSTICAS DE CÓDIGO                      ║
║                                                ║
║ Mi actividad rastreada con WakaTime           ║
╠════════════════════════════════════════════════╣
║                                                ║
║ 📊 Últimos 7 días         Desde siempre: 500hrs║
║                                                ║
║ Total: 42 hrs  |  Promedio: 6 hrs  |  Mejor: 8║
╠════════════════════════════════════════════════╣
║ 💻 Lenguajes más usados                        ║
║                                                ║
║ 🟡 TypeScript  15 hrs ████████████░░ 35.7%     ║
║ 🔵 JavaScript  12 hrs ██████████░░░░ 28.5%     ║
║ 🟣 Python       8 hrs ████████░░░░░░ 19.0%     ║
║ 🟠 HTML         4 hrs ████░░░░░░░░░  9.5%      ║
╠════════════════════════════════════════════════╣
║ Editores          │  Sistemas                  ║
║ VS Code: 40 hrs   │  Windows: 42 hrs          ║
╠════════════════════════════════════════════════╣
║ 📁 Proyectos activos                           ║
║ portfolio.dev: 12 hrs    api-gateway: 8 hrs   ║
╚════════════════════════════════════════════════╝
```

---

## ⚙️ Configuración Actual del Badge

El badge en tu Hero usa tu ID de WakaTime:
```
018da97f-1594-4f03-b4c9-a3c0a861c586
```

**Si quieres cambiarlo:**

Edita `src/components/Hero.astro` línea 50 y reemplaza con tu propio badge URL desde:
https://wakatime.com/share

---

## 📊 ¿Qué Datos Verás?

### Con API Key configurada:
- ✅ Datos detallados de últimos 7 días
- ✅ Desglose completo de lenguajes
- ✅ Editores y sistemas operativos
- ✅ Proyectos en los que trabajas
- ✅ Mejor día de la semana
- ✅ Tiempo total desde que empezaste

### Sin API Key (solo badge):
- ✅ Badge con tiempo total
- ⚠️ Datos limitados (mensaje de configuración)
- 💡 Muestra gráficos públicos de WakaTime

---

## 🔧 Verificar Instalación

Ejecuta este comando para verificar que todo está configurado:

```bash
npm run check:wakatime
```

Esto verificará:
- ✅ Archivo .env existe
- ✅ Variables configuradas
- ✅ Componentes instalados
- ✅ Conexión con WakaTime API

---

## 🐛 Solución de Problemas

### No veo estadísticas

1. **Verifica que WakaTime está activo en VS Code:**
   ```bash
   code --list-extensions | Select-String -Pattern "wakatime"
   ```

2. **Verifica que tu API key es correcta:**
   - Ve a: https://wakatime.com/settings/api-key
   - Copia la key completa
   - Pégala en `.env`

3. **Reinicia el servidor:**
   ```bash
   # Presiona Ctrl+C para detener
   npm run dev
   ```

### Solo veo un mensaje de configuración

**Causa**: No has configurado `WAKATIME_API_KEY` en `.env`

**Solución**: 
1. Edita `.env`
2. Agrega tu API key
3. Reinicia el servidor

### El badge no se muestra

**Causa**: Tu perfil no es público

**Solución**:
1. Ve a: https://wakatime.com/settings/account
2. Activa "Display coding activity publicly"
3. Espera 5-10 minutos

### "No hay suficientes datos"

**Causa**: Acabas de instalar WakaTime

**Solución**: 
- Programa al menos 1 hora con WakaTime activo
- Los datos se sincronizan cada 15 minutos
- Espera unas horas para ver estadísticas completas

---

## 📚 Archivos Modificados

- ✅ `src/components/Hero.astro` - Badge inline agregado
- ✅ `src/pages/index.astro` - Nueva sección de estadísticas
- ✅ `src/components/Header.astro` - Link de navegación actualizado
- ✅ `.env` - Variables de WakaTime configuradas

---

## 🎯 Próximos Pasos

1. **Ahora**: 
   - Configura tu API key en `.env`
   - Abre http://localhost:4322 para ver los cambios

2. **Esta semana**: 
   - Programa al menos 5 horas para tener datos significativos
   - WakaTime rastreará automáticamente tu actividad

3. **Deploy**: 
   - Haz rebuild: `npm run build`
   - Verifica que todo funciona: `npm run preview`
   - Deploy a producción

---

## 💡 Consejos Pro

1. **Privacidad**: Puedes ocultar proyectos privados en WakaTime settings
2. **Precisión**: WakaTime solo cuenta cuando estás escribiendo código activamente
3. **Impresión**: Las estadísticas reales impresionan más que los porcentajes inventados
4. **LinkedIn**: Comparte tu gráfico de WakaTime para mostrar dedicación

---

## 📖 Documentación Completa

Para más detalles, consulta:
- `docs/WAKATIME_README.md` - Resumen completo
- `docs/WAKATIME_SETUP.md` - Guía detallada
- `docs/WAKATIME_INTEGRATION_EXAMPLES.md` - Más ejemplos

---

## ✨ ¡Listo!

Tu portfolio ahora muestra:
- ✅ Badge de tiempo de código en el Hero
- ✅ Sección completa de estadísticas
- ✅ Navegación actualizada
- ✅ Datos reales de tu actividad

**Solo falta configurar tu API key en `.env` y empezar a programar!** 🚀

---

**¿Necesitas ayuda?** Revisa la sección de troubleshooting o consulta la documentación completa.
