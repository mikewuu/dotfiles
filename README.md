# Dotfiles

My highly subjective configs as a JS/PHP dev for:

- tmux
- zsh
- vim/nvim (with coc)
- aliases

Vim purists be warned: I came from an IDE world of sublime, jetbrains, and VSCode,
and have tried to replicate all the modern features I couldn't dev without.

## Install

> Must install oh-my-zsh before running `./install.sh`

You'll need to install the apps yourself. Then run simply run `install.sh`
to copy the configs over.

> Remember to run :PlugInstall in vim afterwards to install plugins

## Other Requirements

## Installing oh-my-zsh odin

[https://github.com/tylerreckart/odin](Odin Theme)

```bash
cd odin && make
```

### Copy over custom theme

```bash
cp odin.zsh-theme  ~/.oh-my-zsh/themes/odin.zsh-theme
```

### Font

Install fira code with nerd fonts to include file icons

### Terminal Theme/Palette

Ocean Next to display vim colors correctly

### Global Gitignore

Tell git about the gitignore file:

`git config --global core.excludesfile ~/.gitignore` (mac)
