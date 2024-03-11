# Regular alias
alias please = please_function
alias fuck = please
alias fck = please
alias reboot = sudo reboot
alias poweroff = sudo poweroff
alias shutdown = sudo shutdown now
alias suspend = systemctl suspend
alias cls = clear
alias ende = suspend and exit
alias tree = lsd --tree --icon always --color always # tree listing
alias vi = nvim
alias vim = vi
alias svim = sudo -E nvim

# sys
alias sctl = sudo systemctl
alias blkid = sudo blkid -o export
alias dlist = sudo blkid -o list
alias updatehosts = sudo cp /home/flmr799e/Documents/server/hosts /etc/hosts
alias hosts = nvim /home/flmr799e/Documents/server/hosts and updatehosts
alias fontsReload = fc-cache -f -v
alias fontsList = fc-list

# copy and moving
alias cd.. = cd ..
alias rm = trash-put
# alias rm = rm -r
# alias frm = rm -rf
alias copy = copy_function
alias cp = cp -r
# alias mvSame = rsync -av --progress --exclude=$1 $2 --remove-source-files --prune-empty-dirs $3
alias scp = sudo cp -r
alias open = xdg-open

# Changing "ls" to "exa"
alias l = ls
alias ls = lsd --icon always --color always --group-dirs first # my preferred listin
alias ll = lsd -l --icon always --color always --group-dirs first # long forma
alias la = lsd -a --icon always --color always --group-dirs first # all files and dir
alias lal = lsd -la --icon always --color always --group-dirs first # long format all files and dir
alias lg = lsd --git --long --icon always --color always --group-dirs first # Display git status. Directory git status is a reduction of included file statuses (recursively).
alias lr = lsd -aR --icon always --color always --group-dirs first # list recursively
alias lt = tree # tree listing

# help and history
alias h = history
alias help = man

# git
alias gt-switch = git switch
alias gt-merge = git merge
alias gt-c = git clone
alias gt-undocommit = git reset HEAD~
alias gt-newbranch = git switch -c
alias gt-delbranch = git branch -d
alias gt-log = git log --oneline --decorate --graph --all
alias gt-logall = git log --oneline --decorate --graph --all --full-history --simplify-by-decoration
alias gt-legacyNewBranch = git checkout -b
alias gt-legacySwitchBranch = git checkout

# Brave fix
alias fixBrave = rm -r cd ~/.config/BraveSoftware/Brave-Browser/SingletonLock

# Flatpak alias
alias flatty = flatpak install flathub
alias rflatty = flatpak remove

# tmux
alias tmuxrc = nvim ~/.tmux.conf # Quick access to the ~/.tmux.conf file

# shell alias
alias zshrc = zshrc_function
alias bashrc = bashrc_function
alias fishrc = fishrc_function
alias nushellrc = nushellrc_function

# nix alias
alias nixrc = nixrc_function
alias nixsearch = nix-env -qaP
alias desktopbuild = sudo nixos-rebuild switch --flake .#desktop
alias laptopbuild = sudo nixos-rebuild switch --flake .#laptop

# dev alias
alias cval = cval_function

# shorcuts
alias sshrc = sshrc_function
alias vimrc = vimrc_function
alias dotfiles = dotfiles_function
alias gitconfig = gitconfig_function

# Define the functions
def please_function [] {
    fc -ln -1 | sudo -
}

def cval_function [arg] {
    make and valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes --verbose $arg err> valgrind.log
}

def zshrc_function [] {
    cd ~/dotfiles/zsh ; nvim ~/dotfiles/zsh/zshrc # Quick access to the ~/.zshrc file
}

def bashrc_function [] {
    cd ~/dotfiles/bash ; nvim ~/dotfiles/bash/bashrc # Quick access to the ~/.bashrc file
}

def fishrc_function [] {
    cd ~/dotfiles/fish ; nvim ~/dotfiles/fish/fishrc # Quick access to the ~/.fishrc file
}

def nushellrc_function [] {
    cd ~/dotfiles/nushell/ ; nvim ~/dotfiles/nushell/config.nu
}

def nixrc_function [] {
    cd /etc/nixos ; nvim /etc/nixos/
}

def sshrc_function [] {
    cd ~/.ssh ; nvim ~/.ssh/config
}

def vimrc_function [] {
    cd ~/.config/nvim ; nvim .
}

def dotfiles_function [] {
    cd ~/dotfiles ; nvim .
}

def gitconfig_function [] {
    cd ~/dotfiles/git ; nvim ~/.gitconfig
}
