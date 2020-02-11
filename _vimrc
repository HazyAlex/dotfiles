" Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
    Plugin 'VundleVim/Vundle.vim'
    Plugin 'altercation/vim-colors-solarized'

    Plugin 'tpope/vim-surround'
call vundle#end()



" -----------------------
"  Compatibility / Theme
" -----------------------
let mapleader = " "

set backspace=indent,eol,start
set encoding=utf-8

set termguicolors " Support true color terminal

" Remove GVIM GUI
set guioptions-=m "Remove menu bar
set guioptions-=T "Remove toolbar
set guioptions-=r "Remove right-hand scroll bar
set guioptions-=L "Remove left-hand scroll bar

syntax on

set cursorline " Show a dark outline on the current line

set background=light
colorscheme solarized
set guifont=Fira\ Code\ Retina:h13


" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="

" --------
"  TYPING
" --------
filetype indent plugin on

set tabstop=4
set shiftwidth=4
set softtabstop=4

set autoindent
set smarttab
set expandtab
set smartindent
set ai

set relativenumber "Show distance to other lines in the left side
set nu             "Make relativenumber show the current line number

set showmatch

set incsearch "Search as characters are entered
set hlsearch  "Highlight matches

set noesckeys

" ---------------------------------------
"  Turn persistent undo on
"  Undo even when you close a buffer/VIM
" ---------------------------------------
set backupdir=~/.vim/temp_dirs/backupdir
set directory=~/.vim/temp_dirs/backupdir

try
    set undodir=~/.vim/temp_dirs/undodir
    set undofile
catch
endtry


" --------
"   MAPS
" --------

" Move visual blocks with > and <
vnoremap < <gv
vnoremap > >gv

" Move vertically by visual line
nnoremap j gj
nnoremap k gk

inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

