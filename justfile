set export

NVM_VERSION := "v0.39.3"
NODE_VERSION := "20.2"
PYTHON_VERSION := "3.11.3"
GO_VERSION := "1.20.4"

update: brew-install-bundle copy-dotfiles install-tools

[private]
copy-dotfiles:
    #!/bin/zsh

    FILES=(
        .functions
        .aliases
        .vimrc
        .zshenv
        .zshrc
        .tmux.conf
        .gitconfig
    )

    for file in $FILES
    do
        cp -f $file ~/$file
    done

[private]
install-tools: setup-zsh setup-tmux install-go install-node install-python

[private]
brew-install-bundle:
    #!/bin/zsh

    brew update
    brew tap homebrew/bundle
    brew bundle

    echo "Done installing brew bundle"

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

    echo "Done setting up ZSH"

[private]
setup-tmux:
    #!/bin/zsh

    if [ ! -d ~/.tmux/plugins/tpm ]
    then
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm || true
    fi

    echo "Done setting up TMUX"

[private]
install-go:
    #!/bin/zsh

    zsh < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer) || true

    . ~/.zshrc

    gvm install "go$GO_VERSION"
    gvm use "go$GO_VERSION" --default

    echo "Done installing Go"

[private]
install-python:
    #!/bin/zsh

    echo "N" | pyenv install $PYTHON_VERSION || true
    pyenv global $PYTHON_VERSION

    echo "Done installing Python"

[private]
install-node:
    #!/bin/zsh

    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh | bash

    . ~/.zshrc

    nvm install $NODE_VERSION || exit 1
    nvm use $NODE_VERSION || exit 1

    echo "Done installing Node.js"
