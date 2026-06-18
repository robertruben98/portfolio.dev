# 📝 Guía de Personalización del Portfolio

Esta guía te ayudará a personalizar el portfolio con tu propia información.

## 🎯 Pasos Rápidos de Personalización

### 1. Información Personal Básica

#### Hero Section (`src/components/Hero.astro`)
```astro
// Línea ~6: Cambiar imagen de perfil
src="/a-robertdev.webp" → src="/tu-foto.webp"

// Línea ~21: Cambiar nombre
¡Hola! Soy <span class="text-yellow-500">RobertDev</span>
→ ¡Hola! Soy <span class="text-yellow-500">TuNombre</span>

// Línea ~24: Cambiar título
Backend Engineer & FullStack Developer
→ Tu Título Profesional

// Línea ~29-33: Actualizar descripción
```

#### Layout (`src/layouts/Layout.astro`)
```astro
// Líneas ~45-70: Actualizar JSON-LD Schema
"name": "Tu Nombre Completo"
"email": "tu-email@example.com"
"url": "https://tu-dominio.com"
// ... actualizar todos los campos
```

### 2. Experiencia Laboral (`src/components/Experience.astro`)

```javascript
const EXPERIENCE = [
  {
    date: "Mes Año - Actualidad",
    title: "Tu Cargo",
    company: "Tu Empresa",
    description: "Descripción breve del rol",
    link: "https://empresa.com",
    achievements: [
      "Logro cuantificable 1",
      "Logro cuantificable 2",
      "Logro cuantificable 3"
    ],
    responsibilities: [
      "Responsabilidad principal 1",
      "Responsabilidad principal 2",
      // ...
    ],
    technologies: ["Tech1", "Tech2", "Tech3"]
  },
  // Añade más experiencias...
]
```

**💡 Tips:**
- Usa números y porcentajes en logros (ej: "Reducción del 40%")
- Máximo 3-4 logros principales por experiencia
- 5-7 responsabilidades clave
- Lista tecnologías específicas

### 3. Proyectos (`src/components/Projects.astro`)

```javascript
const PROJECTS = [
  {
    title: "Nombre del Proyecto",
    description: "Descripción detallada con métricas",
    link: "https://proyecto-live.com",
    github: "https://github.com/usuario/repo",
    image: "/projects/proyecto.webp",
    tags: [TAGS.NODE, TAGS.REACT, TAGS.POSTGRESQL],
    featured: true // Solo 1-2 proyectos destacados
  },
]
```

**Añadir nuevas tecnologías:**
```javascript
const TAGS = {
  TU_TECH: {
    name: "NombreTech",
    class: "bg-[#HEXCOLOR] text-white",
    icon: Code,
  },
}
```

### 4. Habilidades (`src/components/Skills.astro`)

```javascript
const SKILLS = [
  {
    category: "Categoría",
    icon: "🚀",
    items: [
      { name: "Tecnología", level: 90 }, // 0-100
    ]
  },
]
```

**Niveles recomendados:**
- 95-100: Experto (años de experiencia, uso diario)
- 85-94: Avanzado (experiencia sólida)
- 75-84: Intermedio (uso frecuente)
- 60-74: Básico (conocimiento funcional)

### 5. Certificaciones (`src/components/Certifications.astro`)

```javascript
const CERTIFICATIONS = [
  {
    name: "Nombre de la Certificación",
    issuer: "Organización Emisora",
    date: "Año",
    credentialUrl: "https://credential.com/id",
  },
]

const EDUCATION = [
  {
    degree: "Título Académico",
    institution: "Universidad/Institución",
    period: "Año Inicio - Año Fin",
    description: "Especialización o detalles"
  }
]
```

### 6. Testimonios (`src/components/Testimonials.astro`)

```javascript
const TESTIMONIALS = [
  {
    name: "Nombre Completo",
    role: "Cargo en Empresa",
    image: "/testimonials/foto.webp", // Opcional
    content: "Testimonio completo entre comillas",
    rating: 5 // 1-5 estrellas
  },
]
```

**💡 Tips:**
- Pide testimonios en LinkedIn
- Copia exactamente lo que escribieron
- Incluye cargo y empresa para credibilidad

### 7. Sobre Mí (`src/components/AboutMe.astro`)

- Actualiza cada párrafo con tu historia personal
- Incluye métricas de impacto
- Menciona logros cuantificables
- Muestra tu personalidad
- Cambia la imagen (`src="/me.png"`)

### 8. Links y Contacto

