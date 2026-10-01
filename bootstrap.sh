#!/usr/bin/env bash

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo
echo "========================================"
echo "       Bootstrap de entorno Linux"
echo "========================================"
echo
echo "Dotfiles: $DOTFILES_DIR"
echo

# 1. Paquetes del sistema
echo "==> [1/5] Paquetes del sistema"
"$DOTFILES_DIR/install/apt.sh"

# 2. Shell
echo
echo "==> [2/5] Zsh y Oh My Zsh"
"$DOTFILES_DIR/install/shell.sh"

# 3. Node.js
echo
echo "==> [3/5] Node.js y herramientas frontend"
"$DOTFILES_DIR/install/node.sh"

# 4. Herramientas externas
echo
echo "==> [4/5] Herramientas externas"
"$DOTFILES_DIR/install/tools.sh"

# 5. Configuración
echo
echo "==> [5/5] Configuración"
"$DOTFILES_DIR/install/config.sh"

# Git identity
echo
echo "==> Configuración de identidad Git"

GIT_NAME="$(git config --global user.name || true)"
GIT_EMAIL="$(git config --global user.email || true)"

if [ -z "$GIT_NAME" ]; then
    read -r -p "Nombre para Git: " GIT_NAME
    git config --global user.name "$GIT_NAME"
else
    echo "    Nombre: $GIT_NAME"
fi

if [ -z "$GIT_EMAIL" ]; then
    read -r -p "Email para Git: " GIT_EMAIL
    git config --global user.email "$GIT_EMAIL"
else
    echo "    Email: $GIT_EMAIL"
fi

echo
echo "========================================"
echo "       Bootstrap completado"
echo "========================================"
echo
echo "Pendiente de configurar manualmente:"
echo "  - Claves SSH de GitHub"
echo
echo "Recomendación: reinicia la sesión de Zsh antes de continuar."
echo
