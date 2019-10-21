# Prompt setup
prompt_IP=$(curl --silent ifconfig.io)
setopt PROMPT_SUBST
PROMPT='%B%F{red}$prompt_IP@%m%f:%F{blue}${${(%):-%~}}%f$ %b'

# Always stay in same Tmux session
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux new-session -A -s base
fi

# Enable Vi mode within Zsh and set "ii" to work as the Vi escape key
set -o vi
bindkey -M viins 'ii' vi-cmd-mode

# Handy directory movement aliases
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

# Save history to file
export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=1000
setopt SHARE_HISTORY

# Go paths
export GOROOT=$HOME/.go
export PATH=$PATH:$GOROOT/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
