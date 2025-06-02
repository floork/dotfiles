#!/bin/sh

mainMod=Super
APP_LAUNCHER="wofi"
APP_LAUNCHER_DMENU="${APP_LAUNCHER} -d"

# Basic window management
riverctl map normal "$mainMod" Q close
riverctl map normal "$mainMod" F toggle-fullscreen
riverctl map normal "$mainMod"+Shift F toggle-float

# Focus movement
riverctl map normal "$mainMod" H focus-view left
riverctl map normal "$mainMod" L focus-view right
riverctl map normal "$mainMod" K focus-view up
riverctl map normal "$mainMod" J focus-view down

# Window swapping
riverctl map normal "$mainMod"+Shift H swap left
riverctl map normal "$mainMod"+Shift L swap right
riverctl map normal "$mainMod"+Shift K swap up
riverctl map normal "$mainMod"+Shift J swap down

# Layout control
riverctl map normal "$mainMod"+Control H send-layout-cmd rivercarro "set-main-size -0.05"
riverctl map normal "$mainMod"+Control L send-layout-cmd rivercarro "set-main-size +0.05"
riverctl map normal "$mainMod"+Control K send-layout-cmd rivercarro "focus-cycle next"
riverctl map normal "$mainMod"+Control J send-layout-cmd rivercarro "focus-cycle prev"

# Application Launchers
riverctl map normal "$mainMod" X spawn "ghostty" # Assuming ghostty is your terminal
riverctl map normal "$mainMod" Space spawn "$APP_LAUNCHER"
riverctl map normal "$mainMod" E spawn "thunar"
riverctl map normal "$mainMod" N spawn "obsidian"
riverctl map normal "$mainMod" V spawn "bash -c 'cliphist list | $APP_LAUNCHER_DMENU | cliphist decode | wl-copy'"
riverctl map normal "$mainMod" M spawn "thunderbird"
riverctl map normal "$mainMod" S spawn "spotify" # Re-added for clarity in this section

# Media and Communication:
riverctl map normal "$mainMod" A spawn "pavucontrol"
riverctl map normal "$mainMod" B spawn "zen" # Using the nixos 'zen'
riverctl map normal "$mainMod" D spawn "legcord"
riverctl map normal "$mainMod" O spawn "bash ~/.local/bin/bemoji"
riverctl map normal "$mainMod" R spawn "kruler"
riverctl map normal "$mainMod"+Shift B spawn "blueman-manager"
riverctl map normal "$mainMod"+Shift E spawn "element-desktop"

# System and Utility:
riverctl map normal "$mainMod" P spawn "powermenu"
riverctl map normal "$mainMod"+Shift S spawn "grimblast copysave area \"$HOME/Pictures/Screenshots/$(date +%d.%m.%Y-%H:%M:%S).png\""
riverctl map normal "$mainMod"+Shift R spawn "pkill waybar && waybar &" || waybar
riverctl map normal "$mainMod"+Shift K spawn "killProc"

# Lock:
riverctl map normal "$mainMod"+Shift I spawn "hyprlock"

# Pyprpaper (Assuming pypr is available)
riverctl map normal "$mainMod" Z spawn "pypr zoom ++0.5"
riverctl map normal "$mainMod"+Shift Z spawn "pypr zoom"
riverctl map normal "$mainMod"+Mod1 M spawn "pypr toggle_dpms" # Mod1 is Alt

# Media controls (using keysym names)
riverctl map normal None XF86AudioPlay spawn "playerctl play-pause"
riverctl map normal None XF86AudioPrev spawn "playerctl previous"
riverctl map normal None XF86AudioNext spawn "playerctl next"
riverctl map normal None XF86AudioMute spawn "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle" # Using wpctl for PipeWire
riverctl map --repeat normal None XF86AudioRaiseVolume spawn "wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+"
riverctl map --repeat normal None XF86AudioLowerVolume spawn "wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"
riverctl map --repeat normal None XF86MonBrightnessUp spawn "brightnessctl set +1%"
riverctl map --repeat normal None XF86MonBrightnessDown spawn "brightnessctl set 1%-"

# Switch workspaces (tags in River)
# Tags are bitmasks, 1=tag 1, 2=tag 2, 4=tag 3, 8=tag 4, etc.
# So workspace 1 is tag bit 0 (value 1), workspace 2 is tag bit 1 (value 2), etc.
# (1 << (tag_num - 1))
riverctl map normal "$mainMod" 1 set-focused-tags 1  # Workspace 1
riverctl map normal "$mainMod" 2 set-focused-tags 2  # Workspace 2
riverctl map normal "$mainMod" 3 set-focused-tags 4  # Workspace 3
riverctl map normal "$mainMod" 4 set-focused-tags 8  # Workspace 4
riverctl map normal "$mainMod" 5 set-focused-tags 16 # Workspace 5
riverctl map normal "$mainMod" 6 set-focused-tags 32 # Workspace 6
riverctl map normal "$mainMod" 7 set-focused-tags 64 # Workspace 7
riverctl map normal "$mainMod" 8 set-focused-tags 128 # Workspace 8
riverctl map normal "$mainMod" 9 set-focused-tags 256 # Workspace 9
riverctl map normal "$mainMod" 0 set-focused-tags 512 # Workspace 10 (tag bit 9)

# Move active window to a workspace (tag)
riverctl map normal "$mainMod"+Shift 1 set-view-tags 1
riverctl map normal "$mainMod"+Shift 2 set-view-tags 2
riverctl map normal "$mainMod"+Shift 3 set-view-tags 4
riverctl map normal "$mainMod"+Shift 4 set-view-tags 8
riverctl map normal "$mainMod"+Shift 5 set-view-tags 16
riverctl map normal "$mainMod"+Shift 6 set-view-tags 32
riverctl map normal "$mainMod"+Shift 7 set-view-tags 64
riverctl map normal "$mainMod"+Shift 8 set-view-tags 128
riverctl map normal "$mainMod"+Shift 9 set-view-tags 256
riverctl map normal "$mainMod"+Shift 0 set-view-tags 512
