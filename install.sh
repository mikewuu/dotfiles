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
ghostty_config=$dotfiles/ghostty


[[ ! -e $HOME/.aliases ]] && ln -s $aliases $HOME/.aliases

[[ ! -e $HOME/.zshrc ]] && ln -s $zshrc $HOME/.zshrc

[[ ! -e $HOME/.tmux.conf ]] && ln -s $tmux_conf $HOME/.tmux.conf

[[ ! -e $HOME/.gitignore ]] && ln -s $gitignore $HOME/.gitignore

[[ ! -e $HOME/.gitconfig ]] && ln -s $gitconfig $HOME/.gitconfig

[[ ! -e $HOME/.config/nvim ]] && ln -s $neovim_config $HOME/.config/nvim

[[ ! -e "$HOME/Library/Application Support/com.mitchellh.ghostty" ]] && ln -s $ghostty_config "$HOME/Library/Application Support/com.mitchellh.ghostty"

echo "Done"
