#!/usr/bin/env bash

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export PATH="$HOME/.local/bin:$PATH"

echo
echo "========================================"
echo "       Bootstrap de entorno Linux"
echo "========================================"
echo
echo "Dotfiles: $DOTFILES_DIR"
echo

# 1. Paquetes del sistema
echo "==> [1/6] Paquetes del sistema"
"$DOTFILES_DIR/install/apt.sh"

# Guardar identidad Git actual antes de reemplazar ~/.gitconfig
GIT_NAME="$(git config --global user.name || true)"
GIT_EMAIL="$(git config --global user.email || true)"

# 2. Fuentes
echo
echo "==> [2/6] FiraCode Nerd Font"
"$DOTFILES_DIR/install/fonts.sh"

# 3. Shell
echo
echo "==> [3/6] Zsh y Oh My Zsh"
"$DOTFILES_DIR/install/shell.sh"

# 4. Node.js
echo
echo "==> [4/6] Node.js y herramientas frontend"
"$DOTFILES_DIR/install/node.sh"

# 5. Herramientas externas
echo
echo "==> [5/6] Herramientas externas"
"$DOTFILES_DIR/install/tools.sh"

# 6. Configuración
echo
echo "==> [6/6] Configuración"
"$DOTFILES_DIR/install/config.sh"

# Compatibilidad con versiones de Git
GIT_VERSION="$(git --version | awk '{print $3}')"

if [ "$(printf '%s\n' "2.35.0" "$GIT_VERSION" | sort -V | head -n1)" = "2.35.0" ]; then
    git config --global merge.conflictstyle zdiff3
else
    git config --global merge.conflictstyle diff3
fi

# Git identity
echo
echo "==> Configuración de identidad Git"

if [ -z "$GIT_NAME" ]; then
    read -r -p "Nombre para Git: " GIT_NAME
else
    echo "    Nombre: $GIT_NAME"
fi

if [ -z "$GIT_EMAIL" ]; then
    read -r -p "Email para Git: " GIT_EMAIL
else
    echo "    Email: $GIT_EMAIL"
fi

git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"

# Shell predeterminada
echo
if [ "$SHELL" != "$(command -v zsh)" ]; then
    echo "==> Estableciendo Zsh como shell predeterminada..."
    chsh -s "$(command -v zsh)"
else
    echo "==> Zsh ya es la shell predeterminada."
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
