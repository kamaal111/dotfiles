NODE_VERSION="20.2"
NVM_VERSION="v0.39.3"

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh | bash

. ~/.zshrc

nvm install $NODE_VERSION || exit 1
nvm use $NODE_VERSION || exit 1

echo "Done installing Node.js"
