lua require('plugins')

set guifont=Iosevka\ Term:h20
let g:neovide_refresh_rate=144
let g:neovide_fullscreen=v:true
let g:neovide_remember_window_size = v:true
let g:neovide_cursor_animation_length=0.01
let g:neovide_cursor_trail_length=1.0
let g:neovide_cursor_antialiasing=v:true

"let g:neovide_cursor_vfx_mode = "ripple"
let g:neovide_cursor_vfx_mode = "pixiedust"

set background=dark
set termguicolors
colorscheme gruvbox

" Remove '~' on empty lines
"set fcs=eob:\ 

"set cursorline
set ttimeoutlen=0

set updatetime=300

" Merge the gutter and the number into one column
set signcolumn=number

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
"set re=1

" --------
"   MAPS
" --------
command! ReloadConfig so $MYVIMRC
command! OpenConfig edit $LocalAppData\nvim\init.vim
command! OpenPlugins edit $LocalAppData\nvim\lua\plugins.lua

let mapleader = " "

" Move between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Move visual blocks with > and <
vnoremap < <gv
vnoremap > >gv

" Disable Ex-mode
map q: <nop>
nnoremap Q <nop>

" Move vertically by visual line
nnoremap j gj
nnoremap k gk


"
" Completion (Tab, Ctrl + Space)
"

" Use tab for trigger completion with characters ahead and navigate.
" @NOTE: Use the command ':verbose imap <tab>' to make sure tab is not mapped by other plugins.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


"
" Plugin mappings
"

" Fullscreen toggle
nnoremap <F11> <cmd>let g:neovide_fullscreen = !g:neovide_fullscreen<CR>

" TODO: Think about changing this to a good shortcut
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Goto code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

nnoremap <silent> gh <cmd>call <SID>show_documentation()<CR>

" IDE-like rename
nmap <silent> <S-F6> <Plug>(coc-rename)

" TODO: Remap <C-f> and <C-b> for scroll float windows/popups.
"    nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"    nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
"    inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
"    inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
"    vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"    vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"


" Adds a command to format current buffer.
command! -nargs=0 Format <cmd>call CocActionAsync('format')

" Adds a command for organize imports of the current buffer.
command! -nargs=0 OrganizeImports   <cmd>call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Show all diagnostics.
nnoremap <silent><nowait> <leader>w  <cmd>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <leader>x  <cmd>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <leader>c  <cmd>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <leader>o  <cmd>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <leader>O  <cmd>CocList -I symbols<cr>

" VSCode like command pallete
nnoremap <C-p> <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <C-S-f> <cmd>lua require('telescope.builtin').live_grep()<cr>

nnoremap <leader>fp <cmd>Telescope projects<cr>
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
