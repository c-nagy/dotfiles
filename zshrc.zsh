# Prompt setup
public_IP=$(curl --silent checkip.amazonaws.com)
private_IP=$(hostname -I | head -n 1 | tr -d ' \t\n\r\f')
setopt PROMPT_SUBST
PROMPT='%B%F{red}$public_IP / $private_IP%f:%F{blue}${${(%):-%~}}%f$ %b'

# Always stay in same Tmux session
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux new-session -A -s "base"
fi

# Enable Vi mode within Zsh and set "ii" to work as the Vi escape key
set -o vi
bindkey -M viins 'ii' vi-cmd-mode

# Save history to file
export HISTFILE=~/zsh_history.txt
export HISTSIZE=1000000000
export SAVEHIST=1000000000
# Share history between terminals
setopt SHARE_HISTORY
# Enable timestamps in history file
setopt EXTENDED_HISTORY

# Go paths
export GOROOT=$HOME/.go
export PATH=$PATH:$GOROOT/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Bash style ctrl-R search backwards
bindkey -v
bindkey '^R' history-incremental-search-backward

# Invoke Zsh auto-suggestions tool (installed by setup.sh)
source /opt/zsh-autosuggestions/zsh-autosuggestions.zsh
