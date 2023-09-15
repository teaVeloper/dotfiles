return {
    -- NOTE: First, some plugins that don't require any configuration

    -- Git related plugins
    'tpope/vim-fugitive',
    'tpope/vim-rhubarb',

    -- Detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',

    -- tim pope sensible vim
    'tpope/vim-sensible',

    -- tim pope surroung vim editing
    'tpope/vim-surround',

    -- https://github.com/tpope/vim-endwise add intelligent endings
    'tpope/vim-endwise',

    -- bracket mappings https://github.com/tpope/vim-endwise
    'tpope/vim-unimpaired',

    -- projectionist - project specific mappings
    'tpope/vim-projectionist',
    -- vim tmux
    'christoomey/vim-tmux-navigator',

    -- No leakage of passwords from pass
    'https://gitlab.com/craftyguy/vim-redact-pass.git',

    -- vim helpers for unix shell https://github.com/tpope/vim-endwise
    'tpope/vim-eunuch',

    'raimon49/requirements.txt.vim',

    -- .tmux.conf syntax for vim
    'tmux-plugins/vim-tmux',

    -- terraform syntax
    'hashivim/vim-terraform',


    -- open git commit in multiple buffers showing changes
    -- https://github.com/rhysd/committia.vim
    'rhysd/committia.vim',

    -- automatic insert or delete backets in pairs
    'jiangmiao/auto-pairs',

    -- "gc" to comment visual regions/lines
    { 'numToStr/Comment.nvim', opts = {} },

    -- Fuzzy Finder (files, lsp, etc)
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            -- Fuzzy Finder Algorithm which requires local dependencies to be built.
            -- Only load if `make` is available. Make sure you have the system
            -- requirements installed.
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                -- NOTE: If you are having trouble with this installation,
                --       refer to the README for telescope-fzf-native for more instructions.
                build = 'make',
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
        },
    },

}
