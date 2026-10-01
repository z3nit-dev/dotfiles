#!/usr/bin/env bash

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

backup_and_copy() {
    local source="$1"
    local target="$2"
    local relative_target="${target#$HOME/}"
    local backup_target="$BACKUP_DIR/$relative_target"

    if [ -e "$target" ] || [ -L "$target" ]; then
        echo "==> Backup: $target"
        mkdir -p "$(dirname "$backup_target")"
        cp -a "$target" "$backup_target"
    fi

    mkdir -p "$(dirname "$target")"
    cp -a "$source" "$target"

    echo "    ✓ $target"
}

echo "==> Restaurando configuración..."
echo "    Dotfiles: $DOTFILES_DIR"

# Home
backup_and_copy \
    "$DOTFILES_DIR/home/.zshrc" \
    "$HOME/.zshrc"

backup_and_copy \
    "$DOTFILES_DIR/home/.angular-config.json" \
    "$HOME/.angular-config.json"

# Fastfetch
backup_and_copy \
    "$DOTFILES_DIR/config/fastfetch/config.jsonc" \
    "$HOME/.config/fastfetch/config.jsonc"

# Micro
backup_and_copy \
    "$DOTFILES_DIR/config/micro/bindings.json" \
    "$HOME/.config/micro/bindings.json"

# Oh My Posh
backup_and_copy \
    "$DOTFILES_DIR/config/oh-my-posh/unicorn.json" \
    "$HOME/.config/oh-my-posh/unicorn.json"

# Git
backup_and_copy \
    "$DOTFILES_DIR/git/gitconfig" \
    "$HOME/.gitconfig"

# SSH
backup_and_copy \
    "$DOTFILES_DIR/ssh/config" \
    "$HOME/.ssh/config"

chmod 600 "$HOME/.ssh/config"

echo
echo "==> Configuración restaurada correctamente."

if [ -d "$BACKUP_DIR" ]; then
    echo "==> Backup creado en:"
    echo "    $BACKUP_DIR"
fi
