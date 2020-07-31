# Dotfiles

My highly subjective configs as a JS/PHP dev for:

- tmux
- zsh
- vim/nvim (with coc)
- aliases

Vim purists be warned: I came from an IDE world of sublime, jetbrains, and VSCode,
and have tried to replicate all the modern features I couldn't dev without.

## Install

You'll need to install the apps yourself. Then run simply run `install.sh`
to copy the configs over.

> Remember to run :PlugInstall in vim afterwards to install plugins

## Other Requirements

### Font

Install fira code with nerd fonts to include file icons

### Terminal Theme/Palette

Ocean Next to display vim colors correctly

### Global Gitignore

Tell git about the gitignore file:

`git config --global core.excludesfile ~/.gitignore` (mac)