#### Header (`src/components/Header.astro`)
```javascript
// Línea ~33: Email de contacto
url: "mailto:tu-email@example.com"
```

#### Footer (`src/components/Footer.astro`)
```astro
// Línea ~50: Email de contacto
href="mailto:tu-email@example.com"
```

#### Hero (`src/components/Hero.astro`)
```astro
// Líneas ~39-51: Actualizar URLs de redes sociales
href="mailto:tu-email@example.com"
href="https://linkedin.com/in/tu-perfil"
href="https://github.com/tu-usuario"
```

## 🖼️ Imágenes

### Ubicación de Imágenes

```
public/
├── favicon.svg              # Favicon del sitio
├── a-robertdev.webp         # Foto de perfil (Hero)
├── me.png                   # Foto personal (About Me)
└── projects/
    ├── proyecto1.webp       # Screenshots de proyectos
    └── proyecto2.webp
```

### Formatos Recomendados
- **Fotos de perfil**: WebP, 400x400px, optimizado
- **Proyectos**: WebP, 1200x800px, calidad 80%
- **Favicon**: SVG o PNG 512x512px

### Herramientas de Optimización
- [Squoosh](https://squoosh.app/) - Comprimir imágenes
- [TinyPNG](https://tinypng.com/) - Reducir tamaño

## 🎨 Personalizar Colores

### Cambiar Color de Acento

Archivo: `tailwind.config.mjs`

```javascript
// Cambiar de yellow-500 a otro color
// Buscar y reemplazar en todos los componentes:
// yellow-500 → blue-500 (o el color que prefieras)
```

**Colores populares para portfolios:**
- `blue-500` - Profesional, confiable
- `purple-500` - Creativo, moderno
- `green-500` - Fresco, eco-friendly
- `red-500` - Energético, llamativo
- `indigo-500` - Tech, innovador

## 📄 Descargar CV

1. Crea tu CV en PDF
2. Nómbralo: `cv-tu-nombre-profesion.pdf`
3. Colócalo en la carpeta `public/`
4. Actualiza el link en `src/components/DownloadCV.astro`:

```astro
href="/cv-tu-nombre-profesion.pdf"
```

## 🔧 Configuración de SEO

### astro.config.mjs
```javascript
site: 'https://tu-dominio.com',
```

### Layout.astro
```astro
// Actualizar todas las URLs:
<link rel="canonical" href="https://tu-dominio.com/" />
<meta property="og:url" content="https://tu-dominio.com/" />
// ... etc
```

## ✅ Checklist de Personalización

- [ ] Cambiar foto de perfil
- [ ] Actualizar nombre y título
- [ ] Modificar descripción del Hero
- [ ] Añadir/editar experiencias laborales
- [ ] Actualizar proyectos con tus trabajos
- [ ] Ajustar niveles de habilidades
- [ ] Añadir certificaciones reales
- [ ] Solicitar y añadir testimonios
- [ ] Escribir tu propia bio en "Sobre mí"
- [ ] Actualizar todos los emails
- [ ] Cambiar URLs de redes sociales
- [ ] Subir imágenes de proyectos
- [ ] Crear y subir tu CV en PDF
- [ ] Actualizar JSON-LD Schema
- [ ] Cambiar URL del sitio en config
- [ ] Actualizar meta descriptions
- [ ] Probar en dispositivos móviles
- [ ] Verificar todos los links

## 🚀 Después de Personalizar

1. **Testing Local**
   ```bash
   npm run dev
   ```
   Verifica en http://localhost:4321

2. **Build de Producción**
   ```bash
   npm run build
   npm run preview
   ```

3. **Deploy**
   - Vercel: Conecta tu repo de GitHub
   - Netlify: Drag & drop la carpeta `dist/`
   - GitHub Pages: Configura workflow

## 💡 Consejos Finales

1. **Mantén la consistencia**: Usa el mismo tono en toda la página
2. **Sé específico**: Usa números y métricas reales
3. **Actualiza regularmente**: Añade nuevos proyectos y habilidades
4. **Optimiza imágenes**: Mantén el sitio rápido
5. **Prueba en móviles**: La mayoría visita desde mobile
6. **Pide feedback**: Comparte con colegas antes de publicar

## 🆘 Ayuda

Si tienes problemas:
1. Revisa la consola del navegador (F12)
2. Verifica errores de TypeScript
3. Consulta la [documentación de Astro](https://docs.astro.build)
4. Revisa el archivo `MEJORAS_IMPLEMENTADAS.md`

---

**¡Buena suerte con tu portfolio!** 🚀
