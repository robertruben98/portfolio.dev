#!/bin/bash

# 🔄 Script de Rollback para Portfolio
# Este script permite volver a una versión anterior en caso de problemas

set -e

echo "🔄 Portfolio Rollback Script"
echo "=============================="
echo ""

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

DEPLOY_PATH="$HOME/workspace-javascript/porfolio.dev"
BACKUP_DIR="$DEPLOY_PATH/backups"

cd "$DEPLOY_PATH"

# Función para mostrar backups disponibles
list_backups() {
    echo -e "${YELLOW}📋 Backups de imágenes Docker disponibles:${NC}"
    echo ""
    
    local images=$(docker images | grep 'porfoliodev-app.*backup' | awk '{print $1":"$2}')
    
    if [ -z "$images" ]; then
        echo -e "${RED}❌ No hay imágenes de backup disponibles.${NC}"
        echo "💡 Tip: Las imágenes de backup se crean automáticamente en cada deploy"
        return 1
    fi
    
    echo "$images" | nl
    echo ""
    
    echo -e "${YELLOW}📋 Backups de git disponibles:${NC}"
    echo ""
    
    if [ ! -d "$BACKUP_DIR" ] || [ -z "$(ls -A $BACKUP_DIR 2>/dev/null)" ]; then
        echo -e "${YELLOW}⚠️ No hay backups de archivos disponibles.${NC}"
    else
        ls -lt "$BACKUP_DIR" | grep "^d" | awk '{print NR". "$9" ("$6" "$7" "$8")"}'
        echo ""
    fi
}

# Función para hacer rollback usando imagen Docker
rollback_to_docker_image() {
    echo -e "${YELLOW}🔄 Rollback usando imágenes Docker (RÁPIDO)${NC}"
    echo ""
    
    # Listar imágenes de backup
    local images=$(docker images | grep 'porfoliodev-app.*backup' | awk '{print $1":"$2}')
    
    if [ -z "$images" ]; then
        echo -e "${RED}❌ No hay imágenes de backup disponibles.${NC}"
        return 1
    fi
    
    echo "Imágenes disponibles:"
    echo "$images" | nl
    echo ""
    
    read -p "Selecciona el número de imagen (o 'q' para cancelar): " selection
    
    if [ "$selection" = "q" ]; then
        echo "❌ Rollback cancelado."
        return 0
    fi
    
    local selected_image=$(echo "$images" | sed -n "${selection}p")
    
    if [ -z "$selected_image" ]; then
        echo -e "${RED}❌ Selección inválida.${NC}"
        return 1
    fi
    
    echo -e "${YELLOW}🔄 Restaurando imagen: $selected_image${NC}"
    
    # Detener contenedor actual
    echo "🛑 Deteniendo contenedor actual..."
    docker-compose down
    
    # Re-taggear la imagen de backup como latest
    echo "🏷️ Restaurando imagen..."
    docker tag "$selected_image" porfoliodev-app:latest
    
    # Iniciar con la imagen restaurada
    echo "🚀 Iniciando contenedor..."
    docker-compose up -d
    
    # Verificar
    sleep 3
    if docker-compose ps | grep -q "Up"; then
        echo -e "${GREEN}✅ Rollback exitoso!${NC}"
        echo "📍 Imagen restaurada: $selected_image"
    else
        echo -e "${RED}❌ Error: El contenedor no está corriendo.${NC}"
        docker-compose logs --tail=50
        return 1
    fi
}

# Función para hacer rollback a un commit específico
rollback_to_commit() {
    local commit_hash=$1
    
    echo -e "${YELLOW}🔄 Haciendo rollback al commit: $commit_hash${NC}"
    
    # Verificar que el commit existe
    if ! git cat-file -e "$commit_hash^{commit}" 2>/dev/null; then
        echo -e "${RED}❌ Error: El commit $commit_hash no existe.${NC}"
        exit 1
    fi
    
    # Detener contenedores
    echo "🛑 Deteniendo contenedores..."
    docker-compose down || true
    
    # Hacer checkout al commit
    echo "⏮️ Volviendo al commit anterior..."
    git checkout "$commit_hash"
    
    # Rebuild y restart
    echo "🏗️ Reconstruyendo contenedores..."
    docker-compose build --no-cache
    
    echo "🚀 Iniciando contenedores..."
    docker-compose up -d
    
    # Verificar
    sleep 5
    if docker-compose ps | grep -q "Up"; then
        echo -e "${GREEN}✅ Rollback exitoso!${NC}"
        echo "📍 Ahora estás en el commit: $(git log -1 --oneline)"
    else
        echo -e "${RED}❌ Error: Los contenedores no están corriendo.${NC}"
        docker-compose logs --tail=50
        exit 1
    fi
}

# Función para hacer rollback al último commit que funcionaba
rollback_previous() {
    echo -e "${YELLOW}🔄 Volviendo al commit anterior...${NC}"
    
    current_commit=$(git rev-parse HEAD)
    previous_commit=$(git rev-parse HEAD~1)
    
    echo "📍 Commit actual: $(git log -1 --oneline $current_commit)"
    echo "📍 Commit anterior: $(git log -1 --oneline $previous_commit)"
    echo ""
    
    read -p "¿Confirmar rollback? (y/n): " -n 1 -r
    echo ""
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rollback_to_commit "$previous_commit"
    else
        echo "❌ Rollback cancelado."
        exit 0
    fi
}

