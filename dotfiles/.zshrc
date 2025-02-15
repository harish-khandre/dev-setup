# Language and encoding
export LANG=en_US.UTF-8

# Base PATH setup
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Homebrew setup
if [ -e /home/linuxbrew/.linuxbrew/bin/brew ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

eval "$(starship init zsh)"


export EDITOR=nvim

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light MichaelAquilina/zsh-you-should-use

# Add in snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found
zinit snippet OMZP::colored-man-pages
zinit snippet OMZP::copybuffer
zinit snippet OMZP::dirhistory
zinit snippet OMZP::copyfile
zinit snippet OMZP::vi-mode

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# Keybindings
bindkey '^ ' autosuggest-accept
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias vim='nvim'
alias c='clear'
alias vc="cd ~/.config/nvim && nvim ."
alias src="source ~/.zshrc"
alias zshrc="nvim ~/.zshrc"
alias .="nvim ."
alias fzfclip='tac | fzf --multi | tr "\n" " " | xclip -selection clipboard'
alias ff='nvim $(find . -type f \( -path "*/node_modules/*" -prune \) -o -type f -print | fzf -m --preview="bat --color=always {}")'
alias fd='cd "$(find . -type d \( -name node_modules -prune \) -o -type d -print | fzf --preview="ls -al {}")" && nvim .'
alias cat='batcat'
alias mongostart="sudo systemctl start mongod"
alias mongostop="sudo systemctl stop mongod"
alias checkall="bun tsc && bun lint --fix && bun format"
alias ..='cd ..'

# Conditional aliases
if command -v eza &>/dev/null; then
    alias ls='eza --icons=always --color=auto --long'
    alias la='ls -la'
fi

# Development environment setup
# Go
export GOROOT=/home/harish/.local/share/mise/installs/go/1.23.4
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

# Node (NVM)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "/home/harish/.bun/_bun" ] && source "/home/harish/.bun/_bun"
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# PNPM
export PNPM_HOME="/home/harish/.local/share/pnpm"
case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# SST
export PATH=$PATH:$HOME/.sst/bin

# Tool completions
if command -v aws_completer &>/dev/null; then
    complete -C '$(which aws_completer)' aws
fi

complete -o nospace -C /usr/bin/terraform terraform

# Shell integrations
source <(fzf --zsh)
eval "$(zoxide init --cmd cd zsh)"
eval "$(direnv hook zsh)"

# Atuin setup (if installed)
source "$HOME/.atuin/bin/env"

if [ -d $HOME/.atuin ]; then
    source $HOME/.atuin/bin/env
    eval "$(atuin init zsh)"
fi

source "$HOME/.local/share/../bin/env"
