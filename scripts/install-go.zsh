GO_VERSION="1.22.2"

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
