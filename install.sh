#!/usr/bin/env bash
set -euo pipefail

function setup_dotfiles() {
	local script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
	echo "Setting up dotfiles..."
	bash "$script_dir/bin/dotupdate"

	echo "Dotfiles setup complete."
}

setup_dotfiles
