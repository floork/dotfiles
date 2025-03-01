autoload -Uz colors && colors
setopt prompt_subst
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Newline between prompts
precmd() { print "" }

# Symbols for OS Detection
os_icon() {
  case "$(uname -s)" in
    Linux*)   echo "";;
    Darwin*)  echo "󰀵";;
    *)        echo "🖥";;
  esac
}

# Git Branch Info
git_info() {
  local branch
  branch=$(git symbolic-ref --short HEAD 2>/dev/null)
  [[ -n "$branch" ]] && echo "%F{green}on  $branch%f"
}

# Git Status
git_status() {
  local git_state
  git_state=$(git status --porcelain 2>/dev/null)
  if [[ -n "$git_state" ]]; then
    echo "%F{yellow}%f"
  fi
}

# Show Python Virtual Environment
python_env() {
  [[ -n "$VIRTUAL_ENV" ]] && echo "%F{cyan}($(basename $VIRTUAL_ENV))%f"
}

# Prompt Structure
PROMPT='
%F{yellow}╭─%n@%m at %F{cyan} %~%f $(python_env) $(git_info) $(git_status)
%F{yellow}╰─$(os_icon)%f '
