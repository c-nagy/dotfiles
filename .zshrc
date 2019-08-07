set -o vi
setopt PROMPT_SUBST
PROMPT='%B%F{red}<IP>@%D{%b %-d %L:%M:%S%p %Z}%f:%F{blue}${${(%):-%~}}%f$ %b'
TMOUT=1

TRAPALRM() {
    zle reset-prompt
}

if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux new-session -A -s base
fi
