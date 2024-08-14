-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- use PRIMARY and SECONDARY clipboard with leader and localleader
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { silent = true })
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { silent = true })
vim.keymap.set({ "n", "v" }, "<leader>P", '"+P', { silent = true })
vim.keymap.set({ "n", "v" }, "<localleader>y", '"*y', { silent = true })
vim.keymap.set({ "n", "v" }, "<localleader>p", '"*p', { silent = true })
vim.keymap.set({ "n", "v" }, "<localleader>P", '"*P', { silent = true })

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- better up/down
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Resize window using <ctrl> arrow keys
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move Lines
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Add undo break-points
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")

-- Format on <leader>f with lsp
vim.keymap.set("n", "<leader>f", ":Format<CR>")

-- vertical split on <leader>v
vim.keymap.set("n", "<leader>v", ":vsplit<CR>")
-- save on <leader>w
vim.keymap.set("n", "<leader>w", ":w<CR>")

-- map Ctrl+N and Ctrl+P for completion in command mode
-- vim.api.nvim_set_keymap("c", "<C-n>", "<C-z>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("c", "<C-p>", "<s-Tab>", { noremap = true, silent = true })

-- Function to handle completion with Ctrl+N
vim.api.nvim_set_keymap(
    "c",
    "<C-n>",
    'pumvisible() ? "\\<C-n>" : "\\<C-z>"',
    { expr = true, noremap = true, silent = true }
)

-- Function to handle completion with Ctrl+P
vim.api.nvim_set_keymap(
    "c",
    "<C-p>",
    'pumvisible() ? "\\<C-p>" : "\\<C-z>"',
    { expr = true, noremap = true, silent = true }
)