# Función para mostrar últimos commits
show_commits() {
    echo -e "${YELLOW}📋 Últimos 10 commits:${NC}"
    echo ""
    git log --oneline --decorate --graph -10
    echo ""
}

# Función para hacer rollback interactivo
rollback_interactive() {
    show_commits
    echo ""
    read -p "Ingresa el hash del commit al que quieres volver (o 'q' para cancelar): " commit_hash
    
    if [ "$commit_hash" = "q" ]; then
        echo "❌ Rollback cancelado."
        exit 0
    fi
    
    rollback_to_commit "$commit_hash"
}

# Función para volver a la rama principal
rollback_to_main() {
    echo -e "${YELLOW}🔄 Volviendo a la rama main/master...${NC}"
    
    # Detener contenedores
    echo "🛑 Deteniendo contenedores..."
    docker-compose down || true
    
    # Determinar la rama principal
    if git show-ref --verify --quiet refs/heads/main; then
        MAIN_BRANCH="main"
    else
        MAIN_BRANCH="master"
    fi
    
    echo "⏮️ Volviendo a la rama $MAIN_BRANCH..."
    git checkout "$MAIN_BRANCH"
    git pull origin "$MAIN_BRANCH"
    
    # Rebuild y restart
    echo "🏗️ Reconstruyendo contenedores..."
    docker-compose build --no-cache
    
    echo "🚀 Iniciando contenedores..."
    docker-compose up -d
    
    # Verificar
    sleep 5
    if docker-compose ps | grep -q "Up"; then
        echo -e "${GREEN}✅ Rollback a $MAIN_BRANCH exitoso!${NC}"
        echo "📍 Ahora estás en: $(git log -1 --oneline)"
    else
        echo -e "${RED}❌ Error: Los contenedores no están corriendo.${NC}"
        docker-compose logs --tail=50
        exit 1
    fi
}

# Menú principal
show_menu() {
    echo ""
    echo "Selecciona una opción:"
    echo "1) 🚀 Rollback rápido (última imagen Docker)"
    echo "2) 🐳 Rollback a imagen Docker específica"
    echo "3) 📝 Rollback al commit anterior (más lento)"
    echo "4) 🔍 Rollback a un commit específico"
    echo "5) 🌿 Volver a la rama principal (main/master)"
    echo "6) 📋 Ver últimos commits"
    echo "7) 💾 Ver backups disponibles"
    echo "8) 📊 Ver estado actual"
    echo "q) Salir"
    echo ""
}

# Mostrar estado actual
show_status() {
    echo -e "${YELLOW}📊 Estado Actual:${NC}"
    echo ""
    echo "📍 Commit actual:"
    git log -1 --oneline --decorate
    echo ""
    echo "📦 Contenedores:"
    docker-compose ps
    echo ""
}

# Main
main() {
    if [ "$1" = "quick" ] || [ "$1" = "fast" ]; then
        # Rollback rápido a la última imagen
        echo -e "${YELLOW}🚀 Rollback rápido a última imagen...${NC}"
        local last_backup=$(docker images | grep 'porfoliodev-app.*backup' | head -n 1 | awk '{print $1":"$2}')
        if [ -z "$last_backup" ]; then
            echo -e "${RED}❌ No hay imágenes de backup disponibles.${NC}"
            exit 1
        fi
        docker-compose down
        docker tag "$last_backup" porfoliodev-app:latest
        docker-compose up -d
        echo -e "${GREEN}✅ Rollback completado!${NC}"
        exit 0
    elif [ "$1" = "previous" ]; then
        rollback_previous
        exit 0
    elif [ "$1" = "commit" ] && [ -n "$2" ]; then
        rollback_to_commit "$2"
        exit 0
    elif [ "$1" = "main" ]; then
        rollback_to_main
        exit 0
    fi
    
    # Modo interactivo
    while true; do
        show_menu
        read -p "Opción: " option
        
        case $option in
            1)
                # Rollback rápido
                local last_backup=$(docker images | grep 'porfoliodev-app.*backup' | head -n 1 | awk '{print $1":"$2}')
                if [ -z "$last_backup" ]; then
                    echo -e "${RED}❌ No hay imágenes de backup disponibles.${NC}"
                    continue
                fi
                echo -e "${YELLOW}🚀 Rollback rápido a: $last_backup${NC}"
                docker-compose down
                docker tag "$last_backup" porfoliodev-app:latest
                docker-compose up -d
                sleep 3
                if docker-compose ps | grep -q "Up"; then
                    echo -e "${GREEN}✅ Rollback exitoso!${NC}"
                fi
                ;;
            2)
                rollback_to_docker_image
                ;;
            3)
                rollback_previous
                ;;
            4)
                rollback_interactive
                ;;
            5)
                rollback_to_main
                ;;
            6)
                show_commits
                ;;
            7)
                list_backups
                ;;
            8)
                show_status
                ;;
            q|Q)
                echo "👋 Saliendo..."
                exit 0
                ;;
            *)
                echo -e "${RED}❌ Opción inválida.${NC}"
                ;;
        esac
    done
}

main "$@"
