# Linux Dotfiles

Configuración reproducible de mi entorno de desarrollo Linux.

El objetivo de este repositorio es poder reconstruir de forma controlada mi entorno de desarrollo en otra instalación Linux, manteniendo separadas:

- configuración personal
- herramientas y dependencias
- proyectos
- credenciales y secretos

## Qué contiene

- Zsh + Oh My Zsh
- plugins de Zsh
- FiraCode Nerd Font
- configuración de Git
- configuración SSH para GitHub
- Node.js mediante NVM
- pnpm mediante Corepack
- Angular CLI
- Oh My Posh
- OpenCode
- Fastfetch
- Micro
- herramientas CLI instaladas mediante APT

## Qué NO contiene

Este repositorio no contiene:

- claves privadas SSH
- credenciales
- tokens
- historial de shell
- cachés
- `node_modules`
- instalación de NVM
- estado generado por herramientas
- proyectos personales

Las claves SSH deben configurarse manualmente en cada máquina.

## Estructura

dotfiles/
├── config/       # Configuración de aplicaciones
├── git/          # Configuración global de Git
├── home/         # Archivos directamente bajo $HOME
├── install/      # Scripts de instalación
├── ssh/          # Configuración SSH
├── bootstrap.sh  # Instalación completa del entorno
└── .gitignore

## Bootstrap

El script `bootstrap.sh` ejecuta el proceso completo:

1. Instala paquetes del sistema mediante APT.
2. Instala FiraCode Nerd Font.
3. Instala y configura Zsh + Oh My Zsh.
4. Instala Node.js mediante NVM.
5. Configura Corepack, pnpm y Angular CLI.
6. Instala herramientas externas como Oh My Posh y OpenCode.
7. Restaura los archivos de configuración.
8. Configura la identidad global de Git.
9. Establece Zsh como shell predeterminada si es necesario.

Para ejecutarlo:

```bash
./bootstrap.sh
