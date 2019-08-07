external_IP=$(curl --silent ifconfig.io)
setopt PROMPT_SUBST
PROMPT='%B%F{red}$external_IP@%D{%b %-d %L:%M:%S%p %Z}%f:%F{blue}${${(%):-%~}}%f$ %b'
TMOUT=1

TRAPALRM() {
    zle reset-prompt
}

if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux new-session -A -s base
fi

set -o vi
