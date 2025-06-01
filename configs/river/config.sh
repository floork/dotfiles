#!/bin/sh

# Start the layout generator
riverctl spawn "rivercarro -inner-gaps 6 -outer-gaps 6"
riverctl keyboard-layout -options caps:swapescape us
riverctl input pointer-1739-0-Synaptics_TM3289-021 natural-scroll enabled

# Set the default layout
riverctl default-layout rivercarro
riverctl focus-follows-cursor normal

# Set border width (e.g., 2 pixels). Adjust as you like.
riverctl border-width 2

# Set focused window border color to white
# Colors are specified as 0xRRGGBB hexadecimal values
riverctl border-color-focused 0xFFFFFF

# Optional: Set unfocused window border color (e.g., a dark grey or black)
# This helps distinguish the focused window even more.
riverctl border-color-unfocused 0x333333
