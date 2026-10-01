# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"

export PATH="$HOME/.local/bin:$PATH"

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source "$ZSH/oh-my-zsh.sh"

# NVM
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
[[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end

# fzf
source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh

# zoxide
eval "$(zoxide init zsh)"

# direnv
eval "$(direnv hook zsh)"

# Oh My Posh
#eval "$(oh-my-posh init zsh --config 'unicorn')"
eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/unicorn.json)"

# Fastfetch
fastfetch

# Aliases
alias zshconf="micro ~/.zshrc"
alias zshrl="exec zsh"

alias ls='eza --icons'
alias l='eza -l --icons'
alias ll='eza -l --icons --git'
alias la='eza -la --icons --git'
alias lt='eza --tree --level=2 --icons'
alias ldot='eza -ld .* --icons'

alias cat='batcat'
alias ff='fastfetch'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias c='clear'
alias cls='clear'

#Functions
cdl() {
    z "$1" && eza --icons
}


# Load Angular CLI autocompletion.
source <(ng completion script)

# opencode
export PATH="$HOME/.opencode/bin:$PATH"

# SSH Agent / Keychain
eval $(keychain --eval --quiet id_ed25519_github_personal id_ed25519_github_profesional)
