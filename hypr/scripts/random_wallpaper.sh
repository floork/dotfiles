#!/usr/bin/env bash

# Define the path for the lock file
LOCK_FILE="/tmp/set_wallpaper.lock"
WALLPAPERS_DIR="$HOME/.config/wallpapers"
INTERVAL=600

# Function to acquire the lock
function acquire_lock() {
	if [ -e "$LOCK_FILE" ]; then
		echo "Another instance is already running. Exiting."
		exit 1
	else
		touch "$LOCK_FILE"
	fi
}

# Function to release the lock
function release_lock() {
	rm -f "$LOCK_FILE"
}

# Function to get a random wallpaper from the specified directory
function get_wallpaper() {
	if [ ! -d "$1" ]; then
		echo "Error: Wallpapers directory '$1' does not exist."
		exit 1
	fi

	wallpaper=$(find "$1" -type f -name '*.png' | shuf -n 1)
	if [ -z "$wallpaper" ]; then
		echo "Error: No PNG wallpapers found in '$1'."
		exit 1
	fi
}

# Function to kill a process
function kill_process() {
	if pgrep -x "$1" >/dev/null; then
		killall "$1"
	fi
}

# Function to change the wallpaper
function change_wallpaper() {
	local program="$1"
	if [[ "$program" != "swaybg" && "$program" != "hyprpaper" ]]; then
		echo "Error: Invalid parameter. Expected 'swaybg' or 'hyprpaper'."
		return 1
	fi

	kill_process "$program"

	case "$program" in
	swaybg)
		swaybg -i "$wallpaper" -m fill &
		;;
	hyprpaper)
		sleep 1
		hyprpaper &
		;;
	esac
}

# Function to set wallpaper
function set_wallpaper() {
	get_wallpaper "$WALLPAPERS_DIR"
	cp "$wallpaper" ~/.cache/current.png
	change_wallpaper "hyprpaper"
}

# Function to handle cleanup
function cleanup() {
	release_lock
}

# Trap cleanup function on exit
trap cleanup EXIT

# Main function
function main() {
	acquire_lock

	set_wallpaper

	# Set wallpaper at intervals
	while true; do
		sleep "$INTERVAL"
		set_wallpaper
	done
}

main
