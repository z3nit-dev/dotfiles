#!/usr/bin/env bash

set -e

echo "==> Instalando herramientas externas..."

# eza
if ! command -v eza >/dev/null 2>&1; then
    echo "==> Configurando repositorio de eza..."

    sudo mkdir -p /etc/apt/keyrings

    if [ ! -f /etc/apt/keyrings/gierens.gpg ]; then
        wget -qO- \
            https://raw.githubusercontent.com/eza-community/eza/main/deb.asc \
            | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
    fi

    if [ ! -f /etc/apt/sources.list.d/gierens.list ]; then
        echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" \
            | sudo tee /etc/apt/sources.list.d/gierens.list >/dev/null
    fi

    sudo chmod 644 \
        /etc/apt/keyrings/gierens.gpg \
        /etc/apt/sources.list.d/gierens.list

    sudo apt update
    sudo apt install -y eza
else
    echo "==> eza ya está instalado."
fi

# Fastfetch
if ! command -v fastfetch >/dev/null 2>&1; then
    echo "==> Instalando Fastfetch..."

    if [ -f /etc/os-release ]; then
        . /etc/os-release
    fi

    case "$ID" in
        debian)
            echo "==> Debian detectado."
            sudo apt update
            sudo apt install -y fastfetch
            ;;

        ubuntu|linuxmint)
            echo "==> Ubuntu/Mint detectado."
            sudo add-apt-repository -y ppa:zhangsongcui3371/fastfetch
            sudo apt update
            sudo apt install -y fastfetch
            ;;

        *)
            echo "ERROR: Distribución no soportada para la instalación automática de Fastfetch."
            exit 1
            ;;
    esac
else
    echo "==> Fastfetch ya está instalado."
fi

# Git Delta
if ! command -v delta >/dev/null 2>&1; then
    echo "==> Instalando Git Delta..."

    DELTA_URL="$(
        curl -fsSL \
            -H "Accept: application/vnd.github+json" \
            https://api.github.com/repos/dandavison/delta/releases/latest \
        | grep -o 'https://github.com/dandavison/delta/releases/download/[^"]*git-delta_[^"]*_amd64\.deb' \
        | head -n 1
    )"

    if [ -z "$DELTA_URL" ]; then
        echo "ERROR: No se pudo localizar el paquete .deb de Git Delta."
        exit 1
    fi

    TEMP_DEB="$(mktemp --suffix=.deb)"
    trap 'rm -f "$TEMP_DEB"' EXIT

    curl -fsSL \
        -o "$TEMP_DEB" \
        "$DELTA_URL"

    sudo apt install -y "$TEMP_DEB"
else
    echo "==> Git Delta ya está instalado."
fi

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
