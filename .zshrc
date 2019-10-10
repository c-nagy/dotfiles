# Set IP in prompt
prompt_IP=$(curl --silent ifconfig.io)

# Prompt setup
setopt PROMPT_SUBST
PROMPT='%B%F{red}$prompt_IP@%D{%b %-d %L:%M:%S%p %Z}%f:%F{blue}${${(%):-%~}}%f$ %b'
TMOUT=1

TRAPALRM() {
    zle reset-prompt
}

# Always stay in same tmux session
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux new-session -A -s base
fi

# Enable Vi mode within Zsh and set "ii" to work as the Vi escape key
set -o vi
bindkey -M viins 'ii' vi-cmd-mode
