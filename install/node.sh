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
    export PATH="$NVM_BIN:$PATH"
else
    echo "ERROR: No se pudo cargar NVM."
    exit 1
fi

# Node.js LTS
if [ "$(nvm current)" = "system" ] || [ "$(nvm current)" = "none" ]; then
    echo "==> Instalando Node.js LTS..."
    nvm install --lts
fi

nvm alias default 'lts/*'
nvm use --lts

# path pnpm pre-install
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME/bin:$PATH"

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
echo "ng:   $(ng version 2>/dev/null | grep -m1 'Angular CLI' || true)"
