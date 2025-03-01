autoload -Uz colors && colors
setopt prompt_subst

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
  branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  [[ -n "$branch" ]] && echo "%F{green}on  $branch%f"
}

# Git Status
git_status() {
  local git_status_output ahead behind
  git_status_output="$(git status --porcelain=v2 2>/dev/null)"
  ahead="$(git rev-list --count @{upstream}..HEAD 2>/dev/null)"
  behind="$(git rev-list --count HEAD..@{upstream} 2>/dev/null)"

  [[ -n "$git_status_output" ]] && echo "%F{yellow}%f"
  [[ $ahead -gt 0 ]] && echo "%F{red}⇡$ahead%f"
  [[ $behind -gt 0 ]] && echo "%F{blue}⇣$behind%f"
}

# Show Python Virtual Environment
python_env() {
  [[ -n "$VIRTUAL_ENV" ]] && echo "%F{cyan}($(basename $VIRTUAL_ENV))%f"
}

# Prompt Structure
PROMPT='
%F{yellow}╭─%n@%m at %F{cyan} %~%f $(python_env) $(git_info) $(git_status)
%F{yellow}╰─$(os_icon)%f '
