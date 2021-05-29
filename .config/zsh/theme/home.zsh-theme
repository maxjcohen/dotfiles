setopt PROMPT_SUBST

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

# Exit code color
PROMPT+="%(?.%F{green}.%F{red})>%f "
