--
-- Package manager
--
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)
vim.loader.enable()

require('lazy').setup({
    --
    -- Themes
    --

    {
        'rebelot/kanagawa.nvim',
        -- lazy = true,
        priority = 1000,
        config = function()
            vim.cmd('colorscheme kanagawa')
        end
    },

    {
        'JoosepAlviste/palenightfall.nvim',
        lazy = true,
        config = function()
            vim.cmd('colorscheme palenightfall')
        end
    },

    {
        'rose-pine/neovim',
        name = 'rose-pine',
        lazy = true,
        config = function()
            vim.cmd('colorscheme rose-pine')
        end
    },

    --
    -- UI
    --

    {
        'romgrk/barbar.nvim',
        dependencies = {
            'lewis6991/gitsigns.nvim', -- OPTIONAL: git status
            'nvim-tree/nvim-web-devicons', -- OPTIONAL: file icons
        },
        lazy = true,
        init = function() vim.g.barbar_auto_setup = false end,
        config = function()
            require('barbar').setup({
                -- Enable/disable animations
                animation = true,
                -- Automatically hide the tabline when there are this many buffers left.
                auto_hide = 1,
            })

            vim.keymap.set('n', '<A-,>', '<cmd> :BufferPrevious<CR>', { silent = true, noremap = true })
            vim.keymap.set('n', '<A-.>', '<cmd> :BufferNext<CR>', { silent = true, noremap = true })
            vim.keymap.set('n', '<A-<>', '<cmd> :BufferMovePrevious<CR>', { silent = true, noremap = true })
            vim.keymap.set('n', '<A->>', '<cmd> :BufferMoveNext<CR>', { silent = true, noremap = true })
            vim.keymap.set('n', '<A-1>', '<cmd> :BufferGoto 1<CR>', { silent = true, noremap = true })
            vim.keymap.set('n', '<A-2>', '<cmd> :BufferGoto 2<CR>', { silent = true, noremap = true })
            vim.keymap.set('n', '<A-3>', '<cmd> :BufferGoto 3<CR>', { silent = true, noremap = true })
            vim.keymap.set('n', '<A-4>', '<cmd> :BufferGoto 4<CR>', { silent = true, noremap = true })
            vim.keymap.set('n', '<A-5>', '<cmd> :BufferGoto 5<CR>', { silent = true, noremap = true })
            vim.keymap.set('n', '<A-6>', '<cmd> :BufferGoto 6<CR>', { silent = true, noremap = true })
            vim.keymap.set('n', '<A-7>', '<cmd> :BufferGoto 7<CR>', { silent = true, noremap = true })
            vim.keymap.set('n', '<A-8>', '<cmd> :BufferGoto 8<CR>', { silent = true, noremap = true })
            vim.keymap.set('n', '<A-9>', '<cmd> :BufferLast<CR>', { silent = true, noremap = true })
            vim.keymap.set('n', '<C-w>q', '<cmd> :BufferWipeout<CR>', { silent = true, noremap = true })
        end,
    },

    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup({
                options = {
                    theme = 'palenight',
                    section_separators = { left = '', right = '' },
                    component_separators = { left = '', right = '' },
                    always_show_tabline = true,
                    globalstatus = true,
                },
                sections = {
                    lualine_a = {'mode'},
                    lualine_b = {'branch', 'diff', 'diagnostics'},
                    lualine_c = {'filename'},
                    lualine_x = {},
                    lualine_y = {'progress'},
                    lualine_z = {'location'}
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {'filename'},
                    lualine_x = {'location'},
                    lualine_y = {},
                    lualine_z = {}
                },
            })
        end
    },

    {
        'nvim-telescope/telescope.nvim',
        dependencies = 'nvim-lua/plenary.nvim',
        event = 'VeryLazy',
        config = function()
            local actions = require('telescope.actions')
            local action_layout = require('telescope.actions.layout')

            require('telescope').setup({
                extensions = {
                    ['ui-select'] = { require('telescope.themes').get_dropdown() }
                },
                defaults = {
                    mappings = {
                        i = {
                            ['<esc>'] = actions.close,
                            ['<C-j>'] = actions.move_selection_next,
                            ['<C-k>'] = actions.move_selection_previous,
                            ['?'] = action_layout.toggle_preview
                        }
                    },
                    layout_config = {
                        height = 0.4
                    },
                    file_ignore_patterns = {'node_modules', 'vendor'}
                },
                pickers = {
                    find_files = {
                        theme = 'ivy',
                        show_line = true,
                        results_title = false,
                        preview_title = false,
                        layout_config = {
                            height = 0.3
                        },
                        file_ignore_patterns = {'node_modules', 'vendor'},
                        find_command = {'rg', '--hidden', '--no-ignore', '--files'}
                    },
                    live_grep = {
                        theme = 'ivy',
                        show_line = true,
                        results_title = false,
                        preview_title = false,
                        layout_config = {
                            height = 0.3
                        },
                        file_ignore_patterns = {'node_modules', 'vendor'}
                    }
                }
            })

            require('telescope').load_extension('projects')
            require('telescope').load_extension('ui-select')
            require('telescope').load_extension('notify')
            require('telescope').load_extension('neoclip')
            require('telescope').load_extension('macroscope')
        end
    },

    {
        'nvim-telescope/telescope-ui-select.nvim',
        dependencies = 'nvim-telescope/telescope.nvim',
        lazy = true,
    },

    {
        'petertriho/nvim-scrollbar',
        dependencies = 'kevinhwang91/nvim-hlslens',
        event = 'VeryLazy',
        config = function()
            require('scrollbar').setup({
                handlers = {
                    diagnostic = true,
                    search = true
                }
            })
        end
    },

    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        dependencies = {
            -- 'echasnovski/mini.nvim', -- OPTIONAL: icons
            'nvim-tree/nvim-web-devicons', -- OPTIONAL: icons
        },
        config = function()
            local whichKey = require('which-key')

            whichKey.setup({
                plugins = {
                    marks = false,
                    registers = false,
                },
                icons = {
                    rules = false,
                    separator = ' ',
                    group = ' ',
                },
                show_help = false,
                show_keys = true,
            })

            whichKey.add({
                {'<leader>f', group = 'file'},
                -- {'<leader>fr', "<cmd>lua require('spectre').open()<CR>", desc = 'Search and replace'},
                {'<leader>fp', '<cmd>Telescope projects<cr>', desc = 'Projects'},
                {'<leader>ff', '<cmd>Telescope find_files find_command=rg,--hidden,--no-ignore,--files<cr>', desc = 'Find file'},
                {'<leader>fg', '<cmd>Telescope live_grep<cr>', desc = 'Find in files'},
                {'<leader>fb', '<cmd>Telescope buffers<cr>', desc = 'Buffers'},
                {'<leader>fh', '<cmd>Telescope help_tags<cr>', desc = 'Help tags'},

                {'<leader>h', group = 'history'},
                {'<leader>hm', '<cmd>Telescope macroscope<cr>', desc = 'Macro history'},
                {'<leader>hn', '<cmd>Telescope neoclip<cr>', desc = 'Macro history'},

                {'<leader>w', group = 'window'},
                {'<leader>wm', '<cmd>TZFocus<cr>', desc = 'Maximize/minimize current window'},
                {'<leader>wf', '<cmd>TZMinimalist<cr>', desc = 'Focus/markdown mode'},
                {'<leader>wa', '<cmd>TZAtaraxis<cr>', desc = 'Zen mode'},
                {'<leader>wt', '<cmd>Twilight<cr>', desc = 'Toggle twilight mode'},
            })
        end
    },

    -- Notifications
    {
        'rcarriga/nvim-notify',
        event = 'VeryLazy',
        config = function()
            require('notify').setup()
        end
    },

    -- Dashboard
    {
        'goolord/alpha-nvim',
        config = function()
            local alpha = require('alpha')
            local dashboard = require('alpha.themes.dashboard')

            -- dashboard.section.header.val = {[[=================     ===============     ===============   ========  ========]],
            --                                 [[\\ . . . . . . .\\   //. . . . . . .\\   //. . . . . . .\\  \\. . .\\// . . //]],
            --                                 [[||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\/ . . .||]],
            --                                 [[|| . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||]],
            --                                 [[||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||]],
            --                                 [[|| . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\ . . . . ||]],
            --                                 [[||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\_ . .|. .||]],
            --                                 [[|| . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\ `-_/| . ||]],
            --                                 [[||_-' ||  .|/    || ||    \|.  || `-_|| ||_-' ||  .|/    || ||   | \  / |-_.||]],
            --                                 [[||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \  / |  `||]],
            --                                 [[||    `'         || ||         `'    || ||    `'         || ||   | \  / |   ||]],
            --                                 [[||            .===' `===.         .==='.`===.         .===' /==. |  \/  |   ||]],
            --                                 [[||         .=='   \_|-_ `===. .==='   _|_   `===. .===' _-|/   `==  \/  |   ||]],
            --                                 [[||      .=='    _-'    `-_  `='    _-'   `-_    `='  _-'   `-_  /|  \/  |   ||]],
            --                                 [[||   .=='    _-'          '-__\._-'         '-_./__-'         `' |. /|  |   ||]],
            --                                 [[||.=='    _-'                                                     `' |  /==.||]],
            --                                 [[=='    _-'                                                            \/   `==]],
            --                                 [[\   _-'                                                                `-_   /]],
            --                                 [[ `''                                                                      ``' ]]}

            dashboard.section.header.val = {[[                                   ]],
                                            [[                                   ]],
                                            [[                                   ]],
                                            [[                                   ]],
                                            [[   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          ]],
                                            [[    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ]],
                                            [[          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     ]],
                                            [[           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ]],
                                            [[          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ]],
                                            [[   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ]],
                                            [[  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ]],
                                            [[ ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ]],
                                            [[ ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ ]],
                                            [[      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ]],
                                            [[       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ]]}

            -- dashboard.section.header.val = {[[                                                ]],
            --                                 [[                                          _.oo. ]],
            --                                 [[                  _.u[[/;:,.         .odMMMMMM' ]],
            --                                 [[               .o888UU[[[/;:-.  .o@P^    MMM^   ]],
            --                                 [[              oN88888UU[[[/;::-.        dP^     ]],
            --                                 [[             dNMMNN888UU[[[/;:--.   .o@P^       ]],
            --                                 [[            ,MMMMMMN888UU[[/;::-. o@^           ]],
            --                                 [[            NNMMMNN888UU[[[/~.o@P^              ]],
            --                                 [[            888888888UU[[[/o@^-..               ]],
            --                                 [[           oI8888UU[[[/o@P^:--..                ]],
            --                                 [[        .@^  YUU[[[/o@^;::---..                 ]],
            --                                 [[      oMP     ^/o@P^;:::---..                   ]],
            --                                 [[   .dMMM    .o@^ ^;::---...                     ]],
            --                                 [[  dMMMMMMM@^`       `^^^^                       ]],
            --                                 [[ YMMMUP^                                        ]],
            --                                 [[  ^^                                            ]],
            --                                 [[                                                ]]}

            dashboard.section.buttons.val = {dashboard.button('e', '  > New file', ':ene <BAR> startinsert<cr>'),
                                             dashboard.button('f', '  > Find file', ':cd ~ | Telescope find_files<cr>'),
                                             dashboard.button('p', '﬘  > Projects', ':Telescope projects<cr>'),
                                             dashboard.button('r', '  > Recent', ':Telescope oldfiles<cr>'),
                                             dashboard.button('l', '  > Load last session', function() require('resession').load('last') end),
                                             dashboard.button('s', '  > Settings', ':e $MYVIMRC | :cd %:p:h<cr>'),
                                             dashboard.button('m', '  > Manage plugins', ':Lazy<cr>'),
                                             dashboard.button('q', '  > Quit NVIM', ':qa<cr>')}

            alpha.setup(dashboard.opts)
        end
    },

    -- Highlight word under cursor
    {
        'RRethy/vim-illuminate',
        event = 'VeryLazy',
        config = function()
            require('illuminate').configure({
                delay = 0,
                large_file_cutoff = 15000,
                min_count_to_highlight = 2,
            })
        end
    },

    -- Dim inactive parts of the editor
    -- TODO: tree-sitter so it can detect scopes
    {
        'folke/twilight.nvim',
        event = 'VeryLazy',
        config = function()
            require('twilight').setup()
        end
    },

    {
        'Pocco81/TrueZen.nvim',
        event = 'VeryLazy',
        config = function()
            require('true-zen').setup()
        end
    },

    {
        'crivotz/nvim-colorizer.lua',
        event = 'VeryLazy',
        config = function()
            require('colorizer').setup()
        end
    },


    --
    -- Comments / TODO tags
    --

    -- 'gc' to comment visual regions/lines
    {
        'numToStr/Comment.nvim',
        event = 'VeryLazy',
        config = function()
            require('Comment').setup()
        end
    },

    {
        'folke/todo-comments.nvim',
        dependencies = 'nvim-lua/plenary.nvim',
        event = 'VeryLazy',
        config = function()
            require('todo-comments').setup({
                keywords = {
                    FIX = {
                        icon = ' ',
                        color = 'error',
                        alt = {'FIXME', 'Debug', 'Issue', '@FIXME', '@Debug', '@Issue'}
                    },
                    TODO = {
                        icon = ' ',
                        color = 'info'
                    },
                    HACK = {
                        icon = ' ',
                        color = 'warning',
                        alt = {'@Hack'}
                    },
                    WARN = {
                        icon = ' ',
                        color = 'warning',
                        alt = {'WARNING', '@Warning'}
                    },
                    PERFORMANCE = {
                        icon = ' '
                    },
                    NOTE = {
                        icon = ' ',
                        color = 'hint',
                        alt = {'@Note', '@Performance', '@Measure'}
                    }
                },
                highlight = {
                    before = '', -- 'fg' or 'bg' or empty
                    keyword = 'bg', -- 'fg', 'bg', 'wide' or empty
                    after = '', -- 'fg' or 'bg' or empty
                    pattern = [[.*<(KEYWORDS)\s*:]],
                    max_line_len = 500
                }
            })
        end
    },


    --
    -- Functional
    --

    -- Detect tabstop and shiftwidth automatically
    {
        'tpope/vim-sleuth',
        event = 'VeryLazy',
    },

    -- Project management
    {
        'ahmedkhalf/project.nvim',
        lazy = true,
        config = function()
            require('project_nvim').setup({
                patterns = {'.git', '_darcs', '.hg', '.bzr', '.svn'},
            })
        end
    },

    -- Save/restore last session
    {
        'stevearc/resession.nvim',
        config = function()
            require('resession').setup({})

            vim.api.nvim_create_autocmd('VimLeavePre', {
                callback = function()
                    require('resession').save('last')
                end,
            })
        end
    },

    -- Macro and yank history
    {
        'AckslD/nvim-neoclip.lua',
        dependencies = 'nvim-telescope/telescope.nvim',
        lazy = true,
        config = function()
            require('neoclip').setup()
        end
    },

    -- Useful for git blame / used for tabs UI
    {
        'lewis6991/gitsigns.nvim',
        event = 'VeryLazy',
        config = function()
            require('gitsigns').setup()
        end
    },

    -- highlight %s/old/new substitutions
    {
        'winston0410/range-highlight.nvim',
        dependencies = 'winston0410/cmd-parser.nvim',
        event = 'VeryLazy',
        config = function()
            require('range-highlight').setup()
        end
    },

    {
        'andymass/vim-matchup',
        event = 'VeryLazy',
        config = function()
            vim.g.matchup_matchparen_enabled = 1
            vim.g.matchup_transmute_enabled = 1
            vim.g.matchup_matchparen_offscreen = { method = 'popup' }
        end
    },

    {
        'fedepujol/move.nvim',
        event = 'VeryLazy',
        config = function()
            require('move').setup({})

            vim.keymap.set('n', '<S-j>', ':MoveLine(1)<CR>', { noremap = true, silent = true })
            vim.keymap.set('n', '<S-k>', ':MoveLine(-1)<CR>', { noremap = true, silent = true })
            vim.keymap.set('v', '<S-j>', ':MoveBlock(1)<CR>', { noremap = true, silent = true })
            vim.keymap.set('v', '<S-k>', ':MoveBlock(-1)<CR>', { noremap = true, silent = true })
        end
    },

    {
        'tpope/vim-surround',
        event = 'VeryLazy',
    },

    {
        'jeffkreeftmeijer/vim-numbertoggle',
        event = 'VeryLazy',
    },

    {
        'monaqa/dial.nvim',
        lazy = true,
    },

    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        opts = {}
    },

    {
        'lilibyte/tabhula.nvim',
        event = { 'InsertEnter' },
        config = function()
            require('tabhula').setup({
                tabkey = '<Tab>',
                backward_tabkey = '<S-Tab>',
                evil_tabkey = '',
                evil_backward_tabkey = '',
                completion = nil,
                range = 0,
                forward_characters = {
                    ['('] = function() return 1 end,
                    ['['] = function() return 1 end,
                    ['{'] = function() return 1 end,
                    [')'] = function() return 1 end,
                    [']'] = function() return 1 end,
                    ['}'] = function() return 1 end,
                    ['"'] = function() return 1 end,
                    ["'"] = function() return 1 end,
                    ['`'] = function() return 1 end,
                },
                backward_characters = {
                    ['('] = function() return 1 end,
                    ['['] = function() return 1 end,
                    ['{'] = function() return 1 end,
                    [')'] = function() return 1 end,
                    [']'] = function() return 1 end,
                    ['}'] = function() return 1 end,
                    ['"'] = function() return 1 end,
                    ["'"] = function() return 1 end,
                    ['`'] = function() return 1 end,
                },
            })
        end,
    },

    {
        'neovim/nvim-lspconfig',
        event = { 'VeryLazy' },
        config = function()
            local lspconfig = require('lspconfig')

            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(event)
                    --
                end
            })
        end,
    },

    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        event = { 'VeryLazy' },
        config = function()
            require('nvim-treesitter.configs').setup({
                ensure_installed = {
                    'html',
                    'bash',
                    'javascript',
                    'jsdoc',
                    'json',
                    'jsonc',
                    'lua',
                    'luadoc',
                    'markdown',
                    'markdown_inline',
                    'regex',
                    'toml',
                    'yaml',
                    'tsx',
                },
            })
        end,
    },
})
