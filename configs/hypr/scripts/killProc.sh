#!/bin/env bash

function app_launch() {
  # Adjust command for specific launcher
  if [ "$APP_LAUNCHER" == "wofi" ]; then
    launcher_cmd="$APP_LAUNCHER --show dmenu -i -p 'Select a process: '"
  elif [ "$APP_LAUNCHER" == "fuzzel" ]; then
    launcher_cmd="$APP_LAUNCHER --dmenu -p 'Select a process: '"
  elif [ "$APP_LAUNCHER" == "walker" ]; then
    launcher_cmd="$APP_LAUNCHER --dmenu -p 'Select a process: '"
  fi
}

function get_pid() {
  ps --user $(id --user) -o pid,user,comm | sed '1d' | $launcher_cmd | awk '{print $1}'
}

function kill_menu() {
  local options=("Kill" "Force" "Killall" "Cancel")

  local selected=$(echo "${options[@]}" | tr ' ' '\n' | $launcher_cmd)
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
  Killall)
    killall -9 "$pid"
    ;;
  esac
}

function main() {
  app_launch
  local pid
  pid=$(get_pid)

  if [ "$pid" == "" ]; then
    exit 0
  fi

  local kill_option=$(kill_menu)

  kill_process "$pid" "$kill_option"
}

main
