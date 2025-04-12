export ZSH="/Users/$USER/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
	git
  	zsh-autosuggestions
	zsh-syntax-highlighting
)

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

. $ZSH/oh-my-zsh.sh
. ~/.aliases
. ~/.functions
. ~/.gvm/scripts/gvm || true
. <(fzf --zsh)
[ -s ~/.bun/_bun ] && . ~/.bun/_bun
. "$HOME/.rye/env" || true

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(/opt/homebrew/bin/brew shellenv)"
eval $(thefuck --alias)
eval "$(zoxide init zsh)"
eval "$(atuin init zsh)"
eval "$(starship init zsh)"
if which rbenv > /dev/null
then
	eval "$(rbenv init -)"
fi

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

[[ ! -r ~/.opam/opam-init/init.zsh ]] || source ~/.opam/opam-init/init.zsh > /dev/null 2> /dev/null

FNM_PATH="~/Library/Application Support/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="~/Library/Application Support/fnm:$PATH"
  eval "`fnm env`"
fi

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
