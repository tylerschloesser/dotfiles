# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

bindkey -v
bindkey "^p" up-line-or-search
bindkey "^N" down-line-or-search
bindkey "^R" history-incremental-search-backward
