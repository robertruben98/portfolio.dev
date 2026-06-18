# 🚀 Guía de Despliegue - GitHub Actions

Esta guía explica cómo configurar y usar los workflows de GitHub Actions para desplegar automáticamente tu portfolio en tu VPS.

## 📋 Tabla de Contenidos

- [Workflows Disponibles](#workflows-disponibles)
- [Configuración de Secrets](#configuración-de-secrets)
- [Configuración del VPS](#configuración-del-vps)
- [Uso](#uso)
- [Troubleshooting](#troubleshooting)

## 🔄 Workflows Disponibles

### 1. `docker-image.yml` (Autenticación con Password)
Workflow que usa password para SSH. Más simple pero menos seguro.

**Triggers:**
- Push a `main` o `master`
- Ejecución manual

### 2. `deploy-with-ssh-key.yml` (Autenticación con SSH Key) ⭐ Recomendado
Workflow que usa SSH key para autenticación. Más seguro.

**Triggers:**
- Push a `main` o `master`
- Ejecución manual

## 🔐 Configuración de Secrets

### Paso 1: Acceder a Settings en GitHub

1. Ve a tu repositorio en GitHub
2. Click en **Settings** > **Secrets and variables** > **Actions**
3. Click en **New repository secret**

### Paso 2: Crear los Secrets Necesarios

#### Opción A: Con Password (docker-image.yml)

| Secret Name | Descripción | Ejemplo |
|-------------|-------------|---------|
| `HOST` | IP o dominio de tu VPS | `123.45.67.89` o `vps.tudominio.com` |
| `USERNAME` | Usuario SSH del VPS | `root` o `ubuntu` |
| `SERVER_PASSWORD` | Contraseña del usuario SSH | `tu-password-seguro` |
| `SSH_PORT` | Puerto SSH (opcional) | `22` (default) |

#### Opción B: Con SSH Key (deploy-with-ssh-key.yml) ⭐

| Secret Name | Descripción | Cómo obtenerlo |
|-------------|-------------|----------------|
| `HOST` | IP o dominio de tu VPS | `123.45.67.89` |
| `USERNAME` | Usuario SSH del VPS | `root` o `ubuntu` |
| `SSH_PRIVATE_KEY` | Clave privada SSH | Ver instrucciones abajo |
| `SSH_PORT` | Puerto SSH (opcional) | `22` |

### 📝 Cómo generar y configurar SSH Key

#### En tu máquina local:

```bash
# 1. Generar un nuevo par de claves SSH
ssh-keygen -t ed25519 -C "github-actions" -f ~/.ssh/github_actions

# 2. Copiar la clave pública al VPS
ssh-copy-id -i ~/.ssh/github_actions.pub usuario@tu-vps-ip

# 3. Copiar la clave privada (para agregarla a GitHub Secrets)
cat ~/.ssh/github_actions
```

#### En el VPS:

```bash
# Verificar que la clave pública se agregó correctamente
cat ~/.ssh/authorized_keys
```

#### En GitHub:

1. Copia el contenido completo de la clave privada (incluye `-----BEGIN OPENSSH PRIVATE KEY-----` y `-----END OPENSSH PRIVATE KEY-----`)
2. Créala como secret con el nombre `SSH_PRIVATE_KEY`

## 🖥️ Configuración del VPS

### Requisitos Previos

Tu VPS debe tener instalado:
- Git
- Docker
- Docker Compose

### Instalación Rápida (Ubuntu/Debian)

```bash
# Actualizar sistema
sudo apt update && sudo apt upgrade -y

# Instalar Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Agregar usuario al grupo docker
sudo usermod -aG docker $USER

# Instalar Docker Compose
sudo apt install docker-compose -y

# Instalar Git
sudo apt install git -y

# Reiniciar sesión para aplicar cambios de grupo
exit
```

### Configuración del Proyecto en el VPS

```bash
# 1. Crear directorio del proyecto
mkdir -p ~/workspace-javascript
cd ~/workspace-javascript

# 2. Clonar el repositorio
git clone https://github.com/robertruben98/porfolio.dev.git
cd porfolio.dev

# 3. Configurar Git para recordar credenciales (si usas HTTPS)
git config credential.helper store

# 4. Crear directorio para backups
mkdir -p backups

# 5. Verificar que Docker está funcionando
docker --version
docker-compose --version
```

### Configuración de Permisos

```bash
# Asegurarte de que el usuario tenga permisos en el directorio
sudo chown -R $USER:$USER ~/workspace-javascript/porfolio.dev
```

## 🎯 Uso

### Despliegue Automático

Cada vez que hagas `push` a la rama `main` o `master`, el workflow se ejecutará automáticamente:

```bash
git add .
git commit -m "Update portfolio"
git push origin main
```

### Despliegue Manual

1. Ve a la pestaña **Actions** en GitHub
2. Selecciona el workflow que quieres ejecutar
3. Click en **Run workflow**
4. Selecciona la rama y confirma

### Monitoreo del Despliegue

1. Ve a **Actions** en tu repositorio
2. Click en el workflow en ejecución
3. Observa los logs en tiempo real

## 📊 Proceso de Despliegue

El workflow realiza los siguientes pasos:

### Fase de Test
1. ✅ Checkout del código
2. 🔧 Setup de Node.js con caché
3. 📦 Instalación de dependencias
4. 🔍 Type checking y build

### Fase de Deploy
1. 📥 Checkout del código
2. 🚀 Conexión SSH al VPS
3. 💾 Backup de la versión actual
4. ⬇️ Pull de cambios desde Git
5. 🛑 Detención de contenedores actuales
6. 🏗️ Build de nuevos contenedores
7. ✅ Verificación del despliegue
8. 🧹 Limpieza de recursos antiguos

## 🔧 Troubleshooting

### Error: "Permission denied (publickey)"

**Solución:**
```bash
# En el VPS, verifica los permisos de .ssh
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
```

### Error: "docker: command not found"

**Solución:**
```bash
# Instalar Docker en el VPS
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER
```

### Error: "Repository not found" o "Authentication failed"

**Solución:**
```bash
# En el VPS, configura Git con token de acceso personal
git config --global credential.helper store
git pull  # Te pedirá credenciales
```

### Los contenedores no se inician

**Solución:**
```bash
# En el VPS, verifica logs de Docker
docker-compose logs

# Reinicia Docker
sudo systemctl restart docker
docker-compose up -d
```

### Puerto 4321 en uso

**Solución:**
```bash
# Ver qué proceso está usando el puerto
sudo lsof -i :4321

# Matar el proceso (reemplaza PID)
sudo kill -9 PID

# O cambiar el puerto en docker-compose.yml
```

## 🔍 Verificación Post-Despliegue

### En el VPS:

```bash
# Ver contenedores en ejecución
docker-compose ps

# Ver logs de la aplicación
docker-compose logs -f

# Verificar que el sitio está disponible
curl http://localhost:4321
```

### Desde tu navegador:

Accede a `http://TU-VPS-IP:4321` para ver tu aplicación.

## 🎨 Personalización

### Cambiar la Ruta de Despliegue

Edita la variable `DEPLOY_PATH` en el workflow:

```yaml
env:
  DEPLOY_PATH: '~/tu/nueva/ruta'
```

### Cambiar el Puerto

Edita `docker-compose.yml`:

```yaml
ports:
  - "8080:80"  # Cambia 4321 por el puerto deseado
```

### Agregar Variables de Entorno

Crea un archivo `.env` en el VPS o agrégalas en `docker-compose.yml`:

```yaml
environment:
  - NODE_ENV=production
  - API_URL=https://api.example.com
```

## 📱 Notificaciones (Opcional)

### Agregar notificaciones a Slack/Discord

Agrega este step al final del workflow:

```yaml
- name: 🔔 Notify Slack
  if: always()
  uses: 8398a7/action-slack@v3
  with:
    status: ${{ job.status }}
    webhook_url: ${{ secrets.SLACK_WEBHOOK }}
```

## 🔒 Seguridad

### Mejores Prácticas:

1. ✅ **Usa SSH Key** en lugar de password
2. ✅ **Cambia el puerto SSH** por defecto (22)
3. ✅ **Configura un firewall** (UFW en Ubuntu)
4. ✅ **Mantén Docker actualizado**
5. ✅ **Usa certificados SSL** (Let's Encrypt)
6. ✅ **Revisa los logs** regularmente

### Configurar Firewall:

```bash
# Instalar UFW
sudo apt install ufw

# Permitir SSH, HTTP y HTTPS
sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw allow 4321/tcp

# Activar firewall
sudo ufw enable
```

## 📚 Recursos Adicionales

- [Documentación de GitHub Actions](https://docs.github.com/en/actions)
- [Documentación de Docker](https://docs.docker.com/)
- [Astro Deployment Guide](https://docs.astro.build/en/guides/deploy/)

## 💡 Tips

- Los backups se mantienen automáticamente (últimos 5)
- El workflow falla si el build tiene errores
- Puedes ver el progreso en tiempo real en GitHub Actions
- Los logs de Docker están disponibles en el VPS con `docker-compose logs`

---

**¿Necesitas ayuda?** Abre un issue en el repositorio.
