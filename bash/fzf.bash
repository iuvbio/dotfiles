# Setup fzf
# ---------
#if [[ ! "$PATH" == *$HOME/src/fzf/bin* ]]; then
#  export PATH="${PATH:+${PATH}:}$HOME/src/fzf/bin"
#fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$HOME/.opt/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "$HOME/.opt/fzf/shell/key-bindings.bash"
