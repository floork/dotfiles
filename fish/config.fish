
# My fish config. Not much to see here; just some pretty standard stuff.

### ADDING TO THE PATH
# First line removes the path; second line sets it. Without the first line,
# your path gets massive and fish becomes very slow.
set -e fish_user_paths
set -U fish_user_paths $HOME/.local/bin $HOME/Applications $fish_user_paths

set -gx PATH /home/flmr799e/.npm-global/lib/node_modules/.bin $PATH

# Add flatpak exports to PATH
set -l xdg_data_home $XDG_DATA_HOME ~/.local/share
set -gx --path XDG_DATA_DIRS $xdg_data_home[1]/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/local/share:/usr/share

# bitwarden
set -gx BW_SESSION "azcZ7pEiaAh4cB5DLpUmhCyQOr/8MOYQGshnK2G2hLbxqw3XMWxIWqLK4QF110YsYw7iWJtva4DScITpnd4/PA=="

for flatpakdir in ~/.local/share/flatpak/exports/bin /var/lib/flatpak/exports/bin
    if test -d $flatpakdir
        contains $flatpakdir $PATH; or set -a PATH $flatpakdir
    end
end

# Rustup shell setup
# Affix colons on either side of $PATH to simplify matching
set -gx PATH "$HOME/.cargo/bin" $PATH

## EXPORT ###
set fish_greeting # Supresses fish's intro message
set TERM xterm-256color # Sets the terminal type
set -Ux EDITOR lvim # $EDITOR use vim in terminal
set VISUAL lvim

### AUTOCOMPLETE AND HIGHLIGHT COLORS ###
set fish_color_normal brcyan
set fish_color_autosuggestion '#7d7d7d'
set fish_color_command brcyan
set fish_color_error '#ff6c6b'
set fish_color_param brcyan

### FUNCTIONS ###

function sudo_prev_command
    eval (history --search-backward "")
end

# Function for git push
function gt-push # This is the function name and command we call
    git --git-dir=$PWD/.git add . # Stage all unstaged files
    git --git-dir=$PWD/.git commit -a -m $argv # Commit files with the given argument as the commit message
    git --git-dir=$PWD/.git pull # Pull to remote
    git --git-dir=$PWD/.git push # Push to remote
end

function pack_man
    if [ -x "$(command -v apk)" ]
        alias pkm='sudo apk add --no-cache '
    else if [ -x "$(command -v apt-get)" ]
        alias pkm='sudo apt install '
        alias rpkm='sudo apt remove'
        alias cleanup='sudo apt autoremove'
        alias pkmgrade='sudo apt -y update && flatpak -y --noninteractive update'
    else if [ -x "$(command -v dnf)" ]
        alias pkm='sudo dnf install '
        alias rpkm='sudo dnf remove '
        alias cleanup='sudo dnf -y autoremove'
        alias pkmgrade='sudo dnf -y upgrade --refresh'
    else if [ -x "$(command -v zypper)" ]
        alias pkm='sudo zypper install '
    else if [ -x "$(command -v paru)" ]
        alias pkm="paru -S "
        alias rpkm='paru -Rdd'
        alias pacman-update='sudo pacman-mirrors --geoip'
        alias cleanup='sudo pacman -Rns (pacman -Qtdq) && paru -yc' # Cleanup orphaned packages
        alias fixpacman="sudo rm /var/lib/pacman/db.lck"
        alias pkmgrade='paru --noconfirm -Syu && sudo flatpak -y --noninteractive update'
        # get fastest mirrors
        alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
        alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
        alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
        alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save
 /etc/pacman.d/mirrorlist"
    else
        echo 'This Distro is not supported!'
    end
end

function frm
    read -p "Are you sure you want to delete? (y/n): " -l response
    if test "$response" = "y" -o "$response" = "Y"
        command rm -rf $argv
    else
        echo "Aborted."
    end
end

function sudo --description "Replacement for Bash 'sudo !!' command to run last command using sudo."
    if test "$argv" = !!
        echo sudo $history[1]
        eval command sudo $history[1]
    else
        command sudo $argv
    end
end

pack_man

### END OF FUNCTIONS ###

alias reload='source ~/.config/fish/config.fish'
alias frm=frm
alias ex=extract
alias !!=sudo_prev_command

# Include all aliases
[ -f ~/.zsh/aliasrc ] && source ~/.zsh/aliasrc

### SETTING THE STARSHIP PROMPT ###
starship init fish | source
