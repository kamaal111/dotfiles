set export

NVM_VERSION := "v0.39.3"
NODE_VERSION := "20.2"
PYTHON_VERSION := "3.12.1"
GO_VERSION := "1.20.6"
RUBY_VERSION := "3.2.2"
GITHUB_USERNAME := "kamaal111"

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
        .gemrc
    )

    for file in $FILES
    do
        cp -f $file ~/$file
    done

[private]
install-tools: setup-zsh setup-tmux install-go install-node install-python install-rust install-ruby install-bun setup-vim

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
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || exit 1
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
setup-vim:
    #!/bin/zsh

    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    git clone https://github.com/$GITHUB_USERNAME/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim-kickstart || true

[private]
setup-tmux:
    #!/bin/zsh

    if [ ! -d ~/.tmux/plugins/tpm ]
    then
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm || true
    fi

    echo "Done setting up TMUX"

[private]
install-bun:
    #!/bin/zsh

    curl -fsSL https://bun.sh/install | bash

[private]
install-ruby:
    #!/bin/zsh

    echo "N" | rbenv install $RUBY_VERSION
    rbenv global $RUBY_VERSION

    echo "Done installing Ruby"

[private]
install-rust:
    #!/bin/zsh

    curl https://sh.rustup.rs -sSf | sh -s -- -y

    echo "Done installing Rust"

[private]
install-go:
    #!/bin/zsh

    . ~/.zshrc

    if which go > /dev/null
    then
    else
        echo "Install Go first here: https://go.dev/doc/install"
        exit 1
    fi

    zsh < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer) || true

    gvm install "go$GO_VERSION" || exit 1
    gvm use "go$GO_VERSION" --default || exit 1

    echo "Done installing Go"

[private]
install-python:
    #!/bin/zsh

    curl -sSf https://rye-up.com/get | RYE_INSTALL_OPTION="--yes" bash

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

    npm install --global yarn pnpm

    echo "Done installing Node.js"
