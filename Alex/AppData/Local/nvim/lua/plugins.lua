-- Bootstraping
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
                                      install_path})
end

require('packer').init {
    display = {
        open_fn = function()
            return require("packer.util").float {
                border = "rounded"
            }
        end,
        working_sym = '', -- The symbol for a plugin being installed/updated
        error_sym = '✗', -- The symbol for a plugin with an error in installation/updating
        done_sym = '✓', -- The symbol for a plugin which has completed installation/updating
        removed_sym = '-', -- The symbol for an unused plugin which was removed
        moved_sym = '→', -- The symbol for a plugin which was moved (e.g. from opt to start)
        header_sym = '━' -- The symbol for the header line in packer's display
    }
}

require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    --
    -- Themes
    --
    use 'sainnhe/gruvbox-material'
    use 'mhartington/oceanic-next'
    use 'rebelot/kanagawa.nvim'
    use 'JoosepAlviste/palenightfall.nvim'
    use 'Yazeed1s/minimal.nvim'
    use {
        'rose-pine/neovim',
        as = 'rose-pine',
        tag = 'v1.*',
        config = function()
            require('rose-pine').setup({
                dark_variant = 'main', -- 'main' | 'moon'
                bold_vert_split = false,
                dim_nc_background = false,
                disable_background = false,
                disable_float_background = false,
                disable_italics = true,

                --- @usage string hex value or named color from rosepinetheme.com/palette
                groups = {
                    background = 'base',
                    panel = 'surface',
                    border = 'highlight_med',
                    comment = 'muted',
                    link = 'iris',
                    punctuation = 'subtle',

                    error = 'love',
                    hint = 'iris',
                    info = 'foam',
                    warn = 'gold',

                    headings = {
                        h1 = 'iris',
                        h2 = 'foam',
                        h3 = 'rose',
                        h4 = 'gold',
                        h5 = 'pine',
                        h6 = 'foam'
                    }
                },
                highlight_groups = {
                    ColorColumn = {
                        bg = 'rose'
                    }
                }
            })
        end
    }

    --
    -- Performance
    --
    use {
        'lewis6991/impatient.nvim',
        config = function()
            require('impatient') -- .enable_profile()
        end
    }
    use 'nathom/filetype.nvim'

    --
    -- Terminal
    --
    use {
        'voldikss/vim-floaterm',
        config = function()
            vim.cmd [[ hi FloatermBorder guibg=black guifg=white ]]

            vim.g.floaterm_keymap_toggle = '<leader>t'
            vim.g.floaterm_keymap_new = '<F12>'
            vim.g.floaterm_keymap_prev = '<C-S-Tab>'
            vim.g.floaterm_keymap_next = '<C-Tab>'

            vim.g.floaterm_shell = 'pwsh -NoLogo'
            vim.g.floaterm_title = 'Terminal ($1|$2)'
            vim.g.floaterm_autoclose = 2 -- 0 -> never close, 1 -> close on 0 exit code, 2 -> always close

            vim.g.floaterm_width = 0.85
            vim.g.floaterm_height = 30
            vim.g.floaterm_position = 'center'
        end
    }

    --
    -- UI
    --
    use 'nvim-lua/plenary.nvim'
    use 'kyazdani42/nvim-web-devicons'
    use {
        'folke/which-key.nvim',
        config = function()
            require('which-key').setup()
        end
    }

    -- Notifications
    use {
        'rcarriga/nvim-notify',
        config = function()
            require('notify').setup()
        end
    }

    -- Fuzzy file finder
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/plenary.nvim'}}
    }
    use {'nvim-telescope/telescope-ui-select.nvim'}
    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
        config = function()
            require('telescope').load_extension('fzf')
        end
    }
    use {
        'windwp/nvim-spectre',
        config = function()
            require('spectre').setup {
                live_update = true,
                is_insert_mode = true,
                line_sep_start = '',
                line_sep = ''
            }
        end
    }

    -- Project management
    use {
        'ahmedkhalf/project.nvim',
        config = function()
            require('project_nvim').setup {
                patterns = {'.git', '_darcs', '.hg', '.bzr', '.svn'},
                ignore_lsp = {'intelephense'}
                -- silent_chdir = false
            }
        end
    }
    use {
        'petertriho/nvim-scrollbar',
        requires = 'kevinhwang91/nvim-hlslens',
        config = function()
            require('scrollbar').setup({
                handlers = {
                    diagnostic = true,
                    search = true
                }
            })
        end
    }
    -- File tree
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function()
            require('nvim-tree').setup({
                -- When the project is changed, update the file tree
                update_cwd = true,
                respect_buf_cwd = true,

                view = {
                    width = 55,
                    side = 'right',
                    hide_root_folder = true,
                    mappings = {
                        custom_only = true,
                        list = {{
                            key = {'<CR>', '<2-LeftMouse>'},
                            action = 'edit'
                        }, {
                            key = '<BS>',
                            action = 'close_node'
                        }, {
                            key = '<C-e>',
                            action = 'edit_in_place'
                        }, {
                            key = 'o',
                            action = 'system_open'
                        }, {
                            key = 't', -- key?
                            action = 'toggle_git_ignored'
                        }, {
                            key = 'R',
                            action = 'refresh'
                        }, {
                            key = 'i',
                            action = 'create'
                        }, {
                            key = 'd',
                            action = 'remove'
                        }, {
                            key = 'D',
                            action = 'trash'
                        }, {
                            key = 'r',
                            action = 'rename'
                        }, {
                            key = '<C-r>',
                            action = 'full_rename'
                        }, {
                            key = 'x',
                            action = 'cut'
                        }, {
                            key = 'c',
                            action = 'copy'
                        }, {
                            key = 'p',
                            action = 'paste'
                        }, {
                            key = 'y',
                            action = 'copy_name'
                        }, {
                            key = 'Y',
                            action = 'copy_absolute_path' -- copy_path
                        }, {
                            key = 'f',
                            action = 'live_filter'
                        }, {
                            key = 'F',
                            action = 'clear_live_filter'
                        }, {
                            key = 'q',
                            action = 'close'
                        }, {
                            key = 'I',
                            action = 'toggle_file_info'
                        }, {
                            key = 'C',
                            action = 'collapse_all'
                        }, {
                            key = 'E',
                            action = 'expand_all'
                        }, {
                            key = '.',
                            action = 'run_file_command'
                        }, {
                            key = '?',
                            action = 'toggle_help'
                        }}
                    }
                },
                renderer = {
                    special_files = {'README.md', 'package.json', 'composer.json'}
                },
                git = {
                    enable = true,
                    ignore = false
                },
                diagnostics = {
                    enable = false,
                    show_on_dirs = false,
                    icons = {
                        hint = '',
                        info = '',
                        warning = '',
                        error = ''
                    }
                },
                filters = {
                    dotfiles = false,
                    custom = {},
                    exclude = {}
                }
            })
        end
    }

    -- alternative that underlines instead of highlighting: https://github.com/yamatsum/nvim-cursorline
    use 'RRethy/vim-illuminate'

    use {
        'folke/twilight.nvim',
        config = function()
            require('twilight').setup {}
        end
    }

    use {
        'Pocco81/TrueZen.nvim',
        config = function()
            require('true-zen').setup()
        end
    }

    use {
        'crivotz/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup()
        end
    }

    --
    -- LSP / language parsers
    --
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
    use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
    use 'L3MON4D3/LuaSnip' -- Snippets plugin
    use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
    use 'ray-x/lsp_signature.nvim'

    use {
        'rmagatti/goto-preview',
        config = function()
            require('goto-preview').setup {}
        end
    }

    use 'octol/vim-cpp-enhanced-highlight'

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    use 'nvim-treesitter/nvim-treesitter-context'
    use 'JoosepAlviste/nvim-ts-context-commentstring'
    use {
        'windwp/nvim-ts-autotag',
        config = function()
            require('nvim-treesitter.configs').setup {
                autotag = {
                    enable = true
                }
            }
        end
    }
    use {
        'lewis6991/spellsitter.nvim',
        config = function()
            require('spellsitter').setup()
        end
    }

    use {
        'Maan2003/lsp_lines.nvim',
        config = function()
            require('lsp_lines').setup()

            vim.diagnostic.config({
                virtual_text = false
            })
        end
    }

    --
    -- Tabs / Statusline
    --
    use 'romgrk/barbar.nvim'
    use 'feline-nvim/feline.nvim'

    use {
        'goolord/alpha-nvim',
        config = function()
            require('alpha').setup(require('alpha.themes.dashboard').config)
        end
    }

    --
    -- Comments / TODO tags
    --
    use {
        'numToStr/Comment.nvim',
        config = function()
            -- TODO: gyc like alternative
            require('Comment').setup()
        end
    }
    use {
        'folke/todo-comments.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = function()
            require('todo-comments').setup {
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
            }
        end
    }

    --
    -- General improvements
    --

    use 'junegunn/vim-easy-align'

    use 'mg979/vim-visual-multi'

    -- Tabout
    use {
        'lilibyte/tabhula.nvim',
        config = function()
            require('tabhula').setup({
                -- see |tabhula-configuration| https://github.com/lilibyte/tabhula.nvim
            })
        end
    }

    -- Only use it for the git blame
    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end
    }

    -- macro and yank history
    use {
        "AckslD/nvim-neoclip.lua",
        config = function()
            require('neoclip').setup()
        end
    }
    -- highlight %s/old/new substitutions
    use {
        'winston0410/range-highlight.nvim',
        requires = 'winston0410/cmd-parser.nvim',
        config = function()
            require('range-highlight').setup()
        end
    }

    use 'antoinemadec/FixCursorHold.nvim'
    use 'andymass/vim-matchup'
    use 'tpope/vim-repeat'
    use 'tpope/vim-surround'
    use 'jeffkreeftmeijer/vim-numbertoggle'
    use {
        'luukvbaal/stabilize.nvim',
        config = function()
            require('stabilize').setup()
        end
    }
    use 'monaqa/dial.nvim'
    use 'sudormrfbin/cheatsheet.nvim'
    use 'alec-gibson/nvim-tetris'

    --
    -- Web dev.
    --
    use 'leafOfTree/vim-vue-plugin'
    use {
        'windwp/nvim-autopairs',
        config = function()
            require('nvim-autopairs').setup {}
        end
    }

    -- Notes / Documentation
    use 'ixru/nvim-markdown'

    -- Git
    use {
        'TimUntersberger/neogit',
        requires = 'nvim-lua/plenary.nvim'
    }

    -- Bootstraping
    if packer_bootstrap then
        require('packer').sync()
    end
