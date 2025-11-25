set -o vi

# ZINIT SETUP
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# Plugins
zinit ice silent wait
zinit light zsh-users/zsh-syntax-highlighting

zinit ice silent wait
zinit light zsh-users/zsh-completions

zinit ice silent wait
zinit light zsh-users/zsh-autosuggestions

# Useful OMZ plugins (mac uyumlu)
zinit snippet OMZP::tmux
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# Auto-start tmux (local interactive only)
if command -v tmux &> /dev/null && [ -z "$TMUX" ] && [[ -z "$SSH_TTY" ]]; then
    tmux attach -t default || tmux new -s default
    exit
fi

autoload -Uz compinit && compinit
zinit cdreplay -q

# Starship
eval "$(starship init zsh)"

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory sharehistory hist_ignore_space hist_ignore_all_dups hist_save_no_dups hist_ignore_dups hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Aliases (macOS uyumlu hâle getirildi)
alias v='$EDITOR'
alias vim='$EDITOR'
alias c='clear'
alias cat=bat
alias nf='fastfetch'
alias ff='fastfetch'
alias pf='fastfetch'
alias dot="cd ~/dotfiles"
alias notes='$EDITOR ~/notes.txt'

# eza aliases (brew üzerinden yükleniyor)
alias ls='eza -a --icons'
alias ll='eza -al --icons'
alias lt='eza -a --tree --level=1 --icons'

# GIT shortcuts
alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gp="git push"
alias gpl="git pull"
alias gst="git stash"
alias gsp="git stash; git pull"
alias gcheck="git checkout"
alias gcredential="git config credential.helper store"

# Editor
export EDITOR=nvim

# FZF + Zoxide
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
