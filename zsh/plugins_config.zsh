# Download Znap, if it's not there yet.
[[ -r ~/.zsh/plugins/znap/znap.zsh ]] ||
  git clone --depth 1 -- \
    https://github.com/marlonrichert/zsh-snap.git ~/.zsh/plugins/znap
source ~/.zsh/plugins/znap/znap.zsh # Start Znap

znap source z-shell/zsh-navigation-tools
znap source Anant-mishra1729/web-search
znap source zsh-users/zsh-syntax-highlighting
znap source marlonrichert/zsh-autosuggestions
znap source arzzen/calc.plugin.zsh
znap source chisui/zsh-nix-shell
znap source nix-community/nix-zsh-completions
znap source jeffreytse/zsh-vi-mode

# custom configs
ZSH_WEB_SEARCH_ENGINES=(chatgpt "https://chat.openai.com/")
alias chatgpt="web_search chatgpt"

# Disable the cursor style feature
export ZVM_CURSOR_STYLE_ENABLED=false
export ZVM_VI_HIGHLIGHT_FOREGROUND=#1f1d2e
export ZVM_VI_HIGHLIGHT_BACKGROUND=#f6c177
export ZVM_VI_HIGHLIGHT_EXTRASTYLE=bold,underline
