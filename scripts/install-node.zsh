NODE_VERSION="22"
NVM_VERSION="v0.40.3"

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh | bash

. ~/.zshrc

nvm install $NODE_VERSION || exit 1
nvm use $NODE_VERSION || exit 1
nvm alias default $NODE_VERSION || exit 1

echo "Done installing Node.js"

echo corepack enable
echo "Enabled corepack"
