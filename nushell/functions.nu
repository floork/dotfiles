# ex - archive extractor
# usage: ex <file>
def ex [file] {
    match $file {
        (*.7z) => { 7z x $file }
        (*.bz2) => { bunzip2 $file }
        (*.tar.bz2) => { tar xjf $file }
        (*.tar.gz) => { tar xzf $file }
        (*.tar.xz) => { tar xJf $file }
        (*.rar) => { unrar $file }
        (*.gz) => { gunzip $file }
        (*.tar) => { tar xf $file }
        (*.tbz2) => { tar xjf $file }
        (*.tgz) => { tar xzf $file }
        (*.zip) => { unzip $file }
        (*.Z) => { uncompress $file }
        _ => { echo "'$file' cannot be extracted via ex()" }
    }
}

def compress [source format ...rest] {
    let output = $source + "." + $format
    match $format {
        7z => { 7z a $output $source }
        bz2 => { tar -cjvf $output $source }
        gz => {
            gzip $source
            mv $source.gz $output
        }
        rar => { rar a $output $source }
        tbz2 => {
            tar -cjvf $output $source
            mv $source.tbz2 $output
        }
        tgz => { tar -czvf $output $source }
        tar => { tar -cvf $output $source }
        tar.bz2 => { tar -cjvf $output $source }
        tar.gz => { tar -czvf $output $source }
        tar.xz => { tar -cJvf $output $source }
        _ => { echo "Unsupported format: $format" }
    }

    echo "Compression complete: $output"
}

def gt-push [message] {
    git add .
    git commit -m $message
    git pull
    git push
}

# def pack_man [] {
#     def rpkm_arch [] {
#         let packages = (paru -Qdtq)
#         for pkg in $packages {
#             (paru -Rns $pkg)
#         }
#     }
#
#     if (which apk) {
#         alias pkm = sudo apk add --no-cache
#     } else if (which apt) {
#         alias pkm = sudo apt install
#         alias rpkm = sudo apt remove
#         alias rpkmcleanup = sudo apt autoremove
#         alias packdate = sudo apt -y update
#     } else if (which dnf) {
#         alias pkm = sudo dnf install 
#         alias rpkm = sudo dnf remove 
#         alias rpkmcleanup = sudo dnf -y autoremove
#         alias packdate = sudo dnf -y upgrade --refresh
#     } else if (which zypper) {
#         alias pkm = sudo zypper install 
#     } else if (which paru) {
#         alias pkm = paru -S 
#         alias rpkm = paru -Rdd
#         alias pacman-update = sudo pacman-mirrors --geoip
#         alias rpkmcleanup = rpkm_arch # Cleanup orphaned packages
#         alias fixpacman = sudo rm /var/lib/pacman/db.lck
#         alias pkmgrade = paru --noconfirm -Syu
#         # get fastest mirrors
#         alias mirror = sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist
#         alias mirrord = sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist
#         alias mirrors = sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist
#         alias mirrora = sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist
#     } else if (which nix-env) {
#         alias pkm = nix-env -iA
#         alias rpkm = nix-env -e
#         alias rpkmcleanup = nix-collect-garbage -d
#         alias packdate = nix-channel --update
#     } else {
#         echo "This Distro is not supported!"
#     }
# }

# def frm [path] {
#     echo "Are you sure you want to delete [$path]? (y/N): "
#     let response = (stdin() | lines | first)
#     echo "" # move to a new line
#     if $response == "y" || $response == "Y" {
#         rm -rf $path
#         echo "Deleted [$path]"
#     } else {
#         echo "Aborted."
#     }
# }

# def build-cpp [] {
#     # Check if current directory is named "build"
#     if (path.basename (os.path.pwd)) != "build" {
#         if (path.exists "build") {
#             cd build
#         } elif (path.exists "CMakeLists.txt") {
#             mkdir build; cd build
#         } else {
#             echo "No C++ project found in this directory!"
#             return
#         }
#     }
#
#     # Check if cmake is installed
#     if not (which cmake) {
#         echo "cmake could not be found"
#         return
#     }
#
#     cmake ..
#
#     echo "Building C++ project..."
#     # not pretty but zsh doesn't like when defining prefix to /bin/mold
#     if (which /bin/mold) {
#         if (path.exists "CMakeCache.txt") {
#             /bin/mold --run cmake --build . -- $args
#         } elif (path.exists "Makefile") {
#             /bin/mold --run make -j (sysctl -n hw.ncpu) $args
#         } elif (path.exists "build.ninja") {
#             /bin/mold --run ninja $args
#         } else {
#             echo 'Could not determine a suitable build command!' | stderr
#         }
#
#         return
#     }
#
#     if (path.exists "CMakeCache.txt") {
#         cmake --build . -- $args
#     } else if (path.exists "Makefile") {
#         make -j (sysctl -n hw.ncpu) $args
#     } else if (path.exists "build.ninja") {
#         ninja $args
#     } else {
#         echo 'Could not determine a suitable build command!' | stderr
#     }
# }

def kill-tmux-sessions [] {
    if $env.TMUX {
        tmux list-sessions | lines | where { str contains --not "attached" } | each { |session| tmux kill-session -t $session }
    } else {
        echo "Not in a tmux session"
    }
}

def new [] {
    # Find directories in both the regular home directory and specific home directory
    let directories = directories=$(fd -t d -E .git -E node_modules --exclude Downloads --base-directory ~)
    let my_home = (path.home)
    directories += $my_home

    # Use fzf to select a directory from the list
    let dir = $directories | fzf
    if $dir {
        if $dir == $my_home {
            cd $dir
        } else {
            cd ($my_home + "/" + $dir)
        }
        if $env.TMUX {
            tmux rename-window (path.basename $dir)
        }
    }
}

def note [filetype] {
    # Open a note file with the specified filetype in vim
    vim ("+set ft=" + $filetype) ("/tmp/note." + $filetype)
}

# pack_man
