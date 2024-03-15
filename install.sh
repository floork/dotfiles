#!/usr/bin/env bash
set -euo pipefail

function setup_dotfiles() {
	echo "Setting up dotfiles..."
	bash "$script_dir/bin/dotupdate"

	echo "Dotfiles setup complete."
}

setup_dotfiles
