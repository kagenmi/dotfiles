require "nvchad.autocmds"

local autocmd = vim.api.nvim_create_autocmd
local opt = vim.opt

autocmd("TermOpen", {
  command = "setlocal signcolumn=no",
})

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

autocmd("FileType", {
  pattern = "help",
  callback = function(opts)
    local buf = opts.buf

    vim.keymap.set("n", "<A-o>", "<C-]>", { buffer = buf, desc = "Jump to tag" })
    vim.keymap.set("n", "<A-p>", "<C-o>", { buffer = buf, desc = "Backward jump list" })
    vim.keymap.set("n", "<A-n>", "<C-i>", { buffer = buf, desc = "Forward jump list" })

    -- suppress defaults
    vim.keymap.set("n", "<C-]>", "")
    vim.keymap.set("n", "<C-o>", "")
    vim.keymap.set("n", "<C-i>", "")
  end,
})
