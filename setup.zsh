#!/bin/zsh

echo "Setting up your Mac"

if test ! $(which brew)
then
    echo "Installing brew"
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if test ! $(which just)
then
    echo "Install just"
    brew install just
fi

just update
