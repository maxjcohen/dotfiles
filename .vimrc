" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.

runtime! debian.vim

" Pluggin loading
call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'sheerun/vim-polyglot'
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'tmhedberg/SimpylFold'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'bling/vim-bufferline'
Plug 'airblade/vim-gitgutter'
Plug 'lambdalisue/battery.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

call plug#end()

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" Theme/interface
let g:airline_theme='simple'
set background=dark
if has("syntax")
  syntax on
endif
colorscheme challenger_deep
set cursorline

"python with virtualenv support
py3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  with open(activate_this, "r") as f:
    exec(f.read(), dict(__file__=activate_this))
EOF

set encoding=utf-8

" Uncomment the following to have Vim jump to the last position when
" reopening a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
filetype plugin indent on

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set hidden		" Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)
set hlsearch

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

" Display line number
:set number

" Folding method
set foldmethod=indent
set foldlevel=99

set wildmenu

let g:ycm_autoclose_preview_window_after_insertion = 1
