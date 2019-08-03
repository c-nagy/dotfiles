setopt PROMPT_SUBST
PROMPT='%B%F{red}%D{%b %-d %L:%M%p %Z}%f:%F{blue}${${(%):-%~}}%f$ %b'
TMOUT=1

TRAPALRM() {
    zle reset-prompt
}
