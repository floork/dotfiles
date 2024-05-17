# Download Znap, if it's not there yet.
[[ -r ~/.zsh/plugins/znap/znap.zsh ]] ||
git clone --depth 1 -- \
https://github.com/marlonrichert/zsh-snap.git ~/.zsh/plugins/znap
source ~/.zsh/plugins/znap/znap.zsh  # Start Znap


znap source z-shell/zsh-navigation-tools
znap source Anant-mishra1729/web-search
znap source zsh-users/zsh-syntax-highlighting
znap source marlonrichert/zsh-autosuggestions
znap source arzzen/calc.plugin.zsh
znap source chisui/zsh-nix-shell

# custom configs
ZSH_WEB_SEARCH_ENGINES=(chatgpt "https://chat.openai.com/", mensa "https://www.studentenwerk-dresden.de/mensen/speiseplan/")
alias chatgpt="web_search chatgpt"
alias mensa="web_search mensa"

