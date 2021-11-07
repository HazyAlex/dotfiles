if exists('g:fvim_loaded')
    if g:fvim_os == 'windows' || g:fvim_render_scale > 1.0
      set guifont=Iosevka:h18
    else
      set guifont=Iosevka:h28
    endif


    " Font tweaks
    FVimFontAntialias v:true
    FVimFontAutohint v:true
    FVimFontHintLevel 'full'
    FVimFontLigature v:true
    FVimFontSubpixel v:true

    FVimUIPopupMenu v:true

    FVimKeyDisableShiftSpace v:true
    FVimKeyAutoIme v:true

    FVimCursorSmoothMove v:true
    FVimCursorSmoothBlink v:true

    " Ctrl-ScrollWheel for zooming in/out
    nnoremap <silent> <C-ScrollWheelUp> :set guifont=+<CR>
    nnoremap <silent> <C-ScrollWheelDown> :set guifont=-<CR>
    nnoremap <A-CR> :FVimToggleFullScreen<CR>
endif


set background=dark
set termguicolors

" Remove '~' on empty lines
set fcs=eob:\ 

"set cursorline
set ttimeoutlen=0

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

set relativenumber
set nu

set showmatch


" --------
"   MAPS
" --------

" Move between splits
"nnoremap <C-J> <C-W><C-J>
"nnoremap <C-K> <C-W><C-K>
"nnoremap <C-L> <C-W><C-L>
"nnoremap <C-H> <C-W><C-H>

" Move visual blocks with > and <
vnoremap < <gv
vnoremap > >gv

" Disable Ex-mode
map q: <nop>
nnoremap Q <nop>

" Move vertically by visual line
nnoremap j gj
nnoremap k gk
