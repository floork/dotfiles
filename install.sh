#!/usr/bin/env bash
set -euo pipefail

# Get the directory where the script is located
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Define the function to create symbolic links
create_symlinks() {

    # Define an associative array to store the symlink targets.
    declare -A symlinks=(
        [".gitconfig"]="$script_dir/git/gitconfig" 
        [".bashrc"]="$script_dir/bash/bashrc"
        [".aliasrc"]="$script_dir/alias/aliasrc"
        [".zshrc"]="$script_dir/zsh/zshrc"
        [".themes"]="$script_dir/themes"
        [".config/dunst"]="$script_dir/dunst"
        [".config/fish"]="$script_dir/fish"
        [".config/gh"]="$script_dir/gh"
        [".config/hypr"]="$script_dir/hypr"
        [".config/neofetch"]="$script_dir/neofetch"
        [".config/starship.toml"]="$script_dir/starship/starship.toml"
        [".config/Thunar"]="$script_dir/Thunar"
        [".tmux.conf"]="$script_dir/tmux/tmux.conf"
        [".config/waybar"]="$script_dir/waybar"
        [".config/wezterm"]="$script_dir/wezterm"
        [".config/wofi"]="$script_dir/wofi"
        [".config/xsettingsd"]="$script_dir/xsettingsd"
        [".config/zsh"]="$script_dir/zsh"
    )

    # Function to create symbolic links
    create_symlink() {
        local source=$1
        local target=$2

        if [ -e "$target" ]; then
            echo "Symlink for $source already exists."
        else
            ln -s "$source" "$target"
            echo "Symlink for $source created."
        fi
    }

    # Create symbolic links
    for source in "${!symlinks[@]}"; do
        create_symlink "${symlinks[$source]}" "$HOME/$source"
    done
}

# Function to install tmux plugin manager
install_tmux_plugin_manager() {
    tpm_dir="$HOME/.tmux/plugins/tpm"
    if ! [ -d "$tpm_dir" ]; then
        git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
        echo "TMUX Plugin Manager installed."
    fi
}

# Function to install wallpapers
install_wallpapers() {
    WALLPAPERS_DIR="$HOME/.config/wallpapers"
    echo "Do you want to install wallpapers (y/n): "
    read -r ANSWER
    if [ "${ANSWER,,}" == "y" ]; then
        if [ -d "$WALLPAPERS_DIR" ]; then
            rm -rf "$WALLPAPERS_DIR"
        fi
        git clone https://github.com/floork/wallpapers.git "$WALLPAPERS_DIR"
        echo "Wallpapers installed successfully."
    fi
}

# Update wallpapers and other git repositories
update_git_repositories() {
    if [ -d "$WALLPAPERS_DIR" ]; then
        cd "$WALLPAPERS_DIR"
        git pull --recurse-submodules
    fi

    # Update nvim configuration
    NVIM_CONFIG_DIR="$HOME/.config/nvim"
    if [ -d "$NVIM_CONFIG_DIR" ]; then
        cd "$NVIM_CONFIG_DIR"
        git pull
        cd "$script_dir"
    else
        git clone https://github.com/floork/nvim.git "$NVIM_CONFIG_DIR"
    fi

    # Create symlink for nvim if it doesn't exist
    if ! [ -e "$script_dir/nvim" ]; then
        ln -s "$NVIM_CONFIG_DIR" "$script_dir/nvim"
    fi
}

# Add dotfiles update command to user's bin directory
update_user_bin_directory() {
    BIN_DIR="$HOME/.local/bin"
    mkdir -p "$BIN_DIR"

    # Create symbolic links for files in commands directory
    for file in "$script_dir/bin"/*; do
        ln -sf "$file" "$BIN_DIR/"
    done
}

# Main function to setup dotfiles
setup_dotfiles() {
    create_symlinks
    install_tmux_plugin_manager
    install_wallpapers
    update_git_repositories
    update_user_bin_directory
    echo "Dotfiles setup complete."
}

# Call the main setup function
setup_dotfiles
