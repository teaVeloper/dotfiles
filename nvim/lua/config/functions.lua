-- my own function
-- useful utilities I want available
local function toggle_zoom_tab()
    local tab_count = vim.fn.tabpagenr("$") -- Get the total number of tabs
    if tab_count == 1 then
        -- If there's only one tab, check window count in the current tab
        if #vim.api.nvim_tabpage_list_wins(0) > 1 then
            -- More than one window, "zoom in" by creating a new tab with the current buffer
            vim.cmd("tab split")
        else
            -- Only one window, attempt to "zoom out" if there's a previous tab context
            -- This variable should be defined globally or managed to track zoom state
            if vim.g.zoomed_in_previous_tab ~= nil then
                -- Go back to the previous tab if it exists
                vim.cmd("tabclose")
                vim.g.zoomed_in_previous_tab = nil -- Reset the variable
            end
        end
    else
        -- More than one tab, "zoom out" by closing the current tab
        vim.cmd("tabclose")
        vim.g.zoomed_in_previous_tab = vim.fn.tabpagenr() -- Save the current tab number
    end
end

-- Global variables to store the current window size
vim.g.zoomed = false
vim.g.prev_win_height = nil
vim.g.prev_win_width = nil

local function toggle_zoom_window()
    if vim.g.zoomed then
        -- Zoom out
        if vim.g.prev_win_height and vim.g.prev_win_width then
            vim.api.nvim_win_set_height(0, vim.g.prev_win_height)
            vim.api.nvim_win_set_width(0, vim.g.prev_win_width)
        end
        vim.g.zoomed = false
    else
        -- Zoom in
        -- Store current window size
        vim.g.prev_win_height = vim.api.nvim_win_get_height(0)
        vim.g.prev_win_width = vim.api.nvim_win_get_width(0)
        -- Maximize the current window
        vim.api.nvim_win_set_height(0, vim.o.lines - vim.o.cmdheight - 1) -- Account for command line and status line
        vim.api.nvim_win_set_width(0, vim.o.columns)
        vim.g.zoomed = true
    end
end

-- Keymap to toggle zoom
vim.keymap.set("n", "<leader>z", toggle_zoom_tab, { silent = true, noremap = true })
