#!/usr/bin/env bash

# Get the directory where the script is located
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Define an associative array to store the symlink targets.
declare -A symlinks
symlinks[".gitconfig"]="$script_dir/gitconfig"
symlinks[".bashrc"]="$script_dir/bashrc"
symlinks[".zshrc"]="$script_dir/zsh/zshrc"
symlinks[".config/fish"]="$script_dir/fish"
symlinks[".config/gh"]="$script_dir/gh"
symlinks[".config/gtk-2.0"]="$script_dir/gtk-2.0"
symlinks[".config/gtk-3.0"]="$script_dir/gtk-3.0"
symlinks[".config/gtk-4.0"]="$script_dir/gtk-4.0"
symlinks[".config/hypr"]="$script_dir/hypr"
symlinks[".config/kitty"]="$script_dir/kitty"
symlinks[".config/neofetch"]="$script_dir/neofetch"
symlinks[".config/nvim"]="$script_dir/nvim"
symlinks[".config/starship.toml"]="$script_dir/starship.toml"
symlinks[".config/Thunar"]="$script_dir/Thunar"
symlinks[".config/wallpapers"]="$script_dir/wallpapers"
symlinks[".config/waybar"]="$script_dir/waybar"
symlinks[".config/wofi"]="$script_dir/wofi"
symlinks[".config/xsettingsd"]="$script_dir/xsettingsd"
symlinks[".config/zsh"]="$script_dir/zsh"

# Iterate over the associative array and create symlinks.
for file in "${!symlinks[@]}"; do
  if [ -e "$HOME/$file" ]; then
    echo "Symlink for $file already exists."
  else
    ln -s "${symlinks[$file]}" "$HOME/$file"
    echo "Symlink for $file created."
  fi
done

