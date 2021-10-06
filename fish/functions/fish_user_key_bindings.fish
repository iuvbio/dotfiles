function hybrid_bindings
    for mode in default insert visual
        fish_default_key_bindings -M $mode
    end
    fzf_key_bindings
end

set -g fish_key_bindings hybrid_bindings
