#!/bin/env bash

# Function to change directory using fzf
function change_directory() {
  local directories
  # Find directories in both the regular home directory and specific home directory
  directories=$(fd -t d -E .git -E node_modules --exclude Downloads --base-directory ~)
  local my_home
  my_home=$(echo ~)
  directories+=" $my_home"

  # Use fzf to select a directory from the list
  local selected_directory
  selected_directory=$(echo "$directories" | tr ' ' '\n' | fzf)

  if [[ -z "$selected_directory" ]]; then
    echo "No directory selected."
    exit 1
  fi

  if ! [[ "$selected_directory" == "$my_home" ]]; then
    selected_directory="~/$selected_directory"
  fi

  # Open the selected directory in a new Zellij session
  zellij -s --cwd "$(realpath ~/"$selected_directory")"
}

change_directory
