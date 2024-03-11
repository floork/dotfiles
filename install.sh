#!/usr/bin/env bash
set -euo pipefail

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

function setup_dotfiles() {
	echo "Setting up dotfiles..."
	local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

	install_tmux_plugin_manager

	echo "Updating dotfiles..."
	bash "$script_dir/bin/dotupdate"

	echo "Dotfiles setup complete."
}

setup_dotfiles
