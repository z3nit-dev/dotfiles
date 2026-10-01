#!/usr/bin/env bash

set -e

NERD_FONTS_VERSION="3.5.1"
FONT_NAME="FiraCode"
FONT_DIR="$HOME/.local/share/fonts/$FONT_NAME"

echo "==> Configurando $FONT_NAME Nerd Font..."

if fc-list | grep -qi "FiraCode Nerd Font"; then
    echo "==> FiraCode Nerd Font ya está instalada."
    exit 0
fi

echo "==> Descargando FiraCode Nerd Font v$NERD_FONTS_VERSION..."

TEMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TEMP_DIR"' EXIT

curl -fsSL \
    -o "$TEMP_DIR/$FONT_NAME.tar.xz" \
    "https://github.com/ryanoasis/nerd-fonts/releases/download/v${NERD_FONTS_VERSION}/${FONT_NAME}.tar.xz"

mkdir -p "$FONT_DIR"

tar -xJf "$TEMP_DIR/$FONT_NAME.tar.xz" -C "$FONT_DIR"

fc-cache -f "$HOME/.local/share/fonts"

if fc-list | grep -qi "FiraCode Nerd Font"; then
    echo "==> FiraCode Nerd Font instalada correctamente."
else
    echo "ERROR: No se pudo verificar la instalación de FiraCode Nerd Font."
    exit 1
fi
