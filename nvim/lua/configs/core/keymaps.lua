-- Set leader key to space
vim.g.mapleader = " "

-- Define a local variable for keymap utility
local keymap = vim.keymap

-- Text operations
keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without yanking", noremap = true, silent = true })
keymap.set("n", "x", '"_x', { desc = "Delete without yanking", noremap = true, silent = true })

keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down", noremap = true, silent = true })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up", noremap = true, silent = true })

-- open terminal
keymap.set(
  "n",
  "<leader>t",
  "<cmd>split | resize 20 | term<CR>",
  { desc = "Open terminal", noremap = true, silent = true }
)

-- Search and replace
keymap.set(
  "n",
  "<leader>s",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Search and replace", noremap = true, silent = true }
)

-- Join lines without moving cursor
keymap.set("n", "J", "mzJ`z", { desc = "Join lines without moving cursor", noremap = true, silent = true })

-- Highlight word under cursor
keymap.set("n", "vv", "*", { desc = "Highlight word under cursor", noremap = true, silent = true })

-- Clear search highlights
keymap.set("n", "<leader>nh", "<cmd>nohl<CR>", { desc = "Clear search highlights", noremap = true, silent = true })

-- netrw
local netrwIsOpen = false

-- Add your own mapping. For example:
keymap.set("n", "<leader>ee", function()
  if netrwIsOpen then
    local i = vim.fn.bufnr("$")
    while i >= 1 do
      if vim.fn.getbufvar(i, "&filetype") == "netrw" then
        vim.cmd("bwipeout " .. i)
      end
      i = i - 1
    end
    netrwIsOpen = false
  else
    netrwIsOpen = true
    vim.cmd("silent Lexplore")
  end
end, { desc = "toggle Netrw", noremap = true, silent = true })
