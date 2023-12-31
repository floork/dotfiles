-- Set leader key to space
vim.g.mapleader = " "

-- Define a local variable for keymap utility
local keymap = vim.keymap

----------------------- General Keymaps -------------------

-- Text operations
keymap.set({ "n", "v" }, "<leader>d", [["_d]]) -- Delete and yank into black hole register
keymap.set("n", "x", '"_x') -- Delete single character without copying into register

-- Search and replace
keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]) -- Replace under cursor, case-insensitive

-- Join lines without moving cursor
keymap.set("n", "J", "mzJ`z")

-- Highlight word under cursor
keymap.set("n", "vv", "*", { desc = "Highlight word under cursor" })

-- Clear search highlights
keymap.set("n", "<leader>nh", "<cmd>nohl<CR>", { desc = "Clear search highlights" })

----------------------- Save Keymap -------------------

-- Save the current buffer
keymap.set({ "n", "v" }, "<leader>ss", "<cmd>w<CR>", { desc = "Quick Save" })

----------------------- Clipboard Keymaps -------------------

-- Copy to clipboard
keymap.set("v", "<leader>cc", '"+y', { desc = "Copy to clipboard" })

keymap.set("n", "<leader>ee", "<cmd>Sexplore!<CR>", { desc = "Open netrw" }) -- open netrw
