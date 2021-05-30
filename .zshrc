# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' file-sort name
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=* r:|=*'
zstyle ':completion:*' menu select=0
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/home/mrmojo/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.local/share/zsh/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt autocd beep
bindkey -e
# End of lines configured by zsh-newuser-install

# History control
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
[[ -n "${key[Up]}"  ]] && bindkey "${key[Up]}" up-line-or-beginning-search
[[ -n "${key[Down]}"  ]] && bindkey "${key[Down]}" down-line-or-beginning-search

# Theme
source ~/.config/zsh/theme/home.zsh-theme

# Quit
alias :q=exit
