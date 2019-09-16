" Install Vim (x64!) with :echo has('python3') for Rust auto-complete!

" Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
    Plugin 'VundleVim/Vundle.vim'
    Plugin 'altercation/vim-colors-solarized'
    Plugin 'ycm-core/YouCompleteMe'           "Rust
    Plugin 'prabirshrestha/async.vim'         "Rust
    Plugin 'prabirshrestha/vim-lsp'           "Rust
call vundle#end()

if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'nightly', 'rls']},
        \ 'whitelist': ['rust'],
        \ })
endif


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
set guifont=Consolas:h15 "TODO: Change font


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

" Enable folding
set foldmethod=indent
set foldlevel=99


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
noremap <leader>h :LspHover<CR>
noremap <leader>g :LspDefinition<CR>
noremap <leader>r :LspReferences<CR>
noremap <leader>n :LspNextError<CR>
noremap <leader>p :LspPreviousError<CR>
noremap <leader>f :LspDocumentFormat<CR>
noremap <F6> :LspRename<CR>

" Move visual blocks with > and <
vnoremap < <gv
vnoremap > >gv

" Move vertically by visual line
nnoremap j gj
nnoremap k gk

inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" Use hjkl
noremap <up> <C-w><up>
noremap <down> <C-w><down>
noremap <left> <C-w><left>
noremap <right> <C-w><right> 
