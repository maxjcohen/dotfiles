# Path
# Latex paths (perl scripts)
PATH="/home/mrmojo/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/mrmojo/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/mrmojo/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/mrmojo/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/mrmojo/perl5"; export PERL_MM_OPT;
export PATH=$PATH:~/libs/latexindent.pl/

# Editor
export EDITOR=vim

# Alias
alias ls='ls -l --color=auto'
alias grep='grep --color=auto'

alias :q=exit
alias fuck="sudo !!"

alias mplayer="mplayer -lavdopts threads=4"
