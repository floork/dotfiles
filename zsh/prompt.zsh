autoload -Uz colors && colors
setopt prompt_subst
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Newline between prompts
precmd() { print "" }

# Symbols for OS Detection
os_icon() {
  case "$(uname -s)" in
    Linux*)   echo "%B%b";;
    Darwin*)  echo "%B󰀵%b";;
    *)        echo "%B🖥%b";;
  esac
}

# Git Branch Info
git_info() {
  local branch
  branch=$(git symbolic-ref --short HEAD 2>/dev/null)
  [[ -n "$branch" ]] && echo "%F{green}%Bon  $branch%b%f"
}

# Git Status
git_status() {
  local git_state
  git_state=$(git status --porcelain 2>/dev/null)
  if [[ -n "$git_state" ]]; then
    echo "%F{yellow}%B%b%f"
  fi
}

# Show Python Virtual Environment
python_env() {
  [[ -n "$VIRTUAL_ENV" ]] && echo "%F{cyan}%B($(basename $VIRTUAL_ENV))%b%f"
}

# Prompt Structure
PROMPT='
%F{yellow}%B╭─%n@%m%b at %F{cyan}%B%~%b%f $(python_env) $(git_info) $(git_status)
%F{yellow}%B╰─$(os_icon)%b%f '
