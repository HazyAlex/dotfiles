call plug#begin()
    Plug 'tpope/vim-surround'
    Plug 'junegunn/vim-easy-align'

    Plug 'mhartington/oceanic-next'
call plug#end()

set ttimeoutlen=0


if exists('g:vscode')
    " VSCodium extension

    " Instead of using vim-commentary
    xmap gc  <Plug>VSCodeCommentary
    nmap gc  <Plug>VSCodeCommentary
    omap gc  <Plug>VSCodeCommentary
    nmap gcc <Plug>VSCodeCommentaryLine
else

" Neovim
set background=dark
set termguicolors " Support true color terminal
colorscheme OceanicNext

" Remove '~' on empty lines
set fcs=eob:\ 

set cursorline " Show the current selected line

" --------
"  TYPING
" --------
set tabstop=4
set shiftwidth=4
set softtabstop=4

set autoindent
set expandtab
set smartindent
set ai

set relativenumber "Show distance to other lines in the left side
set nu             "Make relativenumber show the current line number

set showmatch


" --------
"   MAPS
" --------

" Move visual blocks with > and <
vnoremap < <gv
vnoremap > >gv

" Move vertically by visual line
nnoremap j gj
nnoremap k gk

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

endif