end)

--
-- Which-key
--
local wk = require('which-key')

wk.register({
    f = {
        name = 'file',
        r = {'<cmd>lua require("spectre").open()<CR>', 'Search and replace'},
        p = {'<cmd>Telescope projects<cr>', 'Projects'},
        f = {'<cmd>Telescope find_files find_command=rg,--hidden,--no-ignore,--files<cr>', 'Find file'},
        g = {'<cmd>Telescope live_grep<cr>', 'Find in files'},
        t = {'<cmd>NvimTreeToggle<cr>', 'File explorer'},
        b = {'<cmd>Telescope buffers<cr>', 'Buffers'},
        h = {'<cmd>Telescope help_tags<cr>', 'Help tags'}
    },
    h = {
        name = 'history',
        m = {'<cmd>Telescope macroscope<cr>', 'Macro history'},
        n = {'<cmd>Telescope neoclip<cr>', 'Yank history'},
        t = {'<cmd>Telescope help_tags<cr>', 'Help tags'}
    },
    w = {
        name = 'window',
        m = {'<cmd>TZFocus<cr>', 'Maximize/minimize current window'},
        f = {'<cmd>TZMinimalist<cr>', 'Focus mode'},
        a = {'<cmd>TZAtaraxis<cr>', 'Zen mode'},
        t = {'<cmd>TwillightToggle<cr>', 'Toggle twillight mode'}
    },
    t = {
        name = 'toggle terminal'
    }
}, {
    prefix = '<leader>'
})

