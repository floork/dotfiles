#!/usr/bin/env bash
# Get the directory where the script is located
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Define an associative array to store the symlink targets.
declare -A symlinks
symlinks[".gitconfig"]="$script_dir/git/gitconfig" # gitconfig should work aslong as gh is installed
symlinks[".bashrc"]="$script_dir/bash/bashrc"
symlinks[".aliasrc"]="$script_dir/alias/aliasrc"
symlinks[".zshrc"]="$script_dir/zsh/zshrc"
symlinks[".themes"]="$script_dir/themes"
symlinks[".config/dunst"]="$script_dir/dunst"
symlinks[".config/fish"]="$script_dir/fish"
symlinks[".config/gh"]="$script_dir/gh"
symlinks[".config/gtk-2.0"]="$script_dir/gtk-2.0"
symlinks[".config/gtk-3.0"]="$script_dir/gtk-3.0"
symlinks[".config/gtk-4.0"]="$script_dir/gtk-4.0"
symlinks[".config/hypr"]="$script_dir/hypr"
symlinks[".config/kitty"]="$script_dir/kitty"
symlinks[".config/neofetch"]="$script_dir/neofetch"
symlinks[".config/starship.toml"]="$script_dir/starship/starship.toml"
symlinks[".config/Thunar"]="$script_dir/Thunar"
symlinks[".tmux.conf"]="$script_dir/tmux/tmux.conf"
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

if [ -d "$HOME/.config/nvim" ]; then
  cd "$HOME/.config/nvim"
  git pull
  cd $script_dir
else
  git clone https://github.com/floork/nvim.git "$HOME/.config/nvim"
fi



# Install install tmux plugin manager
mkdir -p $HOME/.tmux/plugins
if ! [ -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi


WALLPAPERS_DIR="$HOME/.config/wallpapers"

echo "Do you want to install the wallpapers (y/N): "
read -r ANSWER

if [ "$ANSWER" == "y" ] || [ "$ANSWER" == "Y" ]; then
  if [ -d $WALLPAPERS_DIR ]; then
    rm -rf $WALLPAPERS_DIR
  fi
  mkdir -p $WALLPAPERS_DIR
  git clone https://github.com/floork/wallpapers.git $WALLPAPERS_DIR

  exit 0
fi

cd ~/.config/wallpapers
if [ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1; then
  git pull --recurse-submodules
fi
