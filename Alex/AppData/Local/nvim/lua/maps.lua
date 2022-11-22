local noremap = {
    noremap = true
}
local silent = {
    silent = true
}
local silent_noremap = {unpack(silent), unpack(noremap)}

--
--
--

vim.g.mapleader = ' '

-- "Hungry delete" extension alternative
vim.api.nvim_set_keymap("n", "<C-BS>", "", {})

-- change Y to act like C, D
vim.api.nvim_set_keymap("n", "Y", "y$", {})

-- Disable Ex-mode
vim.api.nvim_set_keymap("", "q:", "", {})
vim.api.nvim_set_keymap("", "Q", "", {})

-- Move between splits
vim.api.nvim_set_keymap("n", "<C-H>", "<C-W><C-H>", noremap)
vim.api.nvim_set_keymap("n", "<C-J>", "<C-W><C-J>", noremap)
vim.api.nvim_set_keymap("n", "<C-K>", "<C-W><C-K>", noremap)
vim.api.nvim_set_keymap("n", "<C-L>", "<C-W><C-L>", noremap)

-- Move visual blocks with > and <
vim.api.nvim_set_keymap("v", "<", "<gv", noremap)
vim.api.nvim_set_keymap("v", ">", ">gv", noremap)

-- Move vertically by visual line
vim.api.nvim_set_keymap("n", "j", "gj", noremap)
vim.api.nvim_set_keymap("n", "k", "gk", noremap)

-- Fullscreen toggle
-- https://github.com/neovim/neovim/pull/15373
vim.api.nvim_set_keymap("", "<F11>", "<cmd>let g:neovide_fullscreen = !g:neovide_fullscreen<CR>", noremap)

--
-- Plugins
--

-- VSCode like find shortcut
vim.api.nvim_set_keymap("n", "<C-p>", "<cmd>Telescope find_files<CR>", noremap)

-- Move lines/blocks
vim.api.nvim_set_keymap("n", "<A-j>", "<cmd>:MoveLine(1)<CR>", silent_noremap)
vim.api.nvim_set_keymap("n", "<A-k>", "<cmd>:MoveLine(-1)<CR>", silent_noremap)
vim.api.nvim_set_keymap("v", "<A-j>", "<cmd> :MoveBlock(1)<CR>", silent)
vim.api.nvim_set_keymap("v", "<A-k>", "<cmd> :MoveBlock(-1)<CR>", silent)
vim.api.nvim_set_keymap("n", "<A-l>", "<cmd>:MoveHChar(1)<CR>", silent_noremap)
vim.api.nvim_set_keymap("n", "<A-h>", "<cmd>:MoveHChar(-1)<CR>", silent_noremap)
vim.api.nvim_set_keymap("v", "<A-l>", "<cmd> :MoveHBlock(1)<CR>", silent)
vim.api.nvim_set_keymap("v", "<A-h>", "<cmd> :MoveHBlock(-1)<CR>", silent)

-- barbar.nvim
-- Move to previous/next
vim.api.nvim_set_keymap("n", "<A-,>", "<cmd> :BufferPrevious<CR>", silent_noremap)
vim.api.nvim_set_keymap("n", "<A-.>", "<cmd> :BufferNext<CR>", silent_noremap)
-- Re-order to previous/next
vim.api.nvim_set_keymap("n", "<A-<>", "<cmd> :BufferMovePrevious<CR>", silent_noremap)
vim.api.nvim_set_keymap("n", "<A->>", "<cmd> :BufferMoveNext<CR>", silent_noremap)
-- Goto position
vim.api.nvim_set_keymap("n", "<A-1>", "<cmd> :BufferGoto 1<CR>", silent_noremap)
vim.api.nvim_set_keymap("n", "<A-2>", "<cmd> :BufferGoto 2<CR>", silent_noremap)
vim.api.nvim_set_keymap("n", "<A-3>", "<cmd> :BufferGoto 3<CR>", silent_noremap)
vim.api.nvim_set_keymap("n", "<A-4>", "<cmd> :BufferGoto 4<CR>", silent_noremap)
vim.api.nvim_set_keymap("n", "<A-5>", "<cmd> :BufferGoto 5<CR>", silent_noremap)
vim.api.nvim_set_keymap("n", "<A-6>", "<cmd> :BufferGoto 6<CR>", silent_noremap)
vim.api.nvim_set_keymap("n", "<A-7>", "<cmd> :BufferGoto 7<CR>", silent_noremap)
vim.api.nvim_set_keymap("n", "<A-8>", "<cmd> :BufferGoto 8<CR>", silent_noremap)
vim.api.nvim_set_keymap("n", "<A-9>", "<cmd> :BufferLast<CR>", silent_noremap)
-- Close buffer
vim.api.nvim_set_keymap("n", "<C-w>q", "<cmd> :BufferWipeout<CR>", silent_noremap)

-- Start interactive EasyAlign in visual mode (e.g. vipga)
vim.api.nvim_set_keymap("v", "ga", "<Plug>(EasyAlign)", silent_noremap)
-- Start interactive EasyAlign for a motion/text object (e.g. gaip)
vim.api.nvim_set_keymap("n", "ga", "<Plug>(EasyAlign)", silent_noremap)
