if status is-interactive
    # Commands to run in interactive sessions can go here
end
$HOME/.ghostty-cache.sh

export VISUAL=nvim
export EDITOR=nvim

zoxide init fish --cmd cd | source
starship init fish | source
direnv hook fish | source
