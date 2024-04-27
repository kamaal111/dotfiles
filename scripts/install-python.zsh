PYTHON_VERSION="3.12.1"

curl -sSf https://rye-up.com/get | RYE_INSTALL_OPTION="--yes" bash

echo "N" | pyenv install $PYTHON_VERSION || true
pyenv global $PYTHON_VERSION

echo "Done installing Python"
