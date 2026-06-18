FROM node:22-alpine AS base
WORKDIR /app

# Copiar solo archivos de dependencias primero (mejor caché)
COPY package*.json ./

# Instalar todas las dependencias necesarias para el build
# (Astro requiere devDependencies para compilar)
RUN npm ci && \
    npm cache clean --force

# Copiar el resto del código
COPY . .

# Build de la aplicación
RUN npm run build

# Runtime stage for serving the application
FROM nginx:mainline-alpine-slim AS runtime

# Copiar configuración de nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Copiar archivos estáticos construidos
COPY --from=base /app/dist /usr/share/nginx/html

EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost/ || exit 1

CMD ["nginx", "-g", "daemon off;"]
