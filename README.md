# My Dotfiles

Feel free to go through my system dotfiles

## Basics

- For my operating system, I use Arch Linux (btw).
- For my window manager, I use Hyprland.
- For my terminal, I use Kitty.
- For my shell, I use Zsh.

## Applications

- For my launcher, I use Rofi.
- For my editor, I use Neovim.
- For my file, manager I use Yazi.
- For my terminal multiplexer, I use Tmux.

## Theme

- For my theme, generally I use Catppuccin.
- For terminal font, I use JetBrains Nerd Font.
- For shell prompt, I use oh-my-posh.

## Requirements

Ensure you have the following installed on your system

- Git
- Stow

## Installation

First, check out the dotfiles repo in your $HOME directory using git

```
$ git clone git@github.com:valdezdata/dotfiles.git
$ cd dotfiles
```

then use GNU stow to create symlinks

```
$ stow .
```
