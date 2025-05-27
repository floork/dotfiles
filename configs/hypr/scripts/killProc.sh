#!/bin/env bash

function get_pid() {
  ps --user $(id --user) -o pid,user,cmd | sed '1d' | fuzzel --dmenu | awk '{print $1}'
}

function kill_menu() {
  local options=("Kill" "Force" "Cancel")

  local selected=$(echo "${options[@]}" | tr ' ' '\n' | fuzzel --dmenu -p "Select an option")
  echo "$selected"
}

function kill_process() {
  local pid=$1
  local kill_option=$2

  case "$kill_option" in
  Kill)
    kill "$pid"
    ;;
  Force)
    kill -9 "$pid"
    ;;
  esac
}

function main() {
  local pid
  pid=$(get_pid)

  if [ "$pid" == "" ]; then
    exit 0
  fi

  local kill_option=$(kill_menu)

  kill_process "$pid" "$kill_option"
}

main
