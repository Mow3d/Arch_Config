#!/bin/bash

# Script para preparar el sistema e instalar dependencias básicas.

# Colores para la salida
INFO='[0;34m'
SUCCESS='[0;32m'
WARN='[0;33m'
ERROR='[0;31m'
NC='[0m' # No Color

echo -e "${INFO}Iniciando preparación del sistema...${NC}"

# --- Instalación de Paquetes Base (git y base-devel) ---
echo -e "${INFO}Instalando git y base-devel...${NC}"
sudo pacman -S --noconfirm --needed git base-devel
if [ $? -ne 0 ]; then
    echo -e "${ERROR}No se pudieron instalar los paquetes base. Abortando.${NC}"
    exit 1
fi
echo -e "${SUCCESS}Paquetes base verificados.${NC}"


# --- Instalación de Yay (Ayudante de AUR) ---
echo -e "${INFO}Verificando si Yay está instalado...${NC}"
if ! command -v yay &> /dev/null
then
    echo -e "${WARN}Yay no está instalado. Instalando...${NC}"
    original_dir=$(pwd)
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd "$original_dir"
    
    if command -v yay &> /dev/null; then
        echo -e "${SUCCESS}Yay instalado correctamente.${NC}"
    else
        echo -e "${ERROR}No se pudo instalar Yay. Revisa los errores de makepkg. Abortando.${NC}"
        exit 1
    fi
else
    echo -e "${SUCCESS}Yay ya está instalado.${NC}"
fi

echo -e "${SUCCESS}Preparación del sistema completada.${NC}"
