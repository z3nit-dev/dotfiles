#!/usr/bin/env bash

set -e

echo "==> Configurando Node.js..."

# NVM
if [ ! -d "$HOME/.nvm" ]; then
    echo "==> Instalando NVM..."
    curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
fi

export NVM_DIR="$HOME/.nvm"

# Cargar NVM
if [ -s "$NVM_DIR/nvm.sh" ]; then
    source "$NVM_DIR/nvm.sh"
else
    echo "ERROR: No se pudo cargar NVM."
    exit 1
fi

# Node.js LTS
if ! command -v node >/dev/null 2>&1; then
    echo "==> Instalando Node.js LTS..."
    nvm install --lts
fi

nvm alias default 'lts/*'

# Corepack + pnpm
echo "==> Configurando Corepack..."
corepack enable
corepack install --global pnpm@12.4.2

# Angular CLI
echo "==> Instalando Angular CLI..."
pnpm add --global @angular/cli@22.0.5

echo "==> Node.js configurado correctamente."
echo "Node: $(node --version)"
echo "npm:  $(npm --version)"
echo "pnpm: $(pnpm --version)"
echo "ng:   $(ng version --skip-git 2>/dev/null | head -n 1 || true)"
