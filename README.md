# Proyecto de Configuración de Hyprland

## Propósito del Proyecto
El objetivo de este proyecto es crear una serie de scripts (`.sh`) que automaticen la instalación y configuración de un entorno de escritorio completo y personalizado basado en Hyprland sobre Arch Linux. La meta es lograr un sistema funcional, estético y adaptado a las necesidades de un entorno de desarrollo y uso general, partiendo de una instalación mínima de Arch.

## Objetivo de este Documento
Este `README.md` sirve como el documento central de planificación. Su propósito es definir y organizar todos los componentes del proyecto antes de la implementación. Aquí se detallan las decisiones sobre qué paquetes instalar, cómo estructurar los archivos de configuración y el orden en que se ejecutarán los scripts. Funciona como un mapa y una lista de tareas para el desarrollo del proyecto.

## 1. Objetivos
- [ ] Definir una instalación base limpia y reproducible.
- [ ] Automatizar la configuración de hardware esencial.
- [ ] Instalar y configurar un conjunto de software coherente y estético.
- [ ] Soportar múltiples perfiles de usuario (General, Desarrollo, Creación de Contenido).

## 2. Plan de Configuración

### A. Hardware

#### A.1. Gráficos y Pantallas
- **Controladores Gráficos (Drivers):**
  - `nvidia-dkms`: Driver principal de NVIDIA.
  - `qt5-wayland` y `qt6-wayland`: Compatibilidad para aplicaciones Qt.
  - `libva`: API de aceleración de video.
  - `libva-nvidia-driver`: Aceleración de video por hardware para NVIDIA.
- **Configuración de Monitores:** (Resolución, tasa de refresco, disposición)
- **Efectos Visuales y Composición:** (Hyprland se encarga de esto nativamente: blur, animaciones, sombras)

#### A.2. Audio
- **Servidor de Audio:**
  - `pipewire`: El servidor de audio principal.
  - `pipewire-audio`: Perfiles y configuración para audio estándar.
  - `pipewire-pulse`: Compatibilidad para aplicaciones que esperan PulseAudio.
  - `wireplumber`: Gestor de sesiones para PipeWire.
- **Control de Volumen:**
  - `pavucontrol`: Mezclador de volumen gráfico.
  - `pamixer`: Herramienta de control de volumen para la línea de comandos (útil para atajos de teclado).

#### A.3. Conectividad
- **Gestor de Red:** `NetworkManager` (Para gestionar conexiones Wi-Fi y Ethernet)
- **Bluetooth:**
  - `bluez`: El stack de protocolos de Bluetooth.
  - `bluez-utils`: Utilidades de línea de comandos.
  - `blueman`: Gestor de Bluetooth gráfico y applet.

#### A.4. Periféricos
- **Teclado, Ratón y Touchpad:** (Se configuran directamente en `hyprland.conf`)


### B. Software

#### B.1. Entorno de Escritorio Central
- **Gestor de Ventanas (WM):** `hyprland`
- **Barra de Estado:** `waybar`
- **Lanzador de Aplicaciones:** `wofi`
- **Terminal:** `kitty`
- **Gestor de Notificaciones:** `mako`

#### B.2. Apariencia y Theming
- **Selector de Fondos de Pantalla:** `swww`
- **Tema GTK y de Iconos:** (A decidir, ej: Catppuccin, Papirus)
- **Cursores y Fuentes:**
  - **Fuentes:** Se recomienda una `Nerd Font` (ej. `ttf-firacode-nerd`) para los iconos en la terminal.
  - **Cursores:** (A decidir, ej: `bibata-cursor-theme`)

#### B.3. Perfiles de Software (Para Menú Post-Instalación)
*Nota: Estos perfiles no se instalan por defecto. Estarán disponibles como opciones en un menú de gestión una vez que el sistema base esté funcionando.*

##### Perfil 1: Usuario General (Ofimática y Navegación)
- **Navegador Web:** `firefox`
- **Suite de Ofimática:** `libreoffice-fresh`
- **Cliente de Correo:** `thunderbird`
- **Visor de Documentos:** `evince` (PDF), `loupe` (Imágenes)
- **Gestor de Archivos (Gráfico):** `thunar`

##### Perfil 2: Desarrollo de Software e IA
- **Editores de Código:** `neovim`, `visual-studio-code-bin` (AUR)
- **Contenedores:** `docker`, `docker-compose`
- **Runtimes (ejemplos):** `python`, `nodejs`, `npm`, `go`
- **Herramientas IA (ejemplos):** `jupyterlab`, `python-pytorch-cuda`

##### Perfil 3: Creación de Contenido
- **Edición de Video:** `kdenlive`, `obs-studio` (Grabación y Streaming)
- **Edición de Imagen:** `gimp` (Raster), `inkscape` (Vectorial)
- **Producción de Audio:** `reaper` (AUR), `audacity`
- **Post-Instalación Opcional:** `davinci-resolve` (requiere descarga manual, se creará script aparte).

#### B.4. Utilidades del Sistema
- **Herramientas de Captura de Pantalla:** `grim` y `slurp`
- **Control de Brillo:** `brightnessctl`
- **Gestor del Portapapeles:** `cliphist`
- **Gestor de Archivos (Terminal):** `yazi`
- **Utilidades de Terminal:** `tree`, `bat`, `fzf`

#### B.5. Entorno de Shell
- **Shell:** `zsh`
- **Framework de Zsh:** `oh-my-zsh` (se instala con un script)
- **Configuración de Neovim:** Se gestionará con un script dedicado para instalar un gestor de plugins (ej. Packer, Lazy) y configuraciones para resaltado de sintaxis, árboles de archivos, etc.


## 3. Plan de Implementación (Scripts)
1.  **01-system-prep.sh**: Preparar sistema, instalar `git` y `yay`.
2.  **02-packages-base.sh**: Instalar **únicamente** los paquetes del sistema base (Hardware y Software Central).
3.  **03-configs.sh**: Copiar los dotfiles (configs) al directorio `~/.config`.
4.  **04-services.sh**: Habilitar servicios del sistema (NetworkManager, Bluetooth, Docker, etc).
5.  **05-shell-setup.sh**: Instalar y configurar Zsh, Oh My Zsh, y Neovim.
6.  **06-theming.sh**: Aplicar temas GTK, de iconos y fuentes.
7.  **07-post-install-menu.sh**: **Nuevo.** Script que proveerá un menú (usando wofi) para instalar perfiles de software, actualizar el sistema, etc.  
