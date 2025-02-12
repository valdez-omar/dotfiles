#    _____      __
#   / __(_)____/ /_
#  / /_/ / ___/ __ \
# / __/ (__  ) / / /
#/_/ /_/____/_/ /_/

### ADDING TO THE PATH
# First line removes the path; second line sets it.  Without the first line,
# your path gets massive and fish becomes very slow.
set -e fish_user_paths
set -U fish_user_paths $HOME/.local/bin $HOME/Applications $fish_user_paths
set fish_vi_key_bindings  # Enables vim keybindings

set -U fish_greeting
#set -g fish_autosuggestion_enabled 0
set -Ux EDITOR nvim
set -Ux VISUAL nvim
set -gx PATH $HOME/.cargo/bin $PATH
set -gx GOPATH $HOME/go
set -gx PATH $GOPATH/bin $PATH
# set -gx PATH $HOME/Downloads/google-cloud-sdk/bin $PATH
set -gx SHELL /usr/bin/fish

### Setting the starship prompt
if type -q starship
    starship init fish | source
else
end

### add zoxide setup
zoxide init --cmd cd fish | source

### Calling external scripts
source ~/.config/fish/completions/aliases.fish
