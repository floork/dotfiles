# Download Znap, if it's not there yet.
[[ -r ~/.zsh/plugins/znap/znap.zsh ]] ||
  git clone --depth 1 -- \
    https://github.com/marlonrichert/zsh-snap.git ~/.zsh/plugins/znap
source ~/.zsh/plugins/znap/znap.zsh # Start Znap

znap source zsh-users/zsh-syntax-highlighting
znap source marlonrichert/zsh-autosuggestions
# znap source arzzen/calc.plugin.zsh
# znap source jeffreytse/zsh-vi-mode
# znap source chisui/zsh-nix-shell
# znap source nix-community/nix-zsh-completions

export ZSH_AUTOSUGGEST_HISTORY_IGNORE=" *"
