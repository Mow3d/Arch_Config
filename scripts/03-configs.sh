#!/bin/bash

# Script para copiar los archivos de configuración (dotfiles) desde el repositorio
# al directorio .config del usuario, creando backups de las configuraciones existentes.

# Colores para la salida
INFO='\033[0;34m'
SUCCESS='\033[0;32m'
WARN='\033[0;33m'
NC='\033[0m'

# Directorio de origen (donde están nuestras configs del proyecto)
SRC_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../configs

# Directorio de destino
DEST_DIR=$HOME/.config

# Lista de carpetas de configuración a copiar
CONFIG_FOLDERS=("hyprland" "kitty" "waybar" "wofi" "mako" "yazi")


echo -e "${INFO}Iniciando el proceso de copia de dotfiles...${NC}"

for FOLDER in "${CONFIG_FOLDERS[@]}"; do
    SRC_PATH="$SRC_DIR/$FOLDER"
    DEST_PATH="$DEST_DIR/$FOLDER"

    # Verificar si la carpeta de configuración de origen existe
    if [ -d "$SRC_PATH" ]; then
        echo -e "${INFO}Procesando configuración para: $FOLDER...${NC}"

        # Si ya existe una configuración en el destino, crear un backup
        if [ -d "$DEST_PATH" ] || [ -L "$DEST_PATH" ]; then
            BACKUP_PATH="${DEST_PATH}.bak_$(date +%F_%T)"
            echo -e "  ${WARN}Configuración existente encontrada. Creando backup en:${NC} $BACKUP_PATH"
            mv "$DEST_PATH" "$BACKUP_PATH"
        fi

        # Copiar la nueva configuración
        echo -e "  Copiando nueva configuración a $DEST_DIR"
        cp -r "$SRC_PATH" "$DEST_DIR/"
        echo -e "  ${SUCCESS}Copia de $FOLDER completada.${NC}"
    else
        echo -e "  ${WARN}No se encontró la carpeta de configuración de origen para '$FOLDER' en $SRC_DIR. Omitiendo.${NC}"
    fi
done

echo -e "\n${SUCCESS}¡Proceso de copia de dotfiles finalizado!${NC}"
