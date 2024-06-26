ROOT_FILES=(
    .functions
    .aliases
    .vimrc
    .zshenv
    .zshrc
    .tmux.conf
    .gitconfig
    .gemrc
    .zprofile
)

for file in $ROOT_FILES
do
    cp -f dotfiles/$file ~/$file
done

mkdir -p ~/.config
root=$(pwd)
cd dotfiles/.config
for config in *
do
    rm -rf ~/.config/$config
    cp -rf $config ~/.config/$config
    echo "copied ~/.config/$config"
done
cd $root
