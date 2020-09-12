# Setup fzf
# ---------
#if [[ ! "$PATH" == */home/diosos/src/fzf/bin* ]]; then
#  export PATH="${PATH:+${PATH}:}/home/diosos/src/fzf/bin"
#fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$HOME/.config/bash/fzf/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "$HOME/.config/bash/fzf/key-bindings.bash"
