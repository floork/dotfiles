#!/usr/bin/env bash

# Define the path for the lock file
LOCK_FILE="/tmp/set_wallpaper.lock"

# Function to acquire the lock
function acquire_lock() {
	# Attempt to create the lock file
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

# Function to kill swaybg if running
function kill_swaybg() {
	if pgrep -x "swaybg" >/dev/null; then
		killall swaybg
	fi
}

# Function to set wallpaper
function set_wallpaper() {
	kill_swaybg

	local wallpapers_dir="$HOME/.config/wallpapers/"
	local exclude_1="$HOME/.config/wallpapers/.git/"
	local exclude_2="$HOME/.config/wallpapers/anime/.git/"

	wallpaper=$(find "$wallpapers_dir" -type f -not -path "$exclude_1*" -not -path "$exclude_2*" | shuf -n1)
	cp "$wallpaper" "$wallpapers_dir/current.png"
	swaybg -i "$wallpaper" -m fill &
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

	# Set wallpaper every 10 minutes
	while true; do
		sleep 600
		set_wallpaper
	done
}

main
