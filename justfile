# List available commands
default:
    just --list --unsorted --list-heading $'Available commands\n'

# Update dotfiles
update: brew-install-bundle copy-dotfiles install-tools

copy-dotfiles:
    zsh scripts/copy-dotfiles.zsh

[private]
install-tools: setup-zsh setup-tmux install-go install-node install-python install-rust install-ruby install-bun setup-vim

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
setup-tmux:
    zsh scripts/setup-tmux.zsh

[private]
install-java:
    zsh scripts/install-java.zsh

[private]
install-bun:
    zsh scripts/install-bun.zsh

[private]
install-ruby:
    zsh scripts/install-ruby.zsh

[private]
install-rust:
    zsh scripts/install-rust.zsh

[private]
install-go:
    zsh scripts/install-go.zsh

[private]
install-python:
    zsh scripts/install-python.zsh

[private]
install-node:
    zsh scripts/install-node.zsh
