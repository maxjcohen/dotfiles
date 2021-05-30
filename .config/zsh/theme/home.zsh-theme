setopt PROMPT_SUBST
export VIRTUAL_ENV_DISABLE_PROMPT=1

PROMPT=""

# User and machine name
PROMPT+="%F{green}%n@%m%f:"

# Current directory
PROMPT+="%F{blue}%1~%f "

# Git status
function git_branch(){
    ref=$(git symbolic-ref --short --quiet HEAD 2>/dev/null)
    if [ -n "${ref}" ]; then
	if [ ! -n "$(git status --porcelain)" ]; then
		local status_color="%F{green}"
	else
		local status_color="%F{yellow}"
	fi
        echo "$status_color($ref)%f "
    fi
}
PROMPT+='$(git_branch)'

# Virtualenv currently activated
prompt_virtualenv() {
  if [[ -n $VIRTUAL_ENV  ]]; then
      echo "%F{#d08770}[$(basename $VIRTUAL_ENV)]%f "
  fi
}
PROMPT+='$(prompt_virtualenv)'

# Exit code color
PROMPT+="%(?.%F{green}.%F{red}(%?%))%(!.#.>)%f "
