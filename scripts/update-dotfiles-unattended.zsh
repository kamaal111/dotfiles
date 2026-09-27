#!/bin/zsh
set -eu

repo_dir="${0:A:h:h}"
export DOTFILES="$repo_dir"
export PATH="/opt/homebrew/bin:/usr/local/bin:$HOME/.local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

for tool in git brew just mise; do
    if ! command -v "$tool" > /dev/null; then
        echo "Cannot update dotfiles unattended: $tool is unavailable" >&2
        exit 1
    fi
done

export GIT_TERMINAL_PROMPT=0
export GIT_SSH_COMMAND="/usr/bin/ssh -o BatchMode=yes -o ConnectTimeout=15 -o StrictHostKeyChecking=yes"
export HOMEBREW_NO_ASK=1
export HOMEBREW_NO_SUDO=1
export MISE_YES=1
export NONINTERACTIVE=1

exec /usr/bin/perl "$repo_dir/scripts/with-timeout.pl" 7200 /bin/zsh -c \
    'export DOTFILES="$0"; source "$DOTFILES/dotfiles/.functions" && update-dotfiles </dev/null' \
    "$repo_dir"
