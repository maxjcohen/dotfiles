setopt PROMPT_SUBST
export VIRTUAL_ENV_DISABLE_PROMPT=1

PROMPT=""

# User and machine name
PROMPT+="%F{green}%n@%m%f:"

# Current directory
PROMPT+="%F{blue}%1~%f "

# Git status
function git_branch(){
    # Get branch name
    git_branch=$(git symbolic-ref --short --quiet HEAD 2>/dev/null) || return
    # Get status
    local git_status="$(git status --porcelain | awk '{print $1}')"
    # Assign prompt segment color
    [[ -n $git_status ]] && local status_color='%F{yellow}' || local status_color='%F{green}'
    # Count number of deletion/addition
    local git_removed=$(awk '/D/{cnt++} END {print cnt}' <<< $git_status)
    local git_added=$(awk '/(\?\?)|M/{cnt++} END {print cnt}' <<< $git_status)

    # Compile information
    local prompt="$status_color($git_branch"
    if [[ -n $git_removed ]]; then
 	prompt+=" -$git_removed"
    fi
    if [[ -n $git_added ]]; then
 	prompt+=" +$git_added"
    fi
    prompt+=')%f '
    echo $prompt
}
PROMPT+='$(git_branch)'

# Virtualenv currently activated
function prompt_virtualenv() {
  if [[ -n $VIRTUAL_ENV  ]]; then
      echo "%F{#d08770}[$(basename $VIRTUAL_ENV)]%f "
  fi
}
PROMPT+='$(prompt_virtualenv)'

# Jobs
function prompt_jobs() {
    if [[ -n "$(jobs)" ]]; then
	echo "%F{magenta}[%j]%f "
    fi
}
PROMPT+='$(prompt_jobs)'

# Exit code color
PROMPT+="%(?.%F{green}.%F{red}(%?%))%(!.#.>)%f "
