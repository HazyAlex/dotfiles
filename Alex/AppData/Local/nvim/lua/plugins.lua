require('packer').startup{function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Themes
    use {
        "ellisonleao/gruvbox.nvim"
    }

    -- Coc + ts extension
    use {
        'neoclide/coc.nvim',
        branch = 'release'
    }

    -- Telescope + Project.nvim
    use {
        'nvim-telescope/telescope.nvim',

        requires = {
            {'nvim-lua/plenary.nvim'}
        },
    }

    use {
        "ahmedkhalf/project.nvim",
        config = function()
          require("project_nvim").setup {
              --
          }
        end
    }
end}


--
-- Telescope
--
local actions = require('telescope.actions')
local action_layout = require("telescope.actions.layout")

require('telescope').setup {
    defaults = {
        mappings = {
            i = {
                ['<esc>'] = actions.close,
                ['<C-j>'] = actions.move_selection_next,
                ['<C-k>'] = actions.move_selection_previous,
                ['?'] = action_layout.toggle_preview,
            }
        },
    },

    pickers = {
        find_files = {
            theme = 'ivy',
            show_line = true,
            results_title = false,
            preview_title = false,
        },
        live_grep = {
            theme = 'ivy',
            show_line = true,
            results_title = false,
            preview_title = false,
        }
    },
}

--
-- Project.nvim
--
require('telescope').load_extension('projects')
