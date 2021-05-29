PS1=""

# User and machine name
PS1+="%F{green}%n@%m%f:"

# Current directory
PS1+="%F{blue}%1~%f "

# Exit code color
PS1+="%(?.%F{green}.%F{red})>%f "
