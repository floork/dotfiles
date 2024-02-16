#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

create_symlinks() {
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

    create_symlink() {
        local source=$1
        local target=$2

        if [ -e "$target" ]; then
            echo "Symlink for $source already exists."
        else
            ln -s "$source" "$target" || { echo "Failed to create symlink for $source"; exit 1; }
            echo "Symlink for $source created."
        fi
    }

    for source in "${!symlinks[@]}"; do
        create_symlink "${symlinks[$source]}" "$HOME/$source"
    done
}

install_tmux_plugin_manager() {
    tpm_dir="$HOME/.tmux/plugins/tpm"
    if [ ! -d "$tpm_dir" ]; then
        git clone https://github.com/tmux-plugins/tpm "$tpm_dir" || { echo "Failed to install TMUX Plugin Manager"; exit 1; }
        echo "TMUX Plugin Manager installed."
    fi
}

install_wallpapers() {
    WALLPAPERS_DIR="$HOME/.config/wallpapers"
    echo "Do you want to install wallpapers? (yes/No): "
    read -r ANSWER
    if [ "${ANSWER,,}" == "yes" ] || [ "${ANSWER,,}" == "y" ]; then
        if [ -d "$WALLPAPERS_DIR" ]; then
            rm -rf "$WALLPAPERS_DIR"
        fi
        git clone https://github.com/floork/wallpapers.git "$WALLPAPERS_DIR" || { echo "Failed to install wallpapers"; exit 1; }
        echo "Wallpapers installed successfully."
    fi
}

update_git_repositories() {
    WALLPAPERS_DIR="$HOME/.config/wallpapers"
    echo "Updating wallpapers repository..."
    if [ -d "$WALLPAPERS_DIR" ]; then
        cd "$WALLPAPERS_DIR" || exit
        git pull --recurse-submodules || { echo "Failed to update wallpapers repository"; exit 1; }
        cd "$script_dir" || exit
    fi

    NVIM_CONFIG_DIR="$HOME/.config/nvim"
    echo "Updating nvim configuration..."
    if [ -d "$NVIM_CONFIG_DIR" ]; then
        cd "$NVIM_CONFIG_DIR" || exit
        git pull || { echo "Failed to update nvim configuration"; exit 1; }
        cd "$script_dir" || exit
    else
        git clone https://github.com/floork/nvim.git "$NVIM_CONFIG_DIR" || { echo "Failed to clone nvim configuration"; exit 1; }
    fi

    if [ ! -e "$script_dir/nvim" ]; then
        ln -s "$NVIM_CONFIG_DIR" "$script_dir/nvim" || { echo "Failed to create symlink for nvim"; exit 1; }
    fi
}

update_user_bin_directory() {
    BIN_DIR="$HOME/.local/bin"
    mkdir -p "$BIN_DIR"

    for file in "$script_dir/bin"/*; do
        ln -sf "$file" "$BIN_DIR/" || { echo "Failed to update user bin directory"; exit 1; }
    done
}

setup_dotfiles() {
    create_symlinks
    install_tmux_plugin_manager
    install_wallpapers
    update_git_repositories
    update_user_bin_directory
    echo "Dotfiles setup complete."
}

setup_dotfiles
