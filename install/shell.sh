#!/usr/bin/env bash

set -e

echo "==> Configurando Zsh..."

# Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "==> Instalando Oh My Zsh..."
    RUNZSH=no \
    CHSH=no \
    KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "==> Oh My Zsh ya está instalado."
fi

# zsh-autosuggestions
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
    echo "==> Instalando zsh-autosuggestions..."
    git clone \
        https://github.com/zsh-users/zsh-autosuggestions \
        "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
else
    echo "==> zsh-autosuggestions ya está instalado."
fi

# zsh-syntax-highlighting
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
    echo "==> Instalando zsh-syntax-highlighting..."
    git clone \
        https://github.com/zsh-users/zsh-syntax-highlighting.git \
        "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
else
    echo "==> zsh-syntax-highlighting ya está instalado."
fi

echo "==> Zsh configurado correctamente."