--
-- Dashboard
--
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

-- dashboard.section.header.val = {'          ▀████▀▄▄              ▄█ ',
--                                 '            █▀    ▀▀▄▄▄▄▄    ▄▄▀▀█ ',
--                                 '    ▄        █          ▀▀▀▀▄  ▄▀  ',
--                                 '   ▄▀ ▀▄      ▀▄              ▀▄▀  ',
--                                 '  ▄▀    █     █▀   ▄█▀▄      ▄█    ',
--                                 '  ▀▄     ▀▄  █     ▀██▀     ██▄█   ',
--                                 '   ▀▄    ▄▀ █   ▄██▄   ▄  ▄  ▀▀ █  ',
--                                 '    █  ▄▀  █    ▀██▀    ▀▀ ▀▀  ▄▀  ',
--                                 '   █   █  █      ▄▄           ▄▀   '}

dashboard.section.header.val = {[[                                   ]], [[                                   ]],
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

dashboard.section.buttons.val = {dashboard.button('e', '  > New file', ':ene <BAR> startinsert<cr>'),
                                 dashboard.button('f', '  > Find file', ':cd \\dev | Telescope find_files<cr>'),
                                 dashboard.button('p', '﬘  > Projects', ':Telescope projects<cr>'),
                                 dashboard.button('r', '  > Recent', ':Telescope oldfiles<cr>'),
                                 dashboard.button('s', '  > Settings', ':e $MYVIMRC | :cd %:p:h<cr>'),
                                 dashboard.button('u', '  > Update plugins', ':PackerSync<cr>'),
                                 dashboard.button('q', '  > Quit NVIM', ':qa<cr>')}

alpha.setup(dashboard.opts)

--
-- Telescope
--
local actions = require('telescope.actions')
local action_layout = require('telescope.actions.layout')

require('telescope').setup {
    extensions = {
        ['ui-select'] = {require('telescope.themes').get_dropdown {}}
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
}

require('telescope').load_extension('projects')
require('telescope').load_extension('ui-select')
require('telescope').load_extension('notify')
require('telescope').load_extension('neoclip')
require('telescope').load_extension('macroscope')

--
-- Status bar
--

-- TODO: LSP config

local colors = {
    bg = '#282c34',
    fg = '#abb2bf',
    yellow = '#e0af68',
    cyan = '#56b6c2',
    darkblue = '#081633',
    green = '#98c379',
    orange = '#d19a66',
    violet = '#a9a1e1',
    magenta = '#c678dd',
    blue = '#61afef',
    red = '#e86671'
}

local vi_mode_colors = {
    NORMAL = colors.green,
    INSERT = colors.red,
    VISUAL = colors.magenta,
    OP = colors.green,
    BLOCK = colors.blue,
    REPLACE = colors.violet,
    ['V-REPLACE'] = colors.violet,
    ENTER = colors.cyan,
    MORE = colors.cyan,
    SELECT = colors.orange,
    COMMAND = colors.green,
    SHELL = colors.green,
    TERM = colors.green,
    NONE = colors.yellow
}

local lsp = require 'feline.providers.lsp'
local vi_mode_utils = require 'feline.providers.vi_mode'

local comps = {
    vi_mode = {
        left = {
            provider = function()
                return ' ' .. vi_mode_utils.get_vim_mode()
            end,
            hl = function()
                local val = {
                    name = vi_mode_utils.get_mode_highlight_name(),
                    fg = vi_mode_utils.get_mode_color()
                    -- fg = colors.bg
                }
                return val
            end,
            right_sep = ' '
        }
    },
    file = {
        info = {
            provider = {
                name = 'file_info',
                opts = {
                    type = 'relative-short',
                    file_readonly_icon = '  ',
                    file_modified_icon = ''
                }
            },
            hl = {
                fg = colors.blue,
                style = 'bold'
            }
        },
        encoding = {
            provider = 'file_encoding',
            left_sep = ' ',
            hl = {
                fg = colors.violet,
                style = 'bold'
            }
        },
        type = {
            provider = 'file_type'
        },
        position = {
            provider = 'position',
            left_sep = ' ',
            hl = {
                fg = colors.cyan
                -- style = 'bold'
            }
        }
    },
    line_percentage = {
        provider = 'line_percentage',
        left_sep = ' ',
        hl = {
            style = 'bold'
        }
    },
    scroll_bar = {
        provider = 'scroll_bar',
        left_sep = ' ',
        hl = {
            fg = colors.blue,
            style = 'bold'
        }
    },
    lsp = {
        name = {
            provider = 'lsp_client_names',
            -- left_sep = ' ',
            right_sep = ' ',
            -- icon = '  ',
            icon = '慎',
            hl = {
                fg = colors.yellow
            }
        }
    },
    git = {
        branch = {
            provider = 'git_branch',
            icon = ' ',
            -- icon = ' ',
            left_sep = ' ',
            hl = {
                fg = colors.violet,
                style = 'bold'
            }
        },
        add = {
            provider = 'git_diff_added',
            hl = {
                fg = colors.green
            }
        },
        change = {
            provider = 'git_diff_changed',
            hl = {
                fg = colors.orange
            }
        },
        remove = {
            provider = 'git_diff_removed',
            hl = {
                fg = colors.red
            }
        }
    }
}

local components = {
    active = {},
    inactive = {}
}

table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.inactive, {})
table.insert(components.inactive, {})
table.insert(components.inactive, {})

table.insert(components.active[1], comps.vi_mode.left)
table.insert(components.active[1], comps.file.info)
table.insert(components.active[1], comps.git.branch)
table.insert(components.active[1], comps.git.add)
table.insert(components.active[1], comps.git.change)
table.insert(components.active[1], comps.git.remove)
table.insert(components.active[3], comps.lsp.name)
table.insert(components.active[3], comps.file.os)
table.insert(components.active[3], comps.file.position)
table.insert(components.active[3], comps.line_percentage)
table.insert(components.active[3], comps.scroll_bar)
table.insert(components.active[3], comps.vi_mode.right)

-- Hide when the terminal is active:
-- table.insert(components.inactive[1], comps.vi_mode.left)
-- table.insert(components.inactive[1], comps.file.info)

require('feline').setup {
    theme = {
        bg = '#191724' -- rose-pine theme
        -- bg = '#000000' -- palenightfall theme
    },
    components = components,
    vi_mode_colors = vi_mode_colors
}

--
-- LSP
--

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- luasnip setup
local luasnip = require('luasnip')

-- nvim-cmp setup
local cmp = require('cmp')
cmp.setup {
    experimental = {
        ghost_text = true
    },

    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4), -- ?
        ['<C-f>'] = cmp.mapping.scroll_docs(4), -- ?
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, {'i', 's'}),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {'i', 's'})
    }),
    sources = {{
        name = 'nvim_lsp'
    }, {
        name = 'luasnip'
    }}
}

