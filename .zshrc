setopt PROMPT_SUBST
PROMPT='%B%F{red}<IP>@%D{%b %-d %L:%M:%S%p %Z}%f:%F{blue}${${(%):-%~}}%f$ %b'
TMOUT=1

TRAPALRM() {
    zle reset-prompt
}
