# 📧 Funcionalidad de Formulario de Contacto

## Descripción
Se ha implementado un formulario de contacto completamente funcional y profesional en el portafolio. Esta nueva funcionalidad permite a los visitantes enviar mensajes directamente desde el sitio web.

## 🎯 Características Implementadas

### 1. **Formulario Completo**
- ✅ Campos: Nombre, Email, Asunto y Mensaje
- ✅ Validación en tiempo real
- ✅ Indicadores visuales de campos obligatorios
- ✅ Mensajes de error personalizados

### 2. **Validaciones**
- ✅ Validación de campos obligatorios
- ✅ Validación de formato de email
- ✅ Feedback visual inmediato
- ✅ Prevención de envíos duplicados

### 3. **UX/UI Mejorada**
- ✅ Diseño responsive (mobile-first)
- ✅ Soporte para tema oscuro/claro
- ✅ Animaciones suaves de entrada
- ✅ Estados de carga con spinner animado
- ✅ Mensajes de éxito/error con auto-ocultado
- ✅ Efectos hover y focus mejorados
- ✅ Backdrop blur para glassmorphism

### 4. **Accesibilidad**
- ✅ Labels asociados correctamente
- ✅ Estados de focus visibles
- ✅ Mensajes de error descriptivos
- ✅ Estructura semántica HTML

### 5. **Integración**
- ✅ Nuevo item "Contacto" en el menú de navegación
- ✅ Scroll automático a la sección
- ✅ Resaltado activo en el menú
- ✅ Icono personalizado (Mail)

## 📁 Archivos Creados/Modificados

### Archivos Nuevos:
1. `src/components/ContactForm.astro` - Componente principal del formulario
2. `src/components/icons/Send.astro` - Icono de enviar (opcional)
3. `CONTACTO_FEATURE.md` - Esta documentación

### Archivos Modificados:
1. `src/pages/index.astro` - Agregada sección de contacto
2. `src/components/Header.astro` - Actualizado link de contacto

## 🔧 Integración con Servicios de Email

Actualmente el formulario tiene una simulación de envío. Para hacerlo completamente funcional, puedes integrar con:

### Opción 1: Web3Forms (Recomendado - Gratis)
```typescript
// En ContactForm.astro, dentro del evento submit:
const response = await fetch('https://api.web3forms.com/submit', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  },
  body: JSON.stringify({
    access_key: 'TU_ACCESS_KEY_AQUI', // Obtener en https://web3forms.com
    name: formData.get('name'),
    email: formData.get('email'),
    subject: formData.get('subject'),
    message: formData.get('message'),
  })
})

const result = await response.json()
if (result.success) {
  showMessage('¡Mensaje enviado con éxito!', 'success')
} else {
  showMessage('Error al enviar el mensaje', 'error')
}
```

### Opción 2: EmailJS
```typescript
// Instalar: npm install @emailjs/browser
import emailjs from '@emailjs/browser'

await emailjs.sendForm(
  'YOUR_SERVICE_ID',
  'YOUR_TEMPLATE_ID',
  form,
  'YOUR_PUBLIC_KEY'
)
```

### Opción 3: API Backend Propia
```typescript
const response = await fetch('/api/contact', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({
    name: formData.get('name'),
    email: formData.get('email'),
    subject: formData.get('subject'),
    message: formData.get('message'),
  })
})
```

## 🎨 Personalización

### Colores
Los colores se adaptan automáticamente al tema del sitio usando:
- Amarillo (`yellow-500`/`yellow-400`) para acentos
- Grises para fondos y textos
- Verde para mensajes de éxito
- Rojo para errores

### Animaciones
Puedes ajustar las animaciones en la sección `<style>`:
```css
.form-group:nth-child(1) { animation-delay: 0.1s; }
/* Modificar delays para cambiar velocidad de entrada */
```

## 📱 Responsive Design
El formulario es completamente responsive:
- **Mobile**: Campos en columna única
- **Tablet/Desktop**: Nombre y Email en dos columnas
- **Todos**: Asunto y Mensaje en ancho completo

## ⚡ Performance
- Scripts con `astro:page-load` para SPA navigation
- Validación sin librerías externas
- CSS puro para animaciones
- Optimizado para Core Web Vitals

## 🧪 Testing

Para probar el formulario:
1. Navega a la sección "Contacto"
2. Intenta enviar sin llenar campos (verás validaciones)
3. Llena todos los campos correctamente
4. Observa la animación de envío
5. Verifica el mensaje de éxito

## 🚀 Próximas Mejoras Sugeridas

- [ ] Integración con reCAPTCHA para prevenir spam
- [ ] Campo de teléfono opcional
- [ ] Selector de tipo de proyecto
- [ ] Adjuntar archivos
- [ ] Autoguardado en localStorage
- [ ] Tracking con Google Analytics
- [ ] Webhooks a Slack/Discord
- [ ] Respuesta automática por email

## 📝 Notas Técnicas

- El formulario usa TypeScript en el `<script>` tag
- Compatibilidad con Astro View Transitions
- No requiere dependencias adicionales
- Los estilos son scoped por defecto en Astro
- Event listeners se limpian automáticamente

## 🎓 Beneficios para el Portafolio

1. **Profesionalismo**: Muestra capacidad de implementar UX compleja
2. **Conversión**: Facilita que clientes potenciales te contacten
3. **Engagement**: Aumenta la interacción con visitantes
4. **SEO**: Contenido adicional y tiempo en página
5. **Accesibilidad**: Demuestra buenas prácticas de desarrollo

---

**Implementado por**: GitHub Copilot
**Fecha**: Octubre 2025
**Versión**: 1.0.0
