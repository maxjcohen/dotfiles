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
[[ -n "${key[Up]}"  ]] && bindkey "${key[Up]}" up-line-or-beginning-search || bindkey "[A" up-line-or-beginning-search
[[ -n "${key[Down]}"  ]] && bindkey "${key[Down]}" down-line-or-beginning-search || bindkey "[B" down-line-or-beginning-search

# Latex paths (perl scripts)
PATH="/home/mrmojo/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/mrmojo/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/mrmojo/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/mrmojo/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/mrmojo/perl5"; export PERL_MM_OPT;
export PATH=$PATH:~/libs/latexindent.pl/

# Theme
source ~/.config/zsh/theme/home.zsh-theme

# Colordir for nord theme
test -r ~/.dir_colors && eval $(dircolors ~/.dir_colors)

# Alias
alias ls='ls --color=auto'
alias grep='grep --color=auto'

alias :q=exit
