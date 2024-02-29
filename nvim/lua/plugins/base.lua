-- BASE Plugins
-- a list of plugins with very minimal configuration or that are used
-- by many others, so it should be here as the base setup
--
-- commented out plugins I might have not really used, but want to keep in case I want to start using them
-- or keep as a note to myself

return {
    -- NOTE: First, some plugins that don't require any configuration

    -- Git related plugins
    "tpope/vim-fugitive",
    -- Git hub support
    -- 'tpope/vim-rhubarb',
    -- open git commit in multiple buffers showing changes
    -- https://github.com/rhysd/committia.vim
    "rhysd/committia.vim",
    -- See `:help gitsigns` to understand what the configuration keys do
    { -- Adds git related signs to the gutter, as well as utilities for managing changes
        "lewis6991/gitsigns.nvim",
        opts = {
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },
        },
    },

    -- Detect tabstop and shiftwidth automatically
    "tpope/vim-sleuth",

    -- tim pope sensible vim
    -- 'tpope/vim-sensible',

    -- tim pope surroung vim editing
    "tpope/vim-surround",

    -- https://github.com/tpope/vim-endwise add intelligent endings
    "tpope/vim-endwise",

    -- bracket mappings https://github.com/tpope/vim-endwise
    "tpope/vim-unimpaired",

    -- projectionist - project specific mappings
    -- 'tpope/vim-projectionist',

    -- No leakage of passwords from pass
    "https://gitlab.com/craftyguy/vim-redact-pass.git",

    -- vim helpers for unix shell https://github.com/tpope/vim-endwise
    "tpope/vim-eunuch",

    -- syntax highlight requirements.txt
    "raimon49/requirements.txt.vim",

    -- vim tmux
    "christoomey/vim-tmux-navigator",
    -- should add kitty support and change to using nvim Terminal for splits and multiplexing of terminal emulator
    -- .tmux.conf syntax for vim
    "tmux-plugins/vim-tmux",

    -- terraform syntax
    "hashivim/vim-terraform",

    -- automatic insert or delete backets in pairs
    -- 'jiangmiao/auto-pairs',
    -- so far I dont like auto-pairs, but with tab in insert jumping out, i might like it

    -- "gc" to comment visual regions/lines
    {
        "numToStr/Comment.nvim",
        opts = {
            extra = {
                eol = "gca", -- remove caps for eol add, as there is no conflict, less keys
                above = "gco", -- switch above and below, kind of unintuitive for o and O behaviour
                below = "gcO", -- but more akin, to the use, as I will more often use above, than below
            },
        },
        lazy = false,
    },
    -- Highlight todo, notes, etc in comments
    { "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, opts = { signs = false } },
    { -- Collection of various small independent plugins/modules
        "echasnovski/mini.nvim",
        config = function()
            -- Better Around/Inside textobjects
            --
            -- Examples:
            --  - va)  - [V]isually select [A]round [)]parenthen
            --  - yinq - [Y]ank [I]nside [N]ext [']quote
            --  - ci'  - [C]hange [I]nside [']quote
            require("mini.ai").setup({ n_lines = 500 })

            -- Add/delete/replace surroundings (brackets, quotes, etc.)
            --
            -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
            -- - sd'   - [S]urround [D]elete [']quotes
            -- - sr)'  - [S]urround [R]eplace [)] [']
            require("mini.surround").setup()

            -- Simple and easy statusline.
            --  You could remove this setup call if you don't like it,
            --  and try some other statusline plugin
            require("mini.statusline").setup()

            -- ... and there is more!
            --  Check out: https://github.com/echasnovski/mini.nvim
        end,
    },
}
