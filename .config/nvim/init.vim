""""""""""""""""""""""""""""""""""""""""
" Install pluggins
""""""""""""""""""""""""""""""""""""""""

" Install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Pluggin loading
call plug#begin()

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

call plug#end()

" Enable filetype detection for plugins and indentation options
filetype plugin indent on

""""""""""""""""""""""""""""""""""""""""
" Configure pluggins
""""""""""""""""""""""""""""""""""""""""

" Change learder key
nnoremap <Space> <Nop>
let mapleader = "\<Space>"

" UltiSnips settings
let g:UltiSnipsExpandTrigger = "<c-j>"
let g:UltiSnipsJumpForwardTrigger = "<c-n>"
let g:UltiSnipsJumpBackwardTrigger = "<c-p>"
let g:ultisnips_python_style="numpy"

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
nmap <leader>s :noh<cr>
set incsearch
set hlsearch
set ignorecase
set smartcase

" Map [q ]q to move through quickfix
nnoremap [q :cprevious<cr>
nnoremap ]q :cnext<cr>

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
    augroup LaTex
	autocmd!
	au FileType tex setlocal linebreak
	au FileType tex setlocal wrap
	au FileType tex setlocal shiftwidth=8
	au FileType tex setlocal spell
	au FileType tex compiler tex
	au FileType tex setlocal makeprg=pdflatex\ --shell-escape\ %
	au FileType tex nnoremap <Leader>p :silent execute "!zathura " . expand("%:r") . ".pdf 2> /dev/null &" \| :redraw!<cr>
	au FileType tex nnoremap <Leader>m :silent execute "!pdflatex % > /dev/null" \| :redraw!<cr>
    augroup END

    augroup python
	autocmd!
	au FileType python setlocal shiftwidth=4
	au FileType python setlocal softtabstop=4
	au FileType python setlocal expandtab
	au FileType python setlocal textwidth=88
	au FileType python setlocal colorcolumn=+1
	au FileType python setlocal foldmethod=indent
	au FileType python setlocal foldcolumn=0
	au FileType python setlocal formatoptions=
    augroup END

    augroup misc
	autocmd!
        " HTML
        au FileType html,htmldjango,html setlocal shiftwidth=2
        au FileType html,htmldjango,html setlocal expandtab
        au FileType html,htmldjango,html setlocal nowrap

        " CVS
	au BufRead,BufNewFile *.csv,*.dat,*.tsv,*.tab setlocal filetype=csv
	au FileType csv setlocal nowrap
	au FileType csv setlocal readonly

	" Json
	au FileType json setlocal foldmethod=indent
	au FileType json nnoremap <Leader>f m`:%!python -m json.tool<cr>``
	au FileType json nmap <Leader>" ysiw"

	" Git
	au FileType gitcommit setlocal spell
	au FileType gitcommit setlocal textwidth=72
	au FileType gitcommit setlocal colorcolumn=+1

	" Makefile
	au FileType makefile setlocal shiftwidth=8

	" Yaml
	au FileType yaml setlocal shiftwidth=2
	au FileType yaml setlocal expandtab

	" Nord fix for concealed
	au Colorscheme * hi! link Conceal Number

	au BufNewFile,BufRead *.zsh-theme setlocal syntax=zsh
    augroup END
endif

if executable('black')
    noremap <Leader>f m`:%!black -q -<CR>``
endif

let g:tex_flavor = "latex"
let g:tex_conceal='abdmg'
set conceallevel=1
" Check has latexindent
command! -range LatexIndent :<line1>,<line2>!latexindent

""""""""""""""""""""""""""""""""""""""""
" Misc
""""""""""""""""""""""""""""""""""""""""

" Set diffsplit to vertical
set diffopt+=vertical

" Remove trailing spaces
autocmd BufWritePre * %s/\s\+$//e


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

" Allow copying ligne with <C-c> in visual mode
vnoremap <C-c> :w !xsel -bi<CR><CR>

" Change keymap to FR
nnoremap <Leader>kfr :set keymap=french-azerty<cr>
nnoremap <Leader>kk :set keymap&<cr>
