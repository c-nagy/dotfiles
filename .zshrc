setopt PROMPT_SUBST
PROMPT='%B%F{red}%n@%m%f%F{yellow}[%D{%F %L:%M %p %Z}]%f:%F{blue}${${(%):-%~}}%f$ %b'
TMOUT=1

TRAPALRM() {
    zle reset-prompt
}
