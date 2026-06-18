#!/bin/bash

# 🏥 Health Check Script para Portfolio
# Verifica el estado de la aplicación y los contenedores

set -e

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

DEPLOY_PATH="$HOME/workspace-javascript/porfolio.dev"
APP_PORT=4321

echo "🏥 Portfolio Health Check"
echo "========================="
echo ""

cd "$DEPLOY_PATH"

# Función para verificar Docker
check_docker() {
    echo -e "${BLUE}🐳 Verificando Docker...${NC}"
    
    if command -v docker &> /dev/null; then
        echo -e "${GREEN}✅ Docker instalado: $(docker --version)${NC}"
        
        if docker info &> /dev/null; then
            echo -e "${GREEN}✅ Docker daemon corriendo${NC}"
        else
            echo -e "${RED}❌ Docker daemon no está corriendo${NC}"
            return 1
        fi
    else
        echo -e "${RED}❌ Docker no está instalado${NC}"
        return 1
    fi
    echo ""
}

# Función para verificar Docker Compose
check_docker_compose() {
    echo -e "${BLUE}🐙 Verificando Docker Compose...${NC}"
    
    if command -v docker-compose &> /dev/null; then
        echo -e "${GREEN}✅ Docker Compose instalado: $(docker-compose --version)${NC}"
    else
        echo -e "${RED}❌ Docker Compose no está instalado${NC}"
        return 1
    fi
    echo ""
}

# Función para verificar contenedores
check_containers() {
    echo -e "${BLUE}📦 Verificando contenedores...${NC}"
    
    containers=$(docker-compose ps -q)
    
    if [ -z "$containers" ]; then
        echo -e "${RED}❌ No hay contenedores corriendo${NC}"
        return 1
    fi
    
    docker-compose ps
    echo ""
    
    running=$(docker-compose ps | grep "Up" | wc -l)
    total=$(docker-compose ps | grep "app" | wc -l)
    
    if [ "$running" -eq "$total" ] && [ "$running" -gt 0 ]; then
        echo -e "${GREEN}✅ Todos los contenedores están corriendo ($running/$total)${NC}"
    else
        echo -e "${RED}❌ Algunos contenedores no están corriendo ($running/$total)${NC}"
        return 1
    fi
    echo ""
}

# Función para verificar el puerto
check_port() {
    echo -e "${BLUE}🔌 Verificando puerto $APP_PORT...${NC}"
    
    if netstat -tuln 2>/dev/null | grep -q ":$APP_PORT " || ss -tuln 2>/dev/null | grep -q ":$APP_PORT "; then
        echo -e "${GREEN}✅ Puerto $APP_PORT está en uso${NC}"
    else
        echo -e "${RED}❌ Puerto $APP_PORT no está en uso${NC}"
        return 1
    fi
    echo ""
}

# Función para verificar la aplicación (HTTP)
check_app() {
    echo -e "${BLUE}🌐 Verificando aplicación...${NC}"
    
    if command -v curl &> /dev/null; then
        response=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:$APP_PORT 2>/dev/null || echo "000")
        
        if [ "$response" = "200" ]; then
            echo -e "${GREEN}✅ Aplicación respondiendo correctamente (HTTP $response)${NC}"
        elif [ "$response" = "000" ]; then
            echo -e "${RED}❌ No se pudo conectar a la aplicación${NC}"
            return 1
        else
            echo -e "${YELLOW}⚠️ Aplicación respondió con código HTTP $response${NC}"
            return 1
        fi
    else
        echo -e "${YELLOW}⚠️ curl no está instalado, saltando verificación HTTP${NC}"
    fi
    echo ""
}

# Función para verificar logs recientes
check_logs() {
    echo -e "${BLUE}📋 Últimas 10 líneas de logs...${NC}"
    docker-compose logs --tail=10
    echo ""
}

# Función para verificar uso de recursos
check_resources() {
    echo -e "${BLUE}💻 Uso de recursos...${NC}"
    
    # CPU y memoria de los contenedores
    docker stats --no-stream --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}" $(docker-compose ps -q) 2>/dev/null || echo "No se pudo obtener estadísticas"
    echo ""
    
    # Espacio en disco
    echo -e "${BLUE}💾 Espacio en disco:${NC}"
    df -h "$DEPLOY_PATH" | tail -n 1
    echo ""
}

# Función para verificar Git
check_git() {
    echo -e "${BLUE}📚 Estado de Git...${NC}"
    
    echo "Rama actual: $(git branch --show-current)"
    echo "Último commit: $(git log -1 --oneline)"
    
    # Verificar si hay cambios sin commitear
    if git diff-index --quiet HEAD --; then
        echo -e "${GREEN}✅ No hay cambios sin commitear${NC}"
    else
        echo -e "${YELLOW}⚠️ Hay cambios sin commitear${NC}"
    fi
    
    # Verificar si está actualizado con origin
    git fetch origin -q
    LOCAL=$(git rev-parse @)
    REMOTE=$(git rev-parse @{u})
    
    if [ "$LOCAL" = "$REMOTE" ]; then
        echo -e "${GREEN}✅ Actualizado con origin${NC}"
    else
        echo -e "${YELLOW}⚠️ No está sincronizado con origin${NC}"
    fi
    echo ""
}

# Función para verificar backups
check_backups() {
    echo -e "${BLUE}💾 Backups...${NC}"
    
    if [ -d "$DEPLOY_PATH/backups" ]; then
        backup_count=$(ls -1 "$DEPLOY_PATH/backups" 2>/dev/null | wc -l)
        echo "Backups disponibles: $backup_count"
        
        if [ "$backup_count" -gt 0 ]; then
            echo "Último backup: $(ls -t "$DEPLOY_PATH/backups" | head -n 1)"
        fi
    else
        echo -e "${YELLOW}⚠️ No existe el directorio de backups${NC}"
    fi
    echo ""
}

# Función para mostrar resumen
show_summary() {
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo -e "${BLUE}📊 RESUMEN${NC}"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    if [ "$HEALTH_STATUS" = "healthy" ]; then
        echo -e "${GREEN}✅ Sistema SALUDABLE${NC}"
        echo "Todos los checks pasaron correctamente."
    else
        echo -e "${RED}❌ Sistema CON PROBLEMAS${NC}"
        echo "Algunos checks fallaron. Revisa los detalles arriba."
    fi
    
    echo ""
    echo "🌐 URL: http://$(hostname -I | awk '{print $1}'):$APP_PORT"
    echo "⏰ Fecha: $(date)"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
}

# Main
main() {
    HEALTH_STATUS="healthy"
    
    check_docker || HEALTH_STATUS="unhealthy"
    check_docker_compose || HEALTH_STATUS="unhealthy"
    check_containers || HEALTH_STATUS="unhealthy"
    check_port || HEALTH_STATUS="unhealthy"
    check_app || HEALTH_STATUS="unhealthy"
    check_git
    check_backups
    
    if [ "$1" = "-v" ] || [ "$1" = "--verbose" ]; then
        check_resources
        check_logs
    fi
    
    show_summary
    
    if [ "$HEALTH_STATUS" = "healthy" ]; then
        exit 0
    else
        exit 1
    fi
}

# Mostrar uso
if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    echo "Uso: $0 [opciones]"
    echo ""
    echo "Opciones:"
    echo "  -v, --verbose    Mostrar información detallada (recursos y logs)"
    echo "  -h, --help       Mostrar esta ayuda"
    echo ""
    echo "Ejemplo:"
    echo "  $0              # Check básico"
    echo "  $0 -v           # Check detallado"
    exit 0
fi

main "$@"
