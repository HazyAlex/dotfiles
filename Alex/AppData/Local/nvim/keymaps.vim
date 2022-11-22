command! ReloadConfig so $MYVIMRC
command! OpenConfig edit $LocalAppData\nvim\init.vim
command! OpenPlugins edit $LocalAppData\nvim\lua\plugins.lua

" Change font dynamically
function! FontSizePlus ()
    let l:gf_size_whole = matchstr(&guifont, '\(:h\)\@<=\d\+$')
    let l:gf_size_whole = l:gf_size_whole + 1
    let l:new_font_size = ':h'.l:gf_size_whole
    let &guifont = substitute(&guifont, ':h\d\+$', l:new_font_size, '')
endfunction

function! FontSizeMinus ()
    let l:gf_size_whole = matchstr(&guifont, '\(:h\)\@<=\d\+$')
    let l:gf_size_whole = l:gf_size_whole - 1
    let l:new_font_size = ':h'.l:gf_size_whole
    let &guifont = substitute(&guifont, ':h\d\+$', l:new_font_size, '')
endfunction

nmap <leader><down> :call FontSizeMinus()<CR>
nmap <leader><up>   :call FontSizePlus()<CR>

" Prevent accidental quitting (i.e. disable :q, use :exit or ctrl+w q)
cnoreabbrev <expr> q getcmdtype() == ":" && getcmdline() == 'q' ? '' : ''


" Enable/disable auto-hiding the tab bar when there is a single buffer
let bufferline = get(g:, 'bufferline', {})
let bufferline.auto_hide = v:true

" vim-matchup
let g:matchup_matchparen_enabled = 0
let g:matchup_transmute_enabled = 1
let g:matchup_matchparen_offscreen = {'method': 'popup'}

" multi-cursor
let g:VM_leader = ' '

let g:VM_maps = {}
let g:VM_maps['Undo'] = 'u'
let g:VM_maps['Redo'] = '<C-r>'

let g:VM_maps['Find Under'] = 'gb'
let g:VM_maps['Find Subword Under'] = 'gb'
let g:VM_maps['Select Cursor Down'] = '<C-Down>'
let g:VM_maps['Select Cursor Up'] = '<C-Up>'
let g:VM_maps['Start Regex Search'] = '\\/'

" https://github.com/mg979/vim-visual-multi/wiki/Mappings

" C-LeftMouse    - add cursor
" C-RightMouse   - select word
" M-C-RightMouse - create column
let g:VM_mouse_mappings = 1