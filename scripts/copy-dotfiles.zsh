set -e

repo_root="${0:A:h:h}"

ROOT_FILES=(
    .functions
    .aliases
    .vimrc
    .zshenv
    .zshrc
    .gitconfig
    .zprofile
    .wezterm.lua
)

for file in $ROOT_FILES
do
    cp -f "$repo_root/dotfiles/$file" "$HOME/$file"
done

mkdir -p "$HOME/.config"
for source in "$repo_root"/dotfiles/.config/*
do
    config="${source:t}"
    if [[ -d "$source" ]]; then
        mkdir -p "$HOME/.config/$config"
        cp -R "$source/." "$HOME/.config/$config/"
    else
        cp -f "$source" "$HOME/.config/$config"
    fi
    echo "copied ~/.config/$config"
done
