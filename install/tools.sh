#!/usr/bin/env bash

set -e

echo "==> Instalando herramientas externas..."

# Oh My Posh
if ! command -v oh-my-posh >/dev/null 2>&1; then
    echo "==> Instalando Oh My Posh..."
    curl -s https://ohmyposh.dev/install.sh | bash -s
else
    echo "==> Oh My Posh ya está instalado."
fi

# OpenCode
if ! command -v opencode >/dev/null 2>&1; then
    echo "==> Instalando OpenCode..."
    curl -fsSL https://opencode.ai/install | bash -s -- --no-modify-path
else
    echo "==> OpenCode ya está instalado."
fi

echo "==> Herramientas externas instaladas correctamente."
