# List available commands
default:
    just --list --unsorted --list-heading $'Available commands\n'

# Update dotfiles
update: brew-install-bundle setup-zsh copy-dotfiles install-tools

copy-dotfiles:
    zsh scripts/copy-dotfiles.zsh

[private]
install-tools: install-languages setup-vim

[private]
brew-install-bundle:
    zsh scripts/brew-install-bundle.zsh

[private]
setup-zsh:
    zsh scripts/setup-zsh.zsh

[private]
setup-vim:
    zsh scripts/setup-vim.zsh

[private]
install-languages:
    mise install
