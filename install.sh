#!/usr/bin/env bash
set -euo pipefail

function create_symlinks() {
	declare -A symlinks=(
		# SHELL
		# # bash
		[".bashrc"]="$script_dir/bash/bashrc"
		# # fish
		[".config/fish"]="$script_dir/fish"
		# # zsh
		[".config/zsh"]="$script_dir/zsh"
		[".zshrc"]="$script_dir/zsh/zshrc"
		# # shared resources
		[".aliasrc"]="$script_dir/shell/aliasrc"
		[".functionsrc"]="$script_dir/shell/functionsrc"

		# GIT
		[".gitconfig"]="$script_dir/git/gitconfig"
		[".config/gh"]="$script_dir/gh"

		# CLI
		# # tmux
		[".tmux.conf"]="$script_dir/tmux/tmux.conf"
		# # neofetch
		[".config/neofetch"]="$script_dir/neofetch"
		# # starship
		[".config/starship.toml"]="$script_dir/starship/starship.toml"

		# Desktop applications
		[".config/dunst"]="$script_dir/dunst"
		[".config/hypr"]="$script_dir/hypr"
		[".config/Thunar"]="$script_dir/Thunar"
		[".config/waybar"]="$script_dir/waybar"
		[".config/wofi"]="$script_dir/wofi"
		# # terminal
		[".config/warp-terminal"]="$script_dir/warp-terminal"
		[".config/wezterm"]="$script_dir/wezterm"
	)

	create_symlink() {
		local source=$1
		local target=$2

		if [ -e "$target" ]; then
			echo "Symlink for $source already exists."
		else
			ln -s "$source" "$target" || {
				echo "Failed to create symlink for $source"
				exit 1
			}
			echo "Symlink for $source created."
		fi
	}

	for source in "${!symlinks[@]}"; do
		create_symlink "${symlinks[$source]}" "$HOME/$source"
	done
}

function install_tmux_plugin_manager() {
	tpm_dir="$HOME/.tmux/plugins/tpm"
	if [ ! -d "$tpm_dir" ]; then
		git clone https://github.com/tmux-plugins/tpm "$tpm_dir" || {
			echo "Failed to install TMUX Plugin Manager"
			exit 1
		}
		echo "TMUX Plugin Manager installed."
	fi
}

function install_wallpapers() {
	WALLPAPERS_DIR="$HOME/.config/wallpapers"
	echo "Do you want to install wallpapers? (yes/No): "
	read -r ANSWER
	if [ "${ANSWER,,}" == "yes" ] || [ "${ANSWER,,}" == "y" ]; then
		if [ -d "$WALLPAPERS_DIR" ]; then
			rm -rf "$WALLPAPERS_DIR"
		fi
		git clone https://github.com/floork/wallpapers.git "$WALLPAPERS_DIR" || {
			echo "Failed to install wallpapers"
			exit 1
		}
		echo "Wallpapers installed successfully."
	fi
}

function setup_dotfiles() {
	echo "Setting up dotfiles..."
	script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

	create_symlinks
	install_tmux_plugin_manager
	install_wallpapers
	echo "Dotfiles setup complete."
}

setup_dotfiles
