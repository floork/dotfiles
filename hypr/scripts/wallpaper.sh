#!/bin/env bash

# Function to kill a process if it is running
function kill_process() {
  local process=$1
  if pgrep -x "$process" >/dev/null; then
    pkill "$process"
  fi
}

# Function to kill the random wallpaper script if it is running
function kill_random_wallpaper() {
  local pid=$(pgrep -f "hypr/scripts/random_wallpaper.sh")
  if [ -n "$pid" ]; then
    kill "$pid"
  fi
}

# Function to apply a wallpaper
function apply_wallpaper() {
  local wallpaper=$1
  local backend=$2
  kill_process "$backend" # Kill any existing process related to wallpaper_backend
  kill_random_wallpaper   # Kill the random wallpaper script

  cp "$wallpaper" ~/.cache/current.png # Copy the selected wallpaper to cache directory
  export CURRENT_WALLPAPER="$wallpaper"
  echo "export CURRENT_WALLPAPER=\"$wallpaper\"" >~/.cache/current_wallpaper.sh

  # Check the wallpaper backend and apply accordingly
  if [ "$backend" == "swaybg" ]; then
    swaybg -i "$wallpaper" -m fill & # Set wallpaper using swaybg
    return
  fi

  if [ "$backend" == "hyprpaper" ]; then
    sleep 1
    hyprpaper & # Set wallpaper using hyprpaper
    return
  fi

  echo "Backend not found: $2" # Print error if backend not found
}

# Function to show a menu of wallpapers and apply the selected wallpaper
function show_wallpaper_menu() {
  local launcher_cmd="$APP_LAUNCHER"

  # Adjust command for specific launcher
  if [ "$APP_LAUNCHER" == "wofi" ]; then
    launcher_cmd="$APP_LAUNCHER --show dmenu -i -p 'Select a wallpaper: '"
  elif [ "$APP_LAUNCHER" == "fuzzel" ]; then
    launcher_cmd="$APP_LAUNCHER --dmenu -p 'Select a wallpaper: '"
  fi

  local wallpapers_dir="$HOME/.config/wallpapers"         # Directory containing wallpapers
  local command="fd . --full-path $wallpapers_dir -e png" # Command to list wallpapers

  local wallpapers=($(eval "$command" | sed "s|$wallpapers_dir/||")) # List of wallpapers with only the part behind wallpapers_dir

  local options=$(printf "%s\n" "${wallpapers[@]}") # Options for wallpaper selection menu

  local selected_option=$(echo -e "$options" | $launcher_cmd) # Selected wallpaper option

  if [ -n "$selected_option" ]; then
    selected_option="$wallpapers_dir/$selected_option" # Reconstruct full path
    apply_wallpaper "$selected_option" "hyprpaper"     # Apply the selected wallpaper
  else
    echo "No wallpaper selected."
  fi
}

# Function to check if the launcher menu is open
function check_launcher_open() {
  pgrep -x "$APP_LAUNCHER" >/dev/null
}

# Check if the launcher menu is open, if not, show the wallpaper menu
if ! check_launcher_open; then
  show_wallpaper_menu
fi
