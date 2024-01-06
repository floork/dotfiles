#!/bin/bash

current_dir=$(pwd)

desired_dir="$HOME/dotfiles/"
cd $desired_dir

git pull

cd "$current_dir" || exit

