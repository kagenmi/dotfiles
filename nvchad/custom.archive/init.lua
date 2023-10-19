local autocmd = vim.api.nvim_create_autocmd
local new_cmd = vim.api.nvim_create_user_command
local opt = vim.opt

-- autocmds
autocmd("FileType", {
   pattern = "norg",
   callback = function()
      -- vim.opt.laststatus = 0
      opt.number = false
      opt.showtabline = 0
      opt.cole = 1
      opt.foldlevel = 10
   end,
})

autocmd("FileType", {
   pattern = "go",
   callback = function()
      opt.shiftwidth = 4
   end,
})

autocmd("FileType", {
   pattern = "lua",
   callback = function()
      opt.shiftwidth = 3
   end,
})

-- Open a file from its last left off position
vim.cmd [[ 
   au BufReadPost * 
      \ if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") |
         \ exe "normal! g'\"" |
      \ endif 
]]

-- nvim-tree auto_close
autocmd("BufEnter", {
   nested = true,
   callback = function()
      local nwins = #vim.api.nvim_list_wins()
      if nwins == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
         vim.cmd "quit"
      end
   end
})

-- disable JP IME, when escaping insert mode
if vim.fn.has('mac') and vim.fn.executable('im-select') then
  vim.cmd [[
    augroup MyIMEGroup
      autocmd!
      autocmd InsertLeave * :call system('~/.local/bin/im-select com.apple.keylayout.ABC')
  ]]
end


-- commands

-- I dont use shade.nvim/autosave.nvim all the time so made commands for them 
-- So this makes easy to lazy load them at cmds

new_cmd("EnableShade", function()
   require("shade").setup()
end, {})

new_cmd("EnableAutosave", function()
   require("autosave").setup()
end, {})

new_cmd("close", function()
   vim.cmd [[ bufdo bd ]]
end, {})
