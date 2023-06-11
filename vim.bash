# Setup binaries
# ---------
if [[ ! "$PATH" == *${HOME}/.vim/bin* ]]; then
  PATH="${PATH:+${PATH}:}${HOME}/.vim/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "${HOME}/.vim/.fzf/shell/completion.bash" 2> /dev/null
[[ $- == *i* ]] && source "${HOME}/.vim/.rg/complete/rg.bash" 2> /dev/null

# Key bindings
# ------------
source "${HOME}/.vim/.fzf/shell/key-bindings.bash"

export RIPGREP_CONFIG_PATH="${HOME}/.vim/.ripgreprc"
