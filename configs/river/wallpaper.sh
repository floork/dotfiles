#!/bin/env bash

set -Eeuo pipefail

# Check for a debug flag early
for arg in "$@"; do
  if [ "$arg" == "--debug" ]; then
    set -x
    echo "--- Debug mode enabled (set -x) ---"
    break
  fi
done

WALLPAPERS_DIR="/home/floork/dotfiles/configs/live-wallpapers/"

get_random_wallpaper() {
  local wallpapers=("$WALLPAPERS_DIR"*)

  local random_index=$((RANDOM % ${#wallpapers[@]}))
  local random_wallpaper="${wallpapers[$random_index]}"
  echo "$random_wallpaper"
}

check_available() {
  if command -v "$1" >/dev/null 2>&1; then
    return 0
  fi
  return 1
}

check_running() {
  if pgrep -x "$1" >/dev/null; then
    return 0
  fi
  return 1
}

main() {
  echo "--- Entering main function ---"
  if ! check_available "swww"; then
    echo "swww is not available"
    exit 1
  fi
  echo "swww is available check passed."

  if ! check_running "swww-daemon"; then
    echo "swww-daemon is not running"
    echo "Starting swww-daemon"
    swww-daemon &
  fi
  echo "swww-daemon check passed."
  
  local wallpaper
  echo "Getting random wallpaper..."
  wallpaper=$(get_random_wallpaper)
  echo "Selected wallpaper: $wallpaper"
  
  echo "Setting wallpaper with swww img \"$wallpaper\""
  swww img "$wallpaper"
  echo "Wallpaper set command executed."
  echo "$wallpaper"
  echo "--- Exiting main function ---"
}

main "$@"
