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
    cp -f dotfiles/$file ~/$file
done
