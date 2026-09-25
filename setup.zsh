#!/bin/zsh
set -e

echo "Setting up your Mac"

if ! command -v brew > /dev/null; then
    echo "Installing brew"
    brew_installer="$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    bash -c "$brew_installer"
fi

if command -v brew > /dev/null; then
    eval "$(brew shellenv)"
elif [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
else
    echo "Homebrew installation failed" >&2
    exit 1
fi

if ! command -v just > /dev/null; then
    echo "Install just"
    brew install just
fi

just update
