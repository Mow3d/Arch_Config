#!/bin/bash

# Script para instalar todos los paquetes de software de forma modular.

# Colores para la salida
INFO='\033[0;34m'
SUCCESS='\033[0;32m'
WARN='\033[0;33m'
ERROR='\033[0;31m'
NC='\033[0m' # No Color

# --- Listas de Paquetes (sin cambios) ---
PKGS_HARDWARE_NVIDIA=('nvidia-dkms' 'qt5-wayland' 'qt6-wayland' 'libva' 'libva-nvidia-driver')
PKGS_HARDWARE_AUDIO=('pipewire' 'pipewire-audio' 'pipewire-pulse' 'wireplumber' 'pavucontrol' 'pamixer')
PKGS_HARDWARE_CONNECTIVITY=('networkmanager' 'bluez' 'bluez-utils' 'blueman')
PKGS_SOFTWARE_BASE=('hyprland' 'waybar' 'wofi' 'kitty' 'mako' 'swww' 'bibata-cursor-theme' 'ttf-firacode-nerd' 'grim' 'slurp' 'brightnessctl' 'cliphist' 'yazi' 'tree' 'bat' 'fzf' 'zsh')
PKGS_PROFILE_GENERAL=('firefox' 'libreoffice-fresh' 'thunderbird' 'evince' 'loupe' 'thunar')
PKGS_PROFILE_DEV=('neovim' 'visual-studio-code-bin' 'docker' 'docker-compose' 'python' 'nodejs' 'npm' 'go' 'jupyterlab')
PKGS_PROFILE_CONTENT=('kdenlive' 'obs-studio' 'gimp' 'inkscape' 'reaper' 'audacity')

# --- Función de Instalación Modular ---
install_group() {
    local group_name="$1"
    shift
    local pkgs_to_install=($@)

    echo -e "${INFO}--- Instalando Grupo: $group_name ---${NC}"
    # Usamos un bucle para instalar uno por uno y detectar el fallo exacto
    for pkg in "${pkgs_to_install[@]}"; do
        echo -e "${INFO}Instalando: $pkg...${NC}"
        yay -S --noconfirm --needed "$pkg"
        if [ $? -ne 0 ]; then
            echo -e "${ERROR}Falló la instalación del paquete '$pkg' en el grupo '$group_name'. Abortando.${NC}"
            exit 1
        fi
    done
    echo -e "${SUCCESS}Grupo '$group_name' instalado correctamente.${NC}\n"
}

# --- Lógica de Instalación por Grupos ---
echo -e "${INFO}Iniciando instalación de paquetes por grupos...${NC}"

install_group "Hardware - NVIDIA" "${PKGS_HARDWARE_NVIDIA[@]}"
install_group "Hardware - Audio" "${PKGS_HARDWARE_AUDIO[@]}"
install_group "Hardware - Conectividad" "${PKGS_HARDWARE_CONNECTIVITY[@]}"
install_group "Software - Base" "${PKGS_SOFTWARE_BASE[@]}"

# --- Perfiles Opcionales ---
echo -e "${INFO}--- Selección de Perfiles de Software Opcionales ---${NC}"
read -p "¿Instalar perfil de Usuario General? (s/N): " choice
if [[ "$choice" == "s" || "$choice" == "S" ]]; then
    install_group "Perfil - Usuario General" "${PKGS_PROFILE_GENERAL[@]}"
fi

read -p "¿Instalar perfil de Desarrollo? (s/N): " choice
if [[ "$choice" == "s" || "$choice" == "S" ]]; then
    install_group "Perfil - Desarrollo" "${PKGS_PROFILE_DEV[@]}"
fi

read -p "¿Instalar perfil de Creación de Contenido? (s/N): " choice
if [[ "$choice" == "s" || "$choice" == "S" ]]; then
    install_group "Perfil - Creación de Contenido" "${PKGS_PROFILE_CONTENT[@]}"
fi

echo -e "${SUCCESS}¡Toda la instalación de paquetes ha finalizado con éxito!${NC}"
