# Setup fzf
# ---------
#if [[ ! "$PATH" == *$HOME/src/fzf/bin* ]]; then
#  export PATH="${PATH:+${PATH}:}$HOME/src/fzf/bin"
#fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$HOME/.config/bash/fzf/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "$HOME/.config/bash/fzf/key-bindings.bash"
