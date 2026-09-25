set -e

brew update
brew bundle --file "${0:A:h:h}/Brewfile"

echo "Done installing brew bundle"
