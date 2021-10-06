### My fish config

set -x SHELL fish

#### aliases

# there is `exec fish` for this
#alias reload='source ~/.config/fish/config.fish'
alias ..='cd ..'
alias ...='.. ..'

alias upup="sudo apt update && sudo apt upgrade"
alias pua="pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U"
alias jkyll="bundle exec jekyll"
#alias vactivate="test -d venv && conda deactivate && source venv/bin/activate.fish"
alias vactivate='set venv (find . -name activate.fish) && test -f "$venv[1]" && source "$venv[1]"'
alias cpc="xclip -selection clipboard < "
alias bat="batcat"


#### exports

set -x FZF_DEFAULT_COMMAND "rg --files --follow --glob '!.git' --glob '!venv'"
set -x FZF_DEFAULT_OPTS "-m --height 50% --border"

# set nvim as default editor and vim as fallback
set -x VISUAL nvim
set -x EDITOR nvim


# load fzf key-bindings
# use fish_vi_key_bindings here
source "$HOME/.config/fish/functions/fish_user_key_bindings.fish"

# use starship prompt
starship init fish | source

# start keychain
if status --is-interactive
    keychain --eval --quiet -Q id_ed25519 id_ljnsn | source
end
