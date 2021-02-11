
" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.


""""""""""""""""""""""""""""""""""""""""
" Source local settings
""""""""""""""""""""""""""""""""""""""""


runtime! debian.vim

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif


""""""""""""""""""""""""""""""""""""""""
" Install pluggins
""""""""""""""""""""""""""""""""""""""""


" Install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Pluggin loading
call plug#begin('~/.vim/plugged')

" Theme / UI
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'arcticicestudio/nord-vim'

" Mappings
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Tmux
Plug 'christoomey/vim-tmux-navigator'
Plug 'christoomey/vim-tmux-runner'

" Python
Plug 'jeetsukumaran/vim-pythonsense'
Plug 'Vimjas/vim-python-pep8-indent'

" Misc
Plug 'tmhedberg/SimpylFold'
Plug 'jiangmiao/auto-pairs'
Plug 'ervandew/supertab'

call plug#end()

" Enable filetype detection for plugins and indentation options
filetype plugin indent on


""""""""""""""""""""""""""""""""""""""""
" Configure pluggins
""""""""""""""""""""""""""""""""""""""""


" UltiSnips settings
let g:UltiSnipsExpandTrigger       = "<c-j>"
let g:UltiSnipsJumpForwardTrigger  = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-p>"
let g:ultisnips_python_style="numpy"

" Netrw settings
let g:netrw_browse_split = 0
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_altv = 0
let g:netrw_winsize = 50
let g:netrw_list_hide=netrw_gitignore#Hide()

" Autopairs settings
" Add shortcut for jumping out of pairs
inoremap <C-k> <esc>:call AutoPairsJump()<CR>a
" Show matching brackets.
set showmatch

" Tmux settings
let g:VtrStripLeadingWhitespace = 0
let g:VtrClearEmptyLines = 0
let g:VtrAppendNewline = 1
noremap <Leader>rf :VtrSendFile<cr>
noremap <Leader>rr :VtrSendLinesToRunner<cr>

" Ctrl-P replacer
set wildmenu
set path+=** " Add subdirectories to path
nnoremap <C-p> :find *
set wildignore+=*.pyc,*.ipynb,**/.git/**,**/.env/**

" Theme / UI
try
    colorscheme nord
    let g:airline_theme='nord'
catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme default
    set background=dark
endtry
" Syntax highlighting
if has("syntax")
  syntax on
endif
" Always display status line
set laststatus=2
set cursorline
" Set Vim-specific sequences for RGB colors
if exists('+termguicolors')
    set termguicolors
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif


""""""""""""""""""""""""""""""""""""""""
" Buffer and tab management
""""""""""""""""""""""""""""""""""""""""


" Automatically save before commands like :next and :make
set autowrite
" Hide buffers when they are abandoned
set hidden
" Disable backup and swap, we have git for that
set nobackup
set noswapfile
" Jump to last position on reload
au BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$")
      \ | exe "normal! g'\""
      \ | endif
" New terminal with :tab ter and switch with <C-k>
" In case there's no tmux !
tnoremap <C-k> <C-w>Ngt
nnoremap <C-k> gt


""""""""""""""""""""""""""""""""""""""""
" In-file searching
""""""""""""""""""""""""""""""""""""""""


" Clear search highlight with ESC
nnoremap <esc><esc> :noh<return><esc>
set incsearch
set hlsearch
set ignorecase
set smartcase


""""""""""""""""""""""""""""""""""""""""
" Tabs
""""""""""""""""""""""""""""""""""""""""


" Default tabs
set autoindent
set smarttab
set softtabstop=4
set shiftwidth=4
set complete+=]


""""""""""""""""""""""""""""""""""""""""
" Languages specifics
""""""""""""""""""""""""""""""""""""""""

if has("autocmd")
    " LaTex
    au FileType tex set linebreak
    au FileType tex compiler tex
    au FileType tex set makeprg=pdflatex\ --shell-escape\ %
    au FileType tex let b:AutoPairs = AutoPairsDefine({'$' : '$'})
    au FileType tex set spell

    " Python
    au FileType python set expandtab
    au FileType python set textwidth=88
    au FileType python set colorcolumn=+1
    au FileType python set foldmethod=indent
    au FileType python set foldcolumn=0
    au FileType python set formatoptions=
    au FileType python let b:AutoPairs = AutoPairsDefine({"f'" : "'", "r'" : "'", "b'" : "'"})
    au FileType python compiler python

    " CVS
    au FileType csv set nowrap

    " Git
    au FileType gitcommit set spell

endif

" LaTeX
let g:tex_flavor = "latex"
let g:tex_conceal='abdmg'
set conceallevel=1
command -range LatexIndent :<line1>,<line2>!latexindent.pl <NL> :<line1>,<line2>retab
" function! IndentLatex()
"     :silent !latexindent.pl
"     :'<,'>retab
"     :redraw!
" endfunction


" Python
" Load virtualenv
py3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  with open(activate_this, "r") as f:
    exec(f.read(), dict(__file__=activate_this))
EOF

" HTML cleaning
function! HTMLClean()
  normal! ggVGJ " Join all lines
  :s/> \+\([^ ]\)/>\1/g " Remove space after tags
  :s/\([^ ]\) \+</\1</g " Remove space before tags
  :s/></>\r</g " Add CR after each tag
  normal! G=gg " Auto indent file
endfunction
command! HTMLClean :call HTMLClean()


""""""""""""""""""""""""""""""""""""""""
" Misc
""""""""""""""""""""""""""""""""""""""""


" Remove trailing spaces
autocmd BufWritePre * %s/\s\+$//e

" Change learder key
nnoremap <Space> <Nop>
let mapleader = "\<Space>"
nnoremap <Leader>sop :source ~/.vimrc<cr>

" Scroll 4 lines bellow cursor
set scrolloff=10
" Show (partial) command in status line.
set showcmd
set number
set encoding=utf8
" Make backspace behave as expected
set backspace=eol,indent,start

" Reload a file when it is changed from the outside
set autoread

set foldlevel=99

" English correcting
set spelllang=en
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

set updatetime=300

" For invisibles
set listchars=tab:▸\ ,eol:¬

if executable('black')
    noremap <Leader>k m`:%!black -q -<CR>``
endif

