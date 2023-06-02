#!/bin/zsh

echo "Setting up your Mac"

if test ! $(which brew);
then
    echo "Installing brew"
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "Installing brew bundle"
brew update
brew tap homebrew/bundle
brew bundle

echo "Setting Mac settings"
just set-macos-settings

echo "Copying dotfiles"
just copy-dotfiles

echo "Installing tools"
just install-tools
