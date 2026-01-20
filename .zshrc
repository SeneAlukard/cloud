##### SHELL MODE ###############################################################
set -o vi

##### ZINIT SETUP ##############################################################
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname "$ZINIT_HOME")"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "$ZINIT_HOME/zinit.zsh"

##### PLUGINS ##################################################################
zinit ice silent wait
zinit light zsh-users/zsh-syntax-highlighting

zinit ice silent wait
zinit light zsh-users/zsh-completions

zinit ice silent wait
zinit light zsh-users/zsh-autosuggestions

# Oh My Zsh snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::aws
zinit snippet OMZP::command-not-found

##### COMPLETION ###############################################################
autoload -Uz compinit && compinit
zinit cdreplay -q

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

##### PROMPT ###################################################################
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

##### KEYBINDINGS ##############################################################
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

##### HISTORY ##################################################################
HISTSIZE=5000
SAVEHIST=$HISTSIZE
HISTFILE="$HOME/.zsh_history"

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

##### EDITOR ###################################################################
export EDITOR=nvim

##### ALIASES ##################################################################
alias v='$EDITOR'
alias vim='$EDITOR'
alias c='clear'
alias dot='cd ~/dotfiles'
alias notes='$EDITOR ~/notes.txt'

# cat → bat → batcat fallback
if command -v bat >/dev/null 2>&1; then
  alias cat='bat'
elif command -v batcat >/dev/null 2>&1; then
  alias cat='batcat'
fi

# eza (ls replacement)
if command -v eza >/dev/null 2>&1; then
  alias ls='eza -a --icons'
  alias ll='eza -al --icons'
  alias lt='eza -a --tree --level=1 --icons'
fi

# fastfetch
if command -v fastfetch >/dev/null 2>&1; then
  alias nf='fastfetch'
  alias ff='fastfetch'
  alias pf='fastfetch'
fi

##### GIT SHORTCUTS ############################################################
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gcm='git commit -m'
alias gp='git push'
alias gpl='git pull'
alias gst='git stash'
alias gsp='git stash && git pull'
alias gcheck='git checkout'
alias gcredential='git config credential.helper store'

##### FZF ######################################################################
if command -v fzf >/dev/null 2>&1; then
  eval "$(fzf --zsh)"
fi

##### ZOXIDE ###################################################################
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init --cmd cd zsh)"
fi
