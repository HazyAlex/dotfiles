--
-- Neovide
--
vim.g.neovide_fullscreen = true
vim.g.neovide_refresh_rate = 144
vim.g.neovide_refresh_rate_idle = 1
vim.g.neovide_remember_window_size = true
vim.g.neovide_confirm_quit = true

vim.g.neovide_floating_opacity = 0.75

vim.g.neovide_scroll_animation_length = 0.05
vim.g.neovide_scroll_animation_far_lines = 0

vim.g.neovide_floating_blur = false
vim.g.neovide_floating_blur_amount_x = 0
vim.g.neovide_floating_blur_amount_y = 0

vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_cursor_animation_length = 0.012
vim.g.neovide_cursor_trail_size = 0.8
vim.g.neovide_cursor_trail_length = 1.0
vim.g.neovide_cursor_antialiasing = false
vim.g.neovide_cursor_animate_in_insert_mode = true
vim.g.neovide_cursor_animate_command_line = true

vim.g.neovide_theme = 'dark'

-- vim.g.neovide_cursor_vfx_mode = "ripple"
vim.g.neovide_cursor_vfx_mode = "pixiedust"


--
-- Key mappings
--

-- Fullscreen toggle
vim.keymap.set('', '<F11>', '<cmd>let g:neovide_fullscreen = !g:neovide_fullscreen<CR>', { noremap = true, silent = true })

-- Fix copy/paste
vim.keymap.set('n', '<C-V>', '"+p', { noremap = true, silent = true })
vim.keymap.set('i', '<C-V>', '<ESC>"+pa', { noremap = true, silent = true })

