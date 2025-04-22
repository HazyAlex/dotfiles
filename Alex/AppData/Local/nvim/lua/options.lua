local options = {
    guifont = 'Iosevka Term:h14',

    background = 'dark',
    termguicolors = true,

    -- Remove '~' on empty lines
    fcs = 'eob: ',

    -- cursorline = true,
    ttimeoutlen = 0,
    timeoutlen = 300,
    updatetime = 250,

    signcolumn = 'number', -- Merge the gutter and the number into one column

    showmode = false, -- Hide the current mode, e.g. -- INSERT --
    laststatus = 3, -- Global statusline

    mouse = 'a',

    --
    -- Typing
    --
    spell = true,

    tabstop = 4,
    shiftwidth = 4,
    softtabstop = 4,

    autoindent = true,
    expandtab = true,
    smartindent = true,
    ai = true,

    relativenumber = true,
    nu = true,

    -- Search ignores case unless an uppercase letter appears in the pattern.
    ignorecase = true,
    smartcase = false,

    showmatch = false,
    hlsearch = false,

    conceallevel = 0, -- so that `` is visible in markdown files

    splitbelow = true, -- force all horizontal splits to go below current window
    splitright = true -- force all vertical splits to go to the right of current window
}

for k, v in pairs(options) do
    vim.opt[k] = v
end


vim.g.mapleader = ' '

-- Shortcuts
vim.cmd([[
  command! OpenConfig edit ~/.config/nvim/init.lua
  command! ConfigOpen edit ~/.config/nvim/init.lua
  command! EditConfig edit ~/.config/nvim/init.lua
  command! ConfigEdit edit ~/.config/nvim/init.lua
  command! EditPlugins edit ~/.config/nvim/lua/plugins.lua
  command! PluginsEdit edit ~/.config/nvim/lua/plugins.lua
]])

-- Disable Ex-mode
vim.keymap.set('n', 'gQ', '<Nop>', { noremap = true, silent = true })
vim.keymap.set('n', 'q:', '<Nop>', { noremap = true, silent = true })

-- change Y to act like C, D
vim.keymap.set('n', 'Y', 'y$', { noremap = true, silent = true })

-- Move between splits
vim.keymap.set('n', '<C-H>', '<C-W><C-H>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-J>', '<C-W><C-J>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-K>', '<C-W><C-K>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-L>', '<C-W><C-L>', { noremap = true, silent = true })

-- Move visual blocks with > and <
vim.keymap.set('v', '<', '<gv', { noremap = true, silent = true })
vim.keymap.set('v', '>', '>gv', { noremap = true, silent = true })

-- Move vertically by visual line
vim.keymap.set('n', 'j', 'gj', { noremap = true, silent = true })
vim.keymap.set('n', 'k', 'gk', { noremap = true, silent = true })

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('YankHighlight', { clear = true }),
  pattern = '*',
  callback = function()
    vim.highlight.on_yank()
  end
})

-- Change scale factor at runtime
vim.g.neovide_scale_factor = 1.0
local change_scale_factor = function(delta)
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end

vim.keymap.set("n", "<C-=>", function() change_scale_factor(1.05) end)
vim.keymap.set("n", "<C-->", function() change_scale_factor(1/1.05) end)

-- Disable automatically creating comments on a newline following a comment
vim.api.nvim_create_autocmd('BufEnter', {
  callback = function() vim.opt.formatoptions:remove { 'c', 'r', 'o' } end,
  desc = 'Disable automatic newline comments',
})
