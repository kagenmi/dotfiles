-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

local autocmd = vim.api.nvim_create_autocmd
local new_cmd = vim.api.nvim_create_user_command
local opt = vim.opt

-- Define `ExtraWhitespace` highlight group
vim.cmd('match ExtraWhitespace /\\s\\+$/')

autocmd('InsertLeave', {
  pattern = '*',
  callback = function()
    vim.cmd.hi('ExtraWhitespace ctermbg=red guibg=#ee6d85')
  end,
})

autocmd('InsertEnter', {
  pattern = '*',
  callback = function()
    vim.cmd.hi('clear ExtraWhitespace')
  end,
})

-- Config Indentation

autocmd("FileType", {
   pattern = "go",
   callback = function()
      opt.shiftwidth = 4
   end,
})