-- https://github.com/p00f/clangd_extensions.nvim

vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)

vim.keymap.set('n', 'g[', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', 'g]', vim.diagnostic.goto_next, opts)
-- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

local opts = {
    noremap = true,
    silent = true
}

local on_attach = function(client, bufnr)
    require("lsp_signature").on_attach({
        bind = true,
        handler_opts = {
            border = "none"
        },
        hint_enable = false,
        timer_interval = 50
    }, bufnr)

    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local bufopts = {
        noremap = true,
        silent = true,
        buffer = bufnr
    }

    vim.keymap.set('n', 'gh', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gH', vim.lsp.buf.signature_help, bufopts)

    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)

    vim.keymap.set('n', 'gR', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<S-F6>', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<S-F7>', vim.lsp.buf.rename, bufopts)

    --   cmd('n', '<leader>n', function() vim.diagnostic.goto_next{float = { header = false }} end)
    --   cmd('n', '<leader>N', function() vim.diagnostic.goto_prev{float = { header = false }} end)

    vim.keymap.set('n', '<C-S>', '', {
        unpack(bufopts),
        callback = function()
            if (vim.bo.filetype == 'vue') then
                vim.cmd [[ EslintFixAll ]]
            else
                vim.lsp.buf.format()
            end

            vim.api.nvim_command('write')
        end
    })
