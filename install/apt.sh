#!/usr/bin/env bash

set -e

echo "==> Instalando paquetes del sistema..."

sudo apt update

sudo apt install -y \
    zsh \
    git \
    curl \
    wget \
    unzip \
    fzf \
    direnv \
    keychain \
    micro \
    bat \
    eza \
    zoxide \
    fastfetch \
    git-delta \
    fontconfig

echo "==> Paquetes del sistema instalados correctamente."
