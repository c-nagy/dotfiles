# Prompt setup
# Todo: Fix the hardcoded '$' at the end of the prompt so that it changes to '#' if running as root.
# also, make it so the public IP is switched to the local hostname if an internet connection is not available.
public_IP=$(curl --silent checkip.amazonaws.com)
private_IP=$(hostname -I | cut -d ' ' -f1)
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

# Bash style ctrl-R search backwards
bindkey -v
bindkey '^R' history-incremental-search-backward

# Invoke Zsh auto-suggestions tool (installed by setup.sh)
source /opt/zsh-autosuggestions/zsh-autosuggestions.zsh
# Orange font for Zsh suggestions
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#f56e03"

# Add xclip alias 'c' for easily piping command output into clipboard
alias "c=xclip -selection clipboard"
