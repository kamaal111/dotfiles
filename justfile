set export

NVM_VERSION := "v0.39.3"
NODE_VERSION := "20.2"
NAME := "Kamaal"
PYTHON_VERSION := "3.11.3"

copy-dotfiles:
    #!/bin/zsh

    FILES=(
        .functions
        .aliases
        .vimrc
        .zshenv
        .zshrc
    )

    for file in $FILES
    do
        cp -f $file ~/$file
    done

install-tools: setup-zsh install-node install-python

set-macos-settings:
    #!/bin/zsh

    # Close any open System Preferences panes, to prevent them from overriding
    # settings we are about to change
    osascript -e 'tell application "System Preferences" to quit'

    # Ask for the administrator password upfront
    sudo -v

    # Set computer name (as done via System Preferences → Sharing)
    sudo scutil --set ComputerName "MacBook $NAME"
    sudo scutil --set HostName "MacBook $NAME"
    sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "MacBook $NAME"

[private]
setup-zsh:
    #!/bin/zsh

    if [ ! -f $ZSH/oh-my-zsh.sh ]
    then
        echo "Installing Oh My Zsh"
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi

    if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]
    then
        echo "Installing zsh-autosuggestions"
        git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    fi

    if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]
    then
        echo "Installing zsh-syntax-highlighting"
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    fi

[private]
install-python:
    #!/bin/zsh

    echo "N" | pyenv install $PYTHON_VERSION || true
    pyenv global $PYTHON_VERSION

[private]
install-node:
    #!/bin/zsh

    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh | bash

    . ~/.zshrc

    nvm install $NODE_VERSION || exit 1
    nvm use $NODE_VERSION || exit 1
