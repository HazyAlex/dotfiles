local options = {
    guifont = "Iosevka Term:h16",

    background = "dark",
    termguicolors = true,

    -- Remove '~' on empty lines
    fcs = "eob: ",

    -- TODO: Or hide?
    fileformats = "dos",

    -- cursorline = true,
    ttimeoutlen = 0,
    timeoutlen = 250,
    updatetime = 750,

    signcolumn = "number", -- Merge the gutter and the number into one column

    showmode = false, -- Hide the current mode, e.g. -- INSERT --
    laststatus = 3, -- Global statusline

    mouse = 'a',

    ------------
    -- TYPING --
    ------------
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

    showmatch = true,
    hlsearch = false,

    conceallevel = 0, -- so that `` is visible in markdown files

    splitbelow = true, -- force all horizontal splits to go below current window
    splitright = true -- force all vertical splits to go to the right of current window
}

-- vim.g.gruvbox_material_better_performance = 1
-- vim.g.gruvbox_material_foreground = 'mix'
-- vim.g.gruvbox_material_statusline_style = 'mix'
-- vim.cmd('gruvbox-material')
-- vim.cmd('OceanicNext')
-- vim.cmd('colorscheme kanagawa')
-- vim.cmd('colorscheme rose-pine')
-- vim.cmd('colorscheme palenightfall')

-- vim.cmd('colorscheme minimal')
vim.cmd('colorscheme minimal-base16')

--
for k, v in pairs(options) do
    vim.opt[k] = v
end
