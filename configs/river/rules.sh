#!/bin/sh

workspace1=1
workspace2=2
workspace3=4
workspace4=8
workspace5=16
workspace6=32
# workspace7=64
# workspace8=128
# workspace9=256

# General window rules
riverctl rule-add -app-id "popup" float # Generic, might need refinement
# riverctl rule-add -app-id "popup" stick # If you want popups to be sticky

riverctl rule-add -app-id "xwaylandvideobridge" float
riverctl rule-add -app-id "kruler" float
riverctl rule-add -app-id "Gromit-mpx" float
riverctl rule-add -app-id "Gromit-mpx" stick

# Tag 1: Terminals
riverctl rule-add -app-id "com.mitchellh.ghostty" tags "$workspace1"
riverctl rule-add -app-id "wezterm" tags "$workspace1"
riverctl rule-add -app-id "alacritty" tags "$workspace1"
riverctl rule-add -app-id "warp-terminal" tags "$workspace1"

# Tag 2: Browsers
riverctl rule-add -app-id "brave-browser" tags "$workspace2"   # Use lswt to confirm
riverctl rule-add -app-id "firefox" tags "$workspace2"
riverctl rule-add -app-id "zen" tags "$workspace2"
riverctl rule-add -app-id "zen-browser" tags "$workspace2"     # If this is a separate app-id

# Tag 3: Mail
riverctl rule-add -app-id "thunderbird" tags "$workspace3"
riverctl rule-add -app-id "betterbird" tags "$workspace3"

# Tag 4: Music
riverctl rule-add -app-id "spotify" tags "$workspace4"

# Tag 5: Chat/Comms
riverctl rule-add -app-id "discord" tags "$workspace5"
riverctl rule-add -app-id "legcord" tags "$workspace5"
riverctl rule-add -app-id "element" tags "$workspace5"

# Tag 6: Notes
riverctl rule-add -app-id "obsidian" tags "$workspace6"
