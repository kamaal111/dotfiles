export ZSH="/Users/kamaal/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
	git
  	zsh-autosuggestions
	zsh-syntax-highlighting
)

. $ZSH/oh-my-zsh.sh
. ~/.aliases
. ~/.functions
. ~/.gvm/scripts/gvm || true

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval $(thefuck --alias)
eval "$(zoxide init zsh)"

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
