" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.

runtime! debian.vim

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

" Pluggin loading
call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'sheerun/vim-polyglot'
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'tmhedberg/SimpylFold'
Plug 'airblade/vim-gitgutter'
Plug 'jiangmiao/auto-pairs'
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'ervandew/supertab'
Plug 'christoomey/vim-tmux-navigator'
Plug 'christoomey/vim-tmux-runner'
Plug 'jeetsukumaran/vim-pythonsense'

call plug#end()

" YouCompleteMe settings
let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
let g:ycm_complete_in_comments = 1 " Completion in comments
let g:ycm_complete_in_strings = 1 " Completion in string
let g:ycm_autoclose_preview_window_after_insertion = 1

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
" inoremap <C-k> <esc>:call AutoPairsJump()<CR>a
set showmatch		" Show matching brackets.

" Tmux settings
let g:VtrStripLeadingWhitespace = 0
let g:VtrClearEmptyLines = 0
let g:VtrAppendNewline = 1
noremap <Leader>rf :VtrSendFile<cr>
noremap <Leader>rr :VtrSendLinesToRunner<cr>

" Ctrl-P replace
set wildmenu
set path+=** " Add subdirectories to path
nnoremap <C-p> :find *
set wildignore+=*.pyc,*.ipynb,**/.git/**,**/.env/**

" Theme/interface
let g:airline_theme='simple'
set background=dark
if has("syntax")
  syntax on
endif
colorscheme challenger_deep
set cursorline

" Buffer and tab management
" New terminal with :tab ter and switch with <C-k>
" In case there's no tmux !
tnoremap <C-k> <C-w>Ngt
nnoremap <C-k> gt
set autowrite		" Automatically save before commands like :next and :make
set hidden		" Hide buffers when they are abandoned
set nobackup " We have git for that
" Jump to last position on reload
au BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$")
      \ | exe "normal! g'\""
      \ | endif

" In-file searching
nnoremap <esc><esc> :noh<return><esc> " Clear search highlight with ESC
set incsearch
set hlsearch
set ignorecase
set smartcase

" Remove trailing spaces
autocmd BufWritePre * %s/\s\+$//e

" Misc
nnoremap <Space> <Nop>
let mapleader = "\<Space>"
nnoremap <Leader>sop :source ~/.vimrc<cr>
set scrolloff=4 " Scroll 4 lines bellow cursor
set showcmd		" Show (partial) command in status line.
set number
set encoding=utf8
set autoindent
set smarttab
set complete+=]

" LaTeX
let g:tex_flavor = "latex"
set conceallevel=1
let g:tex_conceal='abdmg'

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
autocmd FileType python set shiftwidth=4
autocmd FileType python set tabstop=4
autocmd FileType python set softtabstop=4
autocmd FileType python set textwidth=80
autocmd FileType python set colorcolumn=+1





" " English correcting
" setlocal spell
" set spelllang=en,fr
" inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u




" HTML cleaning
function! HTMLClean()
  normal! ggVGJ " Join all lines
  :s/> \+\([^ ]\)/>\1/g " Remove space after tags
  :s/\([^ ]\) \+</\1</g " Remove space before tags
  :s/></>\r</g " Add CR after each tag
  normal! G=gg " Auto indent file
endfunction
command! HTMLClean :call HTMLClean()




" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
filetype plugin indent on
set foldmethod=indent
set foldlevel=99