end

local servers = { --
'clangd', -- C
'intelephense', -- PHP
'cssls', 'html', 'eslint', 'volar', 'quick_lint_js' -- Frontend
}

for _, lsp in pairs(servers) do
    require('lspconfig')[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            -- https://github.com/bmewburn/intelephense-docs/blob/master/installation.md
            intelephense = {
                environment = {
                    phpVersion = "8.1.0"
                },
                diagnostics = {
                    undefinedFunctions = false,
                    undefinedMethods = false
                }
            }
        }
    }
end

--
-- Dial.nvim: increment/decrement plugin
--
local noremap = {
    noremap = true
}

vim.api.nvim_set_keymap("n", "<C-a>", require("dial.map").inc_normal(), noremap)
vim.api.nvim_set_keymap("n", "<C-x>", require("dial.map").dec_normal(), noremap)
vim.api.nvim_set_keymap("v", "<C-a>", require("dial.map").inc_visual(), noremap)
vim.api.nvim_set_keymap("v", "<C-x>", require("dial.map").dec_visual(), noremap)
vim.api.nvim_set_keymap("v", "g<C-a>", require("dial.map").inc_gvisual(), noremap)
vim.api.nvim_set_keymap("v", "g<C-x>", require("dial.map").dec_gvisual(), noremap)

--
-- General improvements
--

-- Close NvimTree when it's the last thing open.
vim.api.nvim_create_autocmd('BufEnter', {
    nested = true,
    callback = function()
        if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match('NvimTree_') ~= nil then
            vim.cmd 'quit'
        end
    end
})

-- Time in milliseconds (default 0) to highlight matching word
vim.g.Illuminate_delay = 0

-- C++ Theme
vim.g.cpp_class_scope_highlight = 1
vim.g.cpp_member_variable_highlight = 1
vim.g.cpp_class_decl_highlight = 1
vim.g.cpp_posix_standard = 1
vim.g.cpp_experimental_simple_template_highlight = 1
vim.g.cpp_concepts_highlight = 1

--
-- Web dev.
--

-- Classes with dashes should be considered as a word
vim.api.nvim_command('au FileType vue setlocal iskeyword+=-')
vim.api.nvim_command('au FileType css setlocal iskeyword+=-')
vim.api.nvim_command('au FileType scss setlocal iskeyword+=-')

vim.api.nvim_set_keymap('i', '<Tab>', '<Plug>(Tabout)', {
    silent = true
})

