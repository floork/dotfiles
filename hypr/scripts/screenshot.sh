#!/bin/bash

TARGET="$HOME/Pictures/Screenshots"

BETTER_DATE=$(date +%d.%m.%Y-%H:%M:%S)

if [ ! -d "$TARGET" ]; then
	mkdir -p "$TARGET"
fi

# grim -g "$(slurp)" "$TARGET/$(date +%s).png" | wl-copy -t image/png
grim -g "$(slurp)" "$TARGET/$BETTER_DATE.png" && cat "$TARGET/$BETTER_DATE.png" | wl-copy -t image/png
