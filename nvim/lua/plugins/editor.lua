return {

    -- from lazy.nvim example
    "folke/which-key.nvim",
    { "folke/neoconf.nvim", cmd = "Neoconf" },
    "folke/neodev.nvim",

    -- Useful plugin to show you pending keybinds.
    -- NOTE: Plugins can also be configured to run lua code when they are loaded.
    --
    -- This is often very useful to both group configuration, as well as handle
    -- lazy loading plugins that don't need to be loaded immediately at startup.
    --
    -- For example, in the following configuration, we use:
    --  event = 'VeryLazy'
    --
    -- which loads which-key after all the UI elements are loaded. Events can be
    -- normal autocommands events (:help autocomd-events).
    --
    -- Then, because we use the `config` key, the configuration only runs
    -- after the plugin has been loaded:
    --  config = function() ... end

    { -- Useful plugin to show you pending keybinds.
        "folke/which-key.nvim",
        event = "VeryLazy", -- Sets the loading event to 'VeryLazy'
        config = function() -- This is the function that runs, AFTER loading
            require("which-key").setup()

            -- Document existing key chains
            require("which-key").register({
                ["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
                ["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
                ["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
                ["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
                ["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
            })
        end,
    },
    {
        -- Adds git related signs to the gutter, as well as utilities for managing changes
        "lewis6991/gitsigns.nvim",
        opts = {
            -- See `:help gitsigns.txt`
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },
            on_attach = function(bufnr)
                vim.keymap.set(
                    "n",
                    "<leader>gp",
                    require("gitsigns").prev_hunk,
                    { buffer = bufnr, desc = "[G]o to [P]revious Hunk" }
                )
                vim.keymap.set(
                    "n",
                    "<leader>gn",
                    require("gitsigns").next_hunk,
                    { buffer = bufnr, desc = "[G]o to [N]ext Hunk" }
                )
                vim.keymap.set(
                    "n",
                    "<leader>ph",
                    require("gitsigns").preview_hunk,
                    { buffer = bufnr, desc = "[P]review [H]unk" }
                )
            end,
        },
    },
}
