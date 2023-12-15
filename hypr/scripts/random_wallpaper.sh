#!/usr/bin/env bash

wallpapers_dir=~/.config/wallpapers/
if [ ps aux | grep swaybg | grep -v grep | wc -l -gt 0 ]; then
    killall swaybg
fi
swaybg -i $(find $wallpapers_dir -type f | shuf -n1) -m fill &
OLD_PID=$!
while true; do
    sleep 600
    swaybg -i $(find $wallpapers_dir -type f | shuf -n1) -m fill &
    NEXT_PID=$!
    sleep 5
    kill $OLD_PID
    OLD_PID=$NEXT_PID
done
