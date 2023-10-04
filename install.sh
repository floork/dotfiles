#!/bin/bash
#
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ln -s $SCRIPT_DIR/zsh $HOME/.config/zsh
ln -s $SCRIPT_DIR/zsh/zshrc $HOME/.zshrc
ln -s $SCRIPT_DIR/kitty $HOME/.config/kitty
ln -s $SCRIPT_DIR/nvim $HOME/.config/nvim
ln -s $SCRIPT_DIR/bashrc $HOME/.bashrc

