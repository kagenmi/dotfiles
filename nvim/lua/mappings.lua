require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- General
-- -------

map('n', '<leader>x', ':split<CR>', { desc = "Split window horizontally" })
map('n', '<leader>v', ':vsplit<CR>', { desc = "Split window vertically" })
map('v', '>', '>gv', { desc = "Indent to right" })
map('v', '<', '<gv', { desc = "Indent to left" })

-- Don't copy the replaced text after pasting in visual mode
-- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
map('x', 'p', 'p:let @+=@0<CR>:let @"=@0<CR>', { desc = "Paste without clipboard" })

-- Move the cursor through wrapped lines
map({'n', 'v'}, 'j', 'gj', { desc = "Go down" })
map({'n', 'v'}, 'k', 'gk', { desc = "Go up" })

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

-- lspconfig
-- ---------

map("n", "<LEADER>lf",
  function()
    vim.diagnostic.open_float { border = "rounded" }
  end,
  { desc = "Floating diagnostic." }
)

map("n", "<LEADER>lr", ":LspRestart<CR>", { desc = "LSP Restart" })

-- WinShift
-- --------

map("n", "<C-w>m", ":WinShift<CR>", { desc = "Enter Win-Move mode" })
map("n", "<C-w>x", ":WinShift swap<CR>", { desc = "Swap windows" })
