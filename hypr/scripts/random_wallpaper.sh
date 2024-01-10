#!/usr/bin/env bash

wallpapers_dir=~/.config/wallpapers/
exclude_dir1=~/.config/wallpapers/.git/
exclude_dir2=~/.config/wallpapers/anime/.git/

if [ $(ps aux | grep swaybg | grep -v grep | wc -l) -gt 0 ]; then
    killall swaybg
fi

swaybg -i "$(find "$wallpapers_dir" -type f -not -path "$exclude_dir1*" -not -path "$exclude_dir2*" | shuf -n1)" -m fit &
OLD_PID=$!

while true; do
    sleep 600
    swaybg -i "$(find "$wallpapers_dir" -type f -not -path "$exclude_dir1*" -not -path "$exclude_dir2*" | shuf -n1)" -m fit &
    NEXT_PID=$!
    sleep 5
    kill $OLD_PID
    OLD_PID=$NEXT_PID
done
