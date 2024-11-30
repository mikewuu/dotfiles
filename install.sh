#! /bin/bash

dotfiles=$HOME/dotfiles

zshrc=$dotfiles/.zshrc
aliases=$dotfiles/.aliases
vimrc=$dotfiles/.vimrc
vimfiles=$dotfiles/.vim
tmux_conf=$dotfiles/.tmux.conf
gitignore=$dotfiles/.gitignore
gitconfig=$dotfiles/.gitconfig
coc=$dotfiles/coc
neovim_config=$dotfiles/nvim
wezterm_conf=$dotfiles/.wezterm.lua


[[ ! -e $HOME/.aliases ]] && ln -s $aliases $HOME/.aliases 

[[ ! -e $HOME/.zshrc ]] && ln -s $zshrc $HOME/.zshrc 

[[ ! -e $HOME/.tmux.conf ]] && ln -s $tmux_conf $HOME/.tmux.conf 

[[ ! -e $HOME/.wezterm.lua ]] && ln -s $wezterm_conf $HOME/.wezterm.lua

[[ ! -e $HOME/.gitignore ]] && ln -s $gitignore $HOME/.gitignore 

[[ ! -e $HOME/.gitconfig ]] && ln -s $gitconfig $HOME/.gitconfig 

[[ ! -e $HOME/.config/nvim ]] && ln -s $neovim_config $HOME/.config/nvim

ln -s /Users/mike/dotfiles/tmux-themes/catppuccin /Users/mike/.config/tmux/plugins

echo "Done"
