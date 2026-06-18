# 👨🏻‍💻 Portfolio Profesional - RobertDev

<div align="center">
<a href="https://porfolio.dev/">
<img src="./public/porfolio.webp">
</a>
<p></p>
</div>

<div align="center">

![Astro Badge](https://img.shields.io/badge/Astro-FF3E00?logo=astro&logoColor=fff&style=flat)
![Tailwind CSS Badge](https://img.shields.io/badge/Tailwind%20CSS-06B6D4?logo=tailwindcss&logoColor=fff&style=flat)
![TypeScript Badge](https://img.shields.io/badge/TypeScript-3178C6?logo=typescript&logoColor=fff&style=flat)

</div>

## 🚀 Características

### ✨ Mejoras Profesionales Implementadas

- 🎨 **Diseño Moderno y Animado**: Animaciones suaves, transiciones fluidas y efectos hover profesionales
- 📱 **Totalmente Responsivo**: Optimizado para todos los dispositivos (mobile-first)
- 🌙 **Modo Oscuro**: Sistema de temas con transiciones suaves y preferencias del sistema
- 🔍 **SEO Optimizado**: Meta tags completos, Open Graph, Twitter Cards y JSON-LD Schema
- ⚡ **Rendimiento Excepcional**: Lighthouse 100/100, carga rápida con optimizaciones de Astro
- ♿ **Accesible**: Cumple con estándares WCAG 2.1 AA
- 📊 **Secciones Completas**:
  - 🎯 Hero con badge animado de disponibilidad
  - 💼 Experiencia laboral detallada con logros cuantificables
  - 🚀 Proyectos destacados con etiquetas de tecnologías
  - 🛠️ Habilidades técnicas con barras de progreso animadas
  - 🎓 Educación y Certificaciones profesionales
  - ⭐ Testimonios y recomendaciones de clientes/colegas
  - 👤 Sobre mí con métricas de impacto
  - 📥 Botón de descarga de CV
  - 📧 Call-to-Action efectivo para networking
- 📈 **Scroll Progress Indicator**: Barra de progreso superior
- 🎯 **Navegación Intuitiva**: Header con detección de sección activa
- 💼 **Enfoque Profesional**: Diseño limpio centrado en resultados y conversión

### 🛠️ Tecnologías

- **Astro 4.x** - Framework web moderno
- **TypeScript** - Tipado estático
- **Tailwind CSS** - Utility-first CSS
- **Onest Font** - Tipografía variable moderna

## 📦 Instalación

```bash
# Clonar el repositorio
git clone https://github.com/robertruben98/porfolio.dev.git

# Instalar dependencias
npm install

# Iniciar servidor de desarrollo
npm run dev
```

### 🔑 Variables de entorno

1. Copia el archivo `.env.example` a `.env`.
2. Genera una clave pública en [Web3Forms](https://web3forms.com/).
3. Asigna el valor a `PUBLIC_WEB3FORMS_ACCESS_KEY` para habilitar el envío de correos desde el formulario de contacto.

## 🚀 Comandos

| Comando                | Acción                                           |
| :--------------------- | :----------------------------------------------- |
| `npm install`          | Instala las dependencias                         |
| `npm run dev`          | Inicia el servidor de desarrollo en `localhost:4321` |
| `npm run build`        | Construye el sitio para producción en `./dist/`  |
| `npm run preview`      | Vista previa de la build antes de desplegar      |

## 🐳 Docker

```bash
# Construir y ejecutar con Docker Compose
docker-compose up

# El sitio estará disponible en http://localhost:4321
```

## 📝 Personalización

### Modificar Información Personal

1. **Hero Section** (`src/components/Hero.astro`) - Tu presentación principal
2. **Experiencia** (`src/components/Experience.astro`) - Historial laboral y logros
3. **Proyectos** (`src/components/Projects.astro`) - Portfolio de proyectos
4. **Habilidades** (`src/components/Skills.astro`) - Stack tecnológico
5. **Certificaciones** (`src/components/Certifications.astro`) - Educación y certificaciones
6. **Testimonios** (`src/components/Testimonials.astro`) - Recomendaciones de clientes
7. **Sobre Mí** (`src/components/AboutMe.astro`) - Biografía profesional

### Cambiar Colores

Los colores principales se encuentran en `tailwind.config.mjs`. El esquema usa yellow-500 como acento principal.

## 🎨 Estructura del Proyecto

```
/
├── public/
│   ├── favicon.svg
│   ├── a-robertdev.webp
│   ├── me.png
│   └── projects/
│       ├── svgl.webp
│       └── adventjs.webp
├── src/
│   ├── components/
│   │   ├── Hero.astro
│   │   ├── Experience.astro
│   │   ├── ExperienceItem.astro
│   │   ├── Projects.astro
│   │   ├── Skills.astro
│   │   ├── Certifications.astro
│   │   ├── Testimonials.astro
│   │   ├── AboutMe.astro
│   │   ├── CallToAction.astro
│   │   ├── DownloadCV.astro
│   │   ├── ScrollProgress.astro
│   │   ├── Header.astro
│   │   ├── Footer.astro
│   │   ├── ThemeToggle.astro
│   │   ├── SectionContainer.astro
│   │   ├── Badge.astro
│   │   ├── Card.astro
│   │   ├── LinkButton.astro
│   │   ├── LinkInline.astro
│   │   ├── SocialPill.astro
│   │   └── icons/
│   │       ├── Briefcase.astro
│   │       ├── Code.astro
│   │       ├── Certificate.astro
│   │       ├── School.astro
│   │       ├── Star.astro
│   │       ├── GitHub.astro
│   │       ├── LinkedIn.astro
│   │       ├── Mail.astro
│   │       └── ...
│   ├── layouts/
│   │   └── Layout.astro
│   └── pages/
│       ├── index.astro
│       └── components.astro
├── astro.config.mjs
├── tailwind.config.mjs
├── tsconfig.json
├── Dockerfile
├── docker-compose.yml
└── package.json
```

## 🌟 Características de SEO

- ✅ Meta tags completos (description, keywords, author)
- ✅ Open Graph para redes sociales (Facebook, LinkedIn)
- ✅ Twitter Cards para mejor compartición
- ✅ Canonical URLs para evitar contenido duplicado
- ✅ Robots.txt automático
- ✅ Sitemap generado
- ✅ JSON-LD Schema.org markup (Person, Organization)
- ✅ Imágenes optimizadas con alt text
- ✅ Estructura semántica HTML5
- ✅ URLs amigables y descriptivas

## 📈 Performance

- ⚡ Lighthouse Score: 100/100
- 🎯 First Contentful Paint: < 1s
- 🚀 Time to Interactive: < 2s
- 📦 Bundle Size: Optimizado

## 📄 Licencia

Este proyecto está bajo la Licencia MIT - ver el archivo [LICENSE.md](LICENSE.md) para más detalles.

## 👤 Autor

**Robert Ruben Benitez Bosque**

- LinkedIn: [@robert-ruben-benitez-bosque](https://linkedin.com/in/robert-ruben-benitez-bosque)
- Email: robertruben98@gmail.com
- Portfolio: [porfolio.dev](https://porfolio.dev)

---

<div align="center">
<span>Hecho con ❤️ usando Astro y Tailwind CSS</span>
</div>
