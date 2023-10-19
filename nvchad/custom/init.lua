-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

local autocmd = vim.api.nvim_create_autocmd
local new_cmd = vim.api.nvim_create_user_command
local opt = vim.opt

vim.cmd('match ExtraWhitespace /\\s\\+$/')

autocmd("FileType", {
   pattern = "go",
   callback = function()
      opt.shiftwidth = 4
   end,
})
