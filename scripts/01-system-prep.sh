#!/bin/bash

# Script para preparar el sistema e instalar dependencias básicas.

# Colores para la salida
INFO='[0;34m'
SUCCESS='[0;32m'
WARN='[0;33m'
ERROR='[0;31m'
NC='[0m' # No Color

echo -e "${INFO}Iniciando preparación del sistema...${NC}"

# --- Instalación de Git ---
echo -e "${INFO}Verificando si Git está instalado...${NC}"
if ! command -v git &> /dev/null
then
    echo -e "${WARN}Git no está instalado. Instalando...${NC}"
    sudo pacman -S --noconfirm git
    if [ $? -eq 0 ]; then
        echo -e "${SUCCESS}Git instalado correctamente.${NC}"
    else
        echo -e "${ERROR}No se pudo instalar Git. Abortando.${NC}"
        exit 1
    fi
else
    echo -e "${SUCCESS}Git ya está instalado.${NC}"
fi

# Futuras preparaciones (como instalar yay) irán aquí.

echo -e "${SUCCESS}Preparación del sistema completada.${NC}"
