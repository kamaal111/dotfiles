export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

if [[ -d "$ZSH/custom/plugins/zsh-completions/src" ]]; then
    fpath+=("$ZSH/custom/plugins/zsh-completions/src")
fi

[[ -f "$ZSH/oh-my-zsh.sh" ]] && . "$ZSH/oh-my-zsh.sh"
[[ -f "$HOME/.aliases" ]] && . "$HOME/.aliases"
[[ -f "$HOME/.functions" ]] && . "$HOME/.functions"

if command -v fzf > /dev/null; then
    . <(fzf --zsh)
fi

if command -v brew > /dev/null; then
    eval "$(brew shellenv)"
fi
if command -v mise > /dev/null; then
    eval "$(mise activate zsh)"
fi
if command -v thefuck > /dev/null; then
    eval "$(thefuck --alias)"
fi
if command -v zoxide > /dev/null; then
    eval "$(zoxide init zsh)"
fi
if command -v atuin > /dev/null; then
    eval "$(atuin init zsh)"
fi
if command -v starship > /dev/null; then
    eval "$(starship init zsh)"
fi
HISTSIZE=5000
HISTFILE="$HOME/.zsh_history"
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory sharehistory hist_ignore_space hist_ignore_all_dups hist_save_no_dups hist_ignore_dups hist_find_no_dups

export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Added by git-ai installer on Sat Jan 31 23:17:08 CET 2026
export PATH="/Users/kamaal/.git-ai/bin:$PATH"
