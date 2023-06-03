set export

NVM_VERSION := "v0.39.3"
NODE_VERSION := "20.2"
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
