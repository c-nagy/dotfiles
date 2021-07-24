# Always stay in same Tmux session
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux new-session -A -s "persist"
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

# Bash-style ctrl-R search backwards in Zsh
bindkey -v
bindkey '^R' history-incremental-search-backward

# Zsh suggestions and highlights
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#f56e03"

# Add xclip alias 'c' for easily piping command output into clipboard
alias "c=xclip -selection clipboard"

# Misc aliases for quality of life
alias ls="lsd" 
alias la="lsd -al" 
alias lt="lsd -l --tree" 
alias cat="batcat"
alias fortune="fortune | lolcat"
alias quote='fortune | lolcat'
alias who='tuxi -r who'
alias what='tuxi -r what'
alias spanish='tuxi -r in spanish'
alias weather='tuxi -r weather in missoula'
alias tuxi='tuxi -r'

# Go paths
export GOROOT=$HOME/.go
export PATH=$PATH:$GOROOT/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Fortune once everything is loaded up
fortune
