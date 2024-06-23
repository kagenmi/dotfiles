require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- General
-- -------

map('n', '<leader>x', ':split<CR>', { desc = "Split window horizontally" })
map('n', '<leader>v', ':vsplit<CR>', { desc = "Split window vertically" })
map('v', '>', '>gv', { desc = "Indent" })

-- Comment
-- -------

map("n", "<leader>/", "") -- suppress default
map("n", "<C-_>", "gcc", {
  desc = "Toggle comment",
  remap = true,
})
map("v", "<leader>/", "") -- suppress default
map("v", "<C-_>", "gc", {
  desc = "Toggle comment",
  remap = true,
})

-- tabufline
-- ---------

local tabufline = require("nvchad.tabufline")

map("n", "<TAB>", "<CMD>tabnext<CR>", { desc = "Next tab" })
map("n", "<S-TAB>", "<CMD>tabprevious<CR>", { desc = "Previous tab" })
map("n", "<LEADER>k", tabufline.next, { desc = "Next buffer" })
map("n", "<LEADER>j", tabufline.prev, { desc = "Previous buffer" })
map("n", "tx", tabufline.close_buffer, { desc = "Close buffer" })
map("n", "<LEADER>tt", function() require("base46").toggle_theme() end, { desc = "Toggle Base46 Theme" })

-- nvimtree
-- --------

map("n", "<LEADER>e", "") -- suppress default

-- WinShift
-- --------

map("n", "<C-w>m", ":WinShift<CR>", { desc = "Enter Win-Move mode" })
map("n", "<C-w>x", ":WinShift swap<CR>", { desc = "Swap windows" })
