# Dotfiles

## Setup

1. Clone this repository

```sh
git clone git@github.com:kamaal111/dotfiles.git ~/.dotfiles
```

2. Go to the dotfiles directory

```sh
cd ~/.dotfiles
```

3. Run setup script

```sh
zsh setup.zsh
```

## Update dotfiles

From anywhere run the following

```sh
update-dotfiles
```

## Language versions

Node.js and Rust are managed by mise. Edit
`dotfiles/.config/mise/config.toml` to change the global defaults, then run
`mise install` after the config has been copied to `~/.config/mise/config.toml`.
New Zsh sessions activate mise automatically.
