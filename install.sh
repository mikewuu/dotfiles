#! /bin/bash

dotfiles=$HOME/.dotfiles

zshrc=$dotfiles/.zshrc
aliases=$dotfiles/.aliases
vimrc=$dotfiles/.vimrc
vimfiles=$dotfiles/.vim
tmux_conf=$dotfiles/.tmux.conf
gitignore=$dotfiles/.gitignore
gitconfig=$dotfiles/.gitconfig
coc=$dotfiles/coc
neovim_config=$dotfiles/nvim

[[ ! -e $HOME/.aliases ]] && ln -s $aliases $HOME/.aliases 

[[ ! -e $HOME/.zshrc ]] && ln -s $zshrc $HOME/.zshrc 

[[ ! -e $HOME/.vimrc ]] && ln -s $vimrc $HOME/.vimrc 

[[ ! -e $HOME/.vim ]] && ln -s $vimfiles $HOME/.vim 

[[ ! -e $HOME/.tmux.conf ]] && ln -s $tmux_conf $HOME/.tmux.conf 

[[ ! -e $HOME/.gitignore ]] && ln -s $gitignore $HOME/.gitignore 

[[ ! -e $HOME/.gitconfig ]] && ln -s $gitconfig $HOME/.gitconfig 

[[ ! -e $HOME/.config/coc ]] && ln -s $coc $HOME/.config/coc 

[[ ! -e $HOME/.config/nvim ]] && ln -s $neovim_config $HOME/.config/nvim

echo "Done"
