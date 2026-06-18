# 🛠️ Scripts de Gestión

Este directorio contiene scripts útiles para gestionar el despliegue y mantenimiento de tu portfolio.

## 📋 Scripts Disponibles

### 1. `health-check.sh` - Verificación de Salud

Verifica el estado completo de la aplicación y los contenedores.

**Uso:**
```bash
# Check básico
./scripts/health-check.sh

# Check detallado con recursos y logs
./scripts/health-check.sh -v
./scripts/health-check.sh --verbose

# Ayuda
./scripts/health-check.sh -h
```

**Lo que verifica:**
- ✅ Docker instalado y corriendo
- ✅ Docker Compose instalado
- ✅ Estado de contenedores
- ✅ Puerto de la aplicación
- ✅ Respuesta HTTP de la aplicación
- ✅ Estado de Git
- ✅ Backups disponibles
- ✅ Uso de recursos (modo verbose)

**Código de salida:**
- `0` - Todo funciona correctamente
- `1` - Hay problemas detectados

### 2. `rollback.sh` - Rollback de Despliegue

Permite volver a una versión anterior en caso de problemas.

**Uso:**
```bash
# Modo interactivo (recomendado)
./scripts/rollback.sh

# Rollback al commit anterior
./scripts/rollback.sh previous

# Rollback a un commit específico
./scripts/rollback.sh commit abc123

# Volver a la rama principal
./scripts/rollback.sh main
```

**Características:**
- 🔄 Rollback al commit anterior
- 🎯 Rollback a commit específico
- 🌿 Volver a main/master
- 📋 Ver historial de commits
- 💾 Ver backups disponibles
- 📊 Ver estado actual

**Menú interactivo:**
```
1) Rollback al commit anterior
2) Rollback a un commit específico
3) Volver a la rama principal
4) Ver últimos commits
5) Ver backups disponibles
6) Ver estado actual
q) Salir
```

## 🚀 Configuración Inicial

### Dar permisos de ejecución

```bash
chmod +x scripts/*.sh
```

### Configurar PATH (opcional)

Puedes agregar los scripts al PATH para ejecutarlos desde cualquier lugar:

```bash
# Agregar a ~/.bashrc o ~/.zshrc
export PATH="$HOME/workspace-javascript/porfolio.dev/scripts:$PATH"

# Recargar configuración
source ~/.bashrc  # o source ~/.zshrc
```

Después podrás ejecutar:
```bash
health-check.sh
rollback.sh
```

## 📅 Automatización con Cron

### Health Check Automático

Puedes configurar un health check automático cada hora:

```bash
# Editar crontab
crontab -e

# Agregar esta línea para ejecutar cada hora
0 * * * * /home/usuario/workspace-javascript/porfolio.dev/scripts/health-check.sh >> /tmp/portfolio-health.log 2>&1

# O cada 30 minutos
*/30 * * * * /home/usuario/workspace-javascript/porfolio.dev/scripts/health-check.sh >> /tmp/portfolio-health.log 2>&1
```

### Monitoreo con Notificaciones

Para recibir notificaciones cuando algo falla:

```bash
# Crear script wrapper
cat > ~/monitor-portfolio.sh << 'EOF'
#!/bin/bash
SCRIPT_PATH="$HOME/workspace-javascript/porfolio.dev/scripts/health-check.sh"

if ! $SCRIPT_PATH; then
    # Enviar email (requiere mailutils instalado)
    echo "Portfolio health check failed!" | mail -s "Portfolio Alert" tu@email.com
    
    # O enviar a Slack/Discord
    # curl -X POST -H 'Content-type: application/json' \
    #   --data '{"text":"Portfolio health check failed!"}' \
    #   YOUR_WEBHOOK_URL
fi
EOF

chmod +x ~/monitor-portfolio.sh

# Agregar a crontab
# */15 * * * * ~/monitor-portfolio.sh
```

## 🔧 Troubleshooting

### Error: "Permission denied"

```bash
chmod +x scripts/*.sh
```

### Error: "No such file or directory"

Asegúrate de estar en el directorio correcto:
```bash
cd ~/workspace-javascript/porfolio.dev
./scripts/health-check.sh
```

### Docker commands fail

El usuario debe estar en el grupo docker:
```bash
sudo usermod -aG docker $USER
# Cerrar sesión y volver a entrar
```

## 💡 Tips

1. **Ejecutar health check antes de despliegues importantes:**
   ```bash
   ./scripts/health-check.sh -v
   ```

2. **Hacer backup manual antes de cambios grandes:**
   ```bash
   BACKUP_DIR="backups/manual-$(date +%Y%m%d-%H%M%S)"
   mkdir -p $BACKUP_DIR
   docker-compose config > $BACKUP_DIR/docker-compose.yml
   git log -1 > $BACKUP_DIR/commit.txt
   ```

3. **Ver logs en tiempo real:**
   ```bash
   docker-compose logs -f
   ```

4. **Reinicio rápido:**
   ```bash
   docker-compose restart
   ```

5. **Rebuild completo:**
   ```bash
   docker-compose down
   docker-compose build --no-cache
   docker-compose up -d
   ```

## 🔗 Integración con GitHub Actions

Estos scripts son compatibles con los workflows de GitHub Actions. Puedes ejecutarlos desde los workflows para verificaciones adicionales:

```yaml
- name: Health Check
  run: |
    chmod +x scripts/health-check.sh
    ./scripts/health-check.sh -v
```

## 📚 Recursos

- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [Bash Scripting Guide](https://www.gnu.org/software/bash/manual/)

## 🆘 Soporte

Si encuentras problemas con los scripts:

1. Verifica los logs: `docker-compose logs`
2. Ejecuta el health check: `./scripts/health-check.sh -v`
3. Revisa los permisos: `ls -la scripts/`
4. Abre un issue en el repositorio

---

**Mantenido por:** Robert Ruben Benitez Bosque  
**Última actualización:** Octubre 2025
